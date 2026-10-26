# FISE Student Projects: Lightfields and Optics

This document outlines software and computational simulation project suggestions for advanced undergraduates and early graduate students (master's level) taking Image Systems Engineering (Psych 221 / FISE). 

The projects are designed around the written chapters of **Part I: Scenes (Lightfields)** and **Part II: Optics** in *Foundations of Image Systems Engineering* (FISE). Each project utilizes the open-source software ecosystem developed for image systems simulation: **ISETCam**, **ISETBio**, and **ISET3d** (PBRT).

Examples of past student projects and detailed write-ups can be found on the [Psych 221 Project Wiki](https://fise.miraheze.org/wiki/Main_Page).

---

## What Makes an Exemplary FISE Project?

Based on the archive of successful projects since 1997, great projects exhibit five core traits:

1. **Clear Scientific or Engineering Hypothesis:** A targeted question exploring trade-offs or limits in an image system (e.g., *"How does slit pupil eccentricity trade off depth of field against directional diffraction in animal eyes?"*).
2. **Grounded in Textbook Principles:** Directly exercises the mathematical and physical foundations developed in FISE chapters (e.g., plenoptic sampling, Fraunhofer diffraction, ABCD matrices, wavefront aberrations, or linear spectral models).
3. **Rigorous Simulation Pipeline:** Builds a reproducible forward model:
   $$\text{Scene Radiance } L(\mathbf{r}, \boldsymbol{\omega}, \lambda) \xrightarrow{\text{Optics}} \text{Optical Image / Irradiance } E(\mathbf{r}, \lambda) \xrightarrow{\text{Sensor / Retina}} \text{Electrons / Cones} \xrightarrow{\text{Processing}} \text{Output / Metric}$$
4. **Parameter Sweeps and Analytical Validation:** Sweeps physical parameters across realistic ranges (e.g., aperture size, wavelength $\lambda \in [400, 700]\,\text{nm}$, field angle, object distance) and validates results against analytical limits (Airy disk radius $1.22 \lambda N$, paraxial cardinal points, or thin-lens conjugates).
5. **Tutorial-Style Reproducibility:** Produces clean, well-commented MATLAB LiveScripts or Python notebooks so that "the student taking the course next year" can learn from and build upon the work.

---

## Category 1: Lightfields & Scene Radiometry (Part I: Chapters 1–5)

### Project 1.1: Synthetic Lightfield Refocusing and Synthetic Apertures
* **Relevant Chapters:** [lightfields-01-intro.qmd](../lightfields-01-intro.qmd), [lightfields-02-measurement.qmd](../lightfields-02-measurement.qmd)
* **Software Tools:** ISET3d (rendering a multi-camera array in PBRT) and ISETCam (`oiRefocus`, lightfield toolboxes).
* **Core Principle:** The 4D light field $L(u, v, s, t)$ parameterizes rays by position $(u,v)$ on an entrance aperture and position $(s,t)$ on a sensor plane. An image focused at a virtual depth $z'$ is synthesized by shearing the ray coordinates and integrating over the aperture:
  $$E_{z'}(s,t) = \iint L\left(u, v, s + u\left(1 - \frac{z}{z'}\right), t + v\left(1 - \frac{z}{z'}\right)\right) du\,dv$$
* **Student Investigation:**
  1. Render a multi-depth 3D scene from a $5 \times 5$ or $9 \times 9$ camera array using ISET3d.
  2. Implement an interactive refocusing algorithm to sweep focal planes from near foreground to far background.
  3. Synthesize an **extended depth of field (EDOF)** image by selecting the sharpest sub-aperture patch across depth layers.
  4. Implement **synthetic aperture imaging** to computationally "see through" occlusions (e.g., foliage or a wire fence).
* **What Students Learn:** 4D plenoptic geometry, light field sampling density vs. depth resolution, and synthetic aperture reconstruction.

---

### Project 1.2: Dimensionality Reduction for Natural Illuminants & Reflectance Inversion
* **Relevant Chapters:** [lightfields-03-properties.qmd](../lightfields-03-properties.qmd), [lightfields-04-properties-spectral.qmd](../lightfields-04-properties-spectral.qmd)
* **Software Tools:** ISETCam (`sceneCreate`, `sceneAdjustIlluminant`, hyperspectral image databases).
* **Core Principle:** Natural daylight spectra and surface spectral reflectances occupy low-dimensional linear subspaces:
  $$E(\lambda) \approx \sum_{i=1}^M w_i E_i(\lambda), \qquad R(\lambda) \approx \sum_{j=1}^N \sigma_j R_j(\lambda)$$
  Using the CIE daylight basis functions (Judd et al.) or empirical SVD/PCA bases, scenes can be represented compactly.
* **Student Investigation:**
  1. Analyze a database of hyperspectral natural scenes and extract principal component bases for daylight illuminants and surface reflectances.
  2. Quantify reconstruction errors as a function of the number of basis functions ($M, N \in \{2, 3, 4, 5, 6\}$).
  3. Simulate capturing these scenes under changing diurnal illumination (dawn, midday D65, overcast, sunset) through an RGB camera sensor.
  4. Test bilinear inversion algorithms to evaluate how accurately surface reflectances can be recovered when illuminant spectra vary.
* **What Students Learn:** Spectral radiometry, PCA/SVD decomposition, bilinear color constancy models, and the limits of 3-channel trichromatic capture.

---

### Project 1.3: Spatial Statistics of Synthetic Scenes: The Dead Leaves Model vs. Lens MTF
* **Relevant Chapters:** [lightfields-05-properties-spatial.qmd](../lightfields-05-properties-spatial.qmd), [optics-07-linear-space.qmd](../optics-07-linear-space.qmd)
* **Software Tools:** MATLAB / Python and ISETCam (`sceneCreate`, `oiCreate`).
* **Core Principle:** Natural images exhibit scale-invariant spatial frequency spectra falling off as $1/f^\alpha$ with $\alpha \approx 2$. The **dead leaves model** (overlapping geometric discs with power-law radius distributions $p(r) \propto r^{-\gamma}$) reproduces these statistics naturally.
* **Student Investigation:**
  1. Build a synthetic dead leaves scene generator with tunable disc radius distributions and occlusion ordering.
  2. Compute 2D Fourier power spectra and radial averages to verify the $1/f^\alpha$ power-law exponent.
  3. Pass the synthetic scenes through simulated optical systems in ISETCam with varying f-numbers and aberrations.
  4. Measure how optical blur alters the power spectral slope across low, medium, and high spatial frequencies.
* **What Students Learn:** Spatial image statistics, scale invariance, fractal dimension, and optical low-pass filtering.

---

## Category 2: Geometric & Wave Optics, Diffraction, and Aberrations (Part II: Chapters 1–6)

### Project 2.1: The Pinhole-to-Lens Crossover: Geometric Blur vs. Fraunhofer Diffraction
* **Relevant Chapters:** [optics-01-geometric.qmd](../optics-01-geometric.qmd), [optics-02-wave.qmd](../optics-02-wave.qmd), [optics-03-diffraction-psf.qmd](../optics-03-diffraction-psf.qmd)
* **Software Tools:** ISETCam (`opticsCreate('pinhole')`, `opticsCreate('diffraction')`, `oiCompute`).
* **Core Principle:** In pinhole cameras, geometric ray projection blurs large apertures ($r_{\text{geom}} \propto d$), while Fraunhofer diffraction blurs small apertures ($r_{\text{diff}} \approx 1.22 \lambda s' / d$). The optimal pinhole diameter balances these two competing blurs:
  $$d_{\text{opt}} \approx \sqrt{2.44\,\lambda\,s'}$$
* **Student Investigation:**
  1. Simulate image formation across pinhole diameters ranging from $10\,\mu\text{m}$ to $5\,\text{mm}$ for several sensor distances ($s' \in [20, 200]\,\text{mm}$) and wavelengths ($\lambda \in [400, 700]\,\text{nm}$).
  2. Compute both geometric ray-traced PSFs and wave-diffraction PSFs to map the crossover curve.
  3. Compare the image MTF and spot size of the optimal pinhole against an ideal thin lens of the same aperture.
  4. Evaluate photographic capture of standard resolution targets (e.g., ISO 12233 / slanted edge) to quantify spatial resolution.
* **What Students Learn:** The boundary where geometric ray optics fails and wave diffraction dominates, Airy disk scaling, and optical limits on resolution.

---

### Project 2.2: Non-Circular Pupils: Diffraction & Depth of Field in the Animal Kingdom
* **Relevant Chapters:** [optics-03-diffraction-psf.qmd](../optics-03-diffraction-psf.qmd), [optics-05-thinlens.qmd](../optics-05-thinlens.qmd), [optics-07-linear-space.qmd](../optics-07-linear-space.qmd)
* **Software Tools:** ISETCam / ISETBio (`opticsSet(optics, 'pupil function', ...)`).
* **Core Principle:** Many animals feature non-circular pupils: domestic cats and foxes have vertical slit pupils; grazing prey (goats, horses) have horizontal slit pupils; geckos have multi-pinhole apertures. The 2D incoherent point spread function is the squared magnitude of the Fourier transform of the pupil function:
  $$\mathrm{PSF}(x,y) \propto \left| \mathcal{F}\{ P(u,v) \} \right|^2$$
* **Student Investigation:**
  1. Implement custom 2D aperture masks (vertical slit, horizontal slit, circular, annular) in ISETCam/ISETBio.
  2. Calculate and visualize the resulting 2D PSFs, OTFs, and MTFs across different orientations.
  3. Simulate through-focus blur for 3D scenes with foreground and background objects.
  4. Test the hypothesis: *Does a vertical slit pupil provide large depth of field for horizontal contours while preserving sharp stereoscopic binocular disparity along the vertical axis?*
* **What Students Learn:** 2D Fourier optics, directional diffraction, depth-of-field anisotropy, and evolutionary adaptations in physiological optics.

---

### Project 2.3: Multi-Component Thin Lenses, Stops, and Vignetting
* **Relevant Chapters:** [optics-04-lenses.qmd](../optics-04-lenses.qmd), [optics-05-thinlens.qmd](../optics-05-thinlens.qmd), [optics-06-morelenses.qmd](../optics-06-morelenses.qmd)
* **Software Tools:** MATLAB / ISETCam.
* **Core Principle:** When combining multiple lenses, the aperture stop limits the cone of light reaching on-axis points, while physical lens rims can clip oblique ray bundles, causing optical vignetting (a drop in off-axis irradiance following $\cos^4 \theta$ and mechanical clipping).
* **Student Investigation:**
  1. Build a multi-lens ray-tracing model with two or three thin lens elements and an adjustable physical aperture stop.
  2. Identify the entrance pupil (image of the stop through preceding elements) and exit pupil (image of the stop through following elements).
  3. Trace marginal and chief rays for on-axis and off-axis field heights.
  4. Measure and plot the relative illumination (vignetting curve) across the image plane, comparing pure $\cos^4\theta$ natural vignetting against mechanical pupil clipping.
* **What Students Learn:** Aperture stops, pupil conjugate planes, telecentricity, and off-axis radiometric falloff.

---

## Category 3: Advanced Lenses, Matrices, Wavefronts & Sensing (Part II: Chapters 6, 8, 9, 10)

### Project 3.1: Interactive ABCD Ray Matrix Workbench for Classic Multi-Element Lenses
* **Relevant Chapters:** [optics-06-morelenses.qmd](../optics-06-morelenses.qmd), [optics-08-linear-transform.qmd](../optics-08-linear-transform.qmd)
* **Software Tools:** MATLAB / ISETCam.
* **Core Principle:** In paraxial optics, refraction at a spherical surface and translation through homogeneous media are represented by $2 \times 2$ ABCD matrices:
  $$M_{\text{surface}} = \begin{pmatrix} 1 & 0 \\ \frac{n_1 - n_2}{R\,n_2} & \frac{n_1}{n_2} \end{pmatrix}, \qquad M_{\text{translate}} = \begin{pmatrix} 1 & d \\ 0 & 1 \end{pmatrix}$$
  The product of individual interface matrices yields the system matrix, from which effective focal length (EFL) and back focal length (BFL) are derived:
  $$f_E = -\frac{1}{C}, \qquad f_B = -\frac{A}{C}$$
* **Student Investigation:**
  1. Implement a modular ABCD engine that accepts lens surface curvatures $R_i$, glass thicknesses $d_i$, and wavelength-dependent refractive indices $n_i(\lambda)$ (Sellmeier / Cauchy equations).
  2. Encode historical lens designs: the **Petzval portrait lens**, the **Zeiss Tessar**, and the **Double Gauss**.
  3. Calculate the cardinal points (focal points $F_1, F_2$ and principal planes $P_1, P_2$) as well as pupil locations.
  4. Compare the paraxial ABCD ray paths against exact Snell's law trigonometric ray tracing across increasing aperture heights and field angles to identify where paraxial approximations break down.
* **What Students Learn:** Matrix optics, cardinal points, thick lens behavior, chromatic dispersion in multi-element designs, and limits of paraxial linear models.

---

### Project 3.2: Ray Transfer Functions (RTF): Neural Networks vs. Polynomials for Black-Box Lenses
* **Relevant Chapters:** [optics-06-morelenses.qmd](../optics-06-morelenses.qmd#sec-optics-raytransfer) (discussing Goossens et al., 2022)
* **Software Tools:** ISETCam / ISET3d / PyTorch or MATLAB Deep Learning Toolbox.
* **Core Principle:** Modern complex or proprietary lenses are often represented as black boxes using **Ray Transfer Functions (RTFs)** that map input ray coordinates $(x, y, \theta_x, \theta_y)_{\text{in}}$ at the entrance pupil to output ray coordinates $(x', y', \theta_x', \theta_y')_{\text{out}}$ at the exit pupil without disclosing internal geometry.
* **Student Investigation:**
  1. Generate a dataset of input-output ray pairs through a complex lens design (using Code V, Zemax, or ray tracing in ISET3d).
  2. Fit polynomial RTF models of degrees 3, 5, and 7 to approximate the ray mapping.
  3. Train a compact Multi-Layer Perceptron (MLP) neural network on the same data.
  4. Compare the polynomial model vs. the MLP in terms of ray interpolation accuracy, computational execution speed, memory footprint, and image rendering quality in a 3D scene.
* **What Students Learn:** Black-box optical digital twins, ray transfer function mathematics, and machine learning methods in computational optics.

---

### Project 3.3: Shack-Hartmann Wavefront Sensing and Adaptive Optics Simulation
* **Relevant Chapters:** [optics-09-wavefront.qmd](../optics-09-wavefront.qmd), [optics-10-wavefront-sensing.qmd](../optics-10-wavefront-sensing.qmd)
* **Software Tools:** ISETCam / ISETBio (`wfront2oxford`, `zernike`).
* **Core Principle:** A Shack-Hartmann sensor uses a microlens array to sample local wavefront slopes $\nabla W(\rho, \theta)$. The displacement $(\Delta x, \Delta y)$ of each focused spot is proportional to the average wavefront gradient over that sub-aperture:
  $$\Delta x = f_{\text{lenslet}} \frac{\partial W}{\partial x}, \qquad \Delta y = f_{\text{lenslet}} \frac{\partial W}{\partial y}$$
  The complete wavefront phase $W(x,y)$ is reconstructed by decomposing into Zernike polynomials.
* **Student Investigation:**
  1. Build a forward simulation of a Shack-Hartmann sensor array placed after an aberrated optical system.
  2. Introduce known Zernike wavefront aberrations (defocus $Z_2^0$, astigmatism $Z_2^{\pm 2}$, coma $Z_3^{\pm 1}$, and spherical aberration $Z_4^0$), as well as simulated atmospheric turbulence (Kolmogorov phase screens).
  3. Compute spot centroid displacements and implement modal wavefront reconstruction via least-squares Zernike fitting.
  4. Simulate an adaptive optics closed loop: apply a simulated deformable mirror phase correction, and calculate the PSF and MTF recovery before and after correction.
* **What Students Learn:** Wavefront optics, optical path difference (OPD), Zernike polynomials, Shack-Hartmann sensing, and adaptive optics correction loops.

---

### Project 3.4: Chromatic Aberration in the Eye and Camera: Degradation vs. Depth Cue
* **Relevant Chapters:** [optics-05-thinlens.qmd](../optics-05-thinlens.qmd), [optics-07-linear-space.qmd](../optics-07-linear-space.qmd), [optics-09-wavefront.qmd](../optics-09-wavefront.qmd), and [human-02-physiological-optics.qmd](../human-02-physiological-optics.qmd)
* **Software Tools:** ISETCam (`oiCreate('human')`, `oiCreate('diffraction')`, `oiCompute`).
* **Core Principle:** Because refractive index decreases with wavelength ($dn/d\lambda < 0$), lenses exhibit **longitudinal chromatic aberration (LCA)**, focusing short wavelengths (blue) closer to the lens than long wavelengths (red). In the human eye, LCA spans approximately 2 diopters between 400 nm and 700 nm.
* **Student Investigation:**
  1. Simulate wavelength-dependent PSFs across 31 spectral bands (400–700 nm) for an uncorrected lens and for human physiological optics.
  2. Capture multi-depth synthetic test scenes featuring fine spatial details and color edges.
  3. Quantify image degradation (color fringing and MTF reduction) across red, green, and blue sensor/cone channels.
  4. Implement a computational **depth-from-chromatic-aberration** algorithm that exploits the signed color fringe around blurred edges to estimate scene depth without stereo cameras.
* **What Students Learn:** Dispersion physics, chromatic PSF modeling, multi-spectral image formation, and computational imaging depth estimation.

---

## Suggested Assignment Roadmap & Milestones

For a 10-week academic quarter (e.g., Psych 221):

| Week | Milestone | Deliverable |
| :--- | :--- | :--- |
| **Week 3** | Topic Selection | 1-paragraph proposal identifying hypothesis, chapters, and tools. |
| **Week 5** | Midterm Progress | Forward model pipeline running with initial synthetic stimulus. |
| **Week 7** | Simulation & Sweeps | Parameter sweeps completed, preliminary figures and MTF/PSF curves generated. |
| **Week 9** | Oral Presentation | 10-minute presentation to the class with deep-dive technical feedback. |
| **Week 10** | Final Submission | Published wiki page write-up on Miraheze with archived code repository. |
