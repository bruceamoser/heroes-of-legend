---
name: xref-audit
description: Audit all cross-references across the entire rulebook for broken links, missing targets, and consistency. Use when checking cross-reference health, after chapter renumbering, or before a major release.
---

# Cross-Reference Audit

## When to Use
- After adding, removing, or renumbering chapters
- Before a major build/release
- When you suspect broken references
- Periodic maintenance pass

## Procedure

### 1. COLLECT ALL REFERENCES
Read `quarto-book/_quarto.yml` for the complete list of valid chapter IDs. For each chapter in `quarto-book/chapters/`, find all `@sec-` cross-references.

### 2. VALIDATE EACH REFERENCE
For every `@sec-` reference found:
- Does the target label exist in `_quarto.yml`?
- Does the target chapter file actually exist?
- Is the reference pointing to the right chapter?

### 3. CHECK REFERENCE DIRECTION
- Downstream chapters should reference upstream chapters (not the reverse).
- Circular references are flagged (A references B, B references A).
- Chapters should reference their immediate dependencies.

### 4. BUILD CHECK
Run `cd quarto-book && ./build.sh` (or `.\build.ps1`) and capture all warnings. Quarto/Typst will report undefined labels.

### 5. REPORT
```markdown
## Cross-Reference Audit Report

### Summary
- Total @sec- references found: N
- Valid: N | Broken: N | Suspect: N

### Broken References
| Source Chapter | Reference | Issue |
|---------------|-----------|-------|
| 13-combat.qmd | @sec-magic-items | Label not found |

### Suspect References
| Source Chapter | Reference | Concern |
|---------------|-----------|---------|
| 03-attributes.qmd | @sec-combat | References downstream chapter |
```

## Common Issues
- **Renumbered chapter:** All `@sec-` references still use old number.
- **Copy-paste error:** Reference from one chapter left when copying content.
- **Missing registration:** Chapter exists but isn't in `_quarto.yml`.
- **Typo:** `@sec-comabt` instead of `@sec-combat`.
