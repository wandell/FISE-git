# Spatial metrics slide review

Reviewed 2026-11-08 for use in the FISE book chapter.

## Image processing performed

- Renamed 23 exported slides with ordered, descriptive filenames.
- Removed the 80-pixel PowerPoint title treatment from all 23 slides. The edited images are 1440 × 730 pixels.
- Verified that each source slide exactly matched the corresponding image in `FISE-2025-Figures/Figures/human/04-metrics/04-spatial-metrics.zip` before editing.
- Compared every edited image with the corresponding source crop pixel by pixel. All pixels below the removed title treatment are unchanged apart from PNG re-encoding.
- Preserved the source resolution and did not apply global sharpening. Sharpening would create halos around equations, gratings, and graph lines; the items marked **R** should instead be redrawn or re-exported from source material.
- Left the pre-existing supporting figures `Schade_NAEwebsite.png` and `Vernier_fisica.png` unchanged.
- Slides 005 and 012 had different title bars but identical image content. Their filenames retain the stated script-input/script-output roles; consider keeping only one in the chapter.
- Moved the S-CIELAB sequence to `../06-color-metrics/metrics/`, after the CIELAB material. Three exact duplicates were consolidated with the canonical color-metrics copies.

## Review key

Visual QA:

- **G** — main text and graphics are clean at native resolution.
- **M** — main content is usable, but small labels, equations, or inset graphics may be difficult at a single-column book width.
- **R** — re-export or redraw from the source is recommended before publication.

Accuracy:

- **Pass** — no factual problem found at the pedagogical level of the slide.
- **Note** — basically accurate, but a qualification, source, or condition should be added.
- **Revise** — a concrete correction is proposed below.
- **Hold** — incomplete or not independently reviewable.

## Individual review

### Slanted-edge sharpness

| Image | Visual QA | Accuracy review |
|---|---:|---|
| [001](001-structural-similarity-overview.png) | G | **Pass.** Introductory slide with no quantitative claim. Replace the script name with a repository link if it remains in the book. |
| [002](002-iso-12233-slanted-edge-sharpness.png) | M | **Revise.** Use **slanted edge**, the terminology in ISO 12233, rather than “slanted bar.” Describe the result as the camera/system edge-based spatial frequency response (e-SFR), which can include the lens, sensor sampling, demosaicing, sharpening, compression, and other processing. The slant supplies subpixel phase samples for an oversampled edge-spread estimate; it does not exceed the sensor’s physical resolution. |
| [003](003-slanted-edge-sfr-calculation.png) | R | **Revise.** The derivative of an ideal mathematical step is an impulse, but the derivative of the captured edge-spread function is the line-spread function. Its normalized Fourier magnitude gives e-SFR; call it MTF only when the required linear-system assumptions are justified. Replace “half-width of the MTF” with “MTF50/SFR50: the spatial frequency where the normalized response falls to 0.5.” A simple sum of channels is not generally calibrated luminance. Redraw the plot and state the frequency units and sampling conditions. |

### Structural similarity (SSIM)

| Image | Visual QA | Accuracy review |
|---|---:|---|
| [004](004-structural-similarity-index-overview.png) | M | **Note.** Accurate summary of the original full-reference, grayscale SSIM formulation. Say “full-reference similarity measure” rather than merely “difference.” Values are often between 0 and 1 for ordinary images, but local SSIM can be negative. |
| [005](005-ssim-color-test-pattern-script-input.png) | G | **Note.** The example is useful, but specify the generated signal, noise distribution and amplitude, RGB-to-grayscale conversion, dynamic range, and random seed. Its pixels duplicate slide 012 after the title crop. |
| [006](006-ssim-luminance-test-pattern.png) | G | **Note.** Appropriate luminance-domain input example. State the luminance or grayscale conversion and the noise parameters. |
| [007](007-ssim-calculation-flow.png) | M | **Revise.** Keep 1 as the unique maximum for identical local signals, but do not treat 0 and −1 as a binary “not similar” class. `1 − SSIM` is a useful dissimilarity, with a possible range of 0–2 when negative SSIM is allowed, but it is not generally a mathematical distance metric. Label any displayed map explicitly as SSIM or `1 − SSIM`. |
| [008](008-ssim-component-equations.png) | M | **Note.** The unweighted sample mean, standard deviation, covariance, and comparison equations are correct. The later 11 × 11 implementation uses normalized Gaussian weights, so use weighted local statistics when presenting these equations as the actual implementation. |
| [009](009-ssim-component-equations-enlarged.png) | G | **Note.** Same weighting qualification as slide 008. This is the more legible version; use it instead of 008 if only one equation slide is needed. |
| [010](010-ssim-combined-equation.png) | G | **Note.** The equations and MATLAB defaults shown are correct. Describe `C1` and `C2` as regularization constants derived from the dynamic range: `C1 = (K1 L)^2`, `C2 = (K2 L)^2`, conventionally with `K1 = 0.01` and `K2 = 0.03`; they are not themselves unsquared fractions of the range. |
| [011](011-ssim-local-gaussian-window.png) | M | **Note.** An 11 × 11 Gaussian window with standard deviation 1.5 samples is the original/common single-scale choice. The appropriate perceptual scale depends on image resolution and viewing distance. Cite the original authors’ downsampling guidance or state the exact preprocessing used instead of implying that one fixed window is universally appropriate. |
| [012](012-ssim-color-test-pattern-script-output.png) | G | **Note.** Pixel-identical to slide 005 after removal of the title treatment. Remove one duplicate unless the input/output distinction is explained in the surrounding text. |
| [014](014-ssim-viewing-angle-limitation.png) | R | **Note.** The core PSNR and single-scale SSIM formulas do not take display size or viewing distance as inputs. SSIM’s authors nevertheless recommend scale-dependent preprocessing for a typical viewing distance, and multiscale variants exist. State the claim as a limitation of an unmodified fixed-pixel implementation. Enlarge the example substantially for book use. |
| [015](015-ssim-error-map-viewing-distance-invariant.png) | G | **Revise.** For fixed pixel arrays and fixed parameters, the computed map is independent of physical viewing distance; after scale-dependent resampling it can change. Identify the quantity as SSIM or `1 − SSIM`, label the color bar, and give the window, dynamic range, grayscale conversion, and noise parameters. |
| [019](019-ssim-color-chart-error-map.png) | G | **Revise.** State whether the plot is SSIM or `1 − SSIM`; the current “error map” wording and 0–1 color bar do not establish the direction. Document the grayscale conversion, window, dynamic range, padding/border treatment, noise, and viewing-scale preprocessing. Basic grayscale SSIM does not measure chromatic error. |

### Spatial CIELAB and viewing scale

| Image | Visual QA | Accuracy review |
|---|---:|---|
| [016](../06-color-metrics/metrics/120-scielab-viewing-angle-test-pattern.png) | M | **Note.** A valid scale-dependence demonstration if the two renderings represent defined visual angles. State display pixels per degree, viewing distance, stimulus dimensions, color encoding/calibration, reference white, and noise parameters; “384 × 384” alone is insufficient. |
| [017](../06-color-metrics/metrics/121-scielab-viewing-angle-error-maps.png) | G | **Note.** S-CIELAB should change with angular sampling because its filters are specified in visual units. Confirm that both maps share the same ΔE scale and document the parameters listed for slide 016. |
| [018](../06-color-metrics/metrics/122-color-chart-two-viewing-angles.png) | G | **Note.** The larger/smaller comparison is plausible, but it requires a defined physical display geometry. State how 10° and 50° were generated and whether both panels preserve the same image data, noise, and colorimetric values. |
| [020](../06-color-metrics/metrics/115-spatial-cielab-processing-pipeline.png) | M | **Pass.** Correct S-CIELAB sequence: opponent representation, channel-specific spatial filtering, conversion to XYZ/CIELAB using a reference white, and color-difference calculation. Cite Zhang and Wandell precisely. |
| [021](../06-color-metrics/metrics/116-scielab-delta-e-map-computation.png) | M | **Note.** Correct comparison workflow. Identify the Euclidean difference as CIE76 `ΔE*ab` after S-CIELAB filtering and state the reference white and viewing geometry. A mean ΔE is one summary and can hide localized errors; retain the map or add a percentile/area-above-threshold statistic when localization matters. |
| [022](../06-color-metrics/metrics/123-spatial-cielab-viewing-angle-error-maps.png) | G | **Note.** The qualitative conclusion can be correct for this stimulus, but “smaller is harder” is not universal. Visibility depends on angular frequency, luminance, chromatic direction, adaptation, noise spectrum, and observer. State the same calibration and viewing parameters as slides 016–018 and confirm a shared color scale. |
| [023](../06-color-metrics/metrics/118-color-error-spatial-frequency-dependence.png) | R | **Note.** The qualitative contrast is correct for equal-amplitude patterned errors: pointwise CIELAB has no spatial filtering, whereas S-CIELAB varies with spatial frequency. Add the data source, pattern amplitude, color direction, viewing geometry, reference white, and aggregation method; redraw the graph with readable axes and uncertainty if available. |
| [024](024-spatial-metrics-integration-notes.png) | G | **Hold.** This is an internal planning slide, not book-ready evidence. Replace it with developed text and exact citations. Correct “LPIP” to **LPIPS**; distinguish stelaCSF, S-CIELAB, HDR/ColorVideoVDP-family predictors, and LPIPS by the task and viewing/display parameters each model addresses. |

## Proposed corrections, prioritized

### Correct before publication

1. **002–003:** use ISO 12233 **slanted-edge e-SFR** terminology; define the edge-spread, line-spread, Fourier, normalization, and MTF50/SFR50 steps accurately. Do not call a channel sum luminance without calibration.
2. **007:** replace the binary interpretation of 0/−1 and qualify `1 − SSIM` as a dissimilarity rather than a general distance metric.
3. **015 and 019:** identify whether each map is SSIM or `1 − SSIM`, label the color-bar direction, and report all implementation parameters.
4. **014–019 and 022:** state the pixel-to-visual-angle conversion and distinguish fixed-pixel SSIM from scale-aware preprocessing. Add display geometry, noise, color conversion, dynamic range, and filtering details.
5. **008–011:** keep the formulas but make the local-statistics weighting consistent with the Gaussian-window implementation and define `L`, `K1`, `K2`, `C1`, `C2`, and `C3` together.
6. **016–023:** add the S-CIELAB viewing conditions, calibration/color encoding, white point, ΔE definition, and summary statistic.
7. **024:** exclude the internal TODO slide until the comparison among stelaCSF, S-CIELAB, visual-difference predictors, and LPIPS is written and sourced.

### Improve for book legibility

The strongest redraw/re-export candidates are **003, 014, and 023**. Slides **002, 004, 007, 008, 011, 016, 020, and 021** contain inset graphics or small labels that may be difficult at a single-column width. Prefer slide **009** over **008** for the same SSIM equations, and remove either **005** or **012** because their post-crop content is identical.

## Primary references used for validation

- ISO, [ISO 12233:2024 — Digital cameras: Resolution and spatial frequency responses](https://www.iso.org/standard/88626.html), including the [online preview and terminology](https://www.iso.org/obp/ui#iso:std:iso:12233:ed-5:v1:en).
- Wang, Bovik, Sheikh, and Simoncelli, [“Image Quality Assessment: From Error Visibility to Structural Similarity” (2004)](https://ece.uwaterloo.ca/~z70wang/publications/ssim.pdf), and the authors’ [SSIM implementation and scale guidance](https://www.ece.uwaterloo.ca/~z70wang/research/ssim/).
- MathWorks, [MATLAB `ssim` documentation](https://www.mathworks.com/help/images/ref/ssim.html), for the documented implementation defaults and argument behavior.
- Zhang and Wandell, [“A Spatial Extension of CIELAB for Digital Color-Image Reproduction” (1997)](https://doi.org/10.1889/1.1985127).
- Mantiuk, Ashraf, and Chapiro, [“stelaCSF: A Unified Model of Contrast Sensitivity”](https://doi.org/10.17863/CAM.88203).
- Zhang et al., [“The Unreasonable Effectiveness of Deep Features as a Perceptual Metric” (LPIPS, 2018)](https://openaccess.thecvf.com/content_cvpr_2018/papers/Zhang_The_Unreasonable_Effectiveness_CVPR_2018_paper.pdf).
