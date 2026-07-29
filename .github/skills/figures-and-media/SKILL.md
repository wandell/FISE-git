---
name: figures-and-media
description: Create, select, export, place, caption, attribute, or cross-reference FISE figures, images, diagrams, and videos. Use when editing chapter media, image paths, figure labels, sizing, panels, accessibility text, or HTML/PDF fallbacks.
---

# FISE figures and media

## Asset selection and placement

Book assets normally live under `chapters/images/`, organized by subject and
chapter. Resolve image paths relative to the `.qmd` file being edited; existing
chapter files commonly use `images/...`. Before creating a directory or naming an
asset, inspect nearby assets and follow their established local convention.

- Use vector formats (usually SVG) for diagrams, line art, and text-heavy
  schematics when the output path supports them.
- Use PNG for generated plots, screenshots, pixel-based diagrams, and graphics
  requiring lossless detail. Use JPEG for photographic material when size matters.
- Preserve the source or generating script for any derived scientific figure.
- Do not overwrite an existing asset without inspecting its usage.

## Captions, labels, and alt text

Every instructional figure needs a concise caption that says what is shown and
why it matters. Write a meaningful image description that does not rely on color,
position, or a nearby paragraph. For a complex figure whose accessibility text
needs to differ from its visible caption, use Quarto’s `fig-alt` attribute; use
`fig-cap` when a caption cannot be expressed naturally in image Markdown. Assign a
unique semantic `fig-` label if the figure is cited.

Good:

```markdown
![Poisson distributions become more symmetric as their mean photon count increases.](images/sensors/13-photons/03-Poisson.png){#fig-sensor-poisson width="70%"}
```

Bad:

```markdown
![](images/plot-final-new.png){width="70%"}
```

State external provenance in the caption or adjacent text and provide the
appropriate scholarly citation. Do not claim authorship for third-party content
or use an AI-generated image as evidence for a scientific or historical claim.

## Sizing and layout

Use the project’s existing proportional-width convention (`width="60%"`, for
example) and `fig-align="center"` when it improves the page. Quarto’s `fig-width`
and `fig-height` are available when output sizing needs an explicit physical
dimension. Preserve aspect ratio; do not set conflicting width and height merely
to force a layout. Choose a size that keeps labels legible at normal reading scale.

Good:

```markdown
![Ray paths through a thin lens.](images/optics/07-principles/thinlens-assembled.png){#fig-thin-lens fig-align="center" width="60%"}
```

Bad:

```markdown
![Lens.](images/lens.png){width="200" height="30"}
```

Use an identified figure container for a multi-panel or tabbed figure when the
whole group needs one reference. Give individual panels captions only when the
reader needs to distinguish them independently.

```markdown
::: {#fig-example-comparison layout-ncol=2}
![Condition A.](images/example-a.png)

![Condition B.](images/example-b.png)

Comparison of the two conditions.
:::
```

## Video and format fallback

Video and interactive presentation are HTML-first. Provide a still figure or
other meaningful PDF-safe representation in a `content-visible` block. Do not
reuse a label on both alternatives unless that pattern has been verified for the
target renderer; label the shared container where possible.

Good: an HTML movie paired with a PDF representative frame and a caption that
explains the scientific observation.

Bad: a video with autoplay as the only explanation of a result.

## Quality review

Before completion, check that the file exists, the path is correct from the
chapter, the image is legible at the selected width, the label is unique, the
caption explains the takeaway, and any data/source attribution is present. Render
the chapter and inspect the actual output rather than trusting source syntax.
