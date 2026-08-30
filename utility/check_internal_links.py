#!/usr/bin/env python3
"""Check local links and anchors in a rendered Quarto site."""

from __future__ import annotations

import argparse
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


class PageParser(HTMLParser):
    """Collect link-like attributes and element IDs from one HTML page."""

    def __init__(self) -> None:
        super().__init__()
        self.references: list[tuple[str, str, str]] = []
        self.ids: set[str] = set()

    def handle_starttag(
        self, tag: str, attrs: list[tuple[str, str | None]]
    ) -> None:
        attributes = dict(attrs)
        element_id = attributes.get("id")
        if element_id:
            self.ids.add(element_id)

        for attribute in ("href", "src"):
            value = attributes.get(attribute)
            if value:
                self.references.append((tag, attribute, value))


def parse_page(path: Path) -> PageParser:
    parser = PageParser()
    parser.feed(path.read_text(encoding="utf-8", errors="replace"))
    return parser


def local_target(site_root: Path, page: Path, reference: str) -> tuple[Path, str] | None:
    split = urlsplit(reference)
    if split.scheme or split.netloc or reference.startswith("//"):
        return None

    path_text = unquote(split.path)
    if not path_text:
        target = page
    elif path_text.startswith("/"):
        target = site_root / path_text.lstrip("/")
    else:
        target = page.parent / path_text

    if path_text.endswith("/"):
        target /= "index.html"

    return target.resolve(), unquote(split.fragment)


def check_site(site_root: Path) -> list[str]:
    site_root = site_root.resolve()
    html_files = sorted(site_root.rglob("*.html"))
    parsed_pages = {page.resolve(): parse_page(page) for page in html_files}
    problems: list[str] = []

    for page in html_files:
        for tag, attribute, reference in parsed_pages[page.resolve()].references:
            resolved = local_target(site_root, page, reference)
            if resolved is None:
                continue

            target, fragment = resolved
            location = page.relative_to(site_root)
            if not target.exists():
                problems.append(
                    f"{location}: <{tag}> {attribute} points to missing file: {reference}"
                )
                continue

            if fragment and target.suffix.lower() == ".html":
                target_page = parsed_pages.get(target)
                if target_page is None:
                    target_page = parse_page(target)
                    parsed_pages[target] = target_page
                if fragment not in target_page.ids:
                    problems.append(
                        f"{location}: <{tag}> {attribute} points to missing anchor: {reference}"
                    )

    if not html_files:
        problems.append(f"No HTML files found under {site_root}")

    return problems


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "site_root",
        nargs="?",
        type=Path,
        default=Path("_book"),
        help="rendered site directory (default: _book)",
    )
    args = parser.parse_args()

    problems = check_site(args.site_root)
    if problems:
        print("\n".join(problems))
        print(f"\nFound {len(problems)} broken internal reference(s).")
        return 1

    html_count = sum(1 for _ in args.site_root.rglob("*.html"))
    print(f"Checked {html_count} HTML files; all internal references resolve.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
