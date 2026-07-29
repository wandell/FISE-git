# FISE agent guidance

This repository’s agent instructions are organized as modular Agent Skills in
`.github/skills/`. Use the skill whose trigger description matches the task:

- `quarto-authoring` for `.qmd`, YAML, callouts, layouts, and Quarto rendering;
- `citations-and-crossrefs` for `paperpile.bib`, citations, labels, equations,
  tables, and footnotes;
- `figures-and-media` for images, diagrams, figure labels, captions, and video;
- `reproducible-matlab` for `code/`, MATLAB, live scripts, and generated output;
- `editorial-voice` for prose revision;
- `scientific-notation` for equations, symbols, units, and domain terminology;
- `chapter-architecture` for chapter planning and pedagogical structure.

Substantive-domain skills:

- `light-fields-and-radiometry` for scene-side light, spectra, reflectance, and
  radiometric quantities;
- `optics-and-image-formation` for lenses, diffraction, aberrations, PSFs, and
  transfer functions;
- `image-sensors` for photodiodes, pixels, sensor noise, readout, and CFA work;
- `retinal-and-early-vision` for retinal irradiance, photoreceptors, sampling,
  ganglion-cell models, and prostheses;
- `spatial-vision-and-perception` for contrast, resolution, visual angle, and
  image-quality claims involving observers;
- `color-vision-and-wavelength-encoding` for color matching, cone signals, and
  spectral encoding;
- `displays-and-colorimetry` for display calibration, subpixels, and visual
  stimuli;
- `computational-imaging-and-image-processing` for imaging algorithms and their
  forward models; and
- `cortical-vision-and-inference` for perceptual and cortical claims.

General rules: inspect the relevant source before naming a path, label, or
configuration key; preserve established conventions; prefer small, localized
changes; and state whether a formatting technique works in HTML, PDF, or both.
