# FISE Student Projects: Image Sensors

This document outlines software and computational simulation project suggestions for advanced undergraduates and early graduate students (master's level) taking Image Systems Engineering (Psych 221 / FISE).

The projects are designed around the written chapters of **Part III: Sensors** in *Foundations of Image Systems Engineering* (FISE). Each project utilizes the open-source software ecosystem developed for image systems simulation: **ISETCam** (with the `sensor` and `pixel` architecture), **ISETBio**, and **ISET3d**.

Examples of past student projects and detailed write-ups can be found on the [Psych 221 Project Wiki](https://fise.miraheze.org/wiki/Main_Page).

---

## What Makes an Exemplary FISE Sensor Project?

Based on the archive of successful projects since 1997, great sensor projects exhibit five core traits:

1. **Clear Scientific or Engineering Hypothesis:** A targeted question exploring physical or circuit trade-offs (e.g., *"Does an RGBW color filter array yield higher SNR in low light after demosaicing than a Bayer CFA at equivalent sensor area?"* or *"How does Dual Conversion Gain compare to staggered multi-exposure HDR in preserving motion fidelity for autonomous driving?"*).
2. **Grounded in Physical Stages of Detection:** Directly models the distinct transformations in solid-state imaging:
   $$\text{Photons } N_p \xrightarrow{\text{QE}(\lambda)} \text{Photoelectrons } N_e \xrightarrow{\text{Poisson}} \text{Collected Charge} \xrightarrow{\text{Conversion Gain } g_c} \text{Voltage } V \xrightarrow{\text{ADC}} \text{Digital Numbers (DN)}$$
3. **Distinction Among Noise Sources:** Does not lump noise into a generic "noise" term; explicitly decomposes and measures:
   - **Photon shot noise:** $\sigma_{\text{shot}} = \sqrt{\mu_e}$ (fundamental quantum fluctuation).
   - **Dark current shot noise:** $\sigma_{\text{dark}} = \sqrt{I_{\text{dark}} t_{\text{exp}} / q}$.
   - **Read noise:** $\sigma_{\text{read}}$ (thermal kTC reset noise, source follower $1/f$ and RTS noise, ADC noise) in $\text{e}^-\,\text{rms}$.
   - **Fixed-pattern noise (FPN):** Dark signal non-uniformity (DSNU) and photo-response non-uniformity (PRNU).
   - **Quantization noise:** $\sigma_{\text{quant}} = \frac{1}{\sqrt{12}} q_{\text{ADC}}$.
4. **Validation Against Industry Standards:** Validates simulated sensors against standard measurement protocols, notably **EMVA 1288** and **ISO 12233** (slanted-edge spatial frequency response).
5. **Tutorial-Style Reproducibility:** Produces clean, well-commented MATLAB LiveScripts or Python notebooks enabling next year's students to repeat and extend the experiments.

---

## Category 1: Photons, Noise Limits & Parameter Characterization (Chapters 1, 3, 6)

### Project 1.1: Automated EMVA 1288 Photon Transfer Curve (PTC) & Noise Engine
* **Relevant Chapters:** [sensors-01-photoelectric.qmd](../sensors-01-photoelectric.qmd), [sensors-03-parameters.qmd](../sensors-03-parameters.qmd), [sensors-06-characterization.qmd](../sensors-06-characterization.qmd)
* **Software Tools:** ISETCam (`sensorCreate`, `sensorSet`, `sensorCompute`, `sensorGet`).
* **Core Principle:** The European Machine Vision Association (EMVA) 1288 standard defines a rigorous protocol for extracting fundamental sensor parameters from flat-field images captured across an exposure sweep:
  - Conversion gain $K$ (in $\text{DN}/\text{e}^-$) from the slope of $\sigma_{\text{DN}}^2$ vs. $\mu_{\text{DN}}$ in the shot-noise regime.
  - Read noise $\sigma_{\text{read}}$ (in $\text{e}^-\,\text{rms}$) from the zero-illumination intercept.
  - Full-well capacity $N_{\text{FWC}}$ from the saturation plateau.
  - Dynamic range $\text{DR} = 20 \log_{10}(N_{\text{FWC}} / \sigma_{\text{read}})$.
* **Student Investigation:**
  1. Build an automated EMVA 1288 test bench in MATLAB or Python using ISETCam.
  2. Simulate flat-field captures across 50 exposure levels from total darkness to saturation.
  3. Plot the **Photon Transfer Curve** on log-log axes, identifying read noise floor, Poisson shot-noise slope ($0.5$), and FWC clipping.
  4. Decompose temporal noise vs. spatial FPN (DSNU and PRNU) using two-frame difference analysis:
     $$\sigma_{\text{temporal}}^2 = \frac{1}{2} \operatorname{Var}(I_1 - I_2)$$
  5. Test how robust the automated estimation is when noise parameters or non-linear saturation knee curves are introduced.
* **What Students Learn:** EMVA 1288 characterization standards, photon transfer curves, variance analysis, and industrial sensor specification sheets.

---

### Project 1.2: Pixel Scaling Limits: Small Pixels vs. Large Pixels Under Shot-Noise and Diffraction Limits
* **Relevant Chapters:** [sensors-01-photoelectric.qmd](../sensors-01-photoelectric.qmd), [sensors-03-parameters.qmd](../sensors-03-parameters.qmd), [optics-03-diffraction-psf.qmd](../optics-03-diffraction-psf.qmd)
* **Software Tools:** ISETCam (`pixelSet`, `sensorSet`, `oiCompute`).
* **Core Principle:** Mobile sensors have shrunk pixel pitch from $3\,\mu\text{m}$ down to $0.6\,\mu\text{m}$. Smaller pixels increase spatial sampling but collect fewer photons per pixel ($N_p \propto \text{pixel area}$), reducing SNR and full-well capacity:
  $$\text{SNR}_{\text{shot}} = \sqrt{N_e} = \sqrt{E \cdot A_{\text{pixel}} \cdot t_{\text{exp}} \cdot \text{QE}}$$
  Furthermore, when pixel pitch approaches the wavelength of light ($\sim 0.5\,\mu\text{m}$), optical diffraction blurs light across adjacent pixels.
* **Student Investigation:**
  1. Simulate sensors with pixel pitches of $0.7\,\mu\text{m}$, $1.4\,\mu\text{m}$, $2.8\,\mu\text{m}$, and $5.6\,\mu\text{m}$ on identical total optical formats (e.g., $1/2"$).
  2. Couple the sensors to realistic optics ($f/1.8$ and $f/4.0$).
  3. Sweep scene illuminance from dim indoor lighting ($1\,\text{lux}$) to bright daylight ($10,000\,\text{lux}$).
  4. Evaluate trade-offs: measure effective spatial resolution (using ISO 12233 slanted edge) vs. low-light SNR.
  5. Test whether binning four $0.7\,\mu\text{m}$ pixels digitally matches the low-light SNR of a native $1.4\,\mu\text{m}$ pixel (accounting for read noise per readout).
* **What Students Learn:** The fundamental trade-off between spatial resolution and photon sensitivity, read noise accumulation in pixel binning, and diffraction-limited sampling.

---

### Project 1.3: Low-Light Photon Starvation: Quanta Image Sensors (SPAD / 1-bit QIS) vs. Sub-Electron CMOS
* **Relevant Chapters:** [sensors-01-photoelectric.qmd](../sensors-01-photoelectric.qmd), [sensors-07-innovations.qmd](../sensors-07-innovations.qmd)
* **Software Tools:** MATLAB / Python with ISETCam.
* **Core Principle:** Single-Photon Avalanche Diodes (SPADs) and Quanta Image Sensors (QIS, Fossum et al.) operate as photon-counting sensors. In 1-bit QIS, specialized sub-micron pixels called *jots* detect whether zero or $\ge 1$ photon arrived during an exposure, eliminating analog read noise entirely. The bit value follows binary Poisson statistics:
  $$P(\text{bit} = 0) = e^{-\mu}, \qquad P(\text{bit} = 1) = 1 - e^{-\mu}$$
* **Student Investigation:**
  1. Implement a 1-bit QIS forward simulator where a mega-jot array ($>10$ million binary pixels) oversamples the scene spatially and temporally.
  2. Implement local kernel reconstruction to estimate continuous scene flux from binary bit streams.
  3. Compare QIS reconstructions against a conventional CMOS sensor with low read noise ($\sigma_{\text{read}} \in [0.5, 2.0]\,\text{e}^-\,\text{rms}$) at low photon counts ($0.1$ to $5$ photons/pixel).
  4. Quantify the dynamic range extension and low-light SNR advantages of photon-counting sensors under extreme photon starvation.
* **What Students Learn:** Single-photon statistics, non-linear Poisson flux estimation, binary oversampling, and next-generation quantum image sensors.

---

## Category 2: Sensor Components & Filter Arrays (Chapter 4)

### Project 2.1: Color Filter Array (CFA) Design: Bayer vs. RGBW vs. Quad-Bayer (Tetracell/Nonacell)
* **Relevant Chapters:** [sensors-04-components.qmd](../sensors-04-components.qmd), [sensors-07-innovations.qmd](../sensors-07-innovations.qmd)
* **Software Tools:** ISETCam (`sensorCreate`, `sensorSet(..., 'cfa pattern', ...)`, demosaicing pipeline).
* **Core Principle:** The standard Bayer pattern (RGGB) filters out approximately $65\%$ of incident visible photons at each pixel. Alternative patterns incorporate clear/white pixels (**RGBW**) to boost photon capture by $2\times$ to $3\times$, or cluster identical filters across $2\times2$ (Tetracell) or $3\times3$ (Nonacell) blocks to enable on-chip charge binning in low light and remosaicing in bright light.
* **Student Investigation:**
  1. Define custom CFA patterns in ISETCam: Standard Bayer (RGGB), RGBW (Kodak or Sony pattern), and Quad-Bayer ($2\times2$ color blocks).
  2. Simulate image capture of multi-spectral test charts (Macbeth ColorChecker, ISO 12233) across bright and low-light conditions.
  3. Implement or adapt demosaicing algorithms tailored to each CFA geometry.
  4. Quantify the trade-offs: measure color reconstruction accuracy ($\Delta E_{00}$), low-light SNR, and spatial resolution (resolvable line pairs/mm before aliasing artifacts).
* **What Students Learn:** Color filter spectral transmittance, photon budgeting, demosaicing artifacts (zippering, false color), and high-sensitivity CFA design.

---

### Project 2.2: Multi-Spectral Filter Arrays (MSFA) for In-Vivo Reflectance Recovery
* **Relevant Chapters:** [sensors-04-components.qmd](../sensors-04-components.qmd), [sensors-07-innovations.qmd](../sensors-07-innovations.qmd), [lightfields-04-properties-spectral.qmd](../lightfields-04-properties-spectral.qmd)
* **Software Tools:** ISETCam (`sensorCreate`, custom multi-band filters).
* **Core Principle:** Multi-Spectral Filter Arrays (e.g., IMEC or Spectricity sensors with $4\times4=16$ spectral bands in the visible and NIR) integrate Fabry-Pérot optical cavity filters directly on top of CMOS pixels. This allows single-shot multispectral capture without bulky filter wheels.
* **Student Investigation:**
  1. Model an $8$-band or $16$-band snapshot MSFA in ISETCam with narrow-band filter transmittances centered across 400–900 nm.
  2. Simulate captures of human skin, oral mucosa (tying into medical imaging research), or vegetation under ambient lighting.
  3. Formulate a Wiener estimation or Tikhonov-regularized inversion to recover full $31$-channel spectral reflectance from the sampled MSFA channels.
  4. Compare spatial resolution loss against spectral recovery precision, and test how sensor read noise impacts the spectral reconstruction.
* **What Students Learn:** Multi-spectral imaging, snapshot spectral demosaicing, matrix inversion for spectral reflectance estimation, and biomedical camera design.

---

### Project 2.3: Microlens Acceptance Angle & Chief Ray Angle (CRA) Mismatch Simulation
* **Relevant Chapters:** [sensors-04-components.qmd](../sensors-04-components.qmd), [optics-06-morelenses.qmd](../optics-06-morelenses.qmd)
* **Software Tools:** ISETCam and ray optics modeling.
* **Core Principle:** On-chip microlenses focus incoming light onto the photodiode active area, increasing the effective fill factor from $\sim 40\%$ to $>80\%$. However, at the edges of the sensor, rays arrive at an oblique angle—the **Chief Ray Angle (CRA)**. If the lens CRA does not match the microlens shift, light misses the photodiode or bleeds into neighboring pixels, producing optical crosstalk and severe edge shading (color shading).
* **Student Investigation:**
  1. Model the ray cone arriving at pixels from the optical exit pupil as a function of field height (on-axis $0^\circ$ up to $35^\circ$ off-axis).
  2. Simulate the efficiency of light collection for straight vs. shifted microlenses.
  3. Measure the resulting optical crosstalk (spectral contamination when blue light enters an adjacent red photodiode) and spatial luminance falloff.
  4. Implement an adaptive lens-shading correction (LSC) calibration algorithm to correct spatial and color nonuniformity.
* **What Students Learn:** Microlens optics, chief ray angles, pixel crosstalk, color shading, and hardware-software compensation.

---

## Category 3: Sensor Control, Timing & Dynamics (Chapter 5)

### Project 3.1: Rolling Shutter vs. Global Shutter: Motion Artifacts & Computational Rectification
* **Relevant Chapters:** [sensors-05-control.qmd](../sensors-05-control.qmd)
* **Software Tools:** MATLAB / Python and ISETCam (`sensorCompute`).
* **Core Principle:** Most CMOS sensors utilize a **rolling shutter**, exposing and reading out rows sequentially from top to bottom with a line readout delay $\Delta t_{\text{row}}$. When fast-moving objects (e.g., a rotating propeller, a speeding car, or rapid camera panning) are captured, different rows capture the object at different instants in time, inducing geometric distortions ("jello effect", skew, and curvature). **Global shutter** sensors freeze the entire scene simultaneously using in-pixel memory nodes, but incur higher circuit noise and lower fill factor.
* **Student Investigation:**
  1. Build a time-dependent forward scene simulator that models dynamic objects (rotating blades, horizontally moving cars) sampled by a rolling shutter raster.
  2. Quantify skew, elongation, and wobble as a function of line readout speed ($\Delta t_{\text{row}} \in [5, 30]\,\mu\text{s}$) and frame rate.
  3. Compare rolling shutter captures against a global shutter model with equivalent total exposure.
  4. Implement an optical-flow or spline-based computational rolling shutter rectification algorithm to restore accurate geometry.
* **What Students Learn:** Sensor timing and readout architectures, temporal sampling artifacts, 4T vs 5T pixel structures, and computational motion dewarping.

---

### Project 3.2: Dual-Pixel Autofocus (DPAF) & Phase-Detection Autofocus (PDAF) Simulation
* **Relevant Chapters:** [sensors-05-control.qmd](../sensors-05-control.qmd), [optics-05-thinlens.qmd](../optics-05-thinlens.qmd)
* **Software Tools:** ISETCam / ISETBio (`sensorCreate`, split-pixel optics).
* **Core Principle:** In Dual-Pixel CMOS AF (Canon) and masked PDAF (Sony), each microlens covers two half-photodiodes (left and right sub-pixels). Rays passing through the left half of the lens exit pupil are collected by the right sub-pixel, and vice versa. When an object is in focus, the left and right sub-pixel images align; when defocused, they exhibit a relative spatial phase shift $\Delta x$ proportional to the defocus distance $\Delta z$:
  $$\Delta x = \frac{\Delta z}{2 N}$$
* **Student Investigation:**
  1. Simulate a dual-pixel sensor in ISETCam by modeling sub-aperture pupil splitting for left and right sub-pixels.
  2. Render a 3D scene containing objects at multiple depth planes.
  3. Compute the cross-correlation of left and right sub-images to measure the phase disparity across image patches.
  4. Implement a closed-loop autofocus control algorithm that computes the required lens displacement from a single exposure without iterative focus hunting.
* **What Students Learn:** Phase-detection autofocus physics, pupil split geometry, cross-correlation disparity estimation, and closed-loop camera control systems.

---

### Project 3.3: Auto-Exposure (AE) and ISO Gain: Shot Noise Multiplication vs. Read Noise Dominance
* **Relevant Chapters:** [sensors-03-parameters.qmd](../sensors-03-parameters.qmd), [sensors-05-control.qmd](../sensors-05-control.qmd)
* **Software Tools:** ISETCam (`sensorSet(..., 'exposure time', ...)`, `sensorSet(..., 'gain', ...)`).
* **Core Principle:** A common misconception is that "higher ISO collects more light." In reality, increasing ISO increases analog or digital gain applied to the collected charge, leaving photon collection unchanged while amplifying read noise and reducing dynamic range:
  $$\text{DN} = \operatorname{quant}\left( K \cdot g_{\text{analog}} \cdot (N_e + N_{\text{dark}}) + \text{noise}_{\text{read}} \right)$$
* **Student Investigation:**
  1. Capture a high-contrast indoor/outdoor scene in ISETCam across two capture strategies delivering identical average digital brightness:
     - Strategy A: Long exposure $t_{\text{exp}}$, low analog gain (native ISO).
     - Strategy B: Short exposure $t_{\text{exp}} / 16$, high analog/digital gain ($16\times$ ISO).
  2. Measure SNR across shadow, midtone, and highlight regions for both strategies.
  3. Map the loss of dynamic range as ISO increases (each doubling of ISO reduces headroom by 1 stop / $6\,\text{dB}$).
  4. Implement an automatic exposure control (AEC) algorithm (spot metering, center-weighted, and matrix metering) that optimizes exposure time and gain to maximize sensor dynamic range without clipping highlights.
* **What Students Learn:** The physics of ISO gain, conversion gain vs. analog gain, dynamic range degradation, and auto-exposure optimization algorithms.

---

## Category 4: High Dynamic Range & Emerging Sensor Innovations (Chapter 7)

### Project 4.1: High Dynamic Range (HDR) Architectures: Dual Conversion Gain (DCG) vs. Split-Pixel vs. Multi-Exposure
* **Relevant Chapters:** [sensors-03-parameters.qmd](../sensors-03-parameters.qmd), [sensors-07-innovations.qmd](../sensors-07-innovations.qmd)
* **Software Tools:** ISETCam (`sensorCreate`, multi-exposure pipelines).
* **Core Principle:** Natural scenes frequently span dynamic ranges $>120\,\text{dB}$ (e.g., emerging from a dark tunnel into bright sunlight in autonomous driving), far exceeding the $60\text{--}72\,\text{dB}$ range of a standard CMOS sensor. Modern sensors employ three distinct hardware strategies:
  1. **Dual Conversion Gain (DCG):** Switches floating diffusion capacitance ($C_{\text{FD}}$) to provide low read noise in shadows and high full-well capacity in highlights.
  2. **Split-Pixel (Sub-pixel L-pixel / S-pixel):** Each pixel contains a large sensitive photodiode and a small attenuated photodiode read out simultaneously.
  3. **Staggered Multi-Exposure HDR:** Captures interleaved short, medium, and long exposures in rapid succession.
* **Student Investigation:**
  1. Build forward simulation models in ISETCam for each of the three HDR architectures.
  2. Simulate captures of challenging automotive test scenes (e.g., night-time driving with oncoming headlights, or tunnel exits).
  3. Introduce moving objects and quantify motion artifacts (ghosting and edge chromatic fringe in multi-exposure vs. artifact-free single-exposure split-pixel).
  4. Measure the SNR drop at the handover points (the "SNR dip" where the signal transitions from high gain to low gain, or from L-pixel to S-pixel).
  5. Implement an HDR reconstruction and tone mapping algorithm to synthesize a single $16$-bit radiance map.
* **What Students Learn:** HDR sensor hardware architectures, dual conversion gain, SNR handover transitions, tone mapping, and automotive vision safety trade-offs.

---

### Project 4.2: Neuromorphic Event-Based Sensor (DVS) Simulator for High-Speed Dynamics
* **Relevant Chapters:** [sensors-05-control.qmd](../sensors-05-control.qmd), [sensors-07-innovations.qmd](../sensors-07-innovations.qmd)
* **Software Tools:** MATLAB / Python and ISETCam (time-series optical images).
* **Core Principle:** Dynamic Vision Sensors (DVS / event cameras) abandon synchronous frame-based clocking. Each autonomous pixel responds asynchronously to logarithmic changes in intensity:
  $$\Delta \ln(I) = \ln(I(t)) - \ln(I(t - \Delta t)) \ge \pm C_{\text{threshold}}$$
  Generating a stream of microsecond-timestamped events $(x, y, t, p)$ with $p \in \{+1, -1\}$, event cameras achieve $>120\,\text{dB}$ dynamic range and sub-millisecond temporal resolution with minimal data bandwidth.
* **Student Investigation:**
  1. Build an event-camera simulator that takes a continuous time-series of high-framerate images (or a moving 3D scene from ISET3d) and generates asynchronous event streams.
  2. Incorporate realistic non-idealities: temporal jitter, contrast threshold variation (mismatch across pixels), and background activity noise events.
  3. Test the simulator on high-speed motion tracking and high-dynamic-range scenes where conventional cameras suffer motion blur or saturation.
  4. Implement an event-accumulation or corner-tracking algorithm to demonstrate visual odometry under extreme lighting transitions.
* **What Students Learn:** Neuromorphic computing, asynchronous pixel circuitry, logarithmic photoreceptors, and event-based computer vision.

---

### Project 4.3: Stacked Photodiodes & Vertical Color Separation (Foveon-Style) Without Demosaicing
* **Relevant Chapters:** [sensors-01-photoelectric.qmd](../sensors-01-photoelectric.qmd), [sensors-04-components.qmd](../sensors-04-components.qmd), [sensors-07-innovations.qmd](../sensors-07-innovations.qmd)
* **Software Tools:** ISETCam (silicon absorption depth modeling, multi-junction sensor).
* **Core Principle:** In silicon, the optical absorption coefficient $\alpha(\lambda)$ varies dramatically with wavelength: blue light ($450\,\text{nm}$) is absorbed within the top $0.2\,\mu\text{m}$, green light ($530\,\text{nm}$) penetrates to $\sim 1.5\,\mu\text{m}$, and red light ($650\,\text{nm}$) penetrates to $>3\,\mu\text{m}$. By stacking three vertically integrated p-n junctions at different depths within each pixel (Foveon X3 architecture), every pixel captures red, green, and blue simultaneously without a spatial color filter array.
* **Student Investigation:**
  1. Calculate the spectral responsivity $S_i(\lambda)$ of the three vertical junctions using silicon's wavelength-dependent absorption depth:
     $$P(\text{absorbed in depth } [z_1, z_2]) = e^{-\alpha(\lambda) z_1} - e^{-\alpha(\lambda) z_2}$$
  2. Implement the color transformation matrix that un-mixes the broadband, overlapping spectral responses into standardized sRGB coordinates.
  3. Simulate capture of high-frequency spatial patterns (e.g., zone plates, fabrics) and compare against a standard Bayer sensor.
  4. Evaluate trade-offs: verify the complete elimination of color moiré and demosaicing artifacts against the noise penalty introduced by un-mixing overlapping spectral channels.
* **What Students Learn:** Silicon semiconductor physics, wavelength-dependent absorption depth, multi-junction pixel design, and color matrix un-mixing noise propagation.

---

## Suggested Assignment Roadmap & Milestones

For a 10-week academic quarter (e.g., Psych 221):

| Week | Milestone | Deliverable |
| :--- | :--- | :--- |
| **Week 3** | Topic Selection | 1-paragraph proposal identifying hypothesis, chapters, and tools. |
| **Week 5** | Midterm Progress | Sensor model initialized in ISETCam with verified noise parameters. |
| **Week 7** | Simulation & Sweeps | Parameter sweeps completed, Photon Transfer Curves or MTF/SNR plots generated. |
| **Week 9** | Oral Presentation | 10-minute presentation to the class with deep-dive technical feedback. |
| **Week 10** | Final Submission | Published wiki page write-up on Miraheze with archived code repository. |
