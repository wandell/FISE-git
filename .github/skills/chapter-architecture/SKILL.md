---
name: chapter-architecture
description: Plan, draft, restructure, or review FISE chapters and sections. Use when adding a chapter, creating an overview, reorganizing technical exposition, deciding what belongs in callouts or resources, checking pedagogical flow, or auditing whether section headings and callout titles still match their content.
---

# FISE chapter architecture

## Default chapter pattern

Follow the repository’s established chapter structure unless the content clearly
requires a different sequence:

1. Minimal YAML frontmatter with a title.
2. A level-one chapter title with a stable `sec-` label.
3. An early `## … overview` section that states the chapter’s question, scope,
   prerequisites, and main takeaways.
4. A progression from physical problem or observation to model, interpretation,
   examples, limitations, and connections to other book components.
5. Purposeful figures, equations, callouts, and citations placed near the claims
   they support.

Good:

```markdown
# Sensor parameters {#sec-system-parameters}

## Sensor parameters overview {#sec-system-parameters-overview}

This chapter explains how sensitivity, full-well capacity, and noise determine a
sensor’s useful operating range.
```

Bad:

```markdown
# Sensor parameters

Here are many facts about sensors.
```

## Section design

Give each section one job. Start with a claim, question, or transition; then
develop the evidence or derivation; conclude with its implication or bridge.
Place definitions immediately before the first task that needs them. Break a long
topic into sections by conceptual dependency, not arbitrary page length.

Good:

```markdown
## Well capacity and dynamic range {#sec-wellcapacity-dynamicrange}

Well capacity sets the largest charge a pixel can store. Together with read noise,
it bounds the range of signals the pixel can represent usefully.
```

Bad:

```markdown
## More details

There are several more details to discuss.
```

## Section and callout titles

Headings and callout titles are the chapter's visible outline: a reader scanning
only the titles, top to bottom, should be able to reconstruct what the chapter
argues and in what order. Write each title to name what its section delivers,
not a generic label for its kind — "Overview" or "Details" tells the reader
nothing that isn't already obvious from the heading level.

Prefer active voice in a title when it reads naturally ("The pupil transforms the
wavefront" beats "Pupil transformation"), but this is a preference, not a
requirement — an established noun phrase for a well-known topic (`## Zernike
wavefront model`) is fine. What matters more is specificity: the title should not
be interchangeable, unchanged, with the title of a different section.

Good:

```markdown
## Well capacity limits the largest usable signal {#sec-wellcapacity}

::: {.callout-note title="Why shot noise follows a Poisson distribution"}
```

Bad:

```markdown
## Overview

::: {.callout-note title="Note"}
```

Match the sentence case and `sec-`/`fig-` label conventions already used in the
surrounding chapter; do not introduce Title Case or a new label prefix locally.

## Main path, callouts, and resources

Keep the main path necessary for a first careful reading. Put optional history,
biographical context, an extended derivation, or a specialized implementation
case in a titled callout when it enriches rather than supports the main argument.
Use `chapters/resources/` for material that is useful but outside the book’s main
thread, and link to it deliberately.

Good: a short main explanation of shot noise, followed by an optional historical
callout about Poisson.

Bad: several pages of historical detail before the reader learns why photon counts
fluctuate.

## Cross-chapter coherence

The book follows the image-system chain: scenes and light fields, optics, sensors,
human vision, displays, image processing, and appendices. When a chapter depends
on an earlier concept, link to the relevant labeled section. When it postpones
detail, name the later chapter or resource rather than leaving an unresolved gap.

Do not duplicate a full treatment merely because it is useful in a new chapter;
give a concise reminder and cross-reference the canonical explanation.

## Structural review

Before finalizing, confirm that the overview promises what the chapter delivers,
headings form a logical outline, every section advances the stated question,
technical detail arrives after motivation, and the ending leaves the reader ready
for the next dependency. Preserve existing chapter order in `_quarto.yml` unless
an explicit editorial decision authorizes a change.

Revisit section and callout titles on their own, separately from a body-text
edit: read just the titles in sequence and ask whether they still describe what
is there now. A section drifts from its title not only when its own text
changes, but when neighboring sections are added, merged, or reordered around
it. Do this periodically as the chapter evolves, not only when writing new
material.
