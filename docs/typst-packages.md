# Typst Packages — Heroes of Legend

> **Purpose:** Reference for Typst Universe packages adopted or under investigation
> for the Heroes of Legend rulebook. Each entry covers what the package does,
> how to use it, and our integration status.
>
> **Last updated:** 2026-07-12

---

## Active Packages

### booktabs — Professional Table Styling

- **Package:** `@preview/booktabs:0.0.4`
- **Author:** Budo Zindovic
- **License:** LGPL-3.0
- **Size:** 4.2 kB
- **Min Typst:** 0.13.1

**What it does:** Provides `toprule()`, `midrule()`, `bottomrule()`, `cmidrule()` —
LaTeX-quality horizontal rules for tables. Thick top/bottom rules, thin mid rules,
with proper spacing. This is the industry standard for publication-quality tables.

**How we use it:**

```typst
#import "@preview/booktabs:0.0.4": *

#table(
  columns: 3,
  toprule(),
  table.header([Name], [Damage], [Range]),
  midrule(),
  [Longsword], [2d6], [Melee],
  [Shortbow], [1d6], [30 ft.],
  bottomrule(),
)
```

**Integration status:** ✅ Active — imported in `style.typ`, replaces our
custom table border styling with `booktabs-default-table-style`.

---

### beautitled — Heading & TOC Styles

- **Package:** `@preview/beautitled:0.2.7`
- **Author:** Nathan Scheinmann
- **License:** MIT
- **Size:** 17.9 kB
- **Min Typst:** 0.14.0

**What it does:** 19 print-friendly heading styles with matching TOC designs.
Supports parts (with optional images), cross-references with page numbers,
language presets (EN/FR/DE), 6 color themes. Each style has its own coherent
chapter, section, and TOC renderer.

**Available styles:** `titled`, `classic`, `modern`, `elegant`, `bold`,
`creative`, `minimal`, `vintage`, `schoolbook`, `notes`, `clean`, `technical`,
`academic`, `textbook`, `scholarly`, `classical`, `educational`, `structured`,
`magazine`

**How we use it:**

```typst
#import "@preview/beautitled:0.2.7": *

#beautitled-setup(
  style: "titled",
  chapter-pagebreak: true,
)
#show: beautitled-init
#preset-english()
#theme-warm()    // Orange/brown tones — matches our parchment palette
```

**Integration status:** ✅ Active — imported in `style.typ`, replaces our
custom H1–H4 show rules. Configured with `warm` theme and `titled` style.

**Configuration notes:**
- `style: "titled"` — boxed sections with floating labels (default, closest to our current look)
- `style: "vintage"` — classic book ornaments, good fit for fantasy tome
- `style: "scholarly"` — centered with thin rules, elegant academic
- `chapter-pagebreak: true` — each chapter starts on new page
- `part-fullpage: true` — parts get their own centred page

---

### iconify — Vector Icon Library

- **Package:** `@preview/iconify:0.5.3`
- **Author:** ecstrema
- **License:** MIT
- **Min Typst:** 0.13.0

**What it does:** Loads icons from Iconify JSON collections. 200,000+ icons
available across many sets. Browse at [icones.js.org](https://icones.js.org/).

**Key exports:** `icon` (render an icon), `provide-icons` (load JSON collections)

**How we use it:**

```typst
#import "@preview/iconify:0.5.3": icon, provide-icons

// First, provide icon collections (download JSON from icones.js.org):
// #provide-icons(json("assets/icons/game-icons.json"))

// Then use icons inline:
// #icon("game-icons:flame", y: -0.3em)
// #icon("mdi:sword-cross", width: 1.5em)

// Color follows current text color:
// #text(fill: red)[#icon("carbon:warning")]
```

**Integration status:** ✅ Imported — available for use. Icon collections
need to be downloaded separately before use. See [icones.js.org](https://icones.js.org/)
to browse and download icon sets.

**Useful icon sets for TTRPG:**
- `game-icons:` — fantasy/TTRPG icons (swords, shields, magic, monsters)
- `mdi:` — Material Design Icons (general purpose)
- `carbon:` — IBM Carbon icons (clean, modern)
- `ph:` — Phosphor Icons (clean, modern)
- `fa6-solid:` — Font Awesome 6 solid

**Current imports (style.typ):**
```typst
#import "@preview/iconify:0.5.3": icon, provide-icons
```

---

## Investigation Packages

### dragonling — D&D 5E Content Toolkit

- **Package:** `@preview/dragonling:0.3.1`
- **Author:** Colin Jacobs
- **License:** MIT
- **Size:** 67.7 kB
- **Min Typst:** 0.13.0
- **Repo:** [github.com/coljac/typst-dnd5e](https://github.com/coljac/typst-dnd5e)

**What it does:** Full D&D 5E publishing toolkit — cover page, two-column layout,
parchment background, monster stat blocks (`statbox`), NPC cards (`npcbox`),
spell cards (`spell`), breakout boxes, formatted tables (`dndtab`).

**Key functions we'd study:**

| Function | What it does | Our equivalent need |
|----------|-------------|---------------------|
| `statbox(stats)` | Monster stat block with auto-calculated modifiers from 6 stats | Our bestiary entries (chapter 20) |
| `npcbox(npc)` | NPC card with roleplay notes | NPC descriptions |
| `spell(spell)` | Spell card with casting time, range, duration, components | Our spell stat blocks (chapters 11–12) |
| `breakoutbox(title, content)` | Colored sidebar box | Our callout blocks |
| `dndtab(name, columns:, ..contents)` | Formatted table with D&D styling | Our equipment/stat tables |

**Why we can't use it directly:** Our system uses 3d6 always-hit with
Weak/Standard/Strong tiers, not d20. But the Typst patterns for stat blocks,
tables, and card layouts are directly applicable.

**Investigation plan:**
1. Pull the package and study `statbox` implementation
2. Adapt the stat block pattern for our 6-attribute + 3-tier damage format
3. Study `spell` card layout for our Novice/Adept/Master chain format
4. Evaluate `dndtab` vs our current table styling

**Integration status:** 🔍 Under investigation — not yet integrated.

---

### bookly — Full Book Template

- **Package:** `@preview/bookly:4.1.1`
- **Author:** Mathieu Aucejo
- **License:** MIT
- **Size:** 321 kB
- **Min Typst:** (current)
- **Repo:** [github.com/maucejo/bookly](https://github.com/maucejo/bookly)

**What it does:** Complete book template with 6 visual themes, Tufte layout
(margin notes), front/back matter, info/tip/important/proof/question boxes,
subfigures, equation boxes, per-chapter mini-TOC, bibliography management.

**Key features we'd study:**

| Feature | What it does | Our equivalent |
|---------|-------------|----------------|
| `#part[Title]` and `#chapter[Title]` | Structured book hierarchy | Our part/chapter system in `_quarto.yml` |
| `#info-box`, `#tip-box`, `#important-box` | Semantic callout boxes | Our `:::{.callout-note}` blocks |
| `#subfigure(...)` | Side-by-side figures | Art placement |
| `#minitoc()` | Per-chapter table of contents | Not currently used |
| `#book-title-page(...)` | Professional title page with series, logo, cover | Our `index.qmd` front matter |
| `#back-cover(...)` | Back cover content | Not applicable |

**Why investigate:** If we ever want to move beyond Quarto's built-in book
structure to a pure-Typst pipeline, bookly shows what's possible. Its info-box
pattern could inform better callout styling. Its Tufte layout with margin notes
would be excellent for designer commentary or optional rules.

**Integration status:** 🔍 Under investigation — not yet integrated. Would
require significant migration from Quarto's book system.

---

## Package Management Workflow

### How Typst Packages Work
Typst automatically downloads and caches packages on first use when it encounters an `#import` statement. There is no `package.json` or `package-lock.json` equivalent — packages are resolved at compile time.

For Quarto + Typst, package imports go in:
- `quarto-book/_extensions/heroes-of-legend/style.typ` — for show/set rules
- `quarto-book/_extensions/heroes-of-legend/template.typ` — for template-level setup
- Raw Typst blocks in `.qmd` files: ```` ```{=typst} #import "..." ```` — for one-off use

### Adding a New Package
1. Add `#import "@preview/packagename:version": *` to `style.typ`
2. Build the project — Typst downloads the package on first compile
3. Package files are cached in Typst's package directory (platform-dependent):
   - Windows: `%APPDATA%/typst/packages/`
   - macOS: `~/Library/Application Support/typst/packages/`
   - Linux: `~/.cache/typst/packages/`

### Version Pinning
Typst packages are versioned. Specify the exact version in the import:
```typst
#import "@preview/booktabs:0.0.4": *   // ✅ Pinned
#import "@preview/booktabs:0": *       // ❌ Floating major version
```

### Current Active Packages
| Package | Version | Purpose |
|---------|---------|---------|
| booktabs | 0.0.4 | Professional table rules |
| beautitled | 0.2.7 | Heading/chapter/part styling |
| iconify | 0.5.3 | Vector icon support (collections not yet downloaded) |

### Troubleshooting
- If a package fails to download, check your internet connection
- Clear the cache: delete the package directory under the platform cache path
- Offline builds: pre-download packages on a connected machine, then copy the cache directory
