#!/usr/bin/env python3
"""
Automatically generates an index of HTML files in the `code/` directory and their references in book chapters.
"""

import os
import re
from pathlib import Path

# Configuration
CODE_DIR = "code"
CHAPTERS_DIR = "chapters"
OUTPUT_FILE = "chapters/resources/code-html-links.qmd"


def find_html_files():
    """Find all HTML files in the code directory."""
    html_files = []
    for root, _, files in os.walk(CODE_DIR):
        for file in files:
            if file.endswith(".html"):
                # Store relative path to code directory
                rel_path = os.path.join(root, file)
                html_files.append(rel_path)
    return html_files


def find_references(html_files):
    """Search chapters for references to HTML files."""
    references = {html: [] for html in html_files}
    html_pattern = re.compile(r"(?P<path>code/.*?\.html)")
    
    for root, _, files in os.walk(CHAPTERS_DIR):
        for file in files:
            if file.endswith(".qmd"):
                chapter_path = os.path.join(root, file)
                with open(chapter_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    for match in html_pattern.finditer(content):
                        html_path = match.group("path")
                        if html_path in references:
                            references[html_path].append(chapter_path)
    return references


def generate_index(html_files, references):
    """Generate the Quarto markdown index file."""
    output = """---
title: "Code HTML Links Index"
description: "Index of all HTML files in the `code/` directory and their references in book chapters."
---

## HTML Files in `code/` Directory

This document lists all HTML files in the `code/` directory and the chapters where they are referenced.
"""
    
    # Group by subdirectory
    dirs = {}
    for html in html_files:
        dir_name = os.path.dirname(html)
        if dir_name not in dirs:
            dirs[dir_name] = []
        dirs[dir_name].append(os.path.basename(html))
    
    # List HTML files by directory
    for dir_name, files in dirs.items():
        output += f"\n### {dir_name}/\n"
        for file in sorted(files):
            output += f"- `{file}`\n"
    
    # Add references
    output += "\n## References in Chapters\n"
    for html, chapters in references.items():
        if chapters:
            output += f"\n### `{os.path.basename(html)}`\n"
            for chapter in sorted(set(chapters)):
                chapter_name = os.path.relpath(chapter, CHAPTERS_DIR)
                output += f"- **Chapter**: `{chapter_name}`\n"
    
    # Write to file
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        f.write(output)


if __name__ == "__main__":
    print("Generating HTML links index...")
    html_files = find_html_files()
    references = find_references(html_files)
    generate_index(html_files, references)
    print(f"Index generated at: {OUTPUT_FILE}")