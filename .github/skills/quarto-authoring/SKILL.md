---
name: quarto-authoring
description: Author, edit, or debug FISE Quarto book content and configuration. Use when changing .qmd files, callouts, layouts, YAML, HTML/PDF-specific content, or _quarto.yml.
---

# FISE Quarto authoring

## Scope and operating rules

This repository is a Quarto **book**. The authoritative project configuration is
`_quarto.yml`; the primary published output is HTML. Preserve the possibility of
PDF output unless a change is explicitly HTML-only.

- Inspect the target file and `_quarto.yml` before proposing a path, label, or
  configuration key. Do not invent any of them.
- Make the smallest coherent change. Do not reorganize chapters, assets, or
  project configuration merely to make a local edit look cleaner.
- Keep chapter YAML minimal and inherit project defaults unless the chapter has a
  demonstrable exception.
- After an authoring change, render the smallest relevant scope when practical:
  `quarto render path/to/chapter.qmd --to html`. Use the project render for
  project-wide features such as book cross-references.

## Headings, labels, and overview sections

Use sentence-style headings and explicit, stable labels where a reader or other
chapter will refer to the section. Existing chapter labels use `sec-` prefixes.
Most instructional chapters begin with an overview section immediately after the
chapter title.

Good:

```markdown
# Wavefronts {#sec-optics-wavefront}

## Wavefronts overview {#sec-optics-wavefront-overview}
```

Bad:

```markdown
# WAVEFRONTS

## Overview
```

Do not create a second level-one heading to simulate an overview; use `##`.
Part-divider files are an established exception: retain their `.unlisted` and
`.unnumbered` attributes.

## Callouts and content variants

Use callouts for a bounded aside: historical context, a worked intuition, a
definition that would interrupt the main path, or an implementation detail.
Give the callout a useful title; use `collapse="true"` for optional long material.
Keep the central argument in ordinary prose.

Good:

```markdown
::: {.callout-note title="Why the approximation helps" collapse="false"}
The approximation isolates the dependence that matters for this model.
:::
```

Bad:

```markdown
::: {.callout-note}
Everything important in this section goes here.
:::
```

For format-specific media or layout, state the behavior and supply a fallback.
Use the project’s established `content-visible` blocks for alternatives.

```markdown
::: {.content-visible when-format="html"}
![Animated result.](images/example.mp4){width="80%"}
:::

::: {.content-visible when-format="pdf"}
![Representative frame.](images/example.png){width="80%"}
:::
```

## Layout and format awareness

- Use ordinary Markdown first. Add Quarto layout attributes only when they make
  a real reading improvement.
- Reuse established patterns such as `.column-margin`, `layout`, and
  `.panel-tabset`; inspect a nearby working example before adding one.
- Treat interactive panels, video autoplay, and visual wrapping as HTML features.
  Do not imply that they will reproduce in PDF.
- Keep raw HTML to a justified minimum. Prefer Quarto syntax and CSS already in
  `styles/` over inline styling.
- Self-close void HTML elements (`<source ... />`, `<img ... />`, `<br />`) in
  any raw HTML placed inside a fenced Div (e.g. `.content-visible` video/audio
  embeds). An unclosed void tag can make pandoc misjudge where the Div's `:::`
  fence closes, producing a confusing "unclosed Div" warning whose reported
  line number does not match the source (see Render diagnosis).
- For a deliberately portable single-file HTML artifact, use Quarto’s
  `embed-resources: true` only at the document or rendering scope that needs it;
  do not make the whole book self-contained by default.

Good:

```markdown
::: {.column-margin}
![A supplementary detail.](images/example.png){width="100%"}
:::
```

Bad:

```html
<img src="images/example.png" style="position:absolute; left: 37px">
```

## Configuration changes

`_quarto.yml` defines book order, bibliography, cross-reference prefixes,
execution defaults, CSS, and HTML formatting. Change it only for a project-wide
need, preserve YAML indentation, and explain the rendered effect.

Good: add a new chapter only after its file exists and place it in the appropriate
part of `book.chapters`.

Bad: change `project.resources`, `execute`, or `format` speculatively while fixing
a single chapter.

## Publishing to GitHub Pages

The site is published from the local machine, not CI. `quarto publish gh-pages`
renders the project (HTML only, since PDF output is commented out in
`format:` in `_quarto.yml`) and pushes the rendered `_book` output to the
`gh-pages` branch on `origin` (https://github.com/wandell/FISE-git), which
GitHub Pages serves.

```
quarto publish gh-pages
```

A separate `quarto render --to html` beforehand is unnecessary: `quarto
publish` renders by default and only skips rendering when passed
`--no-render`. Do not run `quarto publish gh-pages` on the user's behalf
without confirmation — it pushes to a shared branch.

## Render diagnosis

For a failing render, start with the file, line, and complete error text. Run
`quarto check` for installation/dependency problems, render the smallest failing
chapter for localized failures, and use `quarto render --debug` only when ordinary
output is insufficient. Inspect VS Code’s Output panel when the editor reports a
Quarto extension error. If output appears stale, verify the relevant source and
render target before proposing cleanup; do not delete `_book/` or caches without
explicit authorization.

Good: identify the duplicate label, repair it, and render the affected chapter.

Bad: erase generated output before reading the render error.

### Warnings whose reported line number doesn't match the source file

Pandoc-filter warnings (e.g. "unclosed Div", shortcode errors) report a line
number in the *fully resolved* document — after `{{< include >}}` expansion and
Quarto's Lua filters run — not the raw `.qmd` line count. That number can look
impossibly large for a short chapter, and the book-level render log doesn't name
a file at all for some warnings (e.g. "Shortcode 'include' not found"). Two
techniques resolve this ambiguity:

1. Render the single suspect chapter in isolation
   (`quarto render chapters/<file>.qmd --to html`) to confirm which chapter
   actually produces the warning — the book-level log's ordering only
   approximates which file a given line belongs to.
2. Get an accurate line number by rendering with `-M keep-md:true`, which
   leaves a resolved `chapters/<file>.html.md` next to the source (delete it
   afterward — it's a debug artifact, not a real doc). Run plain `pandoc
   chapters/<file>.html.md -f markdown -t html -o /dev/null` on that resolved
   file; unlike the Quarto-wrapped render, plain pandoc prints the file name
   with its warning, and the line number matches that resolved file exactly.

A `{{< include ... >}}` shortcode must be a block on its own line, not glued to
following prose on the same line — inline placement can make Quarto fail to
recognize the shortcode at all ("Shortcode 'include' not found") rather than
just misplacing it.

Good: `quarto render chapters/human-01-seeing.qmd --to html -M keep-md:true`,
then `pandoc chapters/human-01-seeing.html.md -t html -o /dev/null` to get a
warning with a real, matching line number; delete the `.html.md` afterward.

Bad: guess which chapter a book-level warning belongs to from log order alone,
or hunt for a line number in the raw `.qmd` that the resolved document doesn't
actually have.

## Completion check

Before handing off, verify that headings are hierarchical, labels are stable,
callout fences balance, image paths resolve relative to the source file, and any
format-specific behavior is identified with a fallback where needed.
