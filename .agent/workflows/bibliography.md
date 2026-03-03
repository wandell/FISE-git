# Bibliography Management Workflow

This document describes how to set up and use `bibtex-tidy` to format the project's bibliography file (`paperpile.bib`).

## Installation

We encountered issues using the VS Code extension alone. The most reliable setup involves installing the command-line tool globally via NPM and configuring VS Code to use it.

### 1. Install Node.js and NPM
Ensure Node.js is installed on your system.
- Check: `node -v`, `npm -v`

### 2. Install bibtex-tidy CLI
Install the tool globally so it can be run from the terminal and found by VS Code extensions if needed.
```bash
npm install -g bibtex-tidy
```
- Verify: `bibtex-tidy --version`

### 3. Install VS Code Extension
Install the `Bibtex Tidy` extension for VS Code:
- Extension ID: `xrimson.bibtex-tidy`
- Name: `Bibtex Tidy`

## Configuration

We use a workspace setting file (`.vscode/settings.json`) to force VS Code to use `bibtex-tidy` as the default formatter for BibTeX files and trigger formatting on save.

1. Create or update `.vscode/settings.json` in your workspace root.
2. Add the following configuration (see `.agent/workflows/settings-backup.json` for reference):

```json
{
    "files.associations": {
        "*.bib": "bibtex"
    },
    "[bibtex]": {
        "editor.defaultFormatter": "xrimson.bibtex-tidy",
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.fixAll": "explicit"
        }
    },
    "[bib]": {
        "editor.defaultFormatter": "xrimson.bibtex-tidy"
    }
}
```

## Usage

### Automatic Formatting (Recommended)
Just edit `paperpile.bib` and save the file (`Cmd+S` or `Ctrl+S`). The formatter runs automatically.

### Manual Formatting
- Select text in `paperpile.bib`, Right-click > `Format Document`.
- Or run from terminal: `bibtex-tidy --modify paperpile.bib`

## Troubleshooting

### "Format Document" Fails Silently
If formatting doesn't happen:
1. **Check Syntax Errors**: The formatter will fail if the `.bib` file has syntax errors (e.g., extra braces, missing commas). Run the CLI tool to see the error message:
   ```bash
   bibtex-tidy --modify paperpile.bib
   ```
   Fix the reported error and try again.

2. **Verify Installation**: Ensure `bibtex-tidy` is in your PATH.
