---
name: editorial-voice
description: Write or revise FISE textbook prose for advanced undergraduates and beginning graduate students. Use when drafting explanations, transitions, captions, callouts, summaries, or editing for clarity, accuracy, brevity, and tone.
---

# FISE editorial voice

## Reader and priorities

Write for technically curious advanced undergraduates and beginning graduate
students. They can follow mathematics and physical reasoning, but should not be
asked to infer unstated assumptions, notation, or motivation.

Priority order: accuracy and clarity first; then a welcoming, personal interesting tone;
then brevity. The voice is direct, calm, and precise—not promotional, inflated,
or overly casual. We are having a one-on-one personal conversation with the reader.

## Explain before compressing

Open a new concept with its role in the image-system story, then define it, show
its consequence, and connect it to an example, figure, or later use. Prefer short
paragraphs with one main job each. Define a term before using an abbreviation.

Good:

```markdown
A lens maps rays from a scene point toward an image point. This mapping explains
both focus and blur: rays meet at one plane and spread at planes away from it.
```

Bad:

```markdown
The lens transfer function is obviously central to imaging and is used throughout.
```

Avoid “obviously,” “simply,” “clearly,” and similar language that can make an
unfamiliar idea feel like a reader failure. Say what makes an inference valid.

## Sentence-level discipline

- Prefer active voice when it identifies an agent or causal mechanism.
- Use concrete nouns and verbs; replace vague references such as “this,” “it,” or
  “the above” when the antecedent could be unclear.
- Use present tense for enduring scientific relationships and past tense for
  historical actions or specific experiments.
- Use first-person plural sparingly and purposefully (“we now compare…”), never
  as a substitute for explanation.
- Retain a technical term when it is the correct term; define it rather than
  replacing it with a misleading simpler word.

Good:

```markdown
Increasing exposure time increases the expected photon count, but it also raises
the chance that motion will blur the image.
```

Bad:

```markdown
It makes it better, although there are some issues with it.
```

## Pedagogical movement

Use a dependable sequence: question or purpose; model or observation; reasoning;
interpretation; limitation; connection. Make limitations explicit—conditions,
approximations, scales, and counterexamples belong in the explanation, not only
in a caveat at the end.

Good:

```markdown
For a spatially invariant system, one point-spread function predicts the response
at every position. Real lenses depart from this approximation away from the field
center because aberrations vary with position.
```

Bad:

```markdown
All systems have one point-spread function.
```

## Revision test

After revising, check that each paragraph advances the chapter, figures are
introduced before they are cited, equations are interpreted in words, and the
reader receives a reason to care before technical detail accumulates. Keep useful
historical context, but place it in a callout when it would interrupt the main
conceptual path.
