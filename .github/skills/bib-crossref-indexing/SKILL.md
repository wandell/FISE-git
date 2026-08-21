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

**Diagnosing a citation that renders as "?" or is missing from the bibliography:**

1. Confirm the exact key exists in `paperpile.bib` or `local.bib`
   (`grep -n "^@.*{the-key" *.bib`) — case matters, keys are case-sensitive.
2. If it was working before a bibliography sync, it likely got renamed in the
   newer Paperpile export — run `bib_key_audit.py` against the new master to
   find it.
3. Confirm the file with the citation is actually listed in `_quarto.yml`'s
   `chapters:`/rendered set.

## Labels and links

Use these label prefixes consistently:

- `sec-` for sections and chapters;
- `fig-` for figures and figure groups;
- `tbl-` for tables;
- `eq-` for display equations.

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
