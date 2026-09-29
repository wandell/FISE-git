---
name: glossary-references
description: Standard conventions for referencing glossary terms and inserting sidebar margin definitions across the FISE manuscript. Use when introducing new technical terms, linking to glossary resources, or refining terminology in chapter text.
---

# Glossary References & Sidebar Annotations Standard

## Purpose

Students and readers frequently encounter technical terms in image systems that sound deceptively similar or rely on strict coordinate/sign conventions (e.g., *focal length* vs. *image distance*, *radius of curvature* vs. *curvature*, *well capacity* vs. *fill factor*). 

Rather than interrupting the narrative flow with inline parentheticals like `(See the Optics Glossary...)` or forcing the reader to leave the chapter to look up a word, FISE uses **lightweight sidebar margin notes** alongside the text. These margin notes give an immediate 1–2 sentence definition right where the term arises, followed by a direct link to the comprehensive glossary entry.

---

## 1. Minimalist Format Specification

Every glossary sidebar reference uses Quarto's native `{.column-margin}` container:

```markdown
::: {.column-margin}
**<Term Name> ($<Symbol>$ hold if applicable)**  
<One to two concise sentences defining the concept, its physical meaning, and standard units or sign convention>.  
[<Domain> Glossary &rarr;](resources/<domain>-glossary.qmd#<section-anchor>)
:::
```

### Exact Concrete Example
From [optics-05-thinlens.qmd](file:///Users/wandell/Documents/FISE-2025-Quarto/chapters/optics-05-thinlens.qmd#L26-L30):

```markdown
A lens is considered a **thin lens** when its axial thickness is negligible compared to the radii of curvature of its surfaces. The *radius of curvature* is the radius of a sphere whose surface matches the curvature of the lens surface.  A lens with two convex surfaces (biconvex) will have two such radii, one for each of its surfaces.

::: {.column-margin}
**Radius of curvature ($R$)**  
Linear distance from the surface vertex to the center of the sphere of curvature.  
[Optics Glossary &rarr;](resources/optics-glossary.qmd#sec-glossary-surfaces)
:::
```

---

## 2. Formatting & Typography Rules

1. **Title Line:**
   - Bold term name: `**Term Name**` or `**Term Name ($Symbol$)**`.
   - End line with **two spaces** to force a clean line break in markdown.
2. **Definition Body:**
   - 1–2 sentences maximum.
   - Plain, clear language highlighting the core physical concept, sign convention, or units.
   - End line with **two spaces**.
3. **Glossary Link:**
   - Label format: `[<Domain> Glossary &rarr;](<relative-path>#<anchor>)`
   - Use the HTML entity `&rarr;` for the right arrow.
   - Link directly to the specific subsection anchor (`#sec-glossary-*`) in the glossary resource.

---

## 3. Placement & Usage Guidelines

- **Place on First Significant Appearance:** Add the margin note where the term is first defined or mathematically deployed in a chapter.
- **Do Not Clutter:** Do not place margin notes for every casual mention of a term. Reserve them for foundational concepts, points of frequent student confusion, or key formulas.
- **Clean the Body Text:** Remove disruptive inline parentheticals like `(See the [Optics Glossary](...) for a discussion...)` from the body paragraph when a margin note is present. The margin note serves this exact purpose cleanly.
- **Immediate Placement:** Place the `::: {.column-margin}` block immediately after the paragraph where the term is introduced. Quarto will vertically align the margin note with that paragraph in the right sidebar.

---

## 4. Glossary Resources & Target Files

When linking, use relative paths from `chapters/`:

| Domain | Resource File Path (relative to `chapters/`) | Primary Topics Covered |
|:-------|:---------------------------------------------|:-----------------------|
| **Optics** | `resources/optics-glossary.qmd` | Surface geometry ($R, C$), focal length ($f$), conjugate image distance ($d_i$), sensor distance ($d_s$), circle of confusion |
| **Sensors** | `resources/sensors-glossary.qmd` | Pixel pitch, fill factor, quantum efficiency (QE), full well capacity (FWC), read noise, dynamic range (DR), conversion gain |
| **Human Vision** | `resources/human-glossary.qmd` | Visual angle, cycles per degree (cpd), luminance vs. illuminance, photopic/scotopic, DVA, cone mosaics |
| **Displays** | `resources/displays-glossary.qmd` | Luminance (nits/$\text{cd/m}^2$), color gamut, subpixel layout, display gamma ($\gamma$), refresh rate, viewing angle |

---

## 5. Anchor Checklist

Before creating a glossary reference link:
1. Verify that the target header in the glossary file has an explicit anchor ID, for example:
   ```markdown
   ## 1. Lens surface geometry {#sec-glossary-surfaces}
   ### Radius of curvature ($R$) {#sec-glossary-radius-curvature}
   ```
2. If an anchor does not exist on the specific entry subsection, add an explicit anchor `{#sec-glossary-<term-slug>}` to the glossary file so the link jumps smoothly to the exact term.
