// ═══════════════════════════════════════════════════════════════════════════
// Heroes of Legend — "Battle-Scarred Tome" Theme
// A dark, grounded medieval fantasy aesthetic.
// Aged parchment, dark brown ink, ornamental flourishes.
// Voice: Direct, commanding, battle-scarred mentor.
// ═══════════════════════════════════════════════════════════════════════════

// ── Typst Universe Package Imports ──────────────────────────────────────────
// See docs/typst-packages.md for details on each package.
#import "@preview/booktabs:0.0.4": *
#import "@preview/beautitled:0.2.7": *
#import "@preview/iconify:0.5.3": icon, provide-icons

// iconify setup — download game-icons collection for fantasy/TTRPG icons:
// 1. Download: https://github.com/iconify/icon-sets/raw/master/json/game-icons.json
// 2. Save to: quarto-book/_extensions/heroes-of-legend/game-icons.json
// 3. Uncomment and configure:
//   #provide-icons(json("game-icons.json"))
// 4. Usage: #icon("game-icons:flame") or #icon("game-icons:crossed-swords")
//
// Browse icons: https://icones.js.org/collection/game-icons

// Future: Replace emoji fallbacks with iconify icons in callout definitions
// Example: icon("game-icons:info") instead of 📝 for note callouts

// ── Font Configuration ───────────────────────────────────────────────────────
// Body: Alegreya (calligraphic, literary, designed for long reading)
// Headings: Almendra (fantasy calligraphic, more readable than IM Fell English)
// Mono: Libertinus Mono (bundled with Typst)
//
// To install fonts for Typst/Quarto:
//   1. Download from https://fonts.google.com/?query=alegreya
//      and https://fonts.google.com/?query=almendra
//   2. Install system-wide (Windows: right-click → Install for all users)
//   3. Or place .ttf/.otf files in quarto-book/fonts/ directory
//
// Fallback stack ensures compilation even if premium fonts are missing.
#let body-font-stack    = ("Alegreya", "Crimson Text", "EB Garamond", "Libertinus Serif")
#let heading-font-stack = ("Almendra", "IM Fell English", "Cinzel", "Crimson Text")
#let mono-font-stack    = ("Libertinus Mono", "Cascadia Code", "Consolas")

// ── Color Palette ────────────────────────────────────────────────────────────
// Aged parchment & dark ink — no faux aging, just confident medieval tone.

// Page & Background
#let page-bg       = rgb("#f4e4c1")  // aged parchment
#let sidebar-bg    = rgb("#faf3e0")  // lighter parchment for sidebars
#let code-bg       = rgb("#fdfaf0")  // very light parchment for stat blocks

// Text & Ink
#let text-color    = rgb("#3d2b1f")  // dark brown ink — body text
#let muted         = rgb("#7a6e5e")  // muted brown for footnotes, page numbers
#let heading-color = rgb("#8b0000")  // deep red-brown — chapter/section headings

// Accent & Decorative
#let gold          = rgb("#c9a84c")  // antique gold — decorative elements
#let gold-dim      = rgb("#8a6a2a")  // warm brown gold — borders, rules
#let link-color    = rgb("#8a6a2a")  // warm brown — cross-references, links

// Table & Border
#let table-border  = rgb("#5c4033")  // medium brown — table borders
#let table-header  = rgb("#5c4033")  // medium brown — table header bg
#let table-stripe  = rgb("#faf3e0")  // lighter parchment — alternating rows
#let border-color  = rgb("#5c4033")  // medium brown — general borders

// Admonition Backgrounds
#let note-bg       = rgb("#fef9e7")  // pale amber — NOTE
#let tip-bg        = rgb("#f0f7e6")  // pale green — TIP
#let warning-bg    = rgb("#fdf0ed")  // pale red — WARNING

// Admonition Border Colors
#let note-border   = rgb("#8a6a2a")  // warm brown
#let tip-border    = rgb("#4a7c3f")  // forest green
#let warning-border = rgb("#8b0000") // deep red-brown

// Surface (legacy compat)
#let surface       = rgb("#f5f1ea")
#let surface-alt   = rgb("#ede7dd")
#let callout-bg    = rgb("#faf3e0")

// ── Unicode Icon Fallbacks ───────────────────────────────────────────────────
// Quarto generates fa-*() for Font Awesome icons. Typst doesn't ship FA.
// These unicode fallbacks provide medieval-appropriate symbols.
#let fa-info()                = [📝]
#let fa-warning()             = [⚠]
#let fa-exclamation()         = [❗]
#let fa-exclamation-triangle()= [⚠]
#let fa-lightbulb()           = [💡]
#let fa-check()               = [✓]
#let fa-times()               = [✗]
#let fa-star()                = [★]
#let fa-book()                = [📖]
#let fa-gear()                = [⚙]
#let fa-cube()                = [📦]
#let fa-bolt()                = [⚡]
#let fa-shield()              = [🛡]
#let fa-fire()                = [🔥]
#let fa-snowflake()           = [❄]
#let fa-bomb()                = [💣]

// ── Page Setup ──────────────────────────────────────────────────────────────
#set page(
  paper: "us-letter",
  fill: page-bg,
  margin: (top: 0.95in, bottom: 1.0in, left: 1.15in, right: 1.15in),
  // ── Header ─────────────────────────────────────────────────────────────
  // Chapter name left-aligned, small caps, with thin ornamental rule beneath.
  // Falls back to "Heroes of Legend" when no chapter heading is on the page.
  header: [
    #set text(size: 7.5pt, fill: muted, font: body-font-stack)
    #grid(
      columns: (1fr, 1fr),
      align(left)[
        #set text(weight: "bold", tracking: 0.8pt)
        #smallcaps[Heroes of Legend]
      ],
      align(right)[
        #context counter(page).display()
      ],
    )
    #v(3pt)
    #line(
      start: (0%, 0pt),
      end: (100%, 0pt),
      stroke: 0.4pt + gold-dim,
    )
  ],
  // ── Footer ─────────────────────────────────────────────────────────────
  // Centered page number with decorative dashes: "— 42 —"
  footer: [
    #set text(size: 7.5pt, fill: muted, font: body-font-stack)
    #align(center)[
      — #context counter(page).display() —
    ]
  ],
  numbering: none, // we provide custom footer
)

// Force warm page fill — overrides any template defaults.
#show page: it => {
  set page(fill: page-bg)
  it
}

// ── Text ────────────────────────────────────────────────────────────────────
#set text(
  font: body-font-stack,
  size: 11.5pt,
  fill: text-color,
  ligatures: true,
  hyphenate: true,
  lang: "en",
)

#set par(
  justify: true,
  leading: 0.95em,
  first-line-indent: 0pt,
  spacing: 1.2em,
)

// ── Headings (powered by beautitled) ────────────────────────────────────────
// 19 print-friendly heading styles with matching TOC designs.
// Current style: "titled" — boxed sections with floating labels.
// Other strong candidates: "vintage" (book ornaments), "scholarly" (centered rules).
// See docs/typst-packages.md for full style catalog.

#beautitled-setup(
  style: "vintage",
  chapter-pagebreak: true,
  show-part-number: true,
  show-chapter-number: true,
  show-section-number: false,
  show-subsection-number: false,
  part-fullpage: true,
)
#show: beautitled-init
#preset-english()
#theme-warm()  // Orange/brown tones — matches our parchment + dark ink palette

// Override beautitled heading fonts to use our fantasy font stack.
// beautitled applies its own font choices; we restore ours after init.
#show heading: set text(font: heading-font-stack)

// ── Tables (booktabs functions available) ───────────────────────────────────
// booktabs provides toprule(), midrule(), bottomrule(), cmidrule().
// Issue #96: Replaced uniform cell borders with booktabs-style rules.
// Top/bottom rules: 1.2pt. Midrule after header: 0.8pt per header cell.
// No vertical rules. No horizontal rules between data rows.
// Tables auto-size columns to content via columns: auto (the Typst default).
// Tables are wrapped in unbreakable blocks so they stay intact on one page.
// Header rows repeat if a table must break across pages.

#set table(
  stroke: none,
  inset: (x: 7pt, y: 5pt),
  columns: auto,
  fill: (_, y) => {
    if y == 0 { return table-header }
    if calc.rem(y, 2) == 1 { return table-stripe }
    return page-bg
  },
)

// Booktabs-style rules: thick toprule above, thick bottomrule below.
// Midrule is drawn at the bottom of each header cell (see header cell show rule).
// Tables are wrapped in unbreakable blocks to prevent mid-table page breaks.
#show table: it => {
  v(4pt)
  line(stroke: 1.2pt + table-border, start: (0%, 0pt), end: (100%, 0pt))
  v(2pt)
  block(breakable: false, it)
  v(2pt)
  line(stroke: 1.2pt + table-border, start: (0%, 0pt), end: (100%, 0pt))
  v(4pt)
}

// Header cells: parchment text on dark brown, bold, with midrule line below
#show table.cell.where(y: 0): it => {
  set text(fill: rgb("#f4e4c1"), weight: "bold", size: 9.5pt, font: body-font-stack)
  stack(
    dir: ttb,
    spacing: 0pt,
    it,
    v(1pt),
    line(stroke: 0.8pt + table-border, start: (0%, 0pt), end: (100%, 0pt)),
  )
}

// Body text
#show table.cell: set text(size: 9pt, font: body-font-stack)

// ── Links & Cross-References ────────────────────────────────────────────────
#show link: set text(fill: link-color)

// ── Emphasis & Strong ───────────────────────────────────────────────────────
#show emph: it => { set text(style: "italic"); it }
#show strong: set text(weight: "bold")

// ── Block Quotes ────────────────────────────────────────────────────────────
// Like marginalia in a medieval manuscript: warm background, thick left border.
#show quote: it => {
  set text(fill: text-color, size: 10pt, font: body-font-stack)
  block(
    fill: sidebar-bg,
    inset: (left: 14pt, right: 10pt, top: 10pt, bottom: 10pt),
    stroke: (left: 4pt + heading-color),
    radius: 2pt,
    it
  )
}

// ── Code / Raw Blocks ───────────────────────────────────────────────────────
// Very light parchment — looks like a stat block or scroll inset.
#show raw.where(block: true): it => {
  set text(size: 9pt, font: mono-font-stack, fill: text-color)
  block(
    fill: code-bg,
    inset: 10pt,
    stroke: 0.5pt + table-border,
    radius: 3pt,
    it
  )
}

// Inline code
#show raw.where(block: false): it => {
  set text(font: mono-font-stack, size: 9.5pt, fill: text-color)
  box(
    fill: code-bg,
    inset: (x: 3pt, y: 1pt),
    stroke: 0.3pt + table-border,
    radius: 2pt,
    it
  )
}

// ── Admonition / Callout Styling ────────────────────────────────────────────
// Medieval marginalia feel: thick left border, pale background, unicode icon.
// Pandoc generates: #callout(body:, title:, type:, appearance:, icon:, ...)
//
// NOTE: Quarto's orange-book template may generate callouts with different
// argument shapes. We define a robust callout that handles multiple forms.

#let callout(body: [], title: "Note", type: "note", appearance: "simple", icon: true, background_color: none, icon_color: black, body_background_color: white, ..rest) = {
  // Determine colors based on type
  let colors = (
    note: (fill: note-bg, stroke: note-border, icon: [📝], label: "NOTE"),
    tip: (fill: tip-bg, stroke: tip-border, icon: [💡], label: "TIP"),
    warning: (fill: warning-bg, stroke: warning-border, icon: [⚠], label: "WARNING"),
    important: (fill: warning-bg, stroke: warning-border, icon: [❗], label: "IMPORTANT"),
    caution: (fill: warning-bg, stroke: warning-border, icon: [⚠], label: "CAUTION"),
  )
  let c = colors.at(type, default: colors.note)

  // If title is empty or default, use the type label
  let display-title = if title == none or title == [] or title == [Note] {
    c.label
  } else {
    title
  }

  block(
    breakable: false,
    fill: c.fill,
    stroke: (left: 4pt + c.stroke),
    width: 100%,
    radius: 2pt,
    inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
    [
      // Title row with icon
      #set text(fill: text-color, weight: "bold", size: 10pt, font: body-font-stack)
      #box[#c.icon #display-title]
      #v(0.3em)
      // Body content
      #set text(fill: text-color, weight: "regular", size: 10pt, font: body-font-stack)
      #body
    ]
  )
  v(0.6em)
}

// ── Part Divider Pages ──────────────────────────────────────────────────────
// Full-bleed part title with ornamental divider.
// Quarto generates #part[Part Title] for book part divisions.
#let part(body) = {
  pagebreak()
  v(35%)
  align(center, {
    // Part label
    set text(size: 12pt, fill: muted, weight: "regular", font: body-font-stack, tracking: 3pt)
    [PART]
    v(0.5em)
    // Part title
    set text(size: 28pt, fill: heading-color, weight: "bold", font: heading-font-stack)
    body
  })
  v(1.5em)
  // Decorative divider: thick gold rule flanked by thin rules
  align(center, {
    line(start: (25%, 0pt), end: (75%, 0pt), stroke: 0.4pt + gold-dim)
    v(4pt)
    line(start: (30%, 0pt), end: (70%, 0pt), stroke: 1.5pt + gold)
    v(4pt)
    line(start: (25%, 0pt), end: (75%, 0pt), stroke: 0.4pt + gold-dim)
  })
  pagebreak()
}

// ── Horizontal Rule ─────────────────────────────────────────────────────────
// Ornamental section break: centered diamond flanked by rules.
#let horizontalrule = {
  v(0.8em)
  align(center, {
    line(start: (0%, 0pt), end: (42%, 0pt), stroke: 0.5pt + gold-dim)
    // Diamond ornament
    [#set text(size: 8pt, fill: gold-dim); ◆]
    line(start: (0%, 0pt), end: (42%, 0pt), stroke: 0.5pt + gold-dim)
  })
  v(0.8em)
}

// Usage from .qmd files:
// ```{=typst}
// #horizontalrule
// ```

// SVG asset usage guide:
// - #image("assets/svg/chapter-stamp.svg", width: 3em)  — decorative stamp for chapter titles
// - #image("assets/svg/divider-rule.svg", width: 100%)   — alternative ornamental divider
// - #image("assets/svg/drop-cap-T.svg", width: 2em)      — drop cap for chapter openings
// - #image("assets/svg/ornament-corner.svg", width: 1.5em) — corner ornament for boxes
// - #image("assets/svg/part-divider.svg", width: 100%)    — part page decorative divider
// - #image("assets/svg/placeholder-section.svg", width: 80%) — placeholder for section art
// - #image("assets/svg/title-page.svg", width: 100%)      — title page decoration

// ── Lists ───────────────────────────────────────────────────────────────────
#set list(
  indent: 1.5em,
  body-indent: 0.5em,
  spacing: 0.3em,
)

// ── Tighten up footnote styling ─────────────────────────────────────────────
#show footnote: set text(size: 8.5pt, fill: muted, font: body-font-stack)

// ── No forced blank pages ───────────────────────────────────────────────────
// orange-book forces chapters onto recto (right-hand) pages, creating blanks.
// Allow page breaks but suppress only recto/verso forced breaks so parts and
// chapters still start on fresh pages.
#show pagebreak: it => {
  if it.to == "recto" or it.to == "verso" {
    pagebreak()
  } else {
    it
  }
}

// ── Title Page Groundwork ────────────────────────────────────────────────────
// Defined as a reusable function. Call via:
//   #titlepage()
// in a .qmd file or template.
//
// Lays the groundwork with ornamental double-border frame, heraldic motif
// placeholder, and display font for the title.
// Full decorative implementation (precise positioning, SVG motif) deferred.
#let titlepage(body: none) = {
  set page(fill: page-bg)
  v(15%)
  align(center)[
    // Outer ornamental border
    #block(
      width: 82%,
      fill: none,
      stroke: (paint: gold-dim, thickness: 1.5pt),
      radius: 3pt,
      inset: 10pt,
    )[
      // Inner ornamental border
      #block(
        width: 100%,
        fill: none,
        stroke: (paint: gold, thickness: 0.6pt),
        radius: 2pt,
        inset: 24pt,
      )[
        // Heraldic motif placeholder
        #v(1em)
        #align(center)[#text(size: 48pt, fill: gold-dim)[❖]]
        #v(1.5em)
        // Title
        #align(center)[#text(size: 30pt, fill: heading-color, weight: "bold", font: heading-font-stack)[Heroes of Legend]]
        #v(0.5em)
        // Subtitle
        #align(center)[#text(size: 14pt, fill: muted, font: body-font-stack, style: "italic")[Core Rules — First Edition]]
        #v(2em)
        // Author
        #align(center)[#text(size: 11pt, fill: text-color, font: body-font-stack)[Bruce A. Moser]]
        #v(3em)
        // Decorative rule
        #align(center)[#line(start: (25%, 0pt), end: (75%, 0pt), stroke: 0.6pt + gold-dim)]
        #v(1em)
        // Tagline
        #align(center)[#text(size: 9.5pt, fill: muted, font: body-font-stack, style: "italic")["Grab your swords. Stow your spell books. Adventure awaits."]]
      ]
    ]
  ]
  pagebreak()
}

// === Marginalia (Margin Notes) ===
// Future enhancement: Add margin notes for rules reminders, cross-references,
// and "Veteran Adventurer" asides.
//
// Typst supports margin notes via #set page(margin: (inside: 1.5in, outside: 1in))
// with asymmetric margins for book-style layouts.
//
// For now, use callout blocks for designer notes and cross-references.
// When marginalia package is available, consider these locations:
//   - Core resolution reminders in ch06 margins
//   - DP cost references in ch07 skill cards
//   - Combat action summaries in ch13
//   - DA tips in ch19 GM guidance

// ── Small Caps Utility ──────────────────────────────────────────────────────
// TODO(#94): Replace faux small caps with OpenType smcp when Crimson Text supports it
// Current implementation uses reduced-size uppercase as a fallback
#let smallcaps(body) = {
  set text(tracking: 1.5pt, size: 0.85em)
  upper(body)
}
