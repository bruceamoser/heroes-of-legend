## Epic 0 — Infrastructure (#2)

**Dependency:** #1
**Est. Effort:** Medium

### Goal
Create the `heroes-of-legend-theme.yml` asciidoctor-pdf theme with a fantasy tome aesthetic: aged parchment background, dark brown ink, serif fonts, ornamental chapter dividers, and decorative table styling.

### Success Criteria
- Build produces a PDF with the fantasy tome visual style
- Theme uses serif fonts (suggest: Crimson Text or Gentium Book Basic for body)
- Tables have alternating warm-tone rows
- Chapter headings have decorative styling
- Theme file validates with `asciidoctor-pdf`

### Design Palette
- **Page background:** Aged parchment (#f4e4c1 or similar warm cream)
- **Text:** Dark brown ink (#3a2a1a)
- **Accents:** Deep red (#8b0000) for headings and important callouts
- **Tables:** Alternating warm rows, decorative borders
- **Callouts:** Illuminated manuscript-style left borders

### Tasks
- [ ] Research appropriate open-source serif fonts (Google Fonts: Crimson Text, Gentium Book Basic, or similar)
- [ ] Download font files to `docs/themes/fonts/`
- [ ] Create `docs/themes/heroes-of-legend-theme.yml` based on neon-relic-theme.yml structure
- [ ] Configure page margins, sizes, running headers/footers
- [ ] Style heading hierarchy (H1-H4)
- [ ] Style tables, admonitions, code blocks
- [ ] Style lists, TOC, cross-references
- [ ] Add ornamental SVG divider for chapter breaks

### Reference
- Neon Relic theme: `../neon-relic/docs/themes/neon-relic-theme.yml`
- Asciidoctor PDF theming guide: https://docs.asciidoctor.org/pdf-converter/latest/theme/
