---
name: interactive-figures
description: Create, modify, embed, format, or diagnose client-side interactive figures and WebAssembly (qMRust / Rust) or Observable JS (OJS) simulations in Quarto book chapters.
---

# Interactive Figures with Quarto, Observable JS, and WebAssembly

## Summary

This project embeds interactive, client-side scientific visualizations and simulations directly into book chapters. Readers can manipulate parameters (e.g., via sliders and numeric inputs) and observe real-time model updates.

All computation runs entirely in the reader's web browser without requiring a server-side computational kernel by leveraging two complementary patterns:

1. **Observable JS (OJS) & Observable Plot**: For direct analytical equations, standard scientific curves, and reactive parameter sweeps.
2. **WebAssembly (Wasm) & Rust / Plotly.js**: For heavy simulations, fitting algorithms, or pre-compiled numerical libraries.

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

## Pattern B: WebAssembly (Wasm), Rust, and Plotly (For Heavy Computation)

### Core Components
1. **WebAssembly (Wasm)**: Heavy equations, numerical integration, and fitting routines compiled from Rust to `.wasm`.
2. **JavaScript ("Glue" Layer)**:
   - Initializes the Wasm module via `wasm_bindgen`.
   - Sets up UI listeners (sliders, buttons).
   - Passes parameter arrays to Wasm functions and routes outputs to Plotly.
3. **Plotly.js**: Charting library (`chapters/interactive/plotly-cartesian.min.js`) for fast 2D line and heatmap renderings.
4. **Static Assets & Quarto Resources**: The Wasm and JS assets live in `chapters/interactive/`. Because JavaScript loads `.wasm` files dynamically at runtime, they must be registered in `_quarto.yml` under `resources`:
   ```yaml
   project:
     type: book
     resources:
       - chapters/interactive/
   ```

### Asset Paths and Scoping Rules
- When referencing stylesheets, scripts, or `.wasm` binaries inside an include file or script, use paths relative to the rendered book root (`interactive/...`):
  ```html
  <link rel="stylesheet" href="interactive/figures.css">
  <script src="interactive/plotly-cartesian.min.js"></script>
  <script src="interactive/qmrust_wasm.js"></script>
  ```
  ```javascript
  wasm_bindgen({ module_or_path: "interactive/qmrust_wasm_bg.wasm" })
  ```
- **Global Scope Protection**: `qmrust_wasm.js` declares `let wasm_bindgen` at top level. Loading this file a second time on the same page triggers a JavaScript `SyntaxError`. Only load shared libraries in the first figure on a page, or share state through common helper modules like `chapters/interactive/ir-shared.js`.
- Wrap conventional `<script>` figure code in immediately invoked function expressions (IIFEs): `(function () { "use strict"; ... })();`.

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

---

## Source Material and Licensing (qMRLab / qMRust)

When adapting quantitative MRI or signal modules from the qMRLab mOOC (Massive Open Online Course):
- Contributed by Mathieu Boudreau (`https://qmrlab.org/mooc/`, `https://github.com/qMRLab/mooc`).
- **License**: Creative Commons Attribution 4.0 International (CC BY 4.0).
- **Attribution**: Include attribution in figure captions and retain third-party notices in `THIRD-PARTY-NOTICES.md`.
