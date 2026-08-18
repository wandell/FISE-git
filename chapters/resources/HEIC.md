For your **Psych 221 (Image Systems Engineering)** lecture, the transition from JPEG to HEIC offers a great case study in how compression algorithms have evolved to better accommodate both the physics of image sensors and the requirements of the human visual system.

Here are a few technical tutorial papers and resources that would be ideal for building out your lecture slides and student reading list:

### 1. The HEIF Standard Technical Overview

* **Source:** *“The High Efficiency Image File Format (HEIF) Standard”* (ISO/IEC 23008-12).
* **Why it’s useful:** This is the authoritative technical paper for understanding HEIF as a **container**, not just a codec. It explains how the format encapsulates **HEVC (H.265)** intra-coded images.
* **Lecture Angle:** Perfect for discussing "image items" vs. "image sequences" and how metadata (like depth maps) is stored alongside the pixel data in the ISO Base Media File Format (ISOBMFF).
* **Link:** [HEIF Standard Technical Paper](https://datahacker.blog/files/85/A-V-Containers/125/HEIF-Standard-Technical-Paper-2015.pdf)

### 2. HEVC Intra-Prediction Mechanics

* **Source:** *“Overview of the High Efficiency Video Coding (HEVC) Standard”* by Sullivan et al. (IEEE Transactions on Circuits and Systems for Video Technology).
* **Why it’s useful:** This is the "gold standard" tutorial paper for the underlying compression engine of HEIC. It provides rigorous detail on **Coding Tree Units (CTUs)** and the **35 intra-prediction modes**.
* **Lecture Angle:** Use this to illustrate the move away from JPEG's fixed 8x8 blocks to the flexible quad-tree structure. You can show how larger blocks are used for low-frequency regions (sky) and smaller blocks for high-frequency details.

### 3. Comparison of HEIF vs. JPEG Architecture

* **Source:** *“A Tutorial on Image Compression for Optical Space Imaging Systems”* (UAB Digital Repository).
* **Why it’s useful:** While it has a remote sensing slant, it provides a very clear "principles-first" comparison of JPEG, JPEG2000, and more modern H.265-based methods.
* **Lecture Angle:** Great for a slide on **Rate-Distortion (RD) curves**. It provides data showing why HEIC achieves better visual quality at half the bitrate of JPEG—a core concept for Psych 221.

### 4. Implementation & Computational Photography

* **Source:** Apple’s WWDC Sessions (e.g., *"Working with HEIF and HEVC"*)
* **Why it’s useful:** These sessions explain the practical side of how Apple implemented HEIC to support **Live Photos** and **Depth Maps**.
* **Lecture Angle:** Since Psych 221 often touches on the entire imaging pipeline, this is useful for discussing how the sensor's raw data is converted and stored, and how depth information is used for post-processing effects like synthetic bokeh.

---

### Suggested Lecture Structure for Psych 221:

If you are organizing this for the "Image Processing and Compression" section of the course, I'd suggest this flow:

1. **The JPEG Legacy:** Review DCT and the limitations of the 8x8 block.
2. **Spatial Correlation:** Introduce HEVC's directional intra-prediction as a more advanced way to handle spatial redundancy.
3. **Adaptive Geometries:** Explain CTUs and quad-tree partitioning (fitting the "engineering" part of the course).
4. **Beyond Pixels:** Discuss HEIF as a container for 10-bit color, alpha channels, and depth maps (fitting the "vision science" part).

**Would you like me to find specific MATLAB code snippets or ISETCam examples that demonstrate these compression artifacts so you can include them in your class tutorials?**