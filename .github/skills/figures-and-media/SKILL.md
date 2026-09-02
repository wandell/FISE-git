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

### Local video files

Embed a local `.mp4`/`.mov`/`.gif` with ordinary image Markdown — Quarto emits
a `<video>` tag automatically for video extensions. Pair it with a PNG/JPG
still frame for PDF, using the same fig-style attributes on both.

```markdown
::: {.content-visible when-format="html"}
![Caption describing what the video shows.](images/topic/nn-section/clip.mp4){#fig-clip width="60%"}
:::

::: {.content-visible when-format="pdf"}
![Caption describing what the video shows.](images/topic/nn-section/clip.png){#fig-clip width="60%"}
:::
```

This is the established pattern for every local video in the book (e.g.
`human-01-seeing.qmd`, `optics-06-linear-transform.qmd`,
`sensors-02-pixels.qmd`). Reuse the same `#fig-` id on both variants; only one
survives in a given render, so it isn't a duplicate-label conflict.

### YouTube embeds

The book embeds YouTube videos with a raw, responsive 16:9 `<iframe>` inside
an HTML-only `content-visible` block, paired with a plain link for PDF:

```markdown
::: {.content-visible when-format="html"}

<div style="max-width: 800px; margin: 0 auto;">
  <div style="position: relative; width: 100%; padding-top: 56.25%;"> <!-- 16:9 -->
    <iframe
      src="https://www.youtube.com/embed/VIDEO_ID"
      style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: 0;"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
      allowfullscreen>
    </iframe>
  </div>
</div>

:::

::: {.content-visible when-format="pdf"}
[In this YouTube video, learn more about ...](https://youtu.be/VIDEO_ID){target=_blank}
:::
```

**Gotcha, confirmed in this repo (2026-09-01):** this `content-visible`/`<iframe>`
block must sit **inside an ordinary block container** — a `.callout-note`, a
`.column-margin`, any div — not as a bare, direct child of the chapter body.
Placed bare, the outer `padding-top: 56.25%` aspect-ratio div collapses to
zero visible height in this book's rendered page-grid layout, even though the
HTML in the rendered output is byte-for-byte identical to a working copy
sitting inside a callout a few lines below it. This is not about the video
itself (both the working and the broken copy passed a YouTube oEmbed check
confirming the video allows embedding) and not about Quarto's Markdown
resolution (`quarto render -M keep-md:true` showed the resolved Markdown and
the final `_book/**/*.html` both contained the correct, complete markup in
both cases). It only shows up visually, and only in the actual browser
rendering — confirmed by rendering to `_book/`, serving it
(`python3 -m http.server`), and screenshotting with headless Chrome
(`google-chrome --headless --disable-gpu --window-size=W,H --screenshot=out.png URL`);
diffing the source or the rendered HTML text will not reveal it.

Good: wrap the embed in `::: {.callout-note title="..."} ... :::` (as done
for every working YouTube embed in `optics-08-wavefront-sensing.qmd`).

Bad: paste the iframe block directly between two paragraphs with no
enclosing div/callout — it will render in the HTML source and in
`_book/**/*.html`, but not on the page.

If a video "isn't showing" and the source/rendered-HTML markup looks correct,
render to a real browser screenshot (steps above) before assuming the link,
video ID, or embed permissions are the problem.

## Quality review

Before completion, check that the file exists, the path is correct from the
chapter, the image is legible at the selected width, the label is unique, the
caption explains the takeaway, and any data/source attribution is present. Render
the chapter and inspect the actual output rather than trusting source syntax.
