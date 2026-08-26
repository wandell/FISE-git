#!/usr/bin/env python3
"""
Check that every bibliographic citation key used in the book's .qmd files
resolves to an entry in paperpile.bib or local.bib (per _quarto.yml's
`bibliography:` list), and flag citations that only fail because of a
case mismatch (e.g. `@DiCarlo2000-daylight` used in prose vs. the
`dicarlo2000-daylight` key a Paperpile re-export produced).

This does NOT flag `@sec-`, `@fig-`, `@tbl-`, `@eq-` cross-reference
labels -- those are Quarto crossrefs, not bibliography citations, and
they are validated separately by `quarto render`.

Usage:
    python3 utility/check_citations.py               # report only
    python3 utility/check_citations.py --fix          # also rewrite
                                                        # case-only mismatches
                                                        # in place

Exit status is nonzero if any citation remains unresolved (or, without
--fix, if any case-only mismatch remains unfixed).
"""
import argparse
import difflib
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BIB_FILES = ["paperpile.bib", "local.bib"]
CHAPTER_TARGETS = ["index.qmd", "chapters"]

BIB_KEY_RE = re.compile(r'^@\w+\{\s*([^,\s]+)\s*,', re.MULTILINE)

XREF_PREFIXES = ("sec-", "fig-", "tbl-", "eq-")

# Pandoc citation-key charset. Deliberately excludes ) ] , ; so those
# always terminate a match rather than needing to be stripped after.
CITE_TOKEN_RE = re.compile(r'(?<![\w@-])-?@([A-Za-z0-9_:.#$%&+?<>~/-]+)')

COMMENT_RE = re.compile(r'<!--.*?-->', re.DOTALL)
FENCE_RE = re.compile(r'^```.*?^```', re.DOTALL | re.MULTILINE)
INLINE_CODE_RE = re.compile(r'`[^`\n]*`')


def find_bib_keys(bib_path: Path) -> set:
    if not bib_path.exists():
        return set()
    text = bib_path.read_text(encoding="utf-8", errors="ignore")
    return set(BIB_KEY_RE.findall(text))


def excluded_spans(text: str):
    spans = []
    for pat in (COMMENT_RE, FENCE_RE, INLINE_CODE_RE):
        spans.extend(m.span() for m in pat.finditer(text))
    return spans


def in_span(pos, spans):
    return any(start <= pos < end for start, end in spans)


def split_trailing_period(raw: str):
    core = raw.rstrip(".")
    return core, raw[len(core):]


def target_files():
    files = []
    for target in CHAPTER_TARGETS:
        p = ROOT / target
        if p.is_file():
            files.append(p)
        elif p.is_dir():
            files.extend(sorted(p.rglob("*.qmd")))
    return files


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fix", action="store_true",
                         help="rewrite case-only mismatches in place")
    args = parser.parse_args()

    bib_keys = set()
    for name in BIB_FILES:
        bib_keys |= find_bib_keys(ROOT / name)

    lower_map = defaultdict(list)
    for k in bib_keys:
        lower_map[k.lower()].append(k)
    lower_list = list(lower_map.keys())

    case_mismatches = []   # (file, lineno, used, correct)
    ambiguous = []         # (file, lineno, used, candidates)
    unresolved = []        # (file, lineno, used, suggestions)
    fixed_count = 0

    for path in target_files():
        text = path.read_text(encoding="utf-8", errors="ignore")
        spans = excluded_spans(text)
        replacements = []  # (start, end, new_text), applied back-to-front

        for m in CITE_TOKEN_RE.finditer(text):
            if in_span(m.start(), spans):
                continue
            raw = m.group(1)
            core, trailing = split_trailing_period(raw)
            if core.lower().startswith(XREF_PREFIXES):
                continue
            lineno = text.count("\n", 0, m.start(1)) + 1

            if core in bib_keys:
                continue

            candidates = lower_map.get(core.lower())
            if candidates and len(candidates) == 1:
                correct = candidates[0]
                case_mismatches.append((path, lineno, core, correct))
                if args.fix:
                    start = m.start(1)
                    end = start + len(core)
                    replacements.append((start, end, correct))
                    fixed_count += 1
            elif candidates:
                ambiguous.append((path, lineno, core, candidates))
            else:
                suggestions = difflib.get_close_matches(
                    core.lower(), lower_list, n=3, cutoff=0.6)
                flat = [c for s in suggestions for c in lower_map[s]]
                unresolved.append((path, lineno, core, flat))

        if replacements and args.fix:
            replacements.sort(key=lambda r: r[0], reverse=True)
            for start, end, new_text in replacements:
                text = text[:start] + new_text + text[end:]
            path.write_text(text, encoding="utf-8")

    def rel(p):
        return p.relative_to(ROOT)

    if args.fix:
        print(f"Fixed {fixed_count} case-only citation mismatch(es).\n")
    elif case_mismatches:
        print(f"{len(case_mismatches)} case-only mismatch(es) found "
              f"(re-run with --fix to correct):\n")
        for path, lineno, used, correct in case_mismatches:
            print(f"  {rel(path)}:{lineno}  @{used}  ->  @{correct}")
        print()

    if ambiguous:
        print(f"{len(ambiguous)} ambiguous case-insensitive match(es) "
              f"(multiple bib keys differ only by case -- fix manually):\n")
        for path, lineno, used, candidates in ambiguous:
            print(f"  {rel(path)}:{lineno}  @{used}  ->  "
                  f"{', '.join('@' + c for c in candidates)}")
        print()

    if unresolved:
        print(f"{len(unresolved)} unresolved citation(s) (no matching key "
              f"in {' or '.join(BIB_FILES)}):\n")
        for path, lineno, used, suggestions in unresolved:
            if suggestions:
                sug = ", ".join("@" + s for s in suggestions)
                print(f"  {rel(path)}:{lineno}  @{used}  (did you mean: {sug}?)")
            else:
                print(f"  {rel(path)}:{lineno}  @{used}  (no close match)")
        print()

    if not (case_mismatches or ambiguous or unresolved):
        print("All citations resolve cleanly against "
              f"{' and '.join(BIB_FILES)}.")

    remaining = unresolved or ambiguous or (case_mismatches and not args.fix)
    sys.exit(1 if remaining else 0)


if __name__ == "__main__":
    main()
