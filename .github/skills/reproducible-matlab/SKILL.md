---
name: reproducible-matlab
description: Maintain or document FISE MATLAB scripts, live scripts, generated figures, and published tutorials. Use when changing or referencing code in isetfise/fise, .m, .mlx, fise_exportMD, fise_exportFigure, or reproducibility notes in chapters.
---

# FISE reproducible MATLAB work

## Repository and Code Ecosystem

The book's computational material is primarily MATLAB and depends on the **ISET** suite of toolboxes:
- **`isetcam`**: core image systems engineering toolbox (optics, sensors, illuminants, camera simulation, `iePublish`).
- **`isetbio`**: biological image processing, physiological optics, retinal mosaic models, and computational observer models.
- **`iset3d`**: 3D spectral scene rendering and ray-tracing integrations.

### Primary Code Repository: `isetfise`

The code supporting this book lives in the GitHub repository **`isetfise`** (<https://github.com/ISET/isetfise>), specifically under the **`isetfise/fise`** subdirectory (organized into topic folders like `01Lightfields/`, `02Optics/`, `03Sensor/`, etc.).

Tutorial scripts are published to HTML using `iePublish` (from `isetcam`) and linked in the book chapters via `htmlpreview.github.io`:
```
https://htmlpreview.github.io/?https://github.com/ISET/isetfise/blob/main/fise/<topic-folder>/<script>.html
```
An index of published code links is maintained in `chapters/resources/code-html-links.qmd`.

Treat source code and its generated figures as a pair. Do not edit a generated image to change a scientific result when the appropriate change belongs in the script or live script.

## Rules for code changes

- Preserve existing function names, input/output contracts, and the FISE `fise_` naming convention unless a deliberate migration is approved.
- Make a script runnable from a documented environment: establish paths, identify required toolboxes (`isetcam`, `isetbio`, `iset3d`, etc.), and avoid hidden workspace state.
- Fix randomness by setting and documenting a seed when a stochastic output is meant to be repeatable.
- Separate computation from presentation where practical: calculate values first, then make figures and export them.
- Do not claim a script was run, a figure regenerated, or a numerical result reproduced unless it was actually executed and checked.

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

Use `fise_exportFigure` when working within the established live-script flow. It exports PNG at a default 150 DPI and supports an explicit resolution and figure dimensions. Choose a descriptive filename that matches the chapter’s existing asset organization; do not use vague names such as `final.png` or `figure2-new`.

Good:

```matlab
fise_exportFigure(gcf, outputFile, 'Resolution', 150, ...
    'Width', 900, 'Height', 600);
```

Bad:

```matlab
fise_exportFigure(gcf, 'test.png');  % copied somewhere later
```

Verify text size, line weights, color contrast, units, and axis labels at the width used in the chapter. A generated plot must be understandable in grayscale or with non-color cues when color encodes category.

### Publication-quality plots from `isetcam` data

When plotting spectral or human-vision data from `isetcam` (such as CMFs, cone fundamentals, luminosity functions, illuminants, or reflectances in `isetcam/data/human/`):

1. **Initialize and load by name**: Call `ieInit; fise_plotDefaults;` at the top of the `fise_*.m` script in `isetfise/fise/<topic>/` and load spectral files by name with `ieReadSpectra` (see `isetcam/data/human/README.md`).
2. **Use a clean white background (do not use `iePlotShadeBackground`)**:
   - Create the figure with `hdl = ieFigure([], 'default');` and explicit pixel size (e.g., `set(hdl, 'Units', 'pixels', 'Position', [100 100 760 520]);`).
   - Keep `ax.Box = 'off'`, `ax.TickDir = 'out'`, `ax.LineWidth = 1.2`, `ax.FontName = 'Georgia'`, `ax.FontSize = 16`, and a subtle grid (`grid(ax, 'on'); ax.GridAlpha = 0.2; ax.GridColor = [0.3 0.3 0.3];`).
   - For trichromatic (RGB / XYZ / LMS) curves on white backgrounds, use high-legibility colors rather than saturated `[0 1 0]` green:
     ```matlab
     triColors = [0.85 0.15 0.20; 0.15 0.65 0.25; 0.15 0.38 0.85];
     ```
     with `LineWidth = 2.4`, and add a dashed zero reference line (`yline(ax, 0, '--', ...)`) whenever curves take negative values.
3. **Lock axis limits across `.panel-tabset` siblings**: When generating multiple plots intended for tabs in the same Quarto `.panel-tabset` (e.g., 2° vs. 10° observers), enforce identical `xlim`, `ylim`, `xticks`, and `yticks` so clicking between tabs never shifts the axes.
4. **Export at 300 DPI via `fiseBookPath`**:
   ```matlab
   outFile = fullfile(fiseBookPath, 'chapters', 'images', ...);
   exportgraphics(hdl, outFile, 'Resolution', 300);
   ```
   Reference the generating script in the Quarto figure caption (`Source: fise_<name>.m`). See `fise_cmfStilesBurch.m` and `fise_cieStandards.m` in `isetfise/fise/04Human/` for canonical examples.

## Live-script export and Quarto integration

`fise_exportMD(liveScriptPath, outputPath)` exports a live script to Markdown with HTML accepted. Inspect exported Markdown before publishing: repair only localized formatting needed for Quarto, and preserve a clear link to the `.mlx` source. Do not assume that MATLAB-exported HTML, embedded images, or interactive behavior will render equivalently in the main book.

Good: keep the `.mlx`, generated `.md`, generated media, and published tutorial in a traceable location in `isetfise/fise/`.

Bad: paste an untracked screenshot of an interactive session into a chapter as the only record of an analysis.

## Reproducibility handoff

For a changed computation, report the source file (in `isetfise/fise/`), inputs or assumptions, dependencies (`isetcam`, `isetbio`, `iset3d`), outputs regenerated, and verification performed. If execution is not available, say so and leave an explicit, minimal command or procedure for a maintainer to run.
