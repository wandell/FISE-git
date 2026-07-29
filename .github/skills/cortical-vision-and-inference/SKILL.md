---
name: cortical-vision-and-inference
description: Draft, edit, or review FISE content about cortical visual processing, perceptual inference, contextual effects, visual illusions, shape interpretation, motion, or links from retinal encoding to visual judgments. Trigger when a chapter makes claims about what the brain or visual cortex computes.
---

# Cortical vision and perceptual inference

## Scope and evidence standard

The current manuscript introduces perception through three-dimensional inference,
contextual comparisons, edges, motion, and visual demonstrations; it does not yet
contain a full visual-cortex sequence. Use this skill to keep any cortical
extension evidence-calibrated. Distinguish psychophysical observation, neural
measurement, computational model, and causal mechanism. An illusion demonstrates
a perceptual outcome under a condition; it does not uniquely identify a neural
mechanism.

## Canonical notation and units

- $\mathbf{s}$: scene/world state or latent cause.
- $\mathbf{r}$: retinal or sensory measurement; define its stage.
- $\mathbf{z}$: neural representation or model feature; do not use it as a
  generic “brain signal” without definition.
- $\hat{\mathbf{s}}$: perceptual estimate or task response.
- $p(\mathbf{s}\mid\mathbf{r})$: posterior distribution in a Bayesian observer
  model; state whether it is a normative model or fitted behavioral model.
- $f$: spatial frequency in cycles/degree; $\theta$: orientation in degrees;
  $t$: time in seconds; avoid assigning a single unit-less “cortical resolution.”

## Core models and assumptions

Bayesian inference is a useful computational-level account: a perceptual estimate
can combine a likelihood with a prior. It does not by itself establish that a
particular cortical area implements Bayes’ rule. Linear receptive-field models
capture selectivity under specified conditions; nonlinearities, normalization,
adaptation, recurrence, attention, and task context often matter. Use “visual
cortex” only when a claim applies broadly enough; otherwise name the area and
evidence.

## Key equations and diagram

```latex
p(\mathbf{s}\mid\mathbf{r}) =
\frac{p(\mathbf{r}\mid\mathbf{s})p(\mathbf{s})}{p(\mathbf{r})}.
```

```latex
\hat{\mathbf{s}}_{\mathrm{MAP}}=
\arg\max_{\mathbf{s}}\;p(\mathbf{r}\mid\mathbf{s})p(\mathbf{s}).
```

```latex
z_i = \phi\!\left(\int k_i(\mathbf{u})r(\mathbf{u})\,d\mathbf{u}\right)
\qquad\text{(generic filter–nonlinearity model).}
```

```text
retinal measurements r → feature-selective neural representations z
                         + context / prior → task-dependent perceptual estimate ŝ
```

## Terminology safeguards

Do use “percept,” “observer model,” “contextual effect,” “correlate,” “causal
evidence,” and named cortical area when supported.

Don’t say “the brain sees,” “the cortex calculates,” or “an illusion proves” as
mechanistic conclusions. Don’t equate a neural correlate with the cause of an
experience, and don’t treat a Bayesian model as literal neural circuitry.

Good: “The demonstration is consistent with an interpretation that incorporates
local context; it does not identify the responsible neural mechanism.”

Bad: “The checker-shadow illusion proves that V1 computes reflectance.”

## Review checks

For each cortical claim, identify the evidence type, population/task/condition,
and inference level. Link retinal encoding to perception without skipping the
intermediate processing stages or overstating what the manuscript establishes.
