#!/usr/bin/env python3
"""
Debug script to examine a Defold documentation JSON file structure.
"""

import json
import sys
from pathlib import Path


def debug_doc_file(doc_path: Path):
    """Examine the structure of a documentation file."""
    if not doc_path.exists():
        print(f"Error: File not found: {doc_path}")
        return

    print(f"Reading: {doc_path}\n")

    with open(doc_path, "r", encoding="utf-8") as f:
        doc_model = json.load(f)

    print("=" * 70)
    print("TOP LEVEL KEYS")
    print("=" * 70)
    for key in doc_model.keys():
        value = doc_model[key]
        if isinstance(value, list):
            print(f"  {key}: list with {len(value)} items")
        elif isinstance(value, dict):
            print(f"  {key}: dict with {len(value)} keys")
        else:
            print(f"  {key}: {type(value).__name__}")

    print("\n" + "=" * 70)
    print("INFO SECTION")
    print("=" * 70)
    if "info" in doc_model:
        info = doc_model["info"]
        for key, value in info.items():
            print(f"  {key}: {value}")
    else:
        print("  No 'info' section found!")

    print("\n" + "=" * 70)
    print("ELEMENTS SECTION")
    print("=" * 70)
    if "elements" in doc_model:
        elements = doc_model["elements"]
        print(f"  Total elements: {len(elements)}\n")

        if elements:
            # Count by type
            types = {}
            for elem in elements:
                elem_type = elem.get("type", "UNKNOWN")
                types[elem_type] = types.get(elem_type, 0) + 1

            print("  Element types:")
            for elem_type, count in sorted(types.items()):
                print(f"    {elem_type}: {count}")

            # Show first element details
            print(f"\n  First element details:")
            first = elements[0]
            for key, value in first.items():
                if isinstance(value, list):
                    print(f"    {key}: list with {len(value)} items")
                elif isinstance(value, dict):
                    print(f"    {key}: dict")
                elif isinstance(value, str) and len(value) > 60:
                    print(f"    {key}: '{value[:60]}...'")
                else:
                    print(f"    {key}: {value}")

            # Show a few element names
            print(f"\n  Sample element names (first 10):")
            for i, elem in enumerate(elements[:10]):
                name = elem.get("name", "NO NAME")
                elem_type = elem.get("type", "?")
                print(f"    [{i}] {elem_type}: {name}")

            if len(elements) > 10:
                print(f"    ... and {len(elements) - 10} more")
        else:
            print("  WARNING: elements array is EMPTY!")
    else:
        print("  No 'elements' section found!")

    print("\n" + "=" * 70)
    print("RAW JSON (first 1000 chars)")
    print("=" * 70)
    json_str = json.dumps(doc_model, indent=2)
    print(json_str[:1000])
    if len(json_str) > 1000:
        print("...")
        print(f"\nTotal JSON size: {len(json_str)} characters")


def main():
    if len(sys.argv) < 2:
        print("Usage: python debug_doc.py <path_to_doc.json>")
        print("\nExample:")
        print("  python debug_doc.py DefoldDocs/doc/go_doc.json")
        sys.exit(1)

    doc_path = Path(sys.argv[1])
    debug_doc_file(doc_path)


if __name__ == "__main__":
    main()
