---
name: image-sensors
description: Draft, edit, or review FISE content about photons, photodiodes, CMOS pixels, quantum efficiency, noise, color filter arrays, readout, sensor characterization, or emerging sensors. Trigger when light is converted into electrical or digital image signals.
---

# Image sensors

## Scope and conceptual model

Model the sensor as a sequence: incident photons, absorptions and photoelectrons,
charge storage, readout voltage, analog-to-digital conversion, and digital
numbers. Keep these quantities distinct. A pixel includes more than a photodiode;
a sensor includes pixel arrays plus readout, timing, conversion, and packaging.

## Canonical notation and units

- $N_p$: incident photon count; $N_e$: generated/stored photoelectron count.
- $\mathrm{QE}(\lambda)$: quantum efficiency, dimensionless (or percent only
  when explicitly formatted as such).
- $\mu_e$, $\sigma_e$: mean and standard deviation in electrons.
- $\sigma_{\mathrm{read}}$: read-noise standard deviation in $\mathrm{e^-\,rms}$.
- $N_{\mathrm{FWC}}$: full-well capacity in electrons.
- $g_c$: conversion gain, conventionally $\mathrm{V/e^-}$; distinguish it from
  system gain expressed as $\mathrm{e^-/DN}$.
- $\mathrm{DN}$: digital number; $t_{\mathrm{exp}}$: exposure time in s.

## Core models and assumptions

For independent photon arrivals and constant efficiency, photoelectron counts are
well modeled as Poisson: mean and variance are equal in electrons. Read noise,
dark signal, fixed-pattern noise, clipping, ADC quantization, rolling shutter,
and color filters are additional processes; do not fold them silently into “shot
noise.” QE is wavelength dependent and does not by itself specify pixel
sensitivity, which also depends on exposure and optics.

Use a linear response model only below saturation and after offset/dark treatment
has been specified. State whether gain includes analog gain, digital gain, or
conversion gain.

## Key equations and diagram

```latex
\mathrm{QE}(\lambda)=\frac{\mathbb{E}[N_e(\lambda)]}{N_p(\lambda)}.
```

```latex
N_e \sim \operatorname{Poisson}(\mu_e),
\qquad \operatorname{Var}(N_e)=\mu_e.
```

```latex
\mathrm{SNR} = \frac{\mu_e}
{\sqrt{\mu_e+\sigma_{\mathrm{read}}^2+\sigma_{\mathrm{other}}^2}}.
```

```text
photons → photodiode → photoelectrons → floating diffusion / readout → ADC → DN
          QE(λ)        shot noise          read noise / gain             quantization
```

## Terminology safeguards

Do use “photoelectron,” “electron count,” “read noise,” “full-well capacity,”
and “digital number” for their distinct stages.

Don’t use “pixel noise” as though it were one physical source. Don’t call QE a
probability without saying it is an average wavelength-dependent efficiency. Don’t
call ISO a physical sensitivity increase without distinguishing capture from gain.

Good: “At fixed exposure, the expected electron count is proportional to incident
photon count until the pixel approaches full well.”

Bad: “Increasing ISO collects more photons.”

## Review checks

Report electrons before DN where possible, include units on every noise quantity,
name the operating conditions, and identify whether a quoted metric is measured,
modeled, or manufacturer specified.
