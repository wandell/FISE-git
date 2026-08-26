---
name: external-resources
description: Surface supplementary videos, interactive demonstrations, and related books or courses that could deepen or extend a FISE chapter. Use when drafting or revising a section that introduces a substantial new concept, when a figure or explanation might benefit from a linked animation or interactive tool, or when explicitly asked to find further-reading, teaching material, or auxiliary resources.
---

# External teaching resources

## Purpose

FISE is Brian Wandell's personal, textbook-style treatment of image systems
engineering. Other high-quality resources exist online that overlap or extend
its material, sometimes with production values (animation, interactivity, a
different pedagogical angle) that a static book cannot match. When a chapter's
concept has a strong existing treatment elsewhere, flag it to the user instead
of silently duplicating the explanation or ignoring the opportunity to link
out.

This skill is about *scouting and suggesting*, not automatic insertion — see
"How to present a suggestion" below.

## Known resource library

Starting points, not an exhaustive catalog:

- **Computational Photography: An AI-powered Slopendium**
  (<https://comp-photo-book.pages.dev/>) — a colleague's in-progress online
  book. Overlaps FISE on imaging fundamentals, optics, sensors, linear
  systems/Fourier methods, and color/perception, and goes beyond FISE's scope
  into probabilistic and learning-based methods (Bayesian inference, learned
  ISP operators, diffusion/generative models) and performance engineering
  (Halide, GPU/NPU backends). Good for: pointing a reader from a FISE
  optics/sensors/linear-systems section toward a complementary or more
  ML-forward treatment, or checking that a new FISE section wouldn't just
  duplicate a page that already exists there. It is a moving draft (versioned,
  e.g. "v0.1.258" as of this writing) — re-check that a specific page still
  exists and still says what you remember before recommending or citing it.
- **Foundations of Vision (1995)** (<https://wandell.github.io/FOV-1995/>) —
  Wandell's earlier vision-science book. Good for: pointing readers to a
  deeper, classic treatment of retinal/cortical vision topics (photoreceptor
  mosaics, cortical representation, motion/depth, color) that FISE's human
  vision chapters cover more briefly.
- **3Blue1Brown** (YouTube channel / <https://www.3blue1brown.com/>) —
  animated math explainers (linear algebra, calculus, Fourier transforms,
  convolution, neural networks). Good for: linear-systems and Fourier-optics
  material (e.g. `optics-05-linear-space.qmd`, `optics-06-linear-transform.qmd`)
  where an animated intuition-builder for convolution or the Fourier transform
  would help a reader who finds the equations alone opaque.
- **Khan Academy** (<https://www.khanacademy.org/>) — broad, approachable
  video lessons spanning physics, optics, biology, and math fundamentals.
  Good for: chapters that assume prerequisite math or physics (wave
  interference, basic geometric optics, probability) some readers may need
  refreshed before continuing.

When none of these fit a specific concept, use `WebSearch`/`WebFetch` to look
for the best current treatment (an applet, a paper, a well-made video) rather
than forcing a fit from the list above. If a search turns up a resource worth
keeping permanently, add it here with the same one-paragraph justification of
scope and fit, so future sessions inherit the find.

## When to flag a resource

- A chapter introduces a foundational concept for the first time (e.g. the
  Fourier transform, convolution, wave interference, color matching) and an
  animation or interactive demo would build intuition faster than static
  prose and figures alone.
- A chapter's scope brushes against material another resource already covers
  in more depth (an ML topic in the comp-photo-book, a cortical-vision topic
  in FOV-1995). Flag it as a candidate cross-reference or "further reading"
  pointer rather than expanding FISE's own scope to cover it.
- The user explicitly asks for supplementary material, further reading, or a
  video/interactive suggestion for a section.

## How to present a suggestion

- **Suggest, don't insert.** Name the candidate resource, the specific
  page/video, and where in the chapter it would go; let the user confirm
  before it becomes a permanent link. Adding an outward-facing link is an
  editorial decision about the book's content, not a mechanical fix.
- Say what concept it addresses and why it's a good fit (production quality,
  deeper treatment, complementary scope) — not just "this looks relevant."
- Verify the specific page or video still exists and still matches the
  claimed content before recommending it; draft sites move and videos get
  taken down.

## If the user approves adding a link

- Follow `figures-and-media` conventions for third-party attribution and
  provenance: do not claim authorship of linked material, and credit it in
  the caption or adjacent prose.
- Most "further reading" pointers are a plain hyperlink in prose or a short
  callout — they are not embedded, so HTML/PDF fallback concerns mostly don't
  apply. Only wrap in a `content-visible when-format="html"` block (per
  `interactive-figures`) if you are embedding the resource itself (e.g. an
  iframe), not merely linking to it.
- If a chapter accumulates several external links, collect them as an
  annotated list under `chapters/resources/` rather than cluttering the main
  path with inline links (see `chapter-architecture`).
