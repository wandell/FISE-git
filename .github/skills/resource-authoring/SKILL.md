---
name: resource-authoring
description: Author, structure, and review files in chapters/resources/. Use when creating a new resource, updating an existing resource, or auditing header and navigation consistency.
---

# FISE Resource File Standard

## Purpose
Resource files in `chapters/resources/` hold supplementary material that lies outside the primary pedagogical path of the book: historical essays, extended mathematical derivations, specialized background, and independent student research/code projects. While outside the main chapter sequence, they must share consistent metadata, visual polish, and navigation.

## Required File Structure

Every resource `.qmd` file must adhere to the following sequence:

### 1. Minimal YAML Frontmatter
Always include the modification date frontmatter at the very top:

```yaml
---
date: last-modified
---
```

### 2. Level-1 Title and Stable Section Anchor
A single `#` title with an explicit `#sec-resource-*` anchor label:

```markdown
# Title of the Resource {#sec-resource-slug}
```

### 3. Work-in-Progress Callout Include
Immediately beneath the title, include the WIP callout using the appropriate relative path:
- For files directly in `chapters/resources/`:
  ```markdown
  {{< include "../includes/WIP-callout.qmd" >}}
  ```
- For nested resources (e.g., `chapters/resources/Artal-2024/Artal-2024.qmd`):
  ```markdown
  {{< include "../../includes/WIP-callout.qmd" >}}
  ```

### 4. Navigation Bar
Provide clear return paths for readers arriving from search, the sidebar, or a chapter link:
- **If linked from a specific parent chapter:**
  ```markdown
  [Return to <Chapter Title>](../<chapter-filename>.qmd) | [Return to book home](../../index.qmd)
  ```
- **If not linked from a specific chapter (general reference):**
  ```markdown
  [Return to book home](../../index.qmd)
  ```

Place the navigation bar near the top (right after the WIP callout or header) and repeat it as a footer at the bottom of the document so readers do not have to scroll all the way back up.

### 5. Pedagogical Scope and Framing
Start with a short introductory section or overview explaining:
- The context and scope of the resource.
- Why this material is presented as an off-path resource rather than within a main chapter.
- Pointers to any related foundational chapters.

### 6. Student Projects and ISETCam Code Opportunities
When a resource suggests an open question or lacks a built-in ISETCam implementation, include a dedicated callout (e.g., `:::{.callout-tip title="Research & Code Opportunity with ISETCam"}`) detailing project directions and encouraging collaboration with the AI assistant.
