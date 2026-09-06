# TODO: CCD to CMOS Transition Review & Narrative Plan

Context: In the preface (`index.qmd`), Willard Boyle and George Smith's 1970 invention of the Charge-Coupled Device (CCD) is introduced as the milestone that replaced chemical film with solid-state silicon. However, the pedagogical and technical transition from Boyle & Smith's CCD to modern CMOS active-pixel sensors (APS) currently feels disjointed across the sensor chapters. 

In `sensors-01-photoelectric.qmd`, circuit architecture (APS, PPS, foundries) is introduced prematurely before physics. In `sensors-02-pixels.qmd`, the two competing readout paradigms (charge-domain shifting vs. voltage-domain matrix readout) are only mentioned in passing, line 29 contains a physical inaccuracy regarding recombination, and the historic adoption of Nobukazu Teranishi's pinned photodiode (PPD) from CCD into CMOS (4T) is not given its full narrative significance.

This document outlines clear, step-by-step recommendations to build a coherent narrative across Part III.

---

## 1. High-Level Narrative Architecture

The narrative arc across the book should follow a clear 4-step conceptual progression:

```
1. Preface (index.qmd)
   Broad historical overview: Film -> Boyle & Smith (CCD) -> Fossum (CMOS APS) -> Smartphone explosion.

2. Part III Intro & Chapter 1 (part-sensors.qmd & sensors-01-photoelectric.qmd)
   The Core Physics (Universal to both CCD and CMOS):
   Light absorption in silicon, electron-hole generation, bandgap, quantum efficiency (QE),
   and Poisson photon/electron arrival statistics (shot noise). Silicon photodiodes do not care
   whether they are embedded in a CCD or CMOS chip.

3. Chapter 2 (sensors-02-pixels.qmd)
   The Readout Architecture & The Paradigm Shift:
   - Paradigm A: Boyle & Smith's Charge Transport ("The Bucket Brigade" - CCD).
     No in-pixel amplifiers; charge packets shifted to a single corner amplifier.
     Superb uniformity, but high voltage/power and no single-chip system integration.
   - Paradigm B: Addressable Voltage Matrix (CMOS).
     Why Passive Pixels (PPS) failed (bus capacitance).
     Fossum's Active Pixel Sensor (APS / 3T) breakthrough: local in-pixel buffer.
   - The Grand Synthesis (4T & Pinned Photodiode):
     CMOS borrows Nobukazu Teranishi's 1980 CCD invention (PPD) to enable complete
     charge transfer and Correlated Double Sampling (CDS), wiping out reset noise.

4. Chapter 7 (sensors-07-innovations.qmd)
   The Modern Counterpoint:
   Why CCD remains the instrument of choice for deep-sky astronomy (e.g., Vera C. Rubin LSSTCam):
   calibrating 3,024 dedicated high-precision channels is vastly more uniform than calibrating
   billions of CMOS in-pixel amplifiers.
```

---

## 2. Step-by-Step Recommendations by Chapter

### A. `chapters/part-sensors.qmd` (Part III Overview)

- [ ] **Frame the two fundamental challenges of electronic imaging:**
  Update the introductory text (around line 8) to state that converting an optical image into a digital image involves two distinct steps:
  1. *Photogeneration (Physics):* Converting incident photons into mobile electron charges inside silicon via the photoelectric effect (identical across CCD and CMOS).
  2. *Readout Architecture (Engineering):* Collecting and measuring those tiny charge packets across an array—tracing the journey from Boyle & Smith's charge-domain shifting (CCD) to modern voltage-domain active pixels (CMOS).

---

### B. `chapters/sensors-01-photoelectric.qmd` (Photons and Electrons)

- [ ] **Streamline the opening overview (lines 11–16):**
  - **Problem:** Lines 13–15 jump into Passive Pixel Sensors (PPS), Active Pixel Sensors (APS), microelectronics fabrication lines, and "camera-on-a-chip." The reader has not yet encountered a p-n junction, capacitance, or a transistor circuit, making this premature.
  - **Recommendation:** Keep `sensors-01` focused on the physics of light-matter interaction. Credit Boyle & Smith for showing that solid-state silicon could replace chemical film, note that all solid-state sensors share identical photodiode physics, and explicitly defer the circuit readout debate (CCD vs. CMOS) to `sensors-02`.
  - **Suggested draft for lines 11–16:**
    ```markdown
    The transition from film to digital imaging began when Willard Boyle and George Smith showed that light could be captured electronically within semiconductor silicon (@boyle1970-ccd-first; see Preface). Digital image sensors use arrays of tiny, light-sensitive semiconductor elements called **photodiodes** to convert incoming light into electrical charge.

    Whether an image sensor is an early charge-coupled device (CCD) or a modern complementary metal-oxide-semiconductor (CMOS) sensor, the fundamental physics of detection is the same: photons absorbed in silicon liberate mobile electrons. 

    In this chapter, we explore this physical conversion: how the photoelectric effect generates charge carriers in silicon, how efficiently photons are converted to electrons (quantum efficiency), and why the quantum nature of light introduces unavoidable statistical fluctuations (shot noise). In the next chapter (@sec-pixels), we examine the engineering architectures used to store, transfer, and measure these electrons.
    ```

---

### C. `chapters/sensors-02-pixels.qmd` (Pixels and Sensors)

This is the primary home for the transition. Several specific edits are needed:

- [ ] **Fix physical inaccuracy at Line 29:**
  - **Current text:**
    > *"Without special circuitry, the hole and electron will re-combine. To make an image sensor, we need a method to measure the number of electrons. In a CCD an electric field between the bands prevents recombination. In CMOS electrons are trapped in capacitors placed in the silicon. We explain this circuitry below."*
  - **Issue:** Both CCD and CMOS use an electric field in a reverse-biased depletion region (a potential well) to separate electrons and holes before they recombine. Both store electrons on capacitance.
  - **Replacement text:**
    > *"Without an electric field, the liberated electron and hole will quickly recombine. In both CCD and CMOS sensors, an internal electric field—created by a reverse-biased diode junction or a biased gate electrode—separates the charges and collects the electrons in a potential well. The defining difference between CCD and CMOS is not how electrons are created, but **how that collected charge is transferred and read out**."*

- [ ] **Add a dedicated subsection before or at Section 14.3 (`#sec-cmos-pixel-fsi`):**
  *Title suggestion:* `### Two Readout Paradigms: Charge Transfer vs. In-Pixel Amplification`
  - **Explain Boyle & Smith's CCD architecture ("The Bucket Brigade"):**
    - Explain that in a CCD, pixels have no internal amplifiers or switches.
    - Instead, the sensor acts as a giant analog shift register. Multi-phase clock voltages applied to gate electrodes march the charge packets across columns and rows, like a bucket brigade, until each packet reaches a single output charge-to-voltage amplifier at the corner.
    - *The CCD Strength:* Every pixel passes through the exact same output amplifier, providing extraordinary uniformity (near-zero fixed pattern noise) and high linearity.
    - *The CCD Bottleneck:* Physically moving charge across large silicon wafers requires high clocking voltages (10–15 V), consumes substantial dynamic power ($P \propto C V^2 f$), is relatively slow, and requires specialized manufacturing lines that cannot integrate digital logic, clock generators, or ADCs on the same chip.
  - **Explain the CMOS Matrix Readout ("Random-Access Memory"):**
    - Contrast this with CMOS, where the sensor operates like an addressable RAM chip (row decoders and column lines).
    - Briefly mention why early Passive Pixel Sensors (PPS) failed: dumping a small charge directly onto a long, high-capacitance column bus drowned the signal in noise.
    - Introduce Eric Fossum's Active Pixel Sensor (APS) concept: putting a buffer amplifier (source follower) *inside* each pixel to convert charge to voltage locally before driving the column line.

- [ ] **Enhance the 4T Pixel and Nobukazu Teranishi's Pinned Photodiode (Section 14.3.2, line 94):**
  - **The Narrative Hook:** When 3T CMOS sensors first appeared in the 1990s, CCD proponents called them noisy toys ("CCD dinosaurs vs. CMOS fleas"). 3T pixels suffered from high dark current and $kTC$ reset noise because reading the voltage required resetting the photodiode, leaving no uncorrupted reference state.
  - **The Resolution:** The breakthrough that allowed CMOS to match CCD image quality came from adopting a technology originally invented for CCDs! In 1980, **Nobukazu Teranishi** at NEC invented the **pinned photodiode (PPD)** for interline-transfer CCDs to eliminate image lag and dark current.
  - When the PPD and a transfer gate were integrated into the CMOS pixel (creating the **4T pixel**), charge could be fully transferred from the photodiode to an isolated floating diffusion node.
  - This enabled **true Correlated Double Sampling (CDS)**: the sensor reads the reset voltage *first*, transfers the charge, and reads the signal voltage *second*, subtracting the two. This completely cancelled $kTC$ reset noise and dramatically lowered dark current.
  - *Synthesis:* Modern CMOS sensors won because they combined the addressability and low power of CMOS with the low-noise charge-transfer physics of CCDs.

- [ ] **Harmonize Section 14.4 ("Multiplex readout", lines 107–109):**
  - Connect line 108 back to the "Two Readout Paradigms" section introduced above, reinforcing how column amplifiers and column-parallel ADCs replace the single output amplifier of the classic CCD.

---

### D. `chapters/sensors-07-innovations.qmd` (Sensor Innovations)

- [ ] **Connect the Vera Rubin / LSSTCam CCD section back to this foundational debate:**
  - In `sensors-07` (@sec-sensor-ccd), you describe why the Vera C. Rubin Observatory chose CCDs over CMOS for the 3.2-gigapixel LSSTCam.
  - Explicitly reference the concepts established in `sensors-02`: because CCDs channel thousands of pixels through a single output amplifier, the entire 3.2-gigapixel camera only has 3,024 readout channels to calibrate. In contrast, a 3.2-gigapixel CMOS array would have 3.2 billion separate in-pixel amplifiers, each with slightly different gain and offset drift—an astronomical calibration nightmare.
  - This provides a satisfying closure: CMOS won consumer and mobile imaging where low power and integration dominate, while CCD preserved its reign where absolute photometric calibration is paramount.

---

## 3. Summary of Files to Modify

| File | Status / Action Needed |
| :--- | :--- |
| [`TODO-CMOS.md`](file:///Users/wandell/Documents/FISE-git/TODO-CMOS.md) | **Created** (this planning tracker). |
| [`chapters/part-sensors.qmd`](file:///Users/wandell/Documents/FISE-git/chapters/part-sensors.qmd) | Add brief framing on Photogeneration (physics) vs. Readout (CCD to CMOS). |
| [`chapters/sensors-01-photoelectric.qmd`](file:///Users/wandell/Documents/FISE-git/chapters/sensors-01-photoelectric.qmd) | Streamline opening (lines 11–16); defer circuit architecture to `sensors-02`. |
| [`chapters/sensors-02-pixels.qmd`](file:///Users/wandell/Documents/FISE-git/chapters/sensors-02-pixels.qmd) | Correct line 29; add "Two Readout Paradigms" subsection; expand 4T / Teranishi PPD narrative. |
| [`chapters/sensors-07-innovations.qmd`](file:///Users/wandell/Documents/FISE-git/chapters/sensors-07-innovations.qmd) | Cross-link the Vera Rubin LSSTCam section back to `sensors-02` calibration concepts. |
