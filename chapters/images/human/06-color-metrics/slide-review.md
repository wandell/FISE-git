# Color metrics slide review

Reviewed 2026-11-08 for use in the FISE book chapter.

## Image processing performed

- Removed the 80-pixel PowerPoint title treatment from the 122 images that contained it. These files are now 1440 × 730 pixels.
- Left `metrics/043-cie-1931-chromaticity-diagram.png` at 1440 × 810 because it had no title treatment.
- Preserved the source resolution and did not apply global sharpening. The remaining text and line pixels are unchanged apart from PNG re-encoding. Global sharpening would create halos around equations and graph lines.
- Corrected the filename for slide 093 from Helmholtz to Hering; the slide quotes and depicts Ewald Hering.
- Moved the complete S-CIELAB sequence (111–118) from `appearance/` to `metrics/`, after the CIELAB material, and added four unique viewing-angle examples (120–123) from the spatial-metrics slide set. Exact duplicate exports were consolidated rather than retained twice.

## Review key

Visual QA:

- **G** — main text and graphics are clean at native resolution.
- **M** — main content is usable, but small labels, code, or inset graphics may be difficult at a single-column book width.
- **R** — re-export or redraw from the source is recommended before publication.

Accuracy:

- **Pass** — no factual problem found at the pedagogical level of the slide.
- **Note** — basically accurate, but a qualification, source, or condition should be added.
- **Revise** — a concrete correction is proposed below.
- **Hold** — incomplete or not independently reviewable.

## Individual review

### Display matching, radiometry, and photometry

| Image | Visual QA | Accuracy review |
|---|---:|---|
| [001](metrics/001-display-color-matching-overview.png) | G | **Pass.** Accurate chapter overview. |
| [002](metrics/002-crt-color-matching-experiment.png) | M | **Pass.** Accurate historical CRT description; diagram labels are small. |
| [003](metrics/003-crt-logical-organization.png) | M | **Pass.** CRT organization and shadow-mask logic are accurate. |
| [004](metrics/004-display-subpixel-layouts.png) | M | **Note.** The layouts are illustrative examples; identify the display technologies or sources if used in the book. |
| [005](metrics/005-crt-shadow-mask-geometry.png) | G | **Pass.** The geometry is a sound qualitative explanation. |
| [006](metrics/006-crt-shadow-mask-electron-beams.png) | G | **Pass.** Consistent with shadow-mask operation. |
| [007](metrics/007-display-primary-spd-superposition.png) | M | **Pass.** Additive superposition of primary spectral radiances is correct. |
| [008](metrics/008-display-emissions-matrix.png) | M | **Note.** Call the columns calibrated primary spectral-radiance basis functions; units and normalization should be stated together. |
| [009](metrics/009-xyz-to-display-primary-intensities.png) | M | **Pass.** Correct for a calibrated linear display model. |
| [010](metrics/010-xyz-to-display-primary-equation.png) | G | **Pass.** Matrix formulation is correct. |
| [011](metrics/011-display-color-matching-inverse-matrix.png) | G | **Note.** State that the inverse solution assumes a nonsingular calibration matrix and an in-gamut XYZ target; otherwise primary values may be negative or exceed one. |
| [012](metrics/012-display-gamma-transduction.png) | M | **Revise.** Label the power law as a CRT-like approximation. Modern systems use specified piecewise transfer functions or EOTFs; “gamma” is not a universal single power law. |
| [013](metrics/013-gamma-perceptual-step-spacing.png) | G | **Pass.** The qualitative comparison is correct. |
| [014](metrics/014-direct-color-processing-pipeline.png) | M | **Note.** The pipeline is intentionally simplified. Camera RGB to XYZ requires device characterization, and real pipelines may include white balance, gamut mapping, and tone mapping. |
| [015](metrics/015-photometry-radiance-luminance-overview.png) | G | **Pass.** Accurate overview. |
| [016](metrics/016-radiometry-geometry.png) | R | **Pass.** Quantities are conceptually correct, but the source drawing and labels should be redrawn for book resolution. |
| [017](metrics/017-spectral-radiance-definition.png) | G | **Pass.** Definition and units are correct. |
| [018](metrics/018-spectral-radiance-spectrum.png) | M | **Pass.** Correct extension of spectral radiance over wavelength. |
| [019](metrics/019-spectral-radiance-solid-angle-units.png) | G | **Note.** Replace the ambiguous `E(λ)` notation with the standard differential radiant-flux definition so energy, power, area, solid angle, and wavelength are unambiguous. |
| [020](metrics/020-spectral-radiance-steradian-geometry.png) | M | **Pass.** Solid-angle explanation is correct for a unit sphere. |
| [021](metrics/021-spectral-radiance-foreshortened-area.png) | M | **Note.** Describe θ explicitly as the angle between the surface normal and viewing direction. |
| [022](metrics/022-measuring-spectral-radiance.png) | M | **Pass.** Spectroradiometer description and units are correct. |
| [023](metrics/023-radiance-distance-invariance.png) | M | **Revise.** Change “measure luminance” to “measure spectral radiance; luminance can then be computed.” Distance invariance assumes a resolved source, fixed viewing direction, and negligible intervening loss. |
| [024](metrics/024-radiance-ray-density-with-distance.png) | M | **Revise.** Apply the same radiance-versus-luminance correction and assumptions as slide 023. |
| [025](metrics/025-radiance-solid-angle-with-distance.png) | M | **Revise.** Apply the same radiance-versus-luminance correction and assumptions as slide 023. |
| [026](metrics/026-radiance-area-solid-angle-balance.png) | M | **Revise.** Apply the same radiance-versus-luminance correction and assumptions as slide 023. |
| [027](metrics/027-irradiance-surface-angle.png) | G | **Pass.** Correct qualitative statement of the cosine projection effect. |
| [028](metrics/028-spectral-radiance-irradiance-units.png) | R | **Revise.** Use standard symbols (`Φe`, `Ie`, `Le`, `Ee`) and define radiance directly as `d²Φe/(dA cosθ dΩ)`. The current table is conceptually sound but its notation is nonstandard and dense. |
| [029](metrics/029-photometry-ives-1912.png) | R | **Pass.** The Ives 1912 historical attribution is appropriate; the article excerpts are not legible at book width and should be represented by a citation or a higher-resolution source. |
| [030](metrics/030-empirical-luminosity-function.png) | G | **Pass.** Correct qualitative account of heterochromatic flicker photometry. |
| [031](metrics/031-flicker-photometry-luminosity-function.png) | M | **Note.** A 20 Hz alternation is illustrative, not universal; flicker fusion depends on field size, luminance, eccentricity, and adaptation. |
| [032](metrics/032-spectral-radiance-to-luminance.png) | M | **Pass.** Correct radiometric-to-photometric relationship. |
| [033](metrics/033-luminance-integral.png) | M | **Note.** `Kcd = 683 lm/W` is exact at 540 THz; this corresponds to about 555.017 nm in standard air. Avoid implying that 683 is merely an empirical rounded peak at exactly 555 nm. |
| [034](metrics/034-photometric-units-geometry.png) | R | **Pass.** The relationships are correct, but the low-resolution historical diagram should be redrawn. |
| [035](metrics/035-typical-luminance-levels.png) | M | **Note.** Values are plausible orders of magnitude but vary greatly with atmosphere, geometry, materials, and measurement method. Add a source and label them approximate. |
| [036](metrics/036-outdoor-luminance-dynamic-range.png) | M | **Note.** The stated dynamic range is sample-specific. State how the minimum and maximum were selected and cite the measurement data. |
| [037](metrics/037-indoor-luminance-dynamic-range.png) | M | **Note.** Same provenance and selection issue as slide 036. |
| [038](metrics/038-corresponding-photometric-units.png) | R | **Revise.** Use standard photometric symbols (`Φv`, `Iv`, `Lv`, `Ev`) and improve the table’s typesetting before publication. |

### Chromaticity, display gamuts, and CIELAB

| Image | Visual QA | Accuracy review |
|---|---:|---|
| [039](metrics/039-cie-xy-chromaticity-overview.png) | G | **Pass.** Accurate overview. |
| [040](metrics/040-chromaticity-coordinate-transform.png) | G | **Pass.** The `x` and `y` definitions and intensity invariance are correct. |
| [041](metrics/041-chromaticity-diagram-construction.png) | M | **Pass.** Correct projective construction. |
| [042](metrics/042-cie-xy-chromaticity-geometry.png) | M | **Pass.** Correct explanation of the XYZ unit plane and xy projection. |
| [043](metrics/043-cie-1931-chromaticity-diagram.png) | R | **Note.** Treat the rendered colors as schematic: an RGB page or display cannot reproduce the entire spectral locus. Re-export or replace the low-resolution chart and cite its source. |
| [044](metrics/044-blackbody-locus.png) | M | **Pass.** Qualitatively correct Planckian-locus construction. |
| [045](metrics/045-complementary-colors.png) | M | **Note.** Complementarity is relative to a specified reference white and additive mixing; the figure appears to use D65, which should be stated in the caption. |
| [046](metrics/046-dominant-wavelength.png) | M | **Note.** Dominant wavelength is relative to a chosen white. Purple-side chromaticities require a complementary wavelength rather than a dominant spectral wavelength. |
| [047](metrics/047-display-gamut-triangle.png) | M | **Revise.** Call the triangle an **xy chromaticity gamut** or 2-D gamut projection; it does not represent luminance range or full 3-D color volume. |
| [048](metrics/048-human-vision-and-hdtv-gamut.png) | M | **Revise.** Replace the categorical claim that a sensor gamut is “not meaningful.” A primary triangle is not an appropriate sensor model, but capture capability can be characterized when spectral sensitivities, noise, exposure, and encoding are specified. |
| [049](metrics/049-industry-color-gamuts.png) | R | **Revise.** Use “chromaticity triangles” rather than full physical display gamuts. Negative primary coefficients are mathematical coordinates, not physically emitted negative light. The many labels need a vector redraw. |
| [050](metrics/050-srgb-color-gamut.png) | M | **Note.** Describe sRGB as a standardized RGB encoding with defined reference conditions, historically designed around CRT behavior, rather than only as a guide for rendering on CRTs. |
| [051](metrics/051-prophoto-rgb-color-gamut.png) | R | **Revise.** Use the standardized name **ROMM RGB (commonly ProPhoto RGB)** and describe it as an extended, output-referred encoding, not a physical display gamut. Verify or remove the unsupported “developed at Kodak in the 1980s” date. |
| [052](metrics/052-prophoto-rgb-xyz-conversion.png) | M | **Pass.** The piecewise ROMM RGB encoding structure is consistent with the standard; cite ISO 22028-2 or the ICC registry and use its notation consistently. |
| [053](metrics/053-signal-light-chromaticities.png) | M | **Note.** The categories are illustrative; regulated signal-light chromaticity boundaries depend on the applicable standard. |
| [054](metrics/054-iset3d-sphere-scene.png) | R | **Note.** The physical example is sound, but the ISET3d API is version-specific. Replace the screenshot with tested source code or verify the current API before publication. |
| [055](metrics/055-sensor-rendered-sphere.png) | R | **Note.** Same software-version issue as slide 054; the rendering concept is correct. |
| [056](metrics/056-rendered-sphere-rgb-variation.png) | R | **Note.** Same software-version issue as slide 054; the shading claim is correct. |
| [057](metrics/057-sphere-luminance-vs-chromaticity.png) | M | **Revise.** `R+G+B` is not luminance for a general RGB space. Relabel it “RGB sum/intensity” or compute calibrated luminance from XYZ `Y` (or appropriate RGB luminance weights). The `r,g` quantities are normalized RGB coordinates, not CIE xy. |
| [058](metrics/058-fruit-scene-shading.png) | M | **Pass.** Accurate qualitative example of diffuse shading and specular structure. |
| [059](metrics/059-fruit-scene-rgb-vs-rg.png) | G | **Note.** Normalized rg reduces common multiplicative intensity variation but does not generally remove illumination spectra, highlights, clipping, or sensor nonlinearity. |
| [060](metrics/060-color-matching-main-points.png) | M | **Pass.** Summary claims are accurate; xy should continue to be described as omitting luminance. |
| [061](metrics/061-color-engineering-overview.png) | G | **Pass.** Accurate transition. |
| [062](metrics/062-cielab-color-metric-overview.png) | G | **Pass.** Appropriate scope and caveat for uniform patches. |
| [063](metrics/063-xyz-distance-nonuniformity-example.png) | G | **Pass.** Correct demonstration that XYZ Euclidean distance is not perceptually uniform. |
| [064](metrics/064-xyz-distance-linear-transform-invariance.png) | G | **Pass.** Correct argument about linear coordinate transforms and background-dependent discrimination. |
| [065](metrics/065-weber-fechner-color-metric.png) | M | **Revise.** Replace “roughly logarithmic” with “compressive, piecewise cube-root/linear” for CIELAB. Weber–Fechner behavior is an approximation over limited regimes. |
| [066](metrics/066-macadam-threshold-ellipse-data.png) | M | **Note.** Local match distributions and thresholds can be approximated by ellipses; CIELAB only approximately makes such regions more circular and uniform. |
| [067](metrics/067-macadam-ellipses.png) | R | **Pass.** The 10× display magnification and MacAdam interpretation are correct. Redraw the low-resolution chart and cite MacAdam (1942). |
| [068](metrics/068-cielab-metric-overview.png) | G | **Pass.** Accurate overview. |
| [069](metrics/069-cie-lightness-formula.png) | M | **Revise.** Correct the breakpoint from `0.00856` to `216/24389 ≈ 0.008856`. `903.3` is the rounded value of `24389/27`. |
| [070](metrics/070-cielab-chrominance-formulas.png) | M | **Revise.** Use the standard piecewise function `f(t)` in the `a*` and `b*` equations; an unconditional cube root is incorrect below the CIELAB breakpoint. |
| [071](metrics/071-cielab-color-solid.png) | M | **Pass.** The orientation is a reasonable conceptual illustration; replace or properly credit the commercial low-resolution graphic. |
| [072](metrics/072-cielab-derived-quantities.png) | M | **Revise.** Use `atan2(b*, a*)` or explicit quadrant correction for hue. Say CIEDE2000 extends CIE76 with lightness, chroma, hue, and interaction corrections under reference conditions, rather than simply “replaces” it. |

### Munsell, discrimination, opponent color, and spatial color

| Image | Visual QA | Accuracy review |
|---|---:|---|
| [073](appearance/073-munsell-color-appearance-overview.png) | G | **Pass.** Accurate overview. |
| [074](appearance/074-munsell-book-of-colors.png) | G | **Pass.** Appropriate historical illustration. |
| [075](appearance/075-munsell-color-solid-model.png) | G | **Pass.** Appropriate illustration of the irregular color solid. |
| [076](appearance/076-munsell-value-radial-slices.png) | M | **Pass.** Correct value-axis organization. |
| [077](appearance/077-munsell-hue-notation.png) | M | **Pass.** Correct hue organization. |
| [078](appearance/078-munsell-chroma-notation.png) | M | **Revise.** Change “center to edge is saturation” to “center to edge is Munsell chroma.” Chroma and saturation are related but not synonymous. |
| [079](appearance/079-munsell-notation-and-sampling.png) | M | **Pass.** `Hue Value/Chroma` notation and renotation statement are correct. |
| [080](appearance/080-cielab-vs-munsell-hue-saturation.png) | M | **Revise.** Change “Munsell hue and saturation” to “Munsell hue and chroma,” including the filename if the slide is revised. |
| [081](appearance/081-multidimensional-scaling-distance-matrix.png) | G | **Note.** MDS can estimate a low-dimensional distance representation; perceptual uniformity is not guaranteed and depends on the judgment and scaling model. Spell the cited law “Stevens’ power law.” |
| [082](appearance/082-multidimensional-scaling-first-distance.png) | G | **Note.** Same modeling qualification as slide 081. |
| [083](appearance/083-multidimensional-scaling-second-distance.png) | G | **Note.** Same modeling qualification as slide 081. |
| [084](appearance/084-multidimensional-scaling-embedding.png) | G | **Note.** Same modeling qualification as slide 081. |
| [085](appearance/085-color-discrimination-cone-noise-overview.png) | G | **Pass.** Accurate overview. |
| [086](appearance/086-cone-absorption-noise-simulation.png) | M | **Note.** Poisson photon-catch noise is a standard first approximation, but the simulation omits or abstracts optical, adaptation, and post-receptoral noise. State all stimulus and observer parameters. |
| [087](appearance/087-cone-noise-low-light-overlap.png) | M | **Revise.** Luminance alone does not determine cone counts or wavelength discrimination. Include pupil/retinal illuminance, duration, field size, adaptation, optics, and cone mosaic parameters; label the conclusion as this simulation’s result. |
| [088](appearance/088-cone-noise-moderate-light-separation.png) | M | **Revise.** Same missing-condition issue as slide 087. |
| [089](appearance/089-cone-noise-high-light-separation.png) | M | **Revise.** Same missing-condition issue as slide 087. |
| [090](appearance/090-color-thresholds-cone-biology.png) | M | **Note.** The threshold concept and cone-contrast result are sound. Replace “Wandell, JOSA, 1986” with the full primary citation for the plotted data; the readily identified related JOSA paper is Wandell (1985). |
| [091](appearance/091-color-threshold-experimental-design.png) | M | **Pass.** Two-interval forced-choice design and threshold interpretation are correct; add the full source citation. |
| [092](appearance/092-color-matching-variance-and-thresholds.png) | M | **Note.** The qualitative conclusion is supported, but the plotted dataset needs an exact primary citation and stimulus conditions. |
| [093](appearance/093-hering-perceptual-opponent-colors.png) | G | **Pass.** The quotation and portrait are Ewald Hering; cite the 1874 source or a reliable translation. |
| [094](appearance/094-red-green-color-examples.png) | G | **Pass.** Illustrative stimulus set; no quantitative claim. |
| [095](appearance/095-opponent-color-axes.png) | M | **Pass.** Correct qualitative opponent-pair organization. |
| [096](appearance/096-blue-yellow-hue-cancellation.png) | G | **Pass.** Correct explanation of blue–yellow hue cancellation. |
| [097](appearance/097-red-green-hue-cancellation.png) | G | **Pass.** Correct explanation of red–green hue cancellation. |
| [098](appearance/098-hue-cancellation-curves.png) | M | **Pass.** Consistent with classical Hurvich–Jameson results; cite the observer and experimental conditions. |
| [099](appearance/099-hue-cancellation-observer-comparison.png) | M | **Pass.** Correctly shows observer variability; cite the data source. |
| [100](appearance/100-opponent-color-neural-pathways.png) | M | **Note.** Eye-specific organization through LGN and into V1 is broadly correct, but binocular integration begins in V1 and the anatomical wording should remain qualified. |
| [101](appearance/101-lgn-wavelength-opponent-responses.png) | M | **Pass.** Correct qualitative description of wavelength-opponent LGN responses. |
| [102](appearance/102-lgn-responses-vs-hue-cancellation.png) | M | **Pass.** The slide appropriately states similarity rather than identity. |
| [103](appearance/103-derrington-lgn-opponent-responses.png) | M | **Pass.** Consistent with Derrington, Krauskopf, and Lennie (1984). |
| [104](appearance/104-opponent-color-functions-summary.png) | G | **Revise.** Avoid implying a direct identity between perceptual hue-cancellation functions and LGN cell responses. Both reflect cone-opponent combinations, but the DKL cardinal mechanisms are not the perceptual red–green and blue–yellow axes. |
| [105](appearance/105-color-discrimination-spatial-pattern-overview.png) | G | **Pass.** Accurate transition. |
| [106](appearance/106-color-pattern-scale-appearance.png) | G | **Pass.** Correct qualitative demonstration that appearance changes with spatial scale. |
| [107](appearance/107-spatial-pattern-color-discrimination.png) | M | **Pass.** Correct qualitative comparison of luminance and chromatic contrast. |
| [108](appearance/108-edge-sensitivity-luminance-vs-color.png) | M | **Pass.** Appropriate demonstration that equal pointwise CIELAB steps do not imply equal spatial visibility. |
| [109](appearance/109-luminance-guides-edge-resolution.png) | G | **Revise.** “Guided by luminance, not color” is too absolute. Use “fine edge resolution is dominated by luminance; chromatic mechanisms also resolve edges at lower spatial bandwidth.” |
| [110](appearance/110-spatiotemporal-color-sensitivity.png) | M | **Note.** The ordering is correct qualitatively, but exact boundaries depend on stimulus, retinal location, luminance, adaptation, and observer. Add the source and conditions. |
| [111](metrics/111-spatial-cielab-overview.png) | G | **Pass.** Accurate transition. |
| [112](metrics/112-asymmetric-color-matching-experiment.png) | M | **Pass.** Consistent with Poirson and Wandell (1993). |
| [113](metrics/113-three-channel-spatial-color-model.png) | M | **Pass.** Correct pattern–color-separable model summary. |
| [114](metrics/114-pattern-color-sensitivity-model-fit.png) | R | **Pass.** Consistent with the published three-mechanism model, but graph labels are too small; redraw from source data. |
| [115](metrics/115-spatial-cielab-processing-pipeline.png) | M | **Pass.** Correct S-CIELAB sequence. Cite either the 1996 SID paper or the 1997 journal paper precisely. |
| [116](metrics/116-scielab-delta-e-map-computation.png) | M | **Pass.** Correct distinction between pointwise CIELAB and spatially filtered S-CIELAB maps. |
| [117](metrics/117-scielab-radcliffe-compression-example.png) | M | **Note.** The example is plausible, but the compression settings, viewing geometry, and summary statistic should be stated. |
| [118](metrics/118-color-error-spatial-frequency-dependence.png) | R | **Note.** The qualitative CIELAB/S-CIELAB contrast is correct for the illustrated equal-amplitude patterns. Add the data source, pattern amplitude, viewing geometry, and error aggregation method; redraw the graph. |
| [119](appearance/119-todo-computer-vision-color-distance.png) | G | **Hold.** This is an internal TODO with no result, method, or citation. Exclude it from the book until the Zheng result is supplied and independently documented. |
| [120](metrics/120-scielab-viewing-angle-test-pattern.png) | M | **Note.** State display pixels per degree, viewing distance, stimulus dimensions, color encoding/calibration, reference white, and noise parameters; “384 × 384” alone does not define the viewing geometry. |
| [121](metrics/121-scielab-viewing-angle-error-maps.png) | G | **Note.** Confirm that both maps use the same ΔE scale and document the viewing and calibration parameters from slide 120. |
| [122](metrics/122-color-chart-two-viewing-angles.png) | G | **Note.** State how the 10° and 50° versions were generated and whether the image data, noise, and colorimetric values were otherwise identical. |
| [123](metrics/123-spatial-cielab-viewing-angle-error-maps.png) | G | **Note.** “Smaller is harder” is stimulus-dependent. State the angular frequency, luminance, chromatic direction, adaptation, noise spectrum, observer assumptions, and shared color scale. |

## Proposed corrections, prioritized

### Correct before publication

1. **069:** change the CIELAB breakpoint from `0.00856` to `0.008856` (prefer the exact `216/24389`).
2. **070:** use the standard piecewise CIELAB `f(t)` function in both chrominance equations.
3. **072:** use `atan2` for hue angle and describe CIEDE2000 more precisely.
4. **057:** do not call `R+G+B` luminance unless the RGB calibration makes that identity true.
5. **078 and 080:** use *Munsell chroma*, not saturation.
6. **023–026:** distinguish measured spectral radiance from derived luminance and state the conditions for distance invariance.
7. **047–051:** distinguish a 2-D xy chromaticity triangle from full color gamut/volume; update the ROMM RGB terminology.
8. **087–089:** expose the simulation parameters required to support the quantitative discrimination claims.
9. **104 and 109:** soften the overly direct LGN/perceptual-opponency mapping and the absolute luminance-versus-color edge claim.
10. **119:** remove from the book until the unfinished result and source are provided.

### Improve for book legibility

The strongest redraw/re-export candidates are **016, 028, 029, 034, 038, 043, 049, 051, 054–056, 067, 114, and 118**. Dense plot labels and code screenshots elsewhere are marked **M** in the tables. Rebuilding these from source plots or typeset equations will be more reliable than sharpening the current raster images.

## Primary references used for validation

- CIE, [Colorimetry, 4th Edition (CIE 015:2018)](https://www.cie.co.at/publications/colorimetry-4th-edition).
- CIE, [Colorimetry Part 4: CIE 1976 L*a*b* Colour Space](https://cie.co.at/publications/colorimetry-part-4-cie-1976-lab-colour-space-0).
- CIE, [Colorimetry Part 6: CIEDE2000 Colour-Difference Formula](https://www.cie.co.at/publications/colorimetry-part-6-ciede2000-colour-difference-formula-1).
- CIE, [International Lighting Vocabulary definition of luminance](https://www.cie.co.at/eilvterm/17-21-050).
- BIPM, [SI definition of the candela](https://www.bipm.org/en/si-base-units/candela).
- IEC, [IEC 61966-2-1:1999 — sRGB](https://webstore.iec.ch/en/publication/6169).
- ISO, [ISO 22028-2:2013 — ROMM RGB](https://www.iso.org/standard/56591.html), and ICC, [ROMM RGB registry entry](https://registry.color.org/rgb-registry/rommrgb).
- MacAdam, [“Visual Sensitivities to Color Differences in Daylight” (1942)](https://doi.org/10.1364/JOSA.32.000247).
- Wandell, [“Color Measurement and Discrimination” (1985)](https://doi.org/10.1364/JOSAA.2.000062).
- Derrington, Krauskopf, and Lennie, [“Chromatic Mechanisms in Lateral Geniculate Nucleus of Macaque” (1984)](https://doi.org/10.1113/jphysiol.1984.sp015499).
- Poirson and Wandell, [“Appearance of Colored Patterns: Pattern-Color Separability” (1993)](https://doi.org/10.1364/JOSAA.10.002458).
- Zhang and Wandell, [“A Spatial Extension of CIELAB for Digital Color-Image Reproduction” (1997)](https://doi.org/10.1889/1.1985127).
- Hurvich and Jameson, [“Some Quantitative Aspects of an Opponent-Colors Theory” (1956)](https://doi.org/10.1364/JOSA.46.000416).
