#!/usr/bin/env python3
"""
Download and extract Defold library projects for IDE autocompletion.

This script downloads popular Defold libraries from GitHub and extracts
their Lua files into a organized directory structure for IDE support.
"""

import argparse
import fnmatch
import json
import os
import shutil
import sys
import zipfile
from pathlib import Path
from typing import List, Dict, Optional
from urllib.request import urlopen, Request
from urllib.error import URLError, HTTPError

from modules.download_lua_headers import (
    download_docs,
    generate_lua_files,
    get_last_defold_version,
)


# Popular Defold libraries with their GitHub URLs
DEFAULT_LIBRARIES = {
    "druid": {
        "url": "https://github.com/Insality/druid/archive/refs/tags/1.1.4.zip",
        "description": "Defold GUI library with rich component system",
    },
    "monarch": {
        "url": "https://github.com/britzl/monarch/archive/master.zip",
        "description": "Screen manager for Defold",
    },
    "defold-orthographic": {
        "url": "https://github.com/britzl/defold-orthographic/archive/master.zip",
        "description": "Orthographic camera system",
    },
    "defos": {
        "url": "https://github.com/subsoap/defos/archive/master.zip",
        "description": "Extra OS functions for desktop platforms",
    },
    "defold-event": {
        "url": "https://github.com/Insality/defold-event/archive/refs/tags/12.zip",
        "description": "Event system for Defold",
    },
    "defold-tweener": {
        "url": "https://github.com/Insality/defold-tweener/archive/refs/tags/5.zip",
        "description": "Tweener library for Defold",
        "exclude_patterns": [
            "annotations*",
            "druid",
        ],
        "output_root": "tweener",
    },
    "defsave": {
        "url": "https://github.com/subsoap/defsave/archive/master.zip",
        "description": "Save system for Defold",
    },
    "nakama-defold": {
        "url": "https://github.com/heroiclabs/nakama-defold/archive/refs/tags/v3.4.0.zip",
        "description": "Nakama client for Defold",
    },
    "defold-random": {
        "url": "https://github.com/selimanac/defold-random/archive/master.zip",
        "description": "Random number generator for Defold",
    },
    "defold-websocket": {
        "url": "https://github.com/defold/extension-websocket/archive/master.zip",
        "description": "WebSocket extension for Defold",
    },
    "box2d":{
        "url": "https://github.com/d954mas/defold-box2d/archive/master.zip",
        "description": "Box2D physics engine for Defold",
    },
    "bridge":{
        "url": "https://github.com/KassiaL/bridge/archive/master.zip",
        "description": "Bridge library for Defold",
    },
    "spine":{
        "url": "https://github.com/defold/extension-spine/archive/refs/tags/4.4.1.zip",
        "description": "Spine runtime for Defold",
    },
    "panthera":{
        "url": "https://github.com/Insality/panthera/archive/refs/tags/runtime.7.zip",
        "description": "Panthera library for Defold",
        "exclude_patterns": [
            "adapters",
            "panthera_*",
        ],
    },
}


GLOBAL_EXCLUDE_PATTERNS = [
    "debugger",
    "spine_tester",
    "luacov",
    "main*",
    "example*",
    "header*",
    "doc*",
    "libs*",
]

class DefoldLibraryDownloader:
    """Download and extract Defold libraries."""

    def __init__(self, output_dir: Path, clean: bool = False):
        """
        Initialize the downloader.

        Args:
            output_dir: Directory to extract libraries to
            clean: Whether to clean the output directory first
        """
        self.output_dir = output_dir
        self.clean = clean
        self.stats = {
            "downloaded": 0,
            "failed": 0,
            "lua_files": 0,
            "skipped_libraries": 0,
            "skipped_files": 0,
        }

    @staticmethod
    def _matches_pattern(value: str, pattern: str) -> bool:
        """Match shell-style patterns against a path component or file stem."""
        value_lower = value.lower()
        pattern_lower = pattern.lower()

        if fnmatch.fnmatchcase(value_lower, pattern_lower):
            return True

        stem = Path(value_lower).stem
        return stem != value_lower and fnmatch.fnmatchcase(stem, pattern_lower)

    @classmethod
    def _matches_any_pattern(cls, value: str, patterns: List[str]) -> bool:
        return any(cls._matches_pattern(value, pattern) for pattern in patterns)

    def is_library_excluded(self, library_name: str) -> bool:
        """Return True when the whole library should be skipped."""
        return self._matches_any_pattern(library_name, GLOBAL_EXCLUDE_PATTERNS)

    def is_path_excluded(
        self,
        library_name: str,
        relative_path: Path,
        library_exclude_patterns: Optional[List[str]] = None,
        library_output_root: Optional[str] = None,
    ) -> bool:
        """
        Return True when a file belongs to an excluded direct child.

        Global exclusions apply to direct children of output_dir. Library-specific
        exclusions additionally apply to direct children of that library's root.
        """
        parts = relative_path.parts
        if not parts:
            return False

        if self._matches_any_pattern(parts[0], GLOBAL_EXCLUDE_PATTERNS):
            return True

        library_patterns = library_exclude_patterns or []
        if not library_patterns:
            return False

        if self._matches_any_pattern(parts[0], library_patterns):
            return True

        library_root = library_output_root or library_name
        if parts[0] == library_root and len(parts) > 1:
            return self._matches_any_pattern(parts[1], library_patterns)

        return False

    def clean_output_dir(self):
        """Clean the output directory."""
        if self.output_dir.exists():
            print(f"Cleaning {self.output_dir}...")
            shutil.rmtree(self.output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)

    def download_file(self, url: str, timeout: int = 30) -> bytes:
        """
        Download a file from URL.

        Args:
            url: URL to download from
            timeout: Timeout in seconds

        Returns:
            File content as bytes

        Raises:
            URLError: If download fails
        """
        print(f"  Downloading from {url}...")

        # Add User-Agent to avoid GitHub blocking
        headers = {"User-Agent": "Mozilla/5.0 (Defold Library Downloader)"}

        request = Request(url, headers=headers)

        try:
            with urlopen(request, timeout=timeout) as response:
                return response.read()
        except HTTPError as e:
            raise URLError(f"HTTP Error {e.code}: {e.reason}")

    def extract_lua_files(
        self,
        zip_data: bytes,
        library_name: str,
        library_exclude_patterns: Optional[List[str]] = None,
        library_output_root: Optional[str] = None,
    ) -> tuple[int, List[str]]:
        """
        Extract Lua files from ZIP archive.

        Args:
            zip_data: ZIP file content
            library_name: Name of the library (not used, kept for compatibility)

        Returns:
            Tuple of (file_count, list of extracted paths)
        """
        from io import BytesIO

        extracted_files = []
        lua_count = 0

        with zipfile.ZipFile(BytesIO(zip_data)) as zip_file:
            for entry in zip_file.namelist():
                # Only extract .lua files
                if not entry.endswith(".lua"):
                    continue

                # Skip test files and examples (optional)
                entry_lower = entry.lower()
                if any(
                    skip in entry_lower
                    for skip in ["test/", "tests/", "example/", "examples/"]
                ):
                    continue

                # Extract the file
                try:
                    # Get relative path (remove only the GitHub archive root directory)
                    parts = Path(entry).parts
                    if len(parts) > 1:
                        # Skip only the root directory (github archive creates one)
                        relative_path = Path(*parts[1:])
                    else:
                        relative_path = Path(entry)

                    if self.is_path_excluded(
                        library_name,
                        relative_path,
                        library_exclude_patterns,
                        library_output_root,
                    ):
                        self.stats["skipped_files"] += 1
                        continue

                    file_data = zip_file.read(entry)

                    # Create target path directly in output_dir
                    target_path = self.output_dir / relative_path
                    target_path.parent.mkdir(parents=True, exist_ok=True)

                    # Write file
                    with open(target_path, "wb") as f:
                        f.write(file_data)

                    extracted_files.append(str(relative_path))
                    lua_count += 1

                except Exception as e:
                    print(f"    ⚠ Warning: Failed to extract {entry}: {e}")

        return lua_count, extracted_files

    def download_library(
        self,
        name: str,
        url: str,
        description: str = "",
        exclude_patterns: Optional[List[str]] = None,
        output_root: Optional[str] = None,
    ) -> bool:
        """
        Download and extract a single library.

        Args:
            name: Library name
            url: Download URL
            description: Library description

        Returns:
            True if successful, False otherwise
        """
        print(f"\n{'=' * 70}")
        print(f"Library: {name}")
        if description:
            print(f"Description: {description}")
        print(f"{'=' * 70}")

        try:
            if self.is_library_excluded(name):
                print(f"  - Skipped by library exclusion")
                self.stats["skipped_libraries"] += 1
                return True

            # Download
            zip_data = self.download_file(url)
            print(f"  ✓ Downloaded {len(zip_data):,} bytes")

            # Extract
            lua_count, extracted_files = self.extract_lua_files(
                zip_data,
                name,
                exclude_patterns,
                output_root,
            )

            if lua_count == 0:
                print(f"  ⚠ No Lua files found in {name}")
                return False

            print(f"  ✓ Extracted {lua_count} Lua files")

            # Show sample files
            if extracted_files:
                print(f"  Sample files:")
                for path in sorted(extracted_files)[:5]:
                    print(f"    - {path}")
                if len(extracted_files) > 5:
                    print(f"    ... and {len(extracted_files) - 5} more")

            self.stats["downloaded"] += 1
            self.stats["lua_files"] += lua_count
            return True

        except URLError as e:
            print(f"  ✗ Download failed: {e}")
            self.stats["failed"] += 1
            return False
        except zipfile.BadZipFile:
            print(f"  ✗ Invalid ZIP file")
            self.stats["failed"] += 1
            return False
        except Exception as e:
            print(f"  ✗ Unexpected error: {e}")
            self.stats["failed"] += 1
            return False

    def download_all(self, libraries: Dict[str, Dict[str, str]]):
        """
        Download all specified libraries.

        Args:
            libraries: Dictionary of library configurations
        """
        if self.clean:
            self.clean_output_dir()
        else:
            self.output_dir.mkdir(parents=True, exist_ok=True)

        total = len(libraries)
        print(f"Downloading {total} libraries to {self.output_dir.absolute()}\n")

        for name, config in libraries.items():
            url = config.get("url", "")
            description = config.get("description", "")
            exclude_patterns = config.get("exclude_patterns")
            output_root = config.get("output_root")

            if not url:
                print(f"⚠ Skipping {name}: No URL provided")
                continue

            self.download_library(
                name,
                url,
                description,
                exclude_patterns,
                output_root,
            )

        # Print summary
        print(f"\n{'=' * 70}")
        print("DOWNLOAD SUMMARY")
        print(f"{'=' * 70}")
        print(f"✓ Downloaded:  {self.stats['downloaded']}/{total}")
        print(f"✗ Failed:      {self.stats['failed']}/{total}")
        print(f"- Skipped:     {self.stats['skipped_libraries']} libraries")
        print(f"- Excluded:    {self.stats['skipped_files']} Lua files")
        print(f"📄 Lua files:  {self.stats['lua_files']}")
        print(f"📁 Output dir: {self.output_dir.absolute()}")
        print(f"{'=' * 70}\n")


def load_custom_libraries(config_file: Path) -> Dict[str, Dict[str, str]]:
    """
    Load custom library configuration from JSON file.

    Args:
        config_file: Path to JSON configuration file

    Returns:
        Dictionary of library configurations

    Example JSON format:
    {
        "my-library": {
            "url": "https://github.com/user/repo/archive/main.zip",
            "description": "My custom library"
        }
    }
    """
    try:
        with open(config_file, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception as e:
        print(f"Error loading config file: {e}")
        sys.exit(1)


def create_sample_config(output_path: Path):
    """Create a sample configuration file."""
    sample = {
        "_comment": "Add your custom Defold libraries here",
        "my-library": {
            "url": "https://github.com/username/repository/archive/main.zip",
            "description": "Description of the library",
        },
        "another-lib": {
            "url": "https://github.com/user/repo/archive/refs/tags/v1.0.0.zip",
            "description": "Another library",
        },
    }

    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(sample, f, indent=2)

    print(f"Sample configuration created at: {output_path}")


def download_defold_api(output_dir: Path, sha: Optional[str] = None, clean: bool = False):
    """Download Defold engine docs and generate Lua API headers."""
    import tempfile

    if clean and output_dir.exists():
        print(f"Cleaning {output_dir}...")
        shutil.rmtree(output_dir)

    output_dir.mkdir(parents=True, exist_ok=True)

    api_dir = output_dir / "api"
    if api_dir.exists():
        print(f"Cleaning {api_dir}...")
        shutil.rmtree(api_dir)

    if sha is None:
        _, sha = get_last_defold_version()

    with tempfile.TemporaryDirectory(prefix="defold-api-docs-") as temp_dir:
        doc_dir = download_docs(sha, Path(temp_dir))
        generate_lua_files(doc_dir, api_dir)

    print(f"\n✓ Defold API headers saved to: {api_dir.absolute()}")


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="Download and extract Defold library projects",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Download default libraries
  python download_defold_libraries.py

  # Download only Defold engine API headers
  python download_defold_libraries.py --defold-api-only

  # Download to custom directory
  python download_defold_libraries.py -o ~/defold-libs

  # Clean output directory first
  python download_defold_libraries.py --clean

  # Use custom library list
  python download_defold_libraries.py -c my_libraries.json

  # Download only specific libraries
  python download_defold_libraries.py -l druid monarch gooey

  # Create sample config file
  python download_defold_libraries.py --create-config libraries.json

  # List available default libraries
  python download_defold_libraries.py --list
        """,
    )

    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=Path("lua_annotations"),
        help="Output directory (default: lua_annotations)",
    )

    parser.add_argument(
        "-c",
        "--config",
        type=Path,
        help="JSON configuration file with custom libraries",
    )

    parser.add_argument(
        "-l",
        "--libraries",
        nargs="+",
        help="Specific libraries to download (by name)",
    )

    parser.add_argument(
        "--clean",
        action="store_true",
        help="Clean output directory before downloading",
    )

    parser.add_argument(
        "--list",
        action="store_true",
        help="List available default libraries and exit",
    )

    parser.add_argument(
        "--create-config",
        type=Path,
        metavar="FILE",
        help="Create a sample configuration file and exit",
    )

    parser.add_argument(
        "--defold-api-only",
        action="store_true",
        help="Download only Defold engine API headers and skip default libraries",
    )

    parser.add_argument(
        "--defold-sha",
        help="Defold archive SHA to use for API headers (default: latest stable)",
    )

    args = parser.parse_args()

    # Handle --list
    if args.list:
        print("Available default libraries:\n")
        for name, config in sorted(DEFAULT_LIBRARIES.items()):
            print(f"  {name:20} - {config['description']}")
            print(f"  {'':20}   {config['url']}")
            print()
        sys.exit(0)

    # Handle --create-config
    if args.create_config:
        create_sample_config(args.create_config)
        sys.exit(0)

    if args.defold_api_only:
        download_defold_api(args.output, sha=args.defold_sha, clean=args.clean)
        sys.exit(0)

    # Determine which libraries to download
    if args.config:
        libraries = load_custom_libraries(args.config)
    elif args.libraries:
        # Filter default libraries
        libraries = {
            name: config
            for name, config in DEFAULT_LIBRARIES.items()
            if name in args.libraries
        }
        if not libraries:
            print(f"Error: None of the specified libraries found")
            print(f"Available: {', '.join(DEFAULT_LIBRARIES.keys())}")
            sys.exit(1)
    else:
        libraries = DEFAULT_LIBRARIES

    # Download
    downloader = DefoldLibraryDownloader(args.output, clean=args.clean)
    downloader.download_all(libraries)


if __name__ == "__main__":
    main()
