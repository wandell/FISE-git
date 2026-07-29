---
name: optics-and-image-formation
description: Draft, edit, or review FISE content about geometric optics, lenses, diffraction, aberrations, ray matrices, PSFs, OTFs, MTFs, or wavefronts. Trigger when explaining how optics transform a scene into an image.
---

# Optics and image formation

## Scope and conceptual model

Build optical explanations in layers: ray geometry is useful within its stated
regime; wave optics is required for diffraction and coherent propagation; linear
systems notation is useful only after stating linearity and shift invariance.
Distinguish an ideal thin lens from a multi-element physical lens and distinguish
an optical image from a sampled sensor image.

## Canonical notation and units

- $n$: refractive index; $\theta_i$, $\theta_t$: incident and transmitted angles
  measured from the surface normal.
- $f$: focal length; $f'$ and $f''$ only when a sign convention has been defined.
- $s$, $s'$: object and image distances; state the chosen sign convention.
- $N=f/D$: f-number, with aperture diameter $D$.
- $h(x,y)$: incoherent intensity PSF; $H(f_x,f_y)$: OTF; $\mathrm{MTF}=|H|$.
- $f_x,f_y$: spatial frequency, with units stated as cycles/mm, cycles/degree,
  or cycles/pixel according to the plane.
- $\lambda$: wavelength; use nm for reported values and m in SI derivations.

## Core models and assumptions

Snell’s law assumes a smooth interface and defines angles relative to the normal.
The Gaussian thin-lens equation is paraxial and convention-dependent; identify the
principal planes and use cardinal-point or ABCD methods for thick/multi-element
systems. A PSF characterizes an incoherent LSI optical system at one field point,
wavelength, focus, and aperture unless the text establishes broader validity.

Do not equate MTF with perceived sharpness: MTF is a physical contrast-transfer
measure, while appearance depends on sampling, noise, viewing, and vision.

## Key equations and diagram

```latex
n_i\sin\theta_i = n_t\sin\theta_t
\qquad\text{(Snell's law).}
```

```latex
\frac{1}{f}=\frac{1}{s}+\frac{1}{s'}
\qquad\text{(thin lens; state the sign convention).}
```

```latex
g(x,y) = (h * o)(x,y), \qquad H(f_x,f_y)=\mathcal{F}\{h(x,y)\}.
```

```text
scene point → aperture / lens → wavelength- and field-dependent PSF h(x, y)
                                      → irradiance image → sensor sampling
```

## Terminology safeguards

Do use “geometric-optics approximation,” “diffraction-limited,” “incoherent PSF,”
“field dependent,” and “spatially invariant” when their conditions are met.

Don’t use “resolution” without naming its metric or units. Don’t call any blur
disk an Airy disk, or any transfer function an MTF. Don’t describe distortion as
a blur aberration; it changes geometry rather than spreading a point locally.

Good: “Near the field center, the system is approximated as shift invariant.”

Bad: “A lens has one PSF everywhere.”

## Review checks

State the coordinate plane and sign convention, define the approximation regime,
retain wavelength dependence where it matters, and separate physical optical
performance from sensor and perceptual performance.
