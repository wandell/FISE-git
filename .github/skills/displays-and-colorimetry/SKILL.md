---
name: displays-and-colorimetry
description: Draft, edit, or review FISE content about display technologies, calibration, the standard display model, subpixels, visual stimuli, colorimetry, AR/VR, or display image quality. Trigger when a display generates the stimulus or is modeled as an imaging-system component.
---

# Displays and colorimetry

## Scope and conceptual model

Model a display by the spatial, spectral, and temporal radiance it emits, not by
its nominal RGB code values alone. The manuscript’s standard display model is an
engineering approximation that supports calibration and simulation. State its
assumptions—additivity, pixel independence, and spatial homogeneity—and describe
the stimulus conditions over which they have been tested.

## Canonical notation and units

- $d_k(x,y)$: digital drive value for primary/subpixel $k$ at display position
  $(x,y)$; specify normalization and bit depth.
- $S_k(\lambda)$: spectral power/radiance distribution of primary $k$ under a
  stated drive and measurement geometry.
- $h_k(x,y)$: subpixel point-spread function for primary $k$.
- $L(x,y,\lambda,t)$: emitted spectral radiance; use
  $\mathrm{W\,m^{-2}\,sr^{-1}\,nm^{-1}}$ when reporting spectral radiance.
- $X,Y,Z$: CIE tristimulus values; $Y$ is photometric luminance only under the
  associated CIE observer and radiometric conversion.
- $\Delta E_{ab}^*$ or $\Delta E$: name the exact color-difference formula.

## Core models and assumptions

For a linear, additive display, emitted radiance is a sum of primary spectra and
spatial subpixel responses. Real displays can violate this through channel
interaction, temporal modulation, local dimming, viewing-angle dependence,
overdrive, and nonuniformity. A calibrated model may still be appropriate for a
restricted stimulus class; say what that class is.

AR/VR analysis must distinguish accommodative distance, vergence distance,
latency, angular resolution, and pupil-dependent optics. Do not imply that a
single display specification predicts comfort or perceptual quality.

## Key equations and diagram

```latex
L(x,y,\lambda) \approx \sum_{k=1}^{K}
\bigl[d_k(x,y)*h_k(x,y)\bigr]S_k(\lambda).
```

```latex
\mathbf{XYZ}=\int L(\lambda)
\begin{bmatrix}\overline{x}(\lambda)\\\overline{y}(\lambda)\\\overline{z}(\lambda)\end{bmatrix}
d\lambda.
```

```text
digital drives d_k → subpixel spatial response h_k + primary spectra S_k(λ)
                 → spectral radiance L(x, y, λ, t) → eye / measurement instrument
```

## Terminology safeguards

Do use “display code value,” “primary,” “subpixel,” “spectral radiance,”
“calibration,” and “characterization.”

Don’t call RGB values colors without a display and encoding context. Don’t call a
display “linear” merely because its code values are evenly spaced; state which
physical output is linearized. Don’t conflate dots per inch, pixels per degree,
and retinal sampling.

Good: “The calibration predicts steady-state spectral radiance for these uniform
patches.”

Bad: “The display emits the same light for every image with the same RGB values.”

## Review checks

Give measurement geometry, bit depth, white point, temporal state, and spatial
region when relevant; state model assumptions; and distinguish a device metric
from a viewer-performance or appearance claim.
