---
name: scientific-notation
description: Apply consistent mathematical, scientific, and engineering notation in FISE chapters. Use when writing equations, defining variables, reporting units, discussing optics, sensors, light fields, displays, human vision, or image-processing measurements.
---

# FISE scientific notation

## General principles

Notation must expose meaning, dimensions, and assumptions. Reuse established
notation within a chapter and inspect related chapters before introducing a new
symbol. Define every nonstandard symbol near its first consequential use and
state the domain or indexing when it is not evident.

- Put mathematics in LaTex delimiters: `$...$` inline and `$$...$$` for displays.
- Use `\mathrm{}` for named operators, units, and upright multi-letter
  abbreviations when mathematical typography requires it; reserve italic letters
  for variables.
- Do not use an equation as decoration. Explain what it expresses, identify the
  quantities, and state the conditions under which it applies.

Good:

```markdown
The quantum efficiency $\mathrm{QE}(\lambda)$ is the ratio of generated electrons
to incident photons at wavelength $\lambda$.
```

Bad:

```markdown
QE(lambda) = e/p
```

## Equations and symbols

Use descriptive subscripts and parentheses to make scope clear. Distinguish a
scalar, vector, function, distribution, and estimate in words and notation.
Avoid reusing one symbol for unrelated quantities in the same section. Put an
equation label on a display only when it will be referenced.

Good:

```markdown
$$
E = \frac{hc}{\lambda}
$$ {#eq-photon-energy}

where $E$ is photon energy, $h$ is Planck’s constant, $c$ is the speed of light
in vacuum, and $\lambda$ is wavelength in vacuum.
```

Bad:

```markdown
$$ E=hc/l $$
```

For probability, distinguish a random variable from an observed value and a
probability distribution from its mean. For example, write $P(n; \lambda)$ for a
Poisson probability only after defining the count $n$ and mean $\lambda$.

## Units, numbers, and dimensions

Use SI units and put a space between a number and its unit: `$5\ \mathrm{mm}$`,
`$10\ \mathrm{ms}$`, `$50\ \mathrm{cd/m^2}$`. Use a centered dot for compound
units when it improves readability (for example, J·s in prose). Write dimensions
and unit conversions explicitly enough that a reader can test them.

Good:

```markdown
Silicon has a bandgap of approximately $1.12\ \mathrm{eV}$ at room temperature.
```

Bad:

```markdown
Silicon has a 1.12eV bandgap.
```

Use significant figures that match the source and the claim. Avoid false
precision from computation or copied data. Name the measurement condition when a
quantity depends materially on wavelength, temperature, exposure, field angle,
or stimulus geometry.

## Domain-specific precision

- Distinguish radiometric quantities from photometric quantities; do not use
  “brightness,” “intensity,” “luminance,” and “radiance” interchangeably.
- Distinguish photons, photoelectrons, electrons, digital numbers, and voltage;
  each is a different stage of an image system.
- Distinguish spatial frequency units and specify the coordinate system or image
  plane when it matters.
- State whether a response is linear, shift-invariant, monochromatic, paraxial,
  or otherwise conditional instead of presenting an approximation as universal.

## Final review

Check symbol reuse, equation punctuation, unit spacing, dimensional consistency,
defined indices, and agreement between captions, axes, prose, and equations. When
an established convention conflicts with a local chapter convention, preserve the
local convention and make the distinction explicit.
