---
name: light-fields-and-radiometry
description: Draft, edit, or review FISE content about scenes, light fields, spectral radiance, reflectance, illumination, polarization, or radiometric quantities. Trigger when a chapter models the light incident on an optical system or retina.
---

# Light fields and radiometry

## Scope and conceptual model

Use this skill for the scene-side description of image systems. The central object
is light distributed over position, direction, wavelength, time, and, when needed,
polarization. Distinguish a scene’s radiance from irradiance at a sensor or retina;
optics transforms the former into the latter.

The manuscript introduces a 7D plenoptic function and practical lower-dimensional
light-field descriptions. State which dimensions have been omitted and why; an
abstraction is not a claim that the omitted physical variables do not exist.

## Canonical notation and units

- $P(x,y,z,\theta,\phi,\lambda,t)$: a 7D plenoptic-function notation used in
  the book; define the coordinate convention locally.
- $L(\mathbf{r},\boldsymbol{\omega},\lambda,t)$: spectral radiance at position
  $\mathbf{r}$, outgoing direction $\boldsymbol{\omega}$, wavelength
  $\lambda$, and time $t$.
- $E(\mathbf{r},\lambda,t)$: spectral irradiance incident on a surface.
- $R(\lambda)$: spectral reflectance of a material under an explicitly stated
  illumination/viewing geometry.
- $f_r(\boldsymbol{\omega}_i,\boldsymbol{\omega}_o,\lambda)$: BRDF.
- Wavelength is $\lambda$ in nm when reporting visible-spectrum samples; use m
  in dimensional equations. Radiance is commonly $\mathrm{W\,m^{-2}\,sr^{-1}}$
  (or per nm for spectral radiance); irradiance is $\mathrm{W\,m^{-2}}$.

## Core models and assumptions

The Lambertian approximation describes an ideal diffuse surface, not a general
surface and not a statement that reflected radiance follows a cosine law with
viewing angle. Under Lambertian reflection, outgoing radiance is direction
independent while irradiance contains the incident-angle cosine term. State when
specular/interface reflection, subsurface scattering, fluorescence, polarization,
or interreflections make the simple model inadequate.

Use the dichromatic-reflectance model only as an approximation: it separates
interface and body-reflection components under restricted material and geometry
assumptions. Do not call a spectral-power distribution an “illuminant” unless it
is specifically the spectrum of the illumination.

## Key equations and diagram

```latex
L_o(\boldsymbol{\omega}_o,\lambda) =
\int_{\Omega^+} f_r(\boldsymbol{\omega}_i,\boldsymbol{\omega}_o,\lambda)
L_i(\boldsymbol{\omega}_i,\lambda)
(\mathbf{n}\mathbin{\cdot}\boldsymbol{\omega}_i)\,d\omega_i
```

```latex
L_o(\lambda) = \frac{\rho(\lambda)}{\pi}E_i(\lambda)
\qquad\text{(ideal Lambertian surface).}
```

```text
illumination L_i(ω_i, λ) → surface [BRDF / reflectance] → L_o(ω_o, λ)
                                                    → optics → sensor irradiance E
```

## Terminology safeguards

Do use “radiance,” “irradiance,” “spectral radiance,” “reflectance,” and
“viewing direction” precisely.

Don’t use “intensity” as a catch-all for radiance, irradiance, power, or perceived
brightness. Don’t call a Lambertian surface “equally bright in every direction”
without clarifying that this refers to radiance, not arbitrary appearance.

Good: “The surface’s spectral radiance depends on illumination, material
reflectance, and viewing geometry.”

Bad: “The object has a color spectrum independent of its illumination.”

## Review checks

Check units, specify direction/geometry, distinguish radiometric from photometric
quantities, and label any approximation that suppresses wavelength, time,
polarization, or spatial variation.
