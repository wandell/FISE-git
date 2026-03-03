# Figure, Margin, and Layout Workflow

This document describes how to manage figures, sizing, and margin contents in the FISE-2025 Quarto book.

## Figures and Cross-references
- Use Quarto’s native crossref system consistently.
- Figures: use stable labels with the `fig-` prefix (e.g., `#fig-myplot`).
- Quarto-native syntax is preferred:
  - `fig-cap`: Figure caption.
  - `fig-alt`: Alt text for accessibility.
  - `fig-align`: Alignment (default is often centered).
  - `fig-width`/`fig-height`: Control size (in inches, usually).

## Margin Content
- **Margin figures**: Use the `.column-margin` class to place specific figures in the margin instead of the main text block.
  ```markdown
  :::{.column-margin}
  ![Caption](images/my-margin-fig.png){#fig-margin}
  :::
  ```

## "Half-page width with text wrapping"
- **HTML Behavior**: True text wrap is achieved via CSS floats (e.g., `float: left` and `width: 50%`).
- **PDF Behavior**: Text wrap is not reliably portable. 
- **Recommendation**:
  1. For HTML-only: Use specific classes or styles defined in `styles/`.
  2. For Portability: Use side-by-side columns or margin figures instead of wrapping.

## Common Image Paths
- Store images in `chapters/images/`.
- Use relative paths: `images/my-image.png`.
