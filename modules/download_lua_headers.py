#!/usr/bin/env python3
"""
Parse Defold docs and generate Lua files for IDE autocompletion.
This is a Python port of the Java implementation.
"""

import json
import os
import re
import sys
import zipfile
from io import BytesIO
from pathlib import Path
from typing import List, Dict, Any, Optional
from urllib.request import urlopen
from html.parser import HTMLParser
from io import StringIO


class HTMLToPlainText(HTMLParser):
    """Convert HTML to plain text for Lua comments."""

    def __init__(self):
        super().__init__()
        self.text = StringIO()
        self.inside_table = False

    def handle_data(self, data):
        if not self.inside_table:
            # Replace newlines with comment continuation
            formatted = data.replace("\n", "\n---")
            self.text.write(formatted)

    def handle_starttag(self, tag, attrs):
        if tag == "li":
            self.text.write("\n--- * ")
        elif tag in ("p", "h1", "h2", "h3", "h4", "h5", "tr"):
            self.text.write("\n---")
        elif tag == "table":
            self.inside_table = True
        elif tag == "br":
            self.text.write("\n---")

    def handle_endtag(self, tag):
        if tag == "table":
            self.inside_table = False

    def get_text(self):
        return self.text.getvalue()


def html_to_plain_text(html_str: str) -> str:
    """Convert HTML string to plain text."""
    if not html_str:
        return ""
    parser = HTMLToPlainText()
    parser.feed(html_str)
    text = parser.get_text()
    # Clean up trailing ---
    if text.endswith("---"):
        text = text[:-3]
    return text.strip()


class LuaBuilder:
    """Build Lua header files from documentation models."""

    IGNORE_DOCS = {
        "base_doc.json",
        "engine_doc.json",
        "dmTime_doc.json",
        "camera_doc.json",
        "coroutine_doc.json",
        "crash_doc.json",
        "debug_doc.json",
        "dmAlign_doc.json",
        "dmArray_doc.json",
        "dmBuffer_doc.json",
        "dmConfigFile_doc.json",
        "dmExtension_doc.json",
        "dmGraphics_doc.json",
        "dmHash_doc.json",
        "dmLog_doc.json",
        "dmScript_doc.json",
        "package_doc.json",
        "sharedlibrary_doc.json",
        "table_doc.json",
        "dmMutex_doc.json",
        "dmConditionVariable_doc.json",
        "dmJson_doc.json",
        "string_doc.json",  # lua plugin already has it
        "dmStringFunc_doc.json",
        "iap_doc.json",
        "webview_doc.json",
        "dmCrypt_doc.json",
        "dmThread_doc.json",
        "facebook_doc.json",
        "iac_doc.json",
        "push_doc.json",
        "dmGameObject_doc.json",
        "dmTransform_doc.json",
        "dmGameSystem_doc.json",
        "dmDDF_doc.json",
    }

    BASE_LUA = """---@class vector3
---@field x number
---@field y number
---@field z number

---@class vector4
---@field x number
---@field y number
---@field z number
---@field w number

---@class quaternion
---@field x number
---@field y number
---@field z number
---@field w number

---@alias quat quaternion

---@class url
---@field socket
---@field path
---@field fragment

---@alias hash userdata
---@alias constant userdata
---@alias bool boolean
---@alias float number
---@alias object userdata
---@alias matrix4 userdata
---@alias node userdata

--mb use number instead of vector4
---@alias vector vector4

--luasocket
---@alias master userdata
---@alias unconnected userdata
---@alias client userdata

--render
---@alias constant_buffer userdata
---@alias render_target userdata
---@alias predicate userdata

--- Calls error if the value of its argument `v` is false (i.e., **nil** or
--- **false**); otherwise, returns all its arguments. In case of error,
--- `message` is the error object; when absent, it defaults to "assertion
--- failed!"
---@generic ANY
---@overload fun(v:any):any
---@param v ANY
---@param message string
---@return ANY
function assert(v,message) return v end"""

    def format_parameter_name(self, name: str) -> str:
        """Format parameter name according to Lua conventions."""
        name = re.sub(r'-|("\\*")', "_", name)
        if name == "repeat":
            name = "_repeat"
        if name.endswith("...]"):
            return "..."
        if "[" in name:
            return name.replace("[", "").replace("]", "")
        return name

    def build_parameter_doc(self, param: Dict[str, Any]) -> str:
        """Build parameter documentation string."""
        types = param.get("types", [])
        # Replace "function" with "fun" in type annotations
        types = [t.replace("function", "fun") for t in types]
        type_str = "|".join(types) if types else "any"

        # Check if parameter is optional
        is_optional = param.get("is_optional", "False")
        if isinstance(is_optional, str):
            is_optional = is_optional.lower() == "true"

        # Add nil to type if optional
        if is_optional and "nil" not in type_str:
            type_str = f"{type_str}|nil"

        doc = param.get("doc", "")
        # Remove HTML lists from inline documentation
        if "<ul>" in doc:
            doc = doc[: doc.index("<ul>")]
        if "<dl>" in doc:
            doc = doc[: doc.index("<dl>")]

        plain_doc = html_to_plain_text(doc).replace("\n---", " ")

        return f"{type_str} {plain_doc}".rstrip()

    def build(self, doc_model: Dict[str, Any]) -> str:
        """Build Lua file content from documentation model."""
        info = doc_model.get("info", {})
        elements = doc_model.get("elements", [])

        # Handle None case
        if elements is None:
            elements = []

        namespace = info.get("namespace", "")
        is_builtins = namespace == "builtins"

        lines = []

        # Add header documentation
        brief = html_to_plain_text(info.get("brief", ""))
        if brief:
            lines.append(f"---{brief}")

        description = html_to_plain_text(info.get("description", ""))
        if description:
            lines.append(f"---{description}")

        # Add class declaration (except for builtins)
        if not is_builtins:
            lines.append(f"---@class {namespace}")
            lines.append(f"{namespace} = {{}}")
        else:
            lines.append("")

        # Sort elements by name
        elements.sort(key=lambda e: e.get("name", ""))

        for element in elements:
            element_type = element.get("type", "")
            name = element.get("name", "")

            if element_type == "FUNCTION":
                # Add function description
                desc = html_to_plain_text(element.get("description", ""))
                if desc:
                    lines.append(f"---{desc}")

                # Add parameter annotations
                parameters = element.get("parameters", [])
                for param in parameters:
                    param_name = self.format_parameter_name(param.get("name", ""))
                    param_doc = self.build_parameter_doc(param)

                    # Don't add @param annotation for varargs
                    if param_name == "...":
                        lines.append(f"--- {param_name} {param_doc}")
                    else:
                        lines.append(f"---@param {param_name} {param_doc}")

                # Add return value annotations
                returnvalues = element.get("returnvalues", [])
                for ret in returnvalues:
                    ret_doc = self.build_parameter_doc(ret)
                    lines.append(f"---@return {ret_doc}")

                # Build function signature
                param_names = [
                    self.format_parameter_name(p.get("name", "")) for p in parameters
                ]
                params_str = ", ".join(param_names)
                lines.append(f"function {name}({params_str}) end")
                lines.append("")

            elif element_type in ("VARIABLE", "PROPERTY", "CONSTANT"):
                # Handle VARIABLE, PROPERTY (game object properties), and CONSTANT types
                brief = html_to_plain_text(element.get("brief", ""))
                description = html_to_plain_text(element.get("description", ""))

                if brief:
                    lines.append(f"---{brief}")
                if description and description != brief:
                    lines.append(f"---{description}")

                lines.append(f"{name} = nil")
                lines.append("")

            elif element_type == "MESSAGE":
                # Skip messages
                pass

        # Add return statement for modules (except builtins)
        if not is_builtins:
            lines.append("")
            lines.append(f"return {namespace}")

        return "\n".join(lines)


def get_last_defold_version() -> tuple[str, str]:
    """Get the latest Defold version and SHA."""
    url = "http://d.defold.com/stable/info.json"
    print(f"Fetching version info from {url}...")

    with urlopen(url) as response:
        data = json.loads(response.read())
        version = data["version"]
        sha = data["sha1"]

    print(f"Version: {version}")
    print(f"SHA1: {sha}")

    return version, sha


def download_docs(sha: str, output_dir: Path) -> Path:
    """Download and extract documentation ZIP file."""
    url = f"http://d.defold.com/archive/{sha}/engine/share/ref-doc.zip"
    print(f"Downloading documentation from {url}...")

    with urlopen(url) as response:
        zip_data = BytesIO(response.read())

    doc_dir = output_dir / "doc"
    doc_dir.mkdir(parents=True, exist_ok=True)

    print(f"Extracting documentation to {doc_dir}...")
    with zipfile.ZipFile(zip_data) as zip_file:
        for entry in zip_file.namelist():
            if entry.endswith(".json"):
                zip_file.extract(entry, output_dir)

    return doc_dir


def generate_lua_files(doc_dir: Path, api_dir: Path):
    """Generate Lua header files from documentation."""
    builder = LuaBuilder()
    api_dir.mkdir(parents=True, exist_ok=True)

    json_files = list(doc_dir.glob("*.json"))
    print(f"Found {len(json_files)} documentation files")

    generated_count = 0

    for json_file in json_files:
        # Skip ignored documentation files
        if json_file.name in builder.IGNORE_DOCS:
            print(f"Skipping {json_file.name} (ignored)")
            continue

        try:
            with open(json_file, "r", encoding="utf-8") as f:
                doc_model = json.load(f)

            info = doc_model.get("info", {})
            file_ext = info.get("file") or ""
            group = info.get("group") or ""
            namespace = info.get("namespace", "")
            elements = doc_model.get("elements", [])

            # Handle None case
            if elements is None:
                elements = []

            # Debug output
            name = info.get("name", json_file.stem)
            print(
                f"Processing {json_file.name}: name={name}, namespace={namespace}, elements={len(elements)}, file={file_ext}, group={group}"
            )

            # Skip C++ headers and DEFOLD SDK group
            # Handle None values properly
            if (file_ext and file_ext.endswith(".h")) or group == "DEFOLD SDK":
                print(f"Skipping {json_file.name} (C++ or SDK)")
                continue

            # Generate Lua file
            lua_content = builder.build(doc_model)

            # Create output filename
            output_name = name.replace(" ", "_").lower() + ".lua"
            output_path = api_dir / output_name

            # Check if file already exists and has more content
            should_write = True
            if output_path.exists():
                existing_size = output_path.stat().st_size
                if existing_size > len(lua_content):
                    print(
                        f"⚠ Skipping {output_name} - existing file is larger ({existing_size} > {len(lua_content)} bytes)"
                    )
                    should_write = False

            if should_write:
                with open(output_path, "w", encoding="utf-8") as f:
                    f.write(lua_content)

                lines_count = lua_content.count("\n")
                print(
                    f"✓ Generated {output_name} ({len(lua_content)} bytes, {lines_count} lines, {len(elements)} elements)"
                )
                generated_count += 1

        except Exception as e:
            print(f"Error processing {json_file.name}: {e}")
            import traceback

            traceback.print_exc()

    # Write base.lua
    base_path = api_dir / "base.lua"
    with open(base_path, "w", encoding="utf-8") as f:
        f.write(builder.BASE_LUA)
    print(f"Generated base.lua")
    generated_count += 1

    print(f"\nGenerated {generated_count} Lua header files")


def test_doc_file(doc_path: Path):
    """Test mode to examine a single documentation file."""
    print(f"Testing documentation file: {doc_path}")

    with open(doc_path, "r", encoding="utf-8") as f:
        doc_model = json.load(f)

    print("\n=== Document Structure ===")
    print(f"Keys: {list(doc_model.keys())}")

    if "info" in doc_model:
        info = doc_model["info"]
        print(f"\nInfo keys: {list(info.keys())}")
        print(f"Name: {info.get('name')}")
        print(f"Namespace: {info.get('namespace')}")
        print(f"File: {info.get('file')}")
        print(f"Group: {info.get('group')}")

    if "elements" in doc_model:
        elements = doc_model["elements"]
        print(f"\nElements count: {len(elements)}")
        if elements:
            print(f"First element keys: {list(elements[0].keys())}")
            print(f"First element: {json.dumps(elements[0], indent=2)[:500]}...")

    # Try to build it
    builder = LuaBuilder()
    try:
        lua_content = builder.build(doc_model)
        print(f"\n=== Generated Lua ({len(lua_content)} bytes) ===")
        print(lua_content[:1000])
        if len(lua_content) > 1000:
            print("...")
    except Exception as e:
        print(f"\nError building: {e}")
        import traceback

        traceback.print_exc()


def main():
    """Main entry point."""
    # Test mode: examine a specific doc file
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        if len(sys.argv) < 3:
            print("Usage: python download_lua_headers.py --test <path_to_doc.json>")
            sys.exit(1)
        test_doc_file(Path(sys.argv[2]))
        return

    # Allow specifying SHA as command line argument
    if len(sys.argv) > 1:
        sha = sys.argv[1]
        version = "custom"
    else:
        version, sha = get_last_defold_version()

    # Setup output directories
    output_dir = Path("lua_annotations")
    api_dir = output_dir / "api"

    # Clean up existing output
    if output_dir.exists():
        print(f"Cleaning up existing {output_dir}...")
        import shutil

        shutil.rmtree(output_dir)

    output_dir.mkdir(parents=True, exist_ok=True)

    # Download and extract documentation
    doc_dir = download_docs(sha, output_dir)

    # Generate Lua files
    generate_lua_files(doc_dir, api_dir)

    print(f"\n✓ Complete! Lua headers saved to: {api_dir.absolute()}")


if __name__ == "__main__":
    main()
