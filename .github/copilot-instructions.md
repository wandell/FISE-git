# FISE agent guidance

This repository’s agent instructions are organized as modular Agent Skills in
`.github/skills/`. Use the skill whose trigger description matches the task:

- `quarto-authoring` for `.qmd`, YAML, callouts, layouts, and Quarto rendering;
- `quarto-publish` for `quarto publish gh-pages` and recovering from a failed
  or interrupted publish;
- `bib-crossref-indexing` for `paperpile.bib`, `local.bib`, citations, labels,
  equations, tables, footnotes, and cross-project bibliography sync;
- `figures-and-media` for images, diagrams, figure labels, captions, and video;
- `interactive-figures` for client-side Observable JS (OJS), Observable Plot, and WebAssembly (Wasm) simulations;
- `reproducible-matlab` for `code/`, MATLAB, live scripts, and generated output;
- `editorial-voice` for prose revision;
- `scientific-notation` for equations, symbols, units, and domain terminology;
- `chapter-architecture` for chapter planning and pedagogical structure;
- `external-resources` for surfacing supplementary videos, interactive demos,
  or related books (e.g., a colleague's computational-photography book,
  3Blue1Brown, Khan Academy, or Wandell's *Foundations of Vision*) worth
  linking to from a chapter.

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

## Git workflow

Do work on a feature branch, not directly on `main`. When a change is ready,
commit it, push the branch, and open a pull request with `gh pr create --web`
(or otherwise open the PR in a browser) so it's there for review before
merging. The `ci.yml` GitHub Actions workflow renders the book on every push
and pull request against `main`; let that check run rather than only relying
on a local `quarto render`.
