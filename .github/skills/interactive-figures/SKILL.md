---
name: interactive-figures
description: Create, modify, embed, format, or diagnose client-side interactive figures using Observable JS (OJS) or self-contained HTML/Canvas 3D iframe visualizations in Quarto book chapters.
---

# Interactive Figures with Quarto

## Summary

This project embeds interactive, client-side scientific visualizations and simulations directly into book chapters. All computation runs entirely in the reader's web browser without a server-side computational kernel, using **two complementary patterns**:

1. **Pattern A — Observable JS (OJS) & Observable Plot (Default for 2D):** Use for analytical equations, standard 2D scientific curves, and reactive parameter sweeps with sliders/inputs. Shares page typography and responsive width natively with no `_quarto.yml` resource entries needed.
2. **Pattern B — Self-Contained HTML / Canvas 3D (`<iframe>`):** Use for interactive 3D geometry, orbitable coordinate spaces, and custom canvas visualizations that work offline without external JS libraries or WebGL, and can also be reused standalone in lecture slides.

*(Avoid introducing heavy compiled toolchains such as WebAssembly/Rust or external charting bundles unless a specific numerical simulation genuinely hits a plain-JavaScript performance bottleneck.)*

---

## Pattern A: Observable JS (OJS) & Observable Plot (Default for Analytical Models)

### Core Components
- **Observable JS (`ojs`)**: Reactive JavaScript runtime built into Quarto.
- **Observable Inputs (`Inputs`)**: Built-in UI widgets (`Inputs.range`, `Inputs.number`, `Inputs.select`, `Inputs.checkbox`, `Inputs.radio`, etc.).
- **Observable Plot (`Plot`)**: Responsive 2D plotting library (`Plot.line`, `Plot.dot`, `Plot.ruleX`, `Plot.text`, `Plot.gridX`, `Plot.gridY`).

### Structure of an OJS Include File (`chapters/includes/figures/<topic-slug>.qmd`)

```qmd
::: {style="width: 80%; margin: 0 auto; overflow: visible; font-size: 1.1rem;"}

```{ojs}
//| echo: false
viewof param_val = Inputs.range([0.1, 4.0], {value: 1.0, step: 0.05, label: "Parameter label (units)"})
```

```{ojs}
//| echo: false
sim_data = {
  const points = [];
  for (let t = 0; t <= 6; t += 0.02) {
    points.push({
      time: t,
      value: 1 - Math.exp(-t / param_val)
    });
  }
  return points;
}

Plot.plot({
  grid: false,
  width: width,
  height: 450,
  marginLeft: 80,
  marginRight: 32,
  marginBottom: 60,
  style: {
    color: "#1f1f1f",
    fontSize: "16px",
    fontFamily: "system-ui, sans-serif"
  },
  x: { label: "Time (s)" },
  y: { label: "Signal (normalized)" },
  marks: [
    Plot.gridX({strokeOpacity: 0.15}),
    Plot.gridY({strokeOpacity: 0.15}),
    Plot.line(sim_data, {x: "time", y: "value", stroke: "#2e7d32", strokeWidth: 2.5})
  ]
})
```
:::
```

---

## Pattern B: Self-Contained HTML / Canvas 3D Figures (`<iframe>`)

Use this pattern for interactive 3D geometric constructions (e.g., chromaticity normalization planes and spectrum loci in `chapters/human-06-color-metrics.qmd`) where readers drag to orbit, zoom, toggle overlays, and hover for coordinate readouts.

### Build & Asset Layout
1. **Self-Contained HTML**: Generate a single offline `.html` file (typically via a Python build script combining scientific data tables with an HTML/CSS/Canvas template). Avoid external CDNs, network calls, or WebGL dependencies so the figure works reliably in any browser and offline.
2. **Co-located Runtime Assets**: Place the `.html` file alongside its static fallbacks in `chapters/images/<subject>/<nn-chapter>/<topic>/`:
   - `<slug>.html` (interactive HTML)
   - `<slug>-static.png` (high-resolution static fallback for PDF/non-HTML formats)
   - `<slug>-static.svg` (optional editable vector source)
3. **Register in `_quarto.yml`**: Quarto does not automatically copy `.html` files referenced inside raw `<iframe>` tags. Register each interactive HTML file under `project.resources` in `_quarto.yml` (static PNGs are discovered automatically):
   ```yaml
   project:
     type: book
     output-dir: _book
     resources:
       - chapters/images/human/06-color-metrics/chromaticity/xy-plane-3d.html
       - chapters/images/human/06-color-metrics/chromaticity/uv-plane-3d.html
   ```

### Chapter Embedding Pattern
Use one outer `::: {#fig-...}` container with format-conditional blocks and a single shared caption at the bottom. Use a relative path from the chapter `.qmd` to the `images/...` asset:

```markdown
::: {#fig-example-3d-interactive}

::: {.content-visible when-format="html"}
<iframe src="images/<subject>/<nn-chapter>/<topic>/<slug>.html" title="Accessible title of the interactive 3D figure" width="100%" height="690" style="border:0;display:block;" loading="lazy"></iframe>
:::

::: {.content-visible unless-format="html"}
![](images/<subject>/<nn-chapter>/<topic>/<slug>-static.png){fig-alt="Accessible description of the static fallback." width="90%"}
:::

Concise caption explaining the geometry and controls (e.g., drag to rotate, zoom, or toggle overlays).
:::
```

### Interaction & Geometric Standards
- **Equal scales / orthonormal camera**: When illustrating 3D geometric spaces (such as CIE $XYZ$), use an orthographic camera with an orthonormal basis and equal world-unit scales on all axes so angles and foreshortening are geometrically faithful.
- **Controls & accessibility**: Support pointer drag (orbit), pinch or `+`/`-` (zoom), keyboard navigation when the canvas is focused (arrow keys to rotate, `Home` to reset), a **Reset view** button, `title` on the `<iframe>`, and `fig-alt` on the static fallback.
- **Verification**: Render the chapter (`quarto render chapters/<chapter>.qmd --to html`), confirm the `.html` asset is copied to `_book/chapters/images/...`, and test the rendered page in `quarto preview` (drag, zoom, toggles, reset, responsive widths).

---

## Shared Authoring Rules & Patterns

### 1. HTML vs. PDF Format Conditioning
Interactive figures cannot execute in PDF/print output. Wrap includes or interactive blocks in format-conditional blocks with a static image fallback:

```markdown
::: {.content-visible when-format="html"}
::: {#fig-interactive-example}
{{< include includes/figures/fig-example.qmd >}}

Caption describing the interactive simulation.
:::
:::

::: {.content-visible when-format="pdf"}
![Representative static result.](images/example-fallback.png){#fig-static-example width="70%"}
:::
```

### 2. Captions and Cross-References
- **Do NOT put captions or `#fig-...` labels inside the `.qmd` include file.** Placing captions inside the include causes duplicate captions or broken numbering.
- **Always wrap the include in a Quarto figure div (`::: {#fig-...}`) in the parent chapter file.**

### 3. Reactive Variable Naming & Scoping
- In OJS, all reactive variables on a single HTML page share a common reactive graph.
- Every `viewof` identifier and top-level calculation variable must be unique across all figures on the same page.
- Prefix control and variable names with a short topic identifier (e.g., `lens_focal_len`, `sensor_noise_gain`).
- Always include `//| echo: false` in OJS chunks to suppress source code display.
