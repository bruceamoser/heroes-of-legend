// ═══════════════════════════════════════════════════════════════════════════
// Heroes of Legend — Pandoc Template (Reference / Fallback)
// "Battle-Scarred Tome" — aged parchment, dark brown ink, ornamental.
//
// NOTE: The active style sheet is style.typ, injected via include-before-body
// in _quarto.yml. This template serves as a reference and fallback for when
// a full Pandoc template replacement is used (via _quarto.yml's `template:`).
//
// Keep this file in sync with style.typ for consistency.
// ═══════════════════════════════════════════════════════════════════════════

// ── Font Setup ──────────────────────────────────────────────────────────────
// Body: Crimson Text (elegant oldstyle serif, Google Fonts)
// Headings: IM Fell English (dramatic 17th-century, Google Fonts)
// Mono: Libertinus Mono (bundled with Typst)
//
// Fonts must be installed system-wide or placed in quarto-book/fonts/.
// Fallback stacks ensure compilation even if premium fonts are missing.

#let body-font    = ("Crimson Text", "Libertinus Serif", "Georgia")
#let heading-font = ("IM Fell English", "Crimson Text", "Libertinus Serif")
#let mono-font    = ("Libertinus Mono", "Cascadia Code", "Consolas")
#let table-font   = ("Crimson Text", "Libertinus Serif")

// ── Color Palette ────────────────────────────────────────────────────────────
#let page-bg       = rgb("#f4e4c1")  // aged parchment
#let text-color    = rgb("#3d2b1f")  // dark brown ink
#let heading-color = rgb("#8b0000")  // deep red-brown
#let gold          = rgb("#c9a84c")  // antique gold
#let gold-dim      = rgb("#8a6a2a")  // warm brown gold
#let muted         = rgb("#7a6e5e")  // muted brown
#let table-border  = rgb("#5c4033")  // medium brown
#let table-header  = rgb("#5c4033")  // table header bg
#let table-stripe  = rgb("#faf3e0")  // alternating row
#let sidebar-bg    = rgb("#faf3e0")  // lighter parchment
#let code-bg       = rgb("#fdfaf0")  // very light parchment
#let note-bg       = rgb("#fef9e7")  // pale amber
#let tip-bg        = rgb("#f0f7e6")  // pale green
#let warning-bg    = rgb("#fdf0ed")  // pale red
#let note-border   = rgb("#8a6a2a")  // warm brown
#let tip-border    = rgb("#4a7c3f")  // forest green
#let warn-border   = rgb("#8b0000")  // deep red-brown

// ── Unicode Icon Fallbacks ──────────────────────────────────────────────────
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

// ── Part Pages ──────────────────────────────────────────────────────────────
#let part(body) = {
  pagebreak()
  v(35%)
  align(center, {
    set text(size: 12pt, fill: muted, weight: "regular", font: body-font, tracking: 3pt)
    [PART]
    v(0.5em)
    set text(size: 28pt, fill: heading-color, weight: "bold", font: heading-font)
    body
  })
  v(1.5em)
  align(center, {
    line(start: (25%, 0pt), end: (75%, 0pt), stroke: 0.4pt + gold-dim)
    v(4pt)
    line(start: (30%, 0pt), end: (70%, 0pt), stroke: 1.5pt + gold)
    v(4pt)
    line(start: (25%, 0pt), end: (75%, 0pt), stroke: 0.4pt + gold-dim)
  })
  pagebreak()
}

// ── Callouts (Admonitions) ──────────────────────────────────────────────────
// Medieval marginalia: thick left border, pale background, unicode icon.
#let callout(body: [], type: "note", title: none, appearance: "simple", icon: true, ..args) = {
  let colors = (
    note: (fill: note-bg, stroke: note-border, icon: [📝], label: "NOTE"),
    tip: (fill: tip-bg, stroke: tip-border, icon: [💡], label: "TIP"),
    warning: (fill: warning-bg, stroke: warn-border, icon: [⚠], label: "WARNING"),
    important: (fill: warning-bg, stroke: warn-border, icon: [❗], label: "IMPORTANT"),
    caution: (fill: warning-bg, stroke: warn-border, icon: [⚠], label: "CAUTION"),
  )
  let c = colors.at(type, default: colors.note)

  let display-title = if title == none or title == [] or title == [Note] {
    c.label
  } else {
    title
  }

  block(
    fill: c.fill,
    stroke: (left: 4pt + c.stroke),
    inset: (left: 12pt, right: 8pt, top: 8pt, bottom: 8pt),
    radius: 2pt,
    [
      #set text(fill: text-color, weight: "bold", size: 10pt, font: body-font)
      #box[#c.icon #display-title]
      #v(0.3em)
      #set text(fill: text-color, weight: "regular", size: 10pt, font: body-font)
      #body
    ]
  )
  v(0.6em)
}

// ── Page Setup ──────────────────────────────────────────────────────────────
#set text(
  font: body-font,
  size: 10.5pt,
  fill: text-color,
  hyphenate: true,
  lang: "en",
)

#set par(
  justify: true,
  leading: 0.95em,
  first-line-indent: 0pt,
  spacing: 1.2em,
)

#set page(
  paper: "us-letter",
  margin: (
    top: 25mm,
    bottom: 28mm,
    left: 22mm,
    right: 22mm,
  ),
  fill: page-bg,
  numbering: "1",
  // ── Header ─────────────────────────────────────────────────────────────
  header: [
    #set text(size: 7.5pt, fill: muted, font: body-font)
    #grid(
      columns: (1fr, 1fr),
      align(left)[
        #set text(weight: "bold", tracking: 0.8pt)
        #smallcaps[Heroes of Legend]
      ],
      align(right)[#context counter(page).display()],
    )
    #v(3pt)
    #line(
      start: (0%, 0pt),
      end: (100%, 0pt),
      stroke: 0.4pt + gold-dim,
    )
  ],
  // ── Footer ─────────────────────────────────────────────────────────────
  footer: [
    #set text(size: 7.5pt, fill: muted, font: body-font)
    #align(center)[
      — #context counter(page).display() —
    ]
  ],
)

// ── Headings ────────────────────────────────────────────────────────────────
#show heading.where(level: 1): it => {
  set text(font: heading-font, size: 26pt, fill: heading-color, weight: "bold")
  pagebreak(weak: true)
  v(0.5em)
  it
  v(0.4em)
  line(start: (0%, 0pt), end: (100%, 0pt), stroke: 1.2pt + gold)
  v(0.4em)
  line(start: (15%, 0pt), end: (85%, 0pt), stroke: 0.4pt + gold-dim)
  v(0.9em)
}

#show heading.where(level: 2): it => {
  set text(font: heading-font, size: 15pt, fill: heading-color, weight: "bold")
  v(0.8em)
  it
  v(0.3em)
}

#show heading.where(level: 3): it => {
  set text(font: body-font, size: 12pt, fill: text-color, weight: "bold")
  v(0.6em)
  it
  v(0.2em)
}

#show heading.where(level: 4): it => {
  set text(font: body-font, size: 11pt, fill: text-color, weight: "bold", style: "italic")
  v(0.4em)
  it
  v(0.1em)
}

// ── Tables ──────────────────────────────────────────────────────────────────
#show table: it => {
  set text(font: table-font, size: 9pt)
  show table.cell.where(y: 0): set text(fill: page-bg, weight: "bold")
  show table.cell.where(y: 0): set fill(table-header)
  // Alternating row striping
  show table.cell.where(y: 1): set fill(table-stripe)
  show table.cell.where(y: 2): set fill(page-bg)
  show table.cell.where(y: 3): set fill(table-stripe)
  show table.cell.where(y: 4): set fill(page-bg)
  show table.cell.where(y: 5): set fill(table-stripe)
  show table.cell.where(y: 6): set fill(page-bg)
  show table.cell.where(y: 7): set fill(table-stripe)
  show table.cell.where(y: 8): set fill(page-bg)
  show table.cell.where(y: 9): set fill(table-stripe)
  show table.cell: set inset(3pt, 6pt, 3pt, 6pt)
  it
}

// ── Block Quotes ────────────────────────────────────────────────────────────
#show quote: it => {
  set text(fill: text-color, style: "italic", font: body-font)
  block(
    fill: sidebar-bg,
    inset: (left: 15pt, right: 8pt, top: 8pt, bottom: 8pt),
    stroke: (left: 4pt + heading-color),
    radius: 2pt,
    it
  )
}

// ── Code Blocks ─────────────────────────────────────────────────────────────
#show raw.where(block: true): it => {
  set text(font: mono-font, size: 9pt, fill: text-color)
  block(
    fill: code-bg,
    inset: 8pt,
    stroke: 0.5pt + table-border,
    radius: 3pt,
    it
  )
}

// Inline code
#show raw.where(block: false): it => {
  set text(font: mono-font, size: 9.5pt, fill: text-color)
  box(
    fill: code-bg,
    inset: (x: 3pt, y: 1pt),
    stroke: 0.3pt + table-border,
    radius: 2pt,
    it
  )
}

// ── Links ───────────────────────────────────────────────────────────────────
#show link: set text(fill: gold-dim)

// ── Lists ───────────────────────────────────────────────────────────────────
#set list(
  indent: 1.5em,
  body-indent: 0.5em,
)

// ── Strong / Bold ───────────────────────────────────────────────────────────
#show strong: set text(weight: "bold")

// ── Emphasis ────────────────────────────────────────────────────────────────
#show emph: it => {
  set text(style: "italic")
  it
}

// ── Footnotes ───────────────────────────────────────────────────────────────
#show footnote: set text(size: 8.5pt, fill: muted, font: body-font)

// ── Small Caps Utility ──────────────────────────────────────────────────────
#let smallcaps(body) = {
  set text(tracking: 1.5pt, size: 0.85em)
  upper(body)
}

// ── Document Body ───────────────────────────────────────────────────────────
// Pandoc template: $body$ is replaced with generated Typst content
$body$
