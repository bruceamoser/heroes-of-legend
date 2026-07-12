// ═══════════════════════════════════════════════════════════════════════════
// Heroes of Legend — "Heroic Modern" Theme
// A clean, warm fantasy aesthetic inspired by modern TTRPG layouts.
// No faux aging — just confident, readable, heroic design.
// ═══════════════════════════════════════════════════════════════════════════

// ── Color Palette ───────────────────────────────────────────────────────────
#let page-bg       = rgb("#fdfcf8")  // warm off-white page
#let text-color    = rgb("#2d2a26")  // rich charcoal
#let crimson       = rgb("#8b1a2a")  // heroic deep red
#let gold          = rgb("#c4a43a")  // warm gold accent
#let gold-dim      = rgb("#a89030")  // darker gold for borders
#let surface       = rgb("#f5f1ea")  // subtle warm surface
#let surface-alt   = rgb("#ede7dd")  // alternate surface
#let callout-bg    = rgb("#f7f3ec")  // callout background
#let table-stripe  = rgb("#f9f6f1")  // table zebra
#let border-color  = rgb("#d4cdc2")  // subtle borders
#let muted         = rgb("#6b6560")  // muted text

// ── Font Awesome Fallbacks ──────────────────────────────────────────────────
#let fa-info()                = []
#let fa-warning()             = []
#let fa-exclamation()         = []
#let fa-exclamation-triangle()= []
#let fa-lightbulb()           = []
#let fa-check()               = []
#let fa-times()               = []
#let fa-star()                = []
#let fa-book()                = []
#let fa-gear()                = []
#let fa-cube()                = []
#let fa-bolt()                = []
#let fa-shield()              = []
#let fa-fire()                = []
#let fa-snowflake()           = []
#let fa-bomb()                = []

// ── Page Setup ──────────────────────────────────────────────────────────────
// Single-column base — chapter headings and part pages need full width.
// Body text flows in two columns via #set page(columns: 2) scoped to content.
#set page(
  paper: "us-letter",
  fill: page-bg,
  margin: (top: 0.95in, bottom: 1.0in, left: 1.15in, right: 1.15in),
  header: [
    #set text(size: 7.5pt, fill: muted, font: "Libertinus Serif")
    #grid(
      columns: (1fr, 1fr),
      align(left)[*Heroes of Legend* · Core Rules],
      align(right)[#context counter(page).display()],
    )
  ],
  footer: [
    #set text(size: 7pt, fill: muted)
    #align(center)[Heroes of Legend]
  ],
  numbering: none, // we use custom footer
)
// Force warm page fill: orange-book template may override set rules.
// A show rule on the page element always wins.
#show page: it => {
  set page(fill: page-bg)
  it
}
// ── Text ────────────────────────────────────────────────────────────────────
#set text(
  font: "Libertinus Serif",
  size: 10.5pt,
  fill: text-color,
  ligatures: true,
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 0pt,
  spacing: 0.45em,
)

// ── Headings ────────────────────────────────────────────────────────────────
// Chapter titles (H1): bold crimson, generous spacing.
#show heading.where(level: 1): it => {
  v(0.8em)
  set text(size: 24pt, fill: crimson, weight: "bold")
  it
  v(0.35em)
  line(start: (0%, 0pt), end: (100%, 0pt), stroke: 1pt + gold-dim)
  v(0.9em)
}

// Section headings (H2): clean, bold
#show heading.where(level: 2): it => {
  v(0.9em)
  set text(size: 15pt, fill: crimson, weight: "bold")
  it
  v(0.35em)
}

// Subsection headings (H3): bold charcoal
#show heading.where(level: 3): it => {
  v(0.7em)
  set text(size: 12pt, fill: text-color, weight: "bold")
  it
  v(0.25em)
}

// Sub-subsection (H4): italic
#show heading.where(level: 4): it => {
  v(0.5em)
  set text(size: 11pt, fill: text-color, weight: "bold", style: "italic")
  it
  v(0.15em)
}

// ── Tables ──────────────────────────────────────────────────────────────────
// Clean modern table style — crimson header, subtle grid
#set table(
  stroke: 0.5pt + border-color,
  inset: (x: 7pt, y: 5pt),
  fill: (_, y) => if y == 0 { crimson },
)

// Header text: white on crimson
#show table.cell.where(y: 0): set text(fill: page-bg, weight: "bold", size: 9.5pt)

// Body text
#show table.cell: set text(size: 9pt)

// ── Links ───────────────────────────────────────────────────────────────────
#show link: set text(fill: crimson)

// ── Emphasis & Strong ───────────────────────────────────────────────────────
#show emph: it => { set text(style: "italic"); it }
#show strong: set text(weight: "bold")

// ── Block Quotes ────────────────────────────────────────────────────────────
#show quote: it => {
  set text(fill: text-color, size: 10pt)
  block(
    fill: surface,
    inset: (left: 14pt, right: 10pt, top: 10pt, bottom: 10pt),
    stroke: (left: 3pt + crimson),
    radius: 2pt,
    it
  )
}

// ── Code / Raw ──────────────────────────────────────────────────────────────
#show raw.where(block: true): it => {
  set text(size: 9pt, font: "Libertinus Mono")
  block(
    fill: surface,
    inset: 10pt,
    stroke: 0.5pt + border-color,
    radius: 3pt,
    it
  )
}

// ── Override callout — modern heroic style ──────────────────────────────────
// Pandoc generates #callout(body:, title:, background_color:, icon:, icon_color:, body_background_color:)
// We ignore Quarto's blue palette and use our own heroic colors.
#let callout(body: [], title: "Callout", background_color: none, icon: none, icon_color: black, body_background_color: white, ..rest) = {
  block(
    breakable: false,
    fill: callout-bg,
    stroke: (paint: gold-dim, thickness: 0.8pt, cap: "round"),
    width: 100%,
    radius: 3pt,
    block(
      inset: 1pt,
      width: 100%,
      below: 0pt,
      // Title bar
      block(
        fill: crimson,
        width: 100%,
        inset: (left: 10pt, right: 10pt, top: 5pt, bottom: 5pt),
        radius: (top: 2pt, bottom: 0pt, left: 2pt, right: 2pt),
      )[
        #set text(fill: page-bg, weight: "bold", size: 10pt)
        #title
      ]
    ) + if(body != []) {
      // Body content
      block(
        inset: 1pt,
        width: 100%,
        block(
          fill: callout-bg,
          width: 100%,
          inset: (left: 10pt, right: 10pt, top: 8pt, bottom: 8pt),
          body,
        )
      )
    }
  )
  v(0.6em)
}

// ── Part divider pages ──────────────────────────────────────────────────────
#let part(body) = {
  pagebreak()
  v(38%)
  align(center, {
    set text(size: 30pt, fill: crimson, weight: "bold")
    body
  })
  v(1em)
  align(center, {
    line(start: (32%, 0pt), end: (68%, 0pt), stroke: 2pt + gold)
  })
}

// ── Horizontal rule ─────────────────────────────────────────────────────────
#let horizontalrule = line(
  start: (20%, 0pt),
  end: (80%, 0pt),
  stroke: 0.5pt + border-color,
)

// ── Lists ───────────────────────────────────────────────────────────────────
#set list(
  indent: 1.5em,
  body-indent: 0.5em,
  spacing: 0.2em,
)

// ── Tighten up footnote styling ─────────────────────────────────────────────
#show footnote: set text(size: 8.5pt, fill: muted)

// ── No em dashes ────────────────────────────────────────────────────────────
#show "—": " -- "
#show "–": " - "

// ── No forced blank pages ───────────────────────────────────────────────────
// orange-book forces chapters onto recto (right-hand) pages, creating blanks.
// Suppress only pagebreaks that force a specific side (to: "right"/"left").
#show pagebreak: it => {
  if it.to != none { none }
}
