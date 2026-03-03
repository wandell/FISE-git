# Development & Debugging Workflow

This document describes how to debug build, render, and formatting issues in the FISE-2025 Quarto book.

## Quarto Checks
- Run `quarto check` to verify that your installation (Quarto and its dependencies) is correct.
- Run `quarto render --debug` to get detailed output on render errors.

## Build and Clean
- If you notice stale content or unexpected formatting in the output:
  - Clean the output directory: `_book/`.
  - Re-render the entire book: `quarto render`.
  - For specific chapters: `quarto render chapters/my-file.qmd`.

## Metadata and Formatting Errors
- Check `_quarto.yml` for syntax errors (the agent can assist with this).
- Error logs in VS Code's "Output" panel are essential for diagnosing failing blocks.

## Workflow Expectations
- Maintain small, testable edits in `.qmd` files.
- Always provide high-level diagnosis before proposing fixes.
