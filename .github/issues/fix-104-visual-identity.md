## Critical Fix #4 — Create Visual Identity (Theme, Fonts, SVG Assets)

**Status:** Must fix before publication  
**Affects:** Theme YAML, assets/svg/, fonts, master document

### Problem
The rulebook has zero visual identity. The `assets/svg/` directory is empty. The theme uses Liberation Serif (a Times New Roman clone). Headers/footers are generic. There are no part dividers, no stamps, no ornamental elements. It looks like a plain text document on cream paper.

By comparison, Neon Relic has 6 custom SVG assets, a bespoke typewriter font, in-world headers/footers on every page, a custom title page SVG, and a cohesive 5-color dossier palette.

### What a Fantasy Tome Needs

#### 1. Fonts — Replace Liberation Serif
**Research task:** Find an open-source fantasy serif font. Options:
- **Crimson Text** (OFL, Google Fonts) — elegant oldstyle, 6 weights including semibold
- **Gentium Book Basic** (OFL) — designed for long reading, excellent at small sizes
- **Alegreya** (OFL) — literary serif with medieval character, extensive weight range
- **IM Fell English** (OFL) — digitized from 17th-century typefaces, extremely fantasy

Download selected font family (Regular, Bold, Italic, Bold Italic at minimum) to `docs/themes/fonts/`. Update theme YAML font catalog. Select a secondary font for tables (clean sans-serif for readability at 9pt).

#### 2. SVG Decorative Elements — Create in assets/svg/
Minimum set (mirrors Neon Relic's 6 assets):

| Asset | Purpose | Design |
|-------|---------|--------|
| `divider-rule.svg` | Chapter breaks, section separators | Horizontal line with center ornament (heraldic shield, Celtic knot, or medieval flourish) |
| `chapter-stamp.svg` | Part divider sidebars | Small decorative stamp (compass rose, dragon head, sword-and-tome icon) |
| `title-page.svg` | Full title page background | Ornamental border, decorative header band, sword-and-stars motif |
| `ornament-corner.svg` | Page corner decorations | Small corner flourish |
| `drop-cap-T.svg` | Chapter opening drop cap | Ornamented first letter (at minimum the letter T for "The") |
| `placeholder-section.svg` | Image placeholders | Decorative border box with ornamental cross |

These can be simple geometric designs created as SVG — they don't need to be complex illustrations. The Neon Relic stamps are rectangles with text and borders.

#### 3. Title Page
Custom SVG background with:
- Ornamental double-border frame
- Title: "HEROES OF LEGEND" in fantasy display font
- Subtitle: "Core Rules — First Edition"
- Author credit
- Heraldic shield or sword motif in center
- Decorative rule under title

#### 4. Headers & Footers
Replace generic headers with in-world flavor:
- Left page: ornamental rule + chapter title in display font
- Right page: page number with ornamental surround
- Footer: "HEROES OF LEGEND" with decorative rules on each side

#### 5. Part Dividers
Replace bare `<<<` page breaks with:
- SVG divider rule (full width)
- Sidebar block with chapter-stamp + part title
- Part metadata (e.g., "PART II — CHARACTER CREATION")

#### 6. Color Palette
Enhance the current 2-tone palette to a 4+ color scheme:
- Background: `#f4e4c1` (aged parchment — keep)
- Text: `#3a2a1a` (dark brown ink — keep)
- Heading accent: `#5a1a0a` (deep red-brown — keep)
- **New:** Gold accent for special callouts: `#8a6a2a`
- **New:** Crimson for critical rules/stamps: `#8b0000`
- **Fix:** Link color from purple `#5a3a8a` to warm brown `#6a4a2a`

#### 7. Admonition Styling
Add themed styling for NOTE, TIP, WARNING blocks:
- NOTE: left border in gold, lighter parchment background
- TIP: left border in green, italic text
- WARNING: left border in crimson, slightly pink background
- Use illuminated-manuscript-inspired left borders

### Implementation Steps
1. Research and select fantasy font (ask Bruce for preference)
2. Download font files, update theme YAML font catalog
3. Create 6 SVG decorative assets
4. Write custom SVG title page
5. Rewrite header/footer configuration in theme YAML
6. Update master document to use SVG dividers and stamps
7. Rebuild and visually review the PDF
8. Iterate on colors, spacing, font sizes
