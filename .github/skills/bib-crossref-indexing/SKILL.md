---
name: bib-crossref-indexing
description: Add, edit, or diagnose FISE citations, bibliography entries, cross-references, equations, figures, tables, and footnotes. Use when working with paperpile.bib, local.bib, or labels such as sec-, fig-, tbl-, and eq- — also covers keeping paperpile.bib in sync with the shared master library across the FISE-2025-Quarto / FOV-2025-Quarto / MRI-2026 projects.
---

# FISE citations and cross-references

## Sources of truth

The project bibliography is `paperpile.bib` plus `local.bib`, both configured in
`_quarto.yml`. Cite only keys that exist in one of those files, preserving their
exact spelling and case. Quarto cross-references are book-scale links and must
point to an existing, unique label in a rendered source file.

- Search before citing or linking; never fabricate a BibTeX key or reference ID.
- Prefer the original paper, technical standard, primary historical source, or
  authoritative technical documentation appropriate to the claim.
- Cite claims that are empirical, historical, numerical, or not established by
  the surrounding derivation. Do not use citations as a substitute for explaining
  a concept.

## Citations

Use Pandoc citation syntax. Prefer a narrative citation when the author is part
of the sentence, and a parenthetical citation when it supports a claim.

Good:

```markdown
@fossum1993-ccd-dinosaurs described the engineering case for CMOS sensors.

Shot-noise behavior has also been measured in image-sensor systems
[@mandel1959-poissonabsorptions; @preece2022-photontransfer].
```

Bad:

```markdown
Fossum (1993) [citation needed] said CMOS is useful.
```

Keep the book’s existing author-date CSL behavior. Do not paste manually formatted
references into chapter prose or duplicate the bibliography in a chapter.

## BibTeX maintenance

The repository’s VS Code settings associate `.bib` files with BibTeX and select
the `xrimson.bibtex-tidy` formatter. Treat formatting as a mechanical maintenance
operation, not a content-editing workflow: inspect the diff after it runs and do
not rewrite `paperpile.bib` while making an unrelated prose change. If a user asks
to format or diagnose the bibliography, first check that `bibtex-tidy` is
available; its modifying invocation is `bibtex-tidy --modify paperpile.bib`. If
`paperpile.bib` was just synced in from the shared master (see below), review the
formatter's diff carefully — it will touch every entry the sync just brought in.

Good: validate a newly added entry, preserve its citation key, and review the
formatter’s diff.

Bad: run a global formatter to repair one missing citation key without checking
the resulting bibliography changes.

## Bibliography file coordination (multi-project)

This repo is one of three actively coordinated Quarto book projects — the others
are `FOV-2025-Quarto` and `MRI-2026`. A fourth project, `FOV-1995-Quarto`, is
frozen (already published, will not change again) and is intentionally excluded
from all of this.

**Architecture**: one fixed master library, plus a small per-project local file.

- `paperpile.bib` in this repo is a **committed copy** of a shared master library
  that lives at `~/Documents/paperpile.bib` on the maintainer's machine. It's
  refreshed by a sync script, not edited by hand for new sources.
- `local.bib` holds references specific to this project that aren't yet in the
  shared Paperpile library. New citations that aren't already in `paperpile.bib`
  go here, not into `paperpile.bib` directly.

**Rules:**

- Never hand-edit `paperpile.bib` to add a new reference — it will be overwritten
  wholesale the next time the master is synced in. Add new sources to `local.bib`
  instead.
- Before adding a citation, check whether the source is already in `paperpile.bib`
  (`grep -m1 "^@.*authorname" paperpile.bib`) to avoid creating a duplicate entry
  for the same paper under a different key in `local.bib`.
- Citation keys are **not guaranteed stable across Paperpile re-exports** — the
  same paper can get a different key in a later export (confirmed in practice:
  one paper appeared as both `Abdelhamed2021-mo` and
  `abdelhamed2021-mofig-modulation-transfer` across two exports of the same
  library). Don't manually renumber or "clean up" keys in `paperpile.bib`; if a
  sync breaks an existing citation, fix the citation in the `.qmd`, not the bib
  file.
- This repo also has an unreferenced `local/softed_refs.bib` (a reformatted
  full-library dump, not wired into `_quarto.yml`). It predates the `local.bib`
  convention above and is **not** this project's local-additions file — don't
  treat it as one, and confirm with the maintainer before deleting or repurposing
  it.
- "Sync the bibliography" / "update paperpile.bib from the master" is a cross-repo
  operation run from `~/Documents`, not something to do by directly editing this
  repo's copy.

**Maintenance scripts** (`~/Documents/`, not part of this repo — they operate
across all three active projects):

- `bib_sync.sh` — copies the current master `paperpile.bib` into each active
  project (this one included) and can commit the change.
- `bib_key_audit.py <project-dir> <candidate-bib>` — before overwriting this
  project's `paperpile.bib` with a fresher master, checks whether any `@citekey`
  actually used in this project's `.qmd` files would go missing. Run this first
  if `paperpile.bib` here hasn't been synced in a while.
- `bib_merge_check.py <master.bib> <local.bib>...` — reports which entries in
  `local.bib` are genuinely new versus already present in the master under a
  different key (compares by DOI, falling back to title). Run periodically to
  find what's ready to add to Paperpile and fold back into the shared master.

**Project-local script** (`utility/check_citations.py`, part of this repo):

- Checks every `@key` citation used in `index.qmd` and `chapters/**/*.qmd`
  against the keys defined in `paperpile.bib` and `local.bib`. Ignores Quarto
  crossrefs (`@sec-`, `@fig-`, `@tbl-`, `@eq-`), HTML comments, and code
  spans, so it only flags real bibliography citations.
- Run with no flags for a report: case-only mismatches, ambiguous
  case-insensitive collisions, and fully unresolved keys (with best-guess
  suggestions for the latter, via `difflib` against the combined key list).
- Run with `--fix` to auto-correct case-only mismatches in place — safe to
  run any time, e.g. right after a `paperpile.bib` sync changes key casing.
  It deliberately leaves ambiguous and fully unresolved keys alone; those
  need a human to confirm the right paper (check title/year against
  `paperpile.bib`, or against a fresh Paperpile BibTeX export if the paper
  is recent) before editing prose or `local.bib`.
- `chapters/resources/PCC.qmd` is intentionally excluded from being a
  concern here: it's a personal source-material file, not in `_quarto.yml`'s
  `book.chapters`, and its ~192 citations use an old, unrelated key
  convention. Don't let it inflate the sense of how broken citations are —
  fix its citations only opportunistically, as specific material is copied
  out of it into a real chapter.

**Diagnosing a citation that renders as "?" or is missing from the bibliography:**

1. Run `python3 utility/check_citations.py` first — it does steps 1-2 below
   automatically across the whole book and suggests fixes.
2. Confirm the exact key exists in `paperpile.bib` or `local.bib`
   (`grep -n "^@.*{the-key" *.bib`) — case matters, keys are case-sensitive.
3. If it was working before a bibliography sync, it likely got renamed in the
   newer Paperpile export — run `bib_key_audit.py` against the new master to
   find it.
4. Confirm the file with the citation is actually listed in `_quarto.yml`'s
   `chapters:`/rendered set.

## Labels and links

Use these label prefixes consistently:

- `sec-` for sections and chapters;
- `fig-` for figures and figure groups;
- `tbl-` for tables;
- `eq-` for display equations;
- `nte-` for a numbered, cross-referenced `.callout-note` (confirmed against
  Quarto's crossref filter source, `ref_type = "nte"`); the sibling callout
  types follow the same pattern if ever needed: `wrn-` (warning), `cau-`
  (caution), `tip-` (tip), `imp-` (important).

A cross-referenced callout needs the id on the fenced div itself, and the
callout's own heading becomes its crossref title:

```markdown
::: {#nte-my-callout .callout-note}
## Cross-referenced Note
This is a note that you can refer to.
:::

See @nte-my-callout for more info.
```

Most callouts in this book are *not* cross-referenced (a plain `title=` on
`.callout-note` is enough for an ordinary aside) — reach for `#nte-` only when
another section actually needs to point back at this specific callout.

Label names should be lowercase, concise, semantic, and stable. A label is an
identifier, not a sentence; do not encode numbering in it. Confirm uniqueness
across the book before adding it.

Good:

```markdown
## Pixel response curve {#sec-pixel-responsecurve}

![A CMOS sensor response curve.](images/sensors/15-parameters/03-responselinearity.png){#fig-sensor-linearity width="60%"}

As shown in @fig-sensor-linearity, the response eventually saturates.
```

Bad:

```markdown
## Pixel response curve {#section-3}

See the figure above.
```

Use `@sec-name`, `@fig-name`, `@tbl-name`, and `@eq-name` in prose. Let Quarto
render the configured prefixes (Figure, Table, Section); do not hard-code a
number such as “Figure 3.2.”

## Equations and tables

Put a cross-reference label after the display-math block and introduce every
symbol in nearby prose. Refer to an equation only when the reader benefits from
returning to it.

Good:

```markdown
$$
E = \frac{hc}{\lambda}
$$ {#eq-photon-energy}

Equation @eq-photon-energy relates photon energy to wavelength.
```

Bad:

```markdown
Equation (4): $E=hc/lambda$.
```

Use a Quarto table with a `#tbl-` identifier when it needs a caption or later
reference. Do not refer to a table by visual position.

## Footnotes

Use a footnote for a brief, nonessential clarification, provenance detail, or
link that would derail the paragraph. Keep it self-contained and avoid putting a
core definition or multi-paragraph argument in a footnote.

Good:

```markdown
The term has a different meaning in radiometry.[^radiometry-term]

[^radiometry-term]: Here it denotes radiant flux per unit area.
```

Bad:

```markdown
The central derivation is in a footnote.[^1]
```

## Diagnose broken references

Check in this order: the target exists; its label is unique; the label is attached
to the correct block; the reference syntax matches the prefix; and the relevant
chapter is included in `book.chapters`. Render after the repair. Avoid changing a
working label because its prose wording changes.

If all five checks pass but `quarto render chapters/<file>.qmd --to html` still
prints `Unable to resolve crossref @sec-...` for a reference into a *different*
chapter, suspect a stale crossref index rather than the label. Quarto caches the
book-wide crossref index under `.quarto/xref/` (and `.quarto/idx/`) and reuses it
for single-chapter renders/previews instead of rebuilding it; after a chapter
reorg or a label rename, that cache can keep resolving the *old* label (or a
whole superseded chapter structure) and never learn the new one. Confirm before
touching anything: `grep -rl "sec-your-label" .quarto/xref/` — if it's empty even
though the label exists correctly in the source, the cache is stale. Per
`quarto-authoring`'s render-diagnosis rule, don't delete `.quarto/` without
explicit authorization; once authorized, `rm -rf .quarto/xref .quarto/idx` and
run a full `quarto render` (not just the one chapter) to rebuild the index, then
re-render the original chapter to confirm the warning is gone. This also tends to
surface other references that still point at labels renamed during the same
reorg — grep the book for the old label name and update any stragglers.
