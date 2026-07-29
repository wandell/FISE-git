---
name: retinal-and-early-vision
description: Draft, edit, or review FISE content about retinal images, photoreceptors, cone mosaics, rods, retinal sampling, photopigment excitations, ganglion-cell encoding, or retinal prostheses. Trigger when linking image-system signals to early visual encoding.
---

# Retinal and early vision

## Scope and conceptual model

Treat the retinal image as spectral irradiance over retinal position and time.
Photoreceptors convert this signal into noisy, spatially sampled excitations; later
retinal circuitry transforms these signals before the optic nerve. Do not describe
the retina as a passive camera sensor: adaptation, optics, sampling, noise, and
postreceptoral processing all matter.

## Canonical notation and units

- $E(r_x,r_y,\lambda,t)$: retinal spectral irradiance.
- $(r_x,r_y)$: retinal coordinates; use mm or degrees only after defining the
  retinal-to-visual-angle mapping.
- $e$: visual-field eccentricity in degrees from fixation.
- $q_k(\lambda)$: spectral sensitivity or quantal efficiency for receptor class
  $k$; name $k\in\{L,M,S\}$ for cone classes or $k=R$ for rods.
- $R_k(r_x,r_y,t)$: receptor excitation or response; specify whether it is
  photon absorptions, isomerizations, or a normalized response.
- $d(e)$: receptor spacing; $f_s(e)=1/d(e)$: nominal sampling frequency.

## Core models and assumptions

The first-stage excitation model is a spectral integral followed by sampling and
noise. Cone mosaics have different L-, M-, and S-cone densities and spatial
arrangements; do not represent them as three co-located, uniform samplers unless
the approximation is stated. Receptor spacing limits sampling but does not alone
predict visual resolution: eye optics, mosaics, neural processing, stimulus
conditions, and task all contribute.

Retinal ganglion cells encode transformed receptor signals, not pixel values.
Center-surround descriptions are useful models of spatial opponency but are not a
complete account of retinal coding or a single fixed filter across retina and
conditions.

## Key equations and diagram

```latex
R_k(r_x,r_y,t) = \int E(r_x,r_y,\lambda,t)\,q_k(\lambda)\,d\lambda.
```

```latex
f_{\mathrm{Nyq}}(e)=\frac{1}{2d(e)}
\qquad\text{(one-dimensional nominal sampling limit).}
```

```latex
R_{\mathrm{GC}}(\mathbf{r}) \approx
\bigl[k_c(\mathbf{r})-k_s(\mathbf{r})\bigr] * R_{\mathrm{cone}}(\mathbf{r}).
```

```text
retinal spectral irradiance E(x, y, λ, t) → L/M/S and rod absorptions
       → irregular receptor mosaic → retinal circuits / ganglion cells → optic nerve
```

## Terminology safeguards

Do use “photoreceptor excitation,” “cone class,” “retinal eccentricity,” and
“retinal image.”

Don’t use “red, green, and blue cones” as scientific names; use L-, M-, and
S-cones and explain that their spectral sensitivity is broad and overlapping.
Don’t equate cone response with perception or use “ganglion-cell pixel.”

Good: “Cone absorptions provide an initial, noisy sampling of the retinal image.”

Bad: “Each cone measures one color at one point.”

## Review checks

Define the response stage, distinguish retinal from visual-angle coordinates,
state adaptation and field-location conditions, and avoid assigning perceptual or
cortical functions directly to a receptor measurement.
