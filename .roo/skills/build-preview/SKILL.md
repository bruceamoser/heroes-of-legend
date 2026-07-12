---
name: build-preview
description: Build the rulebook PDF and report results. Use when validating changes compile, checking for build errors, generating the PDF for review, or troubleshooting Quarto/Typst build issues.
---

# Build & Preview

## When to Use
- After any chapter edit — validate it builds
- Before committing changes
- Troubleshooting build failures
- Generating the PDF for review

## Procedure

### 1. RUN THE BUILD
```bash
cd quarto-book
./build.sh        # Linux/macOS
# or
.\build.ps1       # Windows PowerShell
```

### 2. CAPTURE OUTPUT
Watch for:
- **Errors:** Red text, build halts. Must be fixed.
- **Warnings:** Yellow text, build completes but with issues.
- **Success:** Output file path and size.

### 3. CHECK THE PDF
Output: `quarto-book/_output/heroes-of-legend-core-rules.pdf`

Check if possible:
- Does the PDF open without errors?
- All chapters present in correct order?
- Table of contents correct?
- Cross-references rendering as clickable links?
- Typst theme (fantasy tome aesthetic) applied correctly?
- Tables formatted properly?
- Callout blocks rendering correctly?

### 4. REPORT
```markdown
## Build Report

### Status: ✅ Success / ⚠️ Warnings / ❌ Failed

### Errors (if any)
- [Error message and likely cause]

### Warnings (if any)
- [Warning message and significance]

### PDF Check
- Output: quarto-book/_output/heroes-of-legend-core-rules.pdf
- Size: [file size] | Pages: [page count]
- TOC: ✅/⚠️ | Cross-references: ✅/⚠️ | Theme: ✅/⚠️
- Overall: ✅ Ready / ⚠️ Issues found
```

## Common Build Issues

| Issue | Likely Cause | Fix |
|-------|-------------|-----|
| `undefined label` | Broken `@sec-` reference | Check `_quarto.yml` for correct label |
| `parse error` | Invalid Markdown/YAML | Check for unclosed blocks, bad table syntax |
| `file not found` | Missing chapter or wrong path | Verify file exists and in `_quarto.yml` |
| Typst rendering error | Invalid template syntax | Check `_extensions/heroes-of-legend/template.typ` |
| `duplicate label` | Two chapters with same ID | Check `_quarto.yml` for duplicate IDs |
