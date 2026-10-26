---
name: project
description: Guide the formulation, design, evaluation, and documentation of FISE student projects (Psych 221 / Image Systems Engineering). Use when developing project ideas, defining research questions, structuring simulations with ISETCam, ISETBio, or ISET3d, or writing up wiki project reports.
---

# FISE Project Guide & Rubric

## Purpose and Scope

Course projects in Foundations of Image Systems Engineering (FISE / Psych 221) enable advanced undergraduates and graduate students (master's and doctoral level) to explore a fundamental image systems topic in depth. Projects combine quantitative physical theory from the textbook with computational experiments, simulations, or empirical measurements, using tools such as ISETCam, ISETBio, and ISET3d.

Top-tier projects contribute back to the class wiki (https://fise.miraheze.org) and may be linked directly from or incorporated into chapters of the FISE textbook.

---

## Anatomy of a Successful FISE Project

Based on the archive of successful projects since 1997, great projects exhibit five core traits:

1. **Clear Scientific or Engineering Hypothesis:**
   - Instead of generic exploration, the project asks a focused question (e.g., *"How does slit pupil eccentricity trade off depth of field against directional diffraction in ambush vs. grazing animals?"* or *"Can a neural ray transfer function accurately substitute for high-order polynomial lens mappings in 3D scene rendering?"*).

2. **Grounded in Textbook Principles:**
   - Directly links to the physical and mathematical concepts developed in FISE:
     - **Lightfields/Scenes:** Radiometric units, 4D/7D plenoptic sampling, spectral regularities (PCA/daylight bases), natural scene spatial statistics ($1/f^\alpha$).
     - **Optics:** Snell's law, thin/thick lenses, ABCD ray matrices, Fraunhofer diffraction, wavefront aberrations $W(\rho,\theta)$, Zernike decomposition, PSFs, OTF/MTF, chromatic aberrations.
     - **Sensors:** Photoelectric conversion, pixel circuits, noise sources (photon shot noise, read noise), QE, dynamic range.
     - **Human Vision & Displays:** Physiological optics, cone mosaic sampling, color matching, perceptual metrics (S-CIELAB).

3. **Rigorous Simulation Pipeline:**
   - Implements a repeatable, end-to-end forward model:
     $$\text{Scene Radiance } L(\mathbf{r}, \boldsymbol{\omega}, \lambda) \xrightarrow{\text{Optics}} \text{Optical Image / Irradiance } E(\mathbf{r}, \lambda) \xrightarrow{\text{Sensor / Retina}} \text{Electrons / Cones} \xrightarrow{\text{Processing}} \text{Output / Metric}$$
   - Leverages established toolboxes:
     - **ISETCam:** Camera pipelines, spectral scenes, diffraction/aberrated optics, CMOS sensors, image processing.
     - **ISETBio:** Human eye models, wavefront optics, cone mosaics, photocurrent, spatial/color vision.
     - **ISET3d / PBRT:** Physically based 3D scene rendering, spectral ray tracing through multi-element lenses.

4. **Parameter Sweeps and Trade-off Analysis:**
   - Investigates system trade-offs across parameters (e.g., aperture size vs. diffraction vs. defocus, wavelength dependence 400–700 nm, noise vs. exposure time, pupil geometry).
   - Validates simulations against analytical limits (e.g., Airy disk radius $1.22 \lambda N$, paraxial thin-lens formula, diffraction cutoff $f_c = 1/(\lambda N)$).

5. **Reproducible Code and Tutorial-Style Reporting:**
   - Produces clean, commented MATLAB LiveScripts or Python code archived in a public repository.
   - Written for the "student taking the class next year" with intuitive figures, labeled axes, and clear captions.

---

## Project Archetypes

### Archetype 1: Physical Phenomenon Simulation & Validation
- **Goal:** Model a real-world optical or radiometric phenomenon that cannot be easily measured in a simple classroom lab.
- **Examples:** Diffraction through non-circular apertures; gradient-index (GRIN) lens eyes; underwater scattering and absorption; atmospheric turbulence and adaptive optics.
- **Workflow:** Derive the analytical model $\to$ simulate via wave optics or ray tracing $\to$ sweep geometric/spectral parameters $\to$ compare with published empirical literature.

### Archetype 2: Computational Optics & System Digital Twins
- **Goal:** Build an end-to-end digital twin of an optical device or lens system to test design alternatives.
- **Examples:** Multi-element ABCD lens explorer; Ray Transfer Function (RTF) neural network modeling; Shack-Hartmann wavefront reconstruction; plenoptic camera refocusing.
- **Workflow:** Define component matrices/surfaces $\to$ trace ray bundles $\to$ calculate PSF/MTF $\to$ simulate sensor capture on synthetic targets $\to$ quantify image restoration.

### Archetype 3: Multi-spectral & Radiometric Analysis
- **Goal:** Exploit spectral and spatial regularities in natural scenes to solve an underdetermined imaging problem.
- **Examples:** Daylight illuminant estimation from 3-channel sensors; tissue fluorescence vs. blood absorption; recovery of reflectance spectra using linear basis models.
- **Workflow:** Hyperspectral scene database $\to$ illuminant manipulation $\to$ multi-spectral or RGB sensor simulation $\to$ linear/Bayesian inversion $\to$ error metric analysis.

---

## Project Write-up Structure (Wiki Rubric)

Student reports on the FISE Wiki should follow this standardized structure:

1. **Title and Authors:** Clear descriptive title and group members.
2. **Introduction:** Real-world motivation, practical problem, and executive summary of findings.
3. **Background & Theory:** Literature review, key equations from FISE, and theoretical expectations.
4. **Methods & Simulation Architecture:**
   - System diagram / flowchart.
   - Software packages used (ISETCam, ISETBio, ISET3d, MATLAB, Python).
   - Simulation parameters (focal length, f-number, pixel pitch, spectral sampling, noise settings).
5. **Results & Discussion:**
   - Logically organized graphs and image comparisons.
   - Every graph must have labeled axes with units (e.g., $\text{cycles/mm}$, $\mu\text{m}$, $\text{nm}$).
   - Captions highlighting the key takeaway of each figure.
   - Discussion of where the simulation matches or deviates from theory.
6. **Conclusions & Future Work:** What worked, what failed, why, and recommendations for next year's students.
7. **References:** Formal citations with hyperlinks.
8. **Appendix:** Link to well-commented source code, test scripts, and data tables.

---

## Project Catalogs by Book Section

Detailed project briefs organized by chapter are maintained in:
- **Lightfields and Optics:** [optics.md](file:///Users/wandell/Documents/FISE-git/chapters/projects/optics.md)
- **Image Sensors:** [sensors.md](file:///Users/wandell/Documents/FISE-git/chapters/projects/sensors.md)

