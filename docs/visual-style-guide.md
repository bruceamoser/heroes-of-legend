# Visual Style Guide — Battle-Scarred Tome

## Theme Overview

The "Battle-Scarred Tome" is the visual identity for Heroes of Legend. It evokes an aged fantasy manuscript with dark ink on weathered parchment, accented with antique gold and deep red-brown.

## Color Palette

| Role | Hex | Swatch | Usage |
|------|-----|--------|-------|
| Page Background | `#f4e4c1` | Aged parchment | All page backgrounds |
| Body Text | `#3d2b1f` | Dark brown ink | All body copy |
| Headings | `#8b0000` | Deep red-brown | H1–H4 headings |
| Gold Accent | `#c9a84c` | Antique gold | Rules, dividers, ornaments |
| Gold Dim | `#8a6a2a` | Warm brown gold | Secondary rules |
| Muted | `#7a6e5e` | Muted brown | Captions, metadata |
| Table Border | `#5c4033` | Medium brown | Table rules |
| Table Header | `#5c4033` | Medium brown bg | Table header background |
| Table Stripe | `#faf3e0` | Lighter parchment | Alternating table rows |
| Sidebar BG | `#faf3e0` | Lighter parchment | Callouts, blockquotes |
| Note BG | `#fef9e7` | Pale amber | Note callouts |
| Tip BG | `#f0f7e6` | Pale green | Tip callouts |
| Warning BG | `#fdf0ed` | Pale red | Warning callouts |

## Typography

| Role | Font Family | Size | Weight | Notes |
|------|------------|------|--------|-------|
| Body text | Crimson Text | 11pt | Regular | Leading: 0.90em |
| H1 (Chapter) | IM Fell English | ~26pt | Bold | beautitled-managed |
| H2 (Section) | IM Fell English | ~18pt | Bold | beautitled-managed |
| H3 (Subsection) | IM Fell English | ~14pt | Bold | beautitled-managed |
| H4 | IM Fell English | ~12pt | Bold | beautitled-managed |
| Table body | Crimson Text | 9pt | Regular | — |
| Table header | Crimson Text | 9.5pt | Bold | — |
| Code/Monospace | Libertinus Mono | 9pt | Regular | Stat blocks |

**Fallback stacks:**
- Body: Crimson Text → EB Garamond → Libertinus Serif → Georgia
- Headings: IM Fell English → Cinzel → Crimson Text → Libertinus Serif
- Mono: Libertinus Mono → Cascadia Code → Consolas

## Spacing

| Element | Value |
|---------|-------|
| Paragraph leading | 0.90em (on 11pt text) |
| Paragraph spacing | 0.45em |
| Table cell padding | x: 7pt, y: 5pt |
| List spacing | 0.2em |
| Page margins | Top: 0.95in, Bottom: 1.0in, Left/Right: 1.15in |

## Layout Features

### ◆ Dividers
Use ornamental ◆ dividers between major sections. In `.qmd` files:
````
```{=typst}
#horizontalrule
```
````

### Page Breaks
Use `{{< pagebreak >}}` before major sections that should start on a new page.

### Callout Types
| Type | Use For | Color |
|------|---------|-------|
| `{.callout-note}` | Design justifications, background info | Amber |
| `{.callout-tip}` | Player advice, practical tips | Green |
| `{.callout-important}` | Must-know rules, critical mechanics | Red |
| `{.callout-warning}` | Danger, risk, consequences | Red |
| `{.callout-caution}` | Edge cases, gotchas | Red |

### Tables
- Use booktabs-style rules (thick top/bottom, thin header separator)
- Add captions: `: Table X.Y: Title {#tbl-anchor}`
- For wide tables, prefer splitting into two tables over tiny fonts

## Image Guidelines

- Images live in `quarto-book/assets/images/`
- Use descriptive filenames (not `pageNNN-imgNNN`)
- Reference: `![Alt text](assets/images/descriptive-name.jpg){width="60%"}`
- SVG assets in `quarto-book/assets/svg/` for ornaments and dividers

## See Also
- [Layout Guidelines](layout-guidelines.md) — Full Quarto/Typst conventions
- [Typst Packages](typst-packages.md) — Package management
