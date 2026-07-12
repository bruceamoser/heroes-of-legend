// NOTE: This file is a reference/deprecated.
// The active fantasy theme is in style.typ, injected via include-before-body
// in _quarto.yml. This approach correctly overrides Quarto's default callout
// colors by redefining #let callout() AFTER Pandoc's generated definition
// but BEFORE the document's first callout call.
//
// If you need a FULL Pandoc template replacement (not just style injection),
// use the pattern below with _quarto.yml's `template:` option.
// Fantasy tome aesthetic: aged parchment, dark brown ink, ornamental feel
//
// This template replaces the default Quarto Typst template.
// It provides a fantasy RPG rulebook look while keeping Quarto's
// structural features (TOC, cross-references, etc.).

// ── Font Setup ──────────────────────────────────────────────────────────────
// Use Libertinus Serif (free, bundled with Typst/Quarto) for body text.

#let body-font = "Libertinus Serif"
#let heading-font = "Libertinus Serif"
#let mono-font = "Libertinus Mono"
#let table-font = "Libertinus Serif"

// ── Font Awesome Icon Fallbacks ─────────────────────────────────────────────
// Quarto generates fa-*() for icons, but Typst doesn't ship Font Awesome.
// Provide text fallbacks so the document compiles.

#let fa-info() = [ℹ]
#let fa-warning() = [⚠]
#let fa-exclamation() = [❗]
#let fa-exclamation-triangle() = [⚠]
#let fa-lightbulb() = [💡]
#let fa-check() = [✓]
#let fa-times() = [✗]
#let fa-star() = [★]
#let fa-book() = [📖]
#let fa-gear() = [⚙]
#let fa-cube() = [📦]
#let fa-bolt() = [⚡]
#let fa-shield() = [🛡]
#let fa-fire() = [🔥]
#let fa-snowflake() = [❄]
#let fa-bomb() = [💣]

// ── Part Pages ──────────────────────────────────────────────────────────────
// Quarto generates #part[Title] for book part divisions

#let part(body) = {
  pagebreak()
  v(40%)
  align(center, {
    set text(font: heading-font, size: 28pt, fill: rgb("#5a1a0a"))
    body
  })
  v(2em)
  line(
    start: (30%, 0pt),
    end: (70%, 0pt),
    stroke: 1pt + rgb("#8a7a5a"),
  )
  pagebreak()
}

// ── Callouts (Admonitions) ──────────────────────────────────────────────────
// Quarto generates #callout(body: [Content], type: "note", title: [Title], ...)

#let callout(body: [], type: "note", title: none, appearance: "simple", icon: true, ..args) = {
  let colors = (
    note: (fill: rgb("#efe0c8"), stroke: rgb("#8b4513")),
    warning: (fill: rgb("#faf0d0"), stroke: rgb("#b8860b")),
    tip: (fill: rgb("#e0f0e0"), stroke: rgb("#2e8b57")),
    important: (fill: rgb("#f0e0e0"), stroke: rgb("#8b0000")),
    caution: (fill: rgb("#f0e0e0"), stroke: rgb("#8b0000")),
  )
  let color = colors.at(type, default: colors.note)
  
  block(
    fill: color.fill,
    stroke: (left: 3pt + color.stroke),
    inset: (left: 12pt, right: 8pt, top: 8pt, bottom: 8pt),
    radius: 3pt,
    [
      #set text(fill: rgb("#4a3a2a"))
      #if title != none and title != [] [
        #set text(weight: "bold", size: 10.5pt)
        #title
        #v(0.3em)
      ]
      #set text(size: 10pt)
      #body
    ]
  )
  v(0.8em)
}

#set text(
  font: body-font,
  size: 10.5pt,
  fill: rgb("#3a2a1a"),    // dark brown ink
  hyphenate: true,
  lang: "en",
)

#set page(
  paper: "us-letter",
  margin: (
    top: 25mm,
    bottom: 28mm,
    left: 22mm,
    right: 22mm,
  ),
  fill: rgb("#f4e4c1"),     // aged parchment
  numbering: "1",
)

// ── Headings ────────────────────────────────────────────────────────────────

#show heading.where(level: 1): it => {
  set text(font: heading-font, size: 22pt, fill: rgb("#5a1a0a"))  // deep red-brown
  pagebreak(weak: true)
  v(0.5em)
  it
  v(0.3em)
  // Ornamental divider line
  line(
    start: (0%, 0pt),
    end: (100%, 0pt),
    stroke: 0.5pt + rgb("#8a7a5a"),
  )
  v(0.5em)
}

#show heading.where(level: 2): it => {
  set text(font: heading-font, size: 16pt, fill: rgb("#4a2a1a"))
  v(0.8em)
  it
  v(0.3em)
}

#show heading.where(level: 3): it => {
  set text(font: heading-font, size: 12.5pt, fill: rgb("#3a2a1a"))
  v(0.6em)
  it
  v(0.2em)
}

#show heading.where(level: 4): it => {
  set text(font: heading-font, size: 11pt, fill: rgb("#3a2a1a"), style: "italic")
  v(0.4em)
  it
  v(0.1em)
}

// ── Tables ──────────────────────────────────────────────────────────────────

#show table: it => {
  set text(font: table-font, size: 9pt)
  show table.cell.where(y: 0): set text(fill: rgb("#f4e4c1"), weight: "bold")
  show table.cell.where(y: 0): set fill(rgb("#5a3a1a"))  // dark header
  // Stripe rows
  show table.cell.where(y: 1): set fill(rgb("#faf6ec"))
  show table.cell.where(y: 2): set fill(rgb("#f0e8d0"))
  show table.cell.where(y: 3): set fill(rgb("#faf6ec"))
  show table.cell.where(y: 4): set fill(rgb("#f0e8d0"))
  show table.cell.where(y: 5): set fill(rgb("#faf6ec"))
  show table.cell: set inset(3pt, 6pt, 3pt, 6pt)
  it
}

// ── Headers & Footers ───────────────────────────────────────────────────────

#set page(
  header: [
    #set text(size: 8pt, fill: rgb("#8a7a5a"), font: table-font)
    #grid(
      columns: (1fr, 1fr),
      align(left)[*Heroes of Legend* — Core Rules],
      align(right)[#context counter(page).display()],
    )
  ],
  footer: [
    #set text(size: 7pt, fill: rgb("#8a7a5a"), font: table-font)
    #align(center)[Heroes of Legend — Core Rules]
  ],
)

// ── Block Quotes ────────────────────────────────────────────────────────────

#show quote: it => {
  set text(fill: rgb("#4a3a2a"), style: "italic")
  block(
    fill: rgb("#efe0c8"),
    inset: (left: 15pt, right: 8pt, top: 8pt, bottom: 8pt),
    stroke: (left: 3pt + rgb("#8b4513")),
    it
  )
}

// ── Code Blocks ─────────────────────────────────────────────────────────────

#show raw: it => {
  set text(font: mono-font, size: 9pt)
  block(
    fill: rgb("#efe4cc"),
    inset: 8pt,
    stroke: 0.5pt + rgb("#8a7a5a"),
    radius: 3pt,
    it
  )
}

// ── Links ───────────────────────────────────────────────────────────────────

#show link: set text(fill: rgb("#5a3a8a"))

// ── Lists ───────────────────────────────────────────────────────────────────

#set list(
  indent: 1.5em,
  body-indent: 0.5em,
)

// ── Strong / Bold ───────────────────────────────────────────────────────────

#show strong: set text(fill: rgb("#3a2a1a"))

// ── Emphasis ────────────────────────────────────────────────────────────────

#show emph: it => {
  set text(fill: rgb("#4a3a2a"))
  it
}

// ── Document Body ───────────────────────────────────────────────────────────
// Pandoc template: $body$ is replaced with generated Typst content

$body$
