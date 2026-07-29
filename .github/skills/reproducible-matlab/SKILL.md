---
name: reproducible-matlab
description: Maintain or document FISE MATLAB scripts, live scripts, generated figures, and exported Markdown tutorials. Use when changing code/, .m, .mlx, fise_exportMD, fise_exportFigure, or reproducibility notes in chapters.
---

# FISE reproducible MATLAB work

## Repository workflow

The repository’s computational material is primarily MATLAB. Source lives in
`code/`, including numbered topic folders and shared utilities in `code/utility/`.
Live scripts (`.mlx`) may be exported to Markdown with `fise_exportMD`; rendered
code material has its own `code/_quarto.yml` website configuration.

Treat source code and its generated figures as a pair. Do not edit a generated
image to change a scientific result when the appropriate change belongs in the
script or live script.

## Rules for code changes

- Preserve existing function names, input/output contracts, and the FISE `fise_`
  naming convention unless a deliberate migration is approved.
- Make a script runnable from a documented environment: establish paths, identify
  required toolboxes or external packages, and avoid hidden workspace state.
- Fix randomness by setting and documenting a seed when a stochastic output is
  meant to be repeatable.
- Separate computation from presentation where practical: calculate values first,
  then make figures and export them.
- Do not claim a script was run, a figure regenerated, or a numerical result
  reproduced unless it was actually executed and checked.

Good:

```matlab
% Generate the photon-count distribution used in the chapter figure.
rng(17, 'twister');
counts = poissrnd(meanPhotons, nSamples, 1);
exportgraphics(gcf, outputFile, 'Resolution', 150);
```

Bad:

```matlab
load everything
figure; plot(x)
saveas(gcf, 'final.png')
```

## Figure exports

Use `fise_exportFigure` when working within the established live-script flow. It
exports PNG at a default 150 DPI and supports an explicit resolution and figure
dimensions. Choose a descriptive filename that matches the chapter’s existing
asset organization; do not use vague names such as `final.png` or `figure2-new`.

Good:

```matlab
fise_exportFigure(gcf, outputFile, 'Resolution', 150, ...
    'Width', 900, 'Height', 600);
```

Bad:

```matlab
fise_exportFigure(gcf, 'test.png');  % copied somewhere later
```

Verify text size, line weights, color contrast, units, and axis labels at the
width used in the chapter. A generated plot must be understandable in grayscale
or with non-color cues when color encodes category.

## Live-script export and Quarto integration

`fise_exportMD(liveScriptPath, outputPath)` exports a live script to Markdown
with HTML accepted. Inspect exported Markdown before publishing: repair only
localized formatting needed for Quarto, and preserve a clear link to the `.mlx`
source. Do not assume that MATLAB-exported HTML, embedded images, or interactive
behavior will render equivalently in the main book.

Good: keep the `.mlx`, generated `.md`, generated media, and rendered tutorial
in a traceable location under `code/`.

Bad: paste an untracked screenshot of an interactive session into a chapter as
the only record of an analysis.

## Reproducibility handoff

For a changed computation, report the source file, inputs or assumptions,
dependencies, outputs regenerated, and verification performed. If execution is
not available, say so and leave an explicit, minimal command or procedure for a
maintainer to run.
