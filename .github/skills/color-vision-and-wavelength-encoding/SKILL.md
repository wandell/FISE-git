---
name: color-vision-and-wavelength-encoding
description: Draft, edit, or review FISE content about wavelength encoding, color matching, cone fundamentals, chromatic aberration, color signals, spectral sampling, or retinal prostheses. Trigger when explaining how spectra become visual color signals.
---

# Color vision and wavelength encoding

## Scope and conceptual model

Human color vision begins with spectral irradiance and overlapping L-, M-, and
S-cone excitations. Color matching is a property of an observer and a specified
viewing/measurement condition, not a direct measurement of wavelength or a
universal property of an object. Preserve the distinction between a physical
spectrum, cone excitations, color coordinates, and appearance.

## Canonical notation and units

- $E(\lambda)$: spectral irradiance at the retina or an explicitly named plane.
- $l(\lambda)$, $m(\lambda)$, $s(\lambda)$: L-, M-, and S-cone spectral
  sensitivities/fundamentals; name the standard observer and normalization.
- $R_L,R_M,R_S$: cone excitations or responses.
- $\mathbf{c}=[R_L,R_M,R_S]^\mathsf{T}$: cone-excitation vector.
- $\mathbf{XYZ}=[X,Y,Z]^\mathsf{T}$: CIE tristimulus values, with specified CIE
  observer and spectral sampling.
- $\lambda$: wavelength, in nm for reported visual spectra.

## Core models and assumptions

The trichromatic capture model maps spectra to three cone-excitation values under
specified adaptation and observer assumptions. Metamerism follows because many
spectra can yield the same cone excitations under a fixed condition; it does not
mean two spectra are physically identical or will match under every illuminant.
Chromatic aberration is an optical wavelength-dependent focus/position effect,
not a cone-encoding property.

## Key equations and diagram

```latex
R_k = \int E(\lambda)q_k(\lambda)\,d\lambda,
\qquad k\in\{L,M,S\}.
```

```latex
\mathbf{XYZ}=\int E(\lambda)
\begin{bmatrix}\overline{x}(\lambda)\\\overline{y}(\lambda)\\\overline{z}(\lambda)\end{bmatrix}
d\lambda.
```

```latex
\mathbf{c}_1=\mathbf{c}_2
\quad\not\Rightarrow\quad E_1(\lambda)=E_2(\lambda).
```

```text
spectral irradiance E(λ) → overlapping L/M/S absorptions → cone-excitation vector
                                               → postreceptoral comparisons → color judgment
```

## Terminology safeguards

Do use “wavelength,” “spectrum,” “cone excitation,” “color match,” “metamer,”
and “chromaticity” with their defined technical meanings.

Don’t equate wavelength with color, colorimetry with color appearance, or RGB
device values with cone excitations. Don’t call L-, M-, and S-cones red, green,
and blue receptors except as a carefully qualified historical shorthand.

Good: “The two spectra are metamers for the specified observer and adaptation
condition.”

Bad: “The spectra are the same color, so they are physically the same.”

## Review checks

Name the observer/standard when using color-matching functions, retain the
spectral integration when making a spectral claim, and identify adaptation,
illuminant, and viewing conditions for any appearance claim.
