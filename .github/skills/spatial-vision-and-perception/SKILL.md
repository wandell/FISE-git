---
name: spatial-vision-and-perception
description: Draft, edit, or review FISE content about spatial resolution, contrast sensitivity, retinal sampling, visual angle, image quality, motion, spatial illusions, or perceptual interpretation. Trigger when relating image-system performance to human spatial vision.
---

# Spatial vision and perception

## Scope and conceptual model

Connect image quality to a specified visual task, viewing geometry, stimulus, and
observer condition. Spatial vision is not summarized by a single “eye resolution”;
optics, cone sampling, neural encoding, contrast, luminance, eccentricity,
temporal exposure, and task jointly affect performance.

The manuscript uses spatial demonstrations and image-quality metrics. Present
illusions as evidence that appearance depends on image context and inference, not
as proof that the visual system is “fooled” in a simple generic sense.

## Canonical notation and units

- $\theta$: visual angle in degrees or radians; define the viewing geometry.
- $e$: eccentricity in degrees from fixation.
- $f$: spatial frequency, normally cycles/degree (cpd) for visual performance;
  use cycles/mm only for a retinal or image-plane quantity.
- $C$: contrast; state the definition, such as Michelson or Weber contrast.
- $\mathrm{CSF}(f)$: contrast-sensitivity function; threshold contrast is
  $C_{\mathrm{th}}(f)=1/\mathrm{CSF}(f)$.
- $\Delta E$: color difference only when the associated color space and metric
  are stated; it is not a generic spatial-error metric.

## Core models and assumptions

Contrast sensitivity is condition dependent. Always specify mean luminance,
spatial frequency, temporal frequency if relevant, field location, viewing distance,
stimulus size, and detection/discrimination/identification task when making a
performance claim. Nyquist frequency is a sampling bound, not an assurance of
visible resolution. A system MTF and a human CSF are distinct functions with
different inputs and interpretations.

## Key equations and diagram

```latex
C_{\mathrm{Michelson}}=\frac{L_{\max}-L_{\min}}{L_{\max}+L_{\min}}.
```

```latex
C_{\mathrm{Weber}}=\frac{L-L_b}{L_b}.
```

```latex
C_{\mathrm{th}}(f)=\frac{1}{\mathrm{CSF}(f)}.
```

```text
displayed or captured scene → eye optics → retinal mosaic → neural encoding
       → task-specific decision / appearance judgment
```

## Terminology safeguards

Do use “spatial frequency,” “contrast sensitivity,” “threshold,” “visual angle,”
and the named task.

Don’t use “resolution” or “visibility” without a metric and condition. Don’t call
an MTF curve a CSF, or claim that a stimulus “cannot be seen” from a sampling
calculation alone.

Good: “At this viewing distance, the 2 cpd grating is tested near the observer’s
contrast threshold at the stated mean luminance.”

Bad: “Humans cannot see frequencies above 60 cpd.”

## Review checks

Ensure spatial-frequency units match the coordinate system, contrast has a named
definition, claims distinguish detection from appearance, and demonstrations do
not overgeneralize from a single image or observer.
