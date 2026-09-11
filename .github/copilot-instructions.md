# FISE agent guidance

This repository’s agent instructions are organized as modular Agent Skills in
`.github/skills/`. Use the skill whose trigger description matches the task:

- `quarto-authoring` for `.qmd`, YAML, callouts, layouts, and Quarto rendering;
- `quarto-publish` for `quarto publish gh-pages` and recovering from a failed
  or interrupted publish;
- `git-workflow` for git branches, commits, pushing feature branches, and pull requests on GitHub;
- `bib-crossref-indexing` for `paperpile.bib`, `local.bib`, citations, labels,
  equations, tables, footnotes, and cross-project bibliography sync;
- `figures-and-media` for images, diagrams, figure labels, captions, and video;
- `interactive-figures` for client-side Observable JS (OJS), Observable Plot, and WebAssembly (Wasm) simulations;
- `reproducible-matlab` for MATLAB scripts, live scripts, and generated output supporting the book;
- `matlab-evaluation` for running, testing, or publishing MATLAB code;
- `editorial-voice` for prose revision;
- `scientific-notation` for equations, symbols, units, and domain terminology;
- `chapter-architecture` for chapter planning and pedagogical structure;
- `external-resources` for surfacing supplementary videos, interactive demos,
  or related books (e.g., a colleague's computational-photography book,
  3Blue1Brown, Khan Academy, or Wandell's *Foundations of Vision*) worth
  linking to from a chapter.

## Code and Computational Foundations

Code in support of this book relies on the ISET software ecosystem:
- **`isetcam`**: core image systems engineering toolbox (optics, sensors, illuminants, camera simulation, `iePublish`).
- **`isetbio`**: biological image processing, physiological optics, retinal mosaic models, and computational observer models.
- **`iset3d`**: 3D spectral scene rendering and ray-tracing integrations.

The primary code repository for the book's scripts, live scripts, and published tutorials is **`isetfise`** (<https://github.com/ISET/isetfise>), located in the subdirectory **`isetfise/fise`** (organized by topic folders).

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

**Never push directly to `main`.** All work must be conducted on a feature branch and merged exclusively via a pull request (PR) on GitHub (<https://github.com/wandell/FISE-git>).

1. **Branch:** Always branch from an up-to-date `main`: `git checkout main && git pull origin main`, then `git checkout -b <branch-name>`.
2. **Commit:** Keep commits localized and descriptive. Do not commit build artifacts (`_book/`, `.quarto/`).
3. **Push:** Push the feature branch to origin: `git push -u origin <branch-name>`.
4. **Open PR:** Create a pull request for review on the main site using `gh pr create --web` (or `gh pr create --fill` and share the PR URL).
5. **Review & CI:** Allow GitHub Actions (`ci.yml`) to render the book and verify links on the PR.
6. **Merge:** Complete the merge on GitHub ("the main site"). Once merged, sync local `main`: `git checkout main && git pull origin main`.
See `.github/skills/git-workflow/SKILL.md` for complete operating procedures.

