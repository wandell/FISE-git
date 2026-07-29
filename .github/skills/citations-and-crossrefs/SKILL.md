---
name: citations-and-crossrefs
description: Add, edit, or diagnose FISE citations, bibliography entries, cross-references, equations, figures, tables, and footnotes. Use when working with paperpile.bib or labels such as sec-, fig-, tbl-, and eq-.
---

# FISE citations and cross-references

## Sources of truth

The project bibliography is `paperpile.bib`, configured in `_quarto.yml`. Cite
only keys that exist in that file, preserving their exact spelling and case.
Quarto cross-references are book-scale links and must point to an existing,
unique label in a rendered source file.

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
available; its modifying invocation is `bibtex-tidy --modify paperpile.bib`.

Good: validate a newly added entry, preserve its citation key, and review the
formatter’s diff.

Bad: run a global formatter to repair one missing citation key without checking
the resulting bibliography changes.

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
