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

### 1. CHOOSE THE ARTIFACT AND BUILD

For the current illustrated player book in `design/player-book/`, use:

```bash
python3 design/player-book/build.py --compile
python3 design/player-book/audit.py
```

Read its README for Typst, font, Poppler, Pillow and pypdf requirements.
Output: `design/player-book/output/heroes-of-legend-players-book.pdf`.
The build reads authored Markdown; never regenerate catalog prose from code. It
compiles without decorative fill, identifies clear page areas, recompiles with
a finite set of relevant, unused illustrations, and optimizes only the PDF export's raster images.
Keep generated art masters and prompts. Never cycle artwork to fill gaps. Check
illustration uniqueness across the entire book, including front matter and explicit
placements; repeating functional symbols and logos is allowed. Whitespace is better
than unrelated portrait filler. Inspect discipline symbols with their rank numbers
at the actual printed header size. Do not substitute old Quarto mechanics.

Before delivering an illustrated revision, verify all planned art exists and no
placeholder remains, inspect every page in overview and enlarge representative
cards, tables, forms and image placements. Text bounds alone cannot detect poor
composition, small text, overlapping art or unusable writing fields. Check links,
bookmarks and selectable text after export optimization. Record the final page
count and PDF hash; author QA does not replace Bruce's independent review.

For a requested **legacy Quarto** build, use the following commands:
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
Use the output path for the artifact selected above. Legacy Quarto output:
`quarto-book/_output/heroes-of-legend-core-rules.pdf`

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

For the standalone `design/player-book/` edition, run its build and audit rather
than the legacy Quarto build. After presentation changes, inspect class price
tables, the full discipline matrix, all four ability directories and tiered end
indexes. Verify that shared card rules remain in chapter introductions, origin
grants survive condensation, short tables stay together, and ending columns are
balanced. Keep `ability-summaries.json` and `recipe-presentation.json` synchronized
with their source cards. Check transparent portrait alpha and illustration
uniqueness, then refresh PDF navigation counts and the QA report for the final file.

| Issue | Likely Cause | Fix |
|-------|-------------|-----|
| `undefined label` | Broken `@sec-` reference | Check `_quarto.yml` for correct label |
| `parse error` | Invalid Markdown/YAML | Check for unclosed blocks, bad table syntax |
| `file not found` | Missing chapter or wrong path | Verify file exists and in `_quarto.yml` |
| Typst rendering error | Invalid template syntax | Check `_extensions/heroes-of-legend/template.typ` |
| `duplicate label` | Two chapters with same ID | Check `_quarto.yml` for duplicate IDs |
