---
name: computational-imaging-and-image-processing
description: Draft, edit, or review FISE content about image processing, demosaicking, lens-shading correction, stereo/depth, compression, computational cameras, image quality metrics, or vision algorithms. Trigger when an algorithm transforms, estimates, or evaluates captured image data.
---

# Computational imaging and image processing

## Scope and conceptual model

Describe an algorithm as an estimator or transformation with explicit inputs,
outputs, assumptions, and failure modes. Keep the pipeline distinct: scene and
optics form irradiance, sensors produce sampled noisy measurements, and processing
estimates or renders an image representation. “Computational imaging” should mean
that sensing and inference/design are coupled, not merely that a computer runs an
image filter.

## Canonical notation and units

- $\mathbf{x}$: desired latent scene/image representation; define its domain and
  units.
- $\mathbf{y}$: measured sensor data (often DN or electrons); state the unit.
- $\mathbf{A}$: forward operator, including optics, sampling, color filters, or
  geometric projection as appropriate.
- $\mathbf{n}$: noise/model error; state the distribution when used probabilistically.
- $\hat{\mathbf{x}}$: estimate of $\mathbf{x}$.
- $D(\mathbf{x},\hat{\mathbf{x}})$: stated distortion/error metric; do not use an
  unnamed “quality” scalar.
- $z$: depth; $d$: disparity in pixels; $f$: focal length; $B$: baseline, with
  compatible physical units in stereo equations.

## Core models and assumptions

Start from the forward model, then explain inversion or estimation. Regularization
injects assumptions—smoothness, sparsity, natural-image statistics, learned
priors—and therefore can fail when data violate them. Demosaicking cannot recover
independent full-resolution measurements at all wavelengths; it estimates missing
samples from spatial/color assumptions. Compression trades rate, distortion, and
task relevance; a high PSNR does not ensure perceptual equivalence.

## Key equations and diagram

```latex
\mathbf{y}=\mathbf{A}\mathbf{x}+\mathbf{n}.
```

```latex
\hat{\mathbf{x}}=
\arg\min_{\mathbf{x}}\left\{
\lVert\mathbf{A}\mathbf{x}-\mathbf{y}\rVert_2^2+\lambda\mathcal{R}(\mathbf{x})
\right\}.
```

```latex
z=\frac{fB}{d}
\qquad\text{(rectified stereo; define coordinate and calibration conventions).}
```

```text
scene x → forward imaging operator A → measurements y → reconstruction / inference
       ← assumptions, calibration, regularization R(x), and task-specific metric
```

## Terminology safeguards

Do use “measurement,” “estimate,” “forward model,” “regularization,” “prior,”
“artifact,” and “validation set/task” precisely.

Don’t call an inferred image “ground truth,” an interpolation “recovery,” or a
metric “perceptual” without validation. Don’t claim that an algorithm removes
noise or blur; say whether it suppresses, estimates, deconvolves, or trades errors.

Good: “The demosaicker estimates missing color samples under local smoothness and
edge-alignment assumptions.”

Bad: “Demosaicking reconstructs the original RGB image exactly.”

## Review checks

Identify the forward model, data domain, calibration, noise model, objective,
metric, and failure cases. Separate algorithmic metrics (for example MTF50 or
PSNR) from human-vision metrics unless their relation is established.
