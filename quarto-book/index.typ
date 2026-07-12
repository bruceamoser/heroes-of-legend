// Chapter-based numbering for books with appendix support
#let equation-numbering = it => {
  let pattern = if state("appendix-state", none).get() != none { "(A.1)" } else { "(1.1)" }
  numbering(pattern, counter(heading).get().first(), it)
}
#let callout-numbering = it => {
  let pattern = if state("appendix-state", none).get() != none { "A.1" } else { "1.1" }
  numbering(pattern, counter(heading).get().first(), it)
}
#let subfloat-numbering(n-super, subfloat-idx) = {
  let chapter = counter(heading).get().first()
  let pattern = if state("appendix-state", none).get() != none { "A.1a" } else { "1.1a" }
  numbering(pattern, chapter, n-super, subfloat-idx)
}
// Theorem configuration for theorion
// Chapter-based numbering (H1 = chapters)
#let theorem-inherited-levels = 1

// Appendix-aware theorem numbering
#let theorem-numbering(loc) = {
  if state("appendix-state", none).at(loc) != none { "A.1" } else { "1.1" }
}

// Theorem render function
// Note: brand-color is not available at this point in template processing
#let theorem-render(prefix: none, title: "", full-title: auto, body) = {
  block(
    width: 100%,
    inset: (left: 1em),
    stroke: (left: 2pt + black),
  )[
    #if full-title != "" and full-title != auto and full-title != none {
      strong[#full-title]
      linebreak()
    }
    #body
  ]
}
// Some definitions presupposed by pandoc's typst output.
#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms.item: it => block(breakable: false)[
  #text(weight: "bold")[#it.term]
  #block(inset: (left: 1.5em, top: -0.4em))[#it.description]
]

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let fields = old_block.fields()
  let _ = fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => {
          let subfloat-idx = quartosubfloatcounter.get().first() + 1
          subfloat-numbering(n-super, subfloat-idx)
        })
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => block({
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          })

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let children = old_title_block.body.body.children
  let old_title = if children.len() == 1 {
    children.at(0)  // no icon: title at index 0
  } else {
    children.at(1)  // with icon: title at index 1
  }

  // TODO use custom separator if available
  // Use the figure's counter display which handles chapter-based numbering
  // (when numbering is a function that includes the heading counter)
  let callout_num = it.counter.display(it.numbering)
  let new_title = if empty(old_title) {
    [#kind #callout_num]
  } else {
    [#kind #callout_num: #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block,
    block_with_new_content(
      old_title_block.body,
      if children.len() == 1 {
        new_title  // no icon: just the title
      } else {
        children.at(0) + new_title  // with icon: preserve icon block + new title
      }))

  align(left, block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1)))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color,
        width: 100%,
        inset: 8pt)[#if icon != none [#text(icon_color, weight: 900)[#icon] ]#title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}




#let article(
  title: none,
  subtitle: none,
  authors: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Set document metadata for PDF accessibility
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()
  set par(
    justify: true,
    leading: linestretch * 0.65em
  )
  set text(lang: lang,
           region: region,
           size: fontsize)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
   }

  let has-title-block = title != none or (authors != none and authors != ()) or date != none or abstract != none
  if has-title-block {
    place(
      top,
      float: true,
      scope: "parent",
      clearance: 4mm,
      block(below: 1em, width: 100%)[

        #if title != none {
          align(center, block(inset: 2em)[
            #set par(leading: heading-line-height) if heading-line-height != none
            #set text(font: heading-family) if heading-family != none
            #set text(weight: heading-weight)
            #set text(style: heading-style) if heading-style != "normal"
            #set text(fill: heading-color) if heading-color != black

            #text(size: title-size)[#title #if thanks != none {
              footnote(thanks, numbering: "*")
              counter(footnote).update(n => n - 1)
            }]
            #(if subtitle != none {
              parbreak()
              text(size: subtitle-size)[#subtitle]
            })
          ])
        }

        #if authors != none and authors != () {
          let count = authors.len()
          let ncols = calc.min(count, 3)
          grid(
            columns: (1fr,) * ncols,
            row-gutter: 1.5em,
            ..authors.map(author =>
                align(center)[
                  #author.name \
                  #author.affiliation \
                  #author.email
                ]
            )
          )
        }

        #if date != none {
          align(center)[#block(inset: 1em)[
            #date
          ]]
        }

        #if abstract != none {
          block(inset: 2em)[
          #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
          ]
        }
      ]
    )
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  doc
}

#set table(
  inset: 6pt,
  stroke: none
)
#import "@preview/fontawesome:0.5.0": *
#let brand-color = (
  background: rgb("#f4e4c1"),
  callout-bg: rgb("#faf3e0"),
  code-bg: rgb("#fdfaf0"),
  foreground: rgb("#3d2b1f"),
  light: rgb("#faf3e0"),
  muted: rgb("#7a6e5e"),
  note-bg: rgb("#fef9e7"),
  note-border: rgb("#8a6a2a"),
  primary: rgb("#8b0000"),
  secondary: rgb("#c9a84c"),
  sidebar-bg: rgb("#faf3e0"),
  surface: rgb("#f5f1ea"),
  table-border: rgb("#5c4033"),
  table-header: rgb("#5c4033"),
  table-stripe: rgb("#faf3e0"),
  tertiary: rgb("#8a6a2a"),
  tip-bg: rgb("#f0f7e6"),
  tip-border: rgb("#4a7c3f"),
  warning-bg: rgb("#fdf0ed"),
  warning-border: rgb("#8b0000")
)
#let brand-color-background = (
  background: color.mix((brand-color.background, 15%), (brand-color.background, 85%)),
  callout-bg: color.mix((brand-color.callout-bg, 15%), (brand-color.background, 85%)),
  code-bg: color.mix((brand-color.code-bg, 15%), (brand-color.background, 85%)),
  foreground: color.mix((brand-color.foreground, 15%), (brand-color.background, 85%)),
  light: color.mix((brand-color.light, 15%), (brand-color.background, 85%)),
  muted: color.mix((brand-color.muted, 15%), (brand-color.background, 85%)),
  note-bg: color.mix((brand-color.note-bg, 15%), (brand-color.background, 85%)),
  note-border: color.mix((brand-color.note-border, 15%), (brand-color.background, 85%)),
  primary: color.mix((brand-color.primary, 15%), (brand-color.background, 85%)),
  secondary: color.mix((brand-color.secondary, 15%), (brand-color.background, 85%)),
  sidebar-bg: color.mix((brand-color.sidebar-bg, 15%), (brand-color.background, 85%)),
  surface: color.mix((brand-color.surface, 15%), (brand-color.background, 85%)),
  table-border: color.mix((brand-color.table-border, 15%), (brand-color.background, 85%)),
  table-header: color.mix((brand-color.table-header, 15%), (brand-color.background, 85%)),
  table-stripe: color.mix((brand-color.table-stripe, 15%), (brand-color.background, 85%)),
  tertiary: color.mix((brand-color.tertiary, 15%), (brand-color.background, 85%)),
  tip-bg: color.mix((brand-color.tip-bg, 15%), (brand-color.background, 85%)),
  tip-border: color.mix((brand-color.tip-border, 15%), (brand-color.background, 85%)),
  warning-bg: color.mix((brand-color.warning-bg, 15%), (brand-color.background, 85%)),
  warning-border: color.mix((brand-color.warning-border, 15%), (brand-color.background, 85%))
)
#set page(fill: brand-color.background)
#set text(fill: brand-color.foreground)
#set table.hline(stroke: (paint: brand-color.foreground))
#set line(stroke: (paint: brand-color.foreground))
#let brand-logo = (:)
#set text()
#set par(leading: 0.8em)
#show heading: set text(font: ("IM Fell English",), weight: "bold", fill: rgb("#8b0000"), )
#show raw.where(block: false): set text(size: 9pt, )
#show raw.where(block: true): set text(size: 9pt, )
#show link: set text(fill: rgb("#8b0000"), )

#set page(
  paper: "us-letter",
  margin: (bottom: 28mm,left: 22mm,right: 22mm,top: 25mm,),
  numbering: "1",
  columns: 1,
)
// Logo is handled by orange-book's cover page, not as a page background
// NOTE: marginalia.setup is called in typst-show.typ AFTER book.with()
// to ensure marginalia's margins override the book format's default margins
#import "@preview/orange-book:0.7.1": book, part, chapter, appendices

#show: book.with(
  title: [Heroes of Legend],
  subtitle: [Core Rules],
  author: "Bruce A. Moser",
  date: "2026-07-12",
  main-color: brand-color.at("primary", default: blue),
  logo: {
    let logo-info = brand-logo.at("medium", default: none)
    if logo-info != none { image(logo-info.path, alt: logo-info.at("alt", default: none)) }
  },
  outline-depth: 2,
)


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
  spacing: 0.7em,
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
#show heading.where(level: 1): set text(font: heading-font-stack)
#show heading.where(level: 2): set text(font: heading-font-stack)

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
// Reset Quarto's custom figure counters at each chapter (level-1 heading).
// Orange-book only resets kind:image and kind:table, but Quarto uses custom kinds.
// This list is generated dynamically from crossref.categories.
#show heading.where(level: 1): it => {
  counter(figure.where(kind: "quarto-float-fig")).update(0)
  counter(figure.where(kind: "quarto-float-tbl")).update(0)
  counter(figure.where(kind: "quarto-float-lst")).update(0)
  counter(figure.where(kind: "quarto-callout-Note")).update(0)
  counter(figure.where(kind: "quarto-callout-Warning")).update(0)
  counter(figure.where(kind: "quarto-callout-Caution")).update(0)
  counter(figure.where(kind: "quarto-callout-Tip")).update(0)
  counter(figure.where(kind: "quarto-callout-Important")).update(0)
  counter(math.equation).update(0)
  it
}

= Heroes of Legend
<heroes-of-legend>
Core Rules, First Edition

\
#block[
#emph["Grab your swords. Stow your spell books. Adventure awaits."]

#emph[Heroes of Legend]

]
#part[Introduction]
= Introduction
<sec-chapter-introduction>
#figure([
#box(image("chapters/../assets/images/page003-img002.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 2: Opening Chapter Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 2 --- Opening chapter decorative art. Placeholder; final art TBD. Dimensions: 185×185.]

#pagebreak()
Welcome to #emph[Heroes of Legend]. If you're holding this book, you're about to do something remarkable: build a hero, step into their boots, and tell stories you'll remember for years. This is a game about rolling dice and making choices, but mostly it's about sitting around a table with your friends and saying, "Remember that time Kael charged the dragon?"

Here's how it works. You create a hero --- a Protector, a Blade, an Arcanist, or one of five other classes, each with their own way of approaching the world. One player takes on the role of the Dungeon Architect (DA for short). The DA describes the world. You decide what your hero does. The dice tell you how it goes. That's it. That's the whole game. Everything else is details, and this book is full of them, because the details are where the magic lives.

So take a breath. You don't need to understand it all at once. This book is built to be read in pieces --- crack it open at the table when you need a rule, flip through it on the couch when you're dreaming up your next character, or read it cover to cover if that's your style. However you approach it, you're in good company. Thousands of players have sat where you're sitting now, about to discover what happens when you roll three dice and everything changes.

#pagebreak()
== What You Actually Need
<what-you-actually-need>
Pull up a chair. Let me tell you what you #emph[actually] need to play this game. I've been running tables for thirty years, and I've seen players show up with custom dice towers, hand-painted miniatures, and leather-bound notebooks that cost more than my first sword. You know what the best sessions all had in common? None of that stuff.

You need this book. Everything you need to play is in these pages --- the rules, the spells, the monsters, the advice. It's heavy enough to flatten a goblin if you throw it, but I'd recommend reading it instead.

You need dice. Three to six six-sided dice, the kind you'd find in any board game. Three for a standard roll. A couple more for when fortune smiles on you --- or doesn't. You can spend forty dollars on hand-carved obsidian dice if you want. I've done it. They're gorgeous. They roll exactly the same as the ones that came with your copy of Monopoly. Don't let anyone tell you different.

You need something to write on and something to write with. A printed character sheet, a notebook, the back of a napkin --- I've seen heroes born on all three. Your character sheet is where your hero lives when they're not in your head. Treat it with respect. Update your hit points. Track your gear. Future you will thank present you when the DA asks if anyone remembered to bring rope and you can point to your inventory and say, "Right here."

You need friends. Two to five is the sweet spot. One of you will be the DA --- the architect of dungeons, the voice of villains, the arbiter of "can I try to jump that?" The rest are heroes, each with their own goals, fears, and terrible ideas that somehow work out. Rotate who DAs if you want; the game works either way. Some of the best campaigns I've run started because someone else needed a break and I said, "Hand me the screen."

That's the list. No miniatures required. No battle mat. No hundred-dollar sourcebooks. Just you, your friends, some dice, and your imagination. Everything else is optional --- and the options are wonderful, don't get me wrong. I've got a closet full of miniatures I painted myself. But you don't #emph[need] them. You never did.

#block[
#callout(
body: 
[
One thing, though. I do recommend some graph paper or a gridded surface. Combat in #emph[Heroes of Legend] is tactical --- positioning matters, cover matters, who's standing next to whom matters. A quick sketch of the battlefield helps everyone see the fight. It's the difference between "I attack the goblin" and "I circle around the pillar, use it as cover, and strike from the goblin's blind spot." The rules work fine either way --- theater of the mind is perfectly valid --- but a rough map turns a brawl into a battle. And battles are more fun.

]
, 
title: 
[
Combat Is Tactical
]
, 
background_color: 
color.mix((rgb("#CC1914"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#CC1914")
, 
icon: 
fa-exclamation()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== How to Read This Book
<how-to-read-this-book>
This isn't a manual. It's a companion. You don't read it once and put it on a shelf; you keep it at your elbow during sessions, dog-ear the pages you need most, and discover new things every time you crack it open. Here's how to start, depending on who you are and what you need right now.

#strong[If you're a new player] and you've never rolled a d20 in your life: start with #strong[?\@sec-chapter-character-creation]. It walks you through building a character step by step, from "what do my stats mean?" to "can I buy a horse?" After that, read #strong[?\@sec-chapter-attributes] through #ref(<sec-chapter-disciplines>, supplement: [Chapter]). You don't need to memorize anything. Just read them once so you know where to look when the DA says "make a Fortitude save" and you need to know what that means. The rules will stick through play, not through study. Your first session, you'll look things up constantly. That's normal. By your fifth session, you'll be explaining grappling to the new player at the table. That's normal too.

#strong[If you're the Dungeon Architect] --- the one who's going to run the game --- you've got a slightly longer reading list. Start with #strong[?\@sec-chapter-attributes] through #ref(<sec-chapter-disciplines>, supplement: [Chapter]) to understand the mechanics. Then jump to #strong[?\@sec-chapter-gm-guidance]. That chapter is written for you: it covers building adventures, running monsters, handing out rewards, and keeping the game moving when the party decides to ignore your carefully prepared dungeon and open a bakery instead. (It happens. It always happens. There's advice for that.) After that, skim the equipment and spell chapters so you know what your players can do. You don't need to memorize every spell. You just need to know that #emph[someone] at the table can cast #emph[Water Breathing], so maybe don't hang your entire adventure on "they can't cross the lake."

#strong[If you just want to see what this game is about] --- if you're browsing, curious, trying to decide whether to bring this to your table --- read this chapter. Then read the example of play below. If it makes you want to grab some dice, call your friends, and find out what happens when Kael kicks down the door, we've done our job. Welcome aboard.

#pagebreak()
#figure([
#box(image("chapters/../assets/images/page003-img003.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 3: Introduction Second Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 3 --- Credits page art. Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
== The Core Mechanic
<the-core-mechanic>
All right. Roll up your sleeves. This is the engine that drives everything.

In #emph[Heroes of Legend], whenever you attempt something with risk --- swinging a sword, casting a spell, talking your way past a guard, climbing a crumbling wall while something with too many teeth chases you --- you reach for three six-sided dice. You roll them. You add your hero's relevant attribute. You add your skill bonus if you have one. The DA may add or subtract a modifier for difficulty. Then you look at the total. That number tells you what happens. That's it. That's the whole game, right there, in one sentence.

But numbers without context are just arithmetic. Here's what those totals #emph[feel] like at the table:

#strong[Weak (1--8):] You pull it off, but barely. The lock clicks open as the guard's footsteps round the corner. You scale the wall but your rope frays and you'll need a new one. Your blade finds the goblin but it's a glancing blow --- he's bleeding, he's angry, he's still standing. Weak successes are the game's way of saying "yes, but." The story moves forward. You just might not like how.

#strong[Standard (9--14):] Clean, professional work. The spell fires true. The lie lands. The ancient text yields its secrets. This is what trained competence looks like --- the lock opens, the arrow flies straight, the negotiation goes your way. Standard results are the backbone of the game. They happen most often. They make you feel capable without making you feel invincible.

#strong[Strong (15--18+):] You make it look easy. The crowd gasps. The enemy reels. The thing you were trying to do? You did it so well that something extra happens --- bonus damage, bonus information, a moment of pure triumph that'll have the table on its feet. Strong results are rare enough to feel special and common enough to feel earned. This is why you trained. This is the moment you'll be talking about after the session.

Three natural 6s is a #strong[Critical] --- automatic Strong plus a bonus effect. The dice came up 6, 6, 6. The table erupts. Three natural 1s is a #strong[Fumble] --- automatic failure with a twist. Something has gone spectacularly, memorably wrong. Both happen about once every 200 rolls. When they do, they're not just numbers. They're stories.

That's the engine. Everything else in this book --- skills, spells, equipment, monsters --- hangs on that one roll. The 3d6. The bell curve. The three tiers of success. Master this and you've mastered the game. Everything else is just knowing when to roll and what to add.

Now go grab three dice. Roll them. Look at the numbers. Imagine adding your best attribute --- the thing your hero is #emph[exceptional] at. That's a Strong. Now imagine adding nothing, just raw luck. That's probably a Standard. Now imagine rolling three ones. That's the universe laughing at you. It happens to everyone. Even heroes.

#pagebreak()
== A Note About Hitting Things
<a-note-about-hitting-things>
Let me tell you something that might surprise you.

In #emph[Heroes of Legend], attacks always hit. Always. Read that again. When you swing your sword at a goblin, you connect. When you hurl a firebolt at a troll, it lands. Every. Single. Time.

This is not how most games work. In most games, you roll to see #emph[if] you hit. If you miss, your turn ends. Nothing happens. The table checks their phones. The dragon you're fighting stands there, entirely unharmed, while four heroes take turns swinging at the air around it. That's not drama. That's dead air.

In #emph[Heroes of Legend], the question isn't #emph[whether] you hit. It's #emph[how hard.] Your 3d6 roll determines the damage tier --- Weak, Standard, or Strong. A Weak hit is a glancing blow that still draws blood. A Standard hit is a solid strike. A Strong hit is the kind of blow that makes the enemy reconsider every choice that led them to this moment. Something always happens. Every swing advances the fight. Every round, the board changes.

This keeps combat fast, cinematic, and dangerous. You can't stack armor so high that goblins can't touch you. Every attack lands. Armor reduces damage instead of preventing hits --- the knight in plate mail still gets knocked around, they just stay standing longer. Combat becomes about who's left standing, not about who finally rolled high enough to participate.

#block[
#callout(
body: 
[
Think about your favorite fantasy fight scenes. The duel on the cliff. The desperate last stand in the throne room. The ambush in the forest. How often does the hero swing and completely miss? Almost never. They clash. They parry. They take glancing blows. Contact happens. The always-hit rule means the fiction at your table feels like the fiction in your head --- every exchange matters, every blow counts, and nobody spends their turn accomplishing nothing.

]
, 
title: 
[
Why Always-Hit?
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Example of Play
<example-of-play>
Kael is a dwarf Blade --- a shadow on the wall, the last face his enemies see. He strikes with precision, not fury, and his light blades find the gaps in any armor. Lyra is a halfling Odd, an unpredictable wildcard whose enemies never know what she'll do next --- and neither do her friends, honestly. Their DA, Morgan, has been running them through a goblin-infested ruin for the past hour. They've just kicked down the door to the chieftain's chamber.

#strong[Morgan (DA):] "The goblin chieftain rises from his throne of salvaged shields. He's easily seven feet of scar tissue and bad decisions. He raises a rusted axe the size of your torso and bellows something in Goblin that probably isn't a compliment. What do you do?"

#strong[Kael:] "I draw my longsword and step forward. 'You're in my spot.' I strike."

#strong[Morgan:] "Roll 3d6."

#emph[Kael grabs three dice. The table goes quiet. He shakes them in his hand --- everyone has their ritual --- and lets them fly.]

#emph[Kael rolls:] "Four, three, five. That's twelve. My Brawn is +2, and I've got Blade Fighting at Adept, so that's another +2. Total is sixteen."

#strong[Morgan:] "Sixteen is Strong. Your longsword's Strong damage is 5."

#strong[Kael:] "The goblin has no armor. That's 5 damage straight through."

#strong[Morgan:] "Your blade cleaves through the chieftain's crude leather armor like it isn't there. He staggers backward, eyes wide --- nobody's made him bleed in years. The remaining goblins go quiet. Their champion just took a hit that would have killed any of them. For one breath, the whole room is still."

#strong[Lyra:] "While he's distracted and everyone's staring at Kael, I want to slip behind the throne and check for anything valuable. Or explosive. Ideally both."

#strong[Morgan:] "Give me a Stealth roll. The goblins are watching Kael, so I'll say Standard difficulty, no modifier."

#emph[Lyra rolls. She doesn't shake the dice --- she just drops them, casual, like she's not doing anything important.]

#emph[Lyra rolls:] "Five, four, six. That's fifteen. Agility +2, Stealth Adept +2. Nineteen total."

#strong[Morgan:] "Strong. You ghost past the goblin guards like you were never there. Behind the throne you find a locked chest. Also, what looks like a half-empty keg of something that smells powerfully flammable."

#strong[Kael:] "I like where this is going."

#strong[Morgan:] "I thought you might."

This is #emph[Heroes of Legend.] Every roll drives the story forward. Every success tier changes the scene. And sometimes, just sometimes, you find an explosive keg behind the boss's chair. What you do with it --- that's up to you.

#pagebreak()
== Design Justifications: Why We Built It This Way
<sec-design-justifications>
#emph[The following notes are written in a different voice --- call it the boots-off-the-table register. You've just met the Mentor. Now meet the designer. These are the reasons behind the rules, the math we ran, the playtests we held, and the arguments we had at three in the morning that ended with someone shouting "but what if attacks ALWAYS hit?" and everyone else going quiet.]

#block[
#callout(
body: 
[
I've played casters who spent entire sessions saying "I miss." Not "I fail" --- "I #emph[miss]." As in, nothing happened. The turn ended. Next player. That's not drama. That's dead air at the table while someone checks their phone.

So we made a rule: attacks always connect. Always. You swing, you cast, you fire --- something happens. The roll doesn't ask #emph[whether] you hit. It asks #emph[how hard.] Weak damage is a glancing blow, a near-miss that still draws blood, a spell that clips the target instead of engulfing them. The fiction stays alive. Combat keeps moving. Nobody's turn is wasted.

This also means fights are inherently dangerous. You can't stack AC so high that goblins need a natural 20 to touch you. Every attack lands. Armor reduces damage instead of preventing hits, which means the knight in plate mail still gets knocked around --- they just stay standing longer. The goblins are always a threat. The dragon is always terrifying. Combat doesn't become a solved equation; it stays a fight.

]
, 
title: 
[
Always-Hit: Something Always Happens
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#block[
#callout(
body: 
[
A twenty-sided die doesn't care about your backstory. Every number from 1 to 20 has exactly the same 5% chance --- your legendary swordsman with +12 to hit has the same odds of rolling a natural 1 as the farmer who's never held a blade. That's not how competence works in stories, and it shouldn't be how it works in games.

Three six-sided dice create a bell curve. Most rolls land between 9 and 12. That means your attributes, your skills, your Disciplines --- the things you #emph[chose] for your character --- matter more than the dice. A master thief almost always sneaks past the guards. A legendary blacksmith almost never ruins the sword. When the dice #emph[do] produce triple 1s or triple 6s, it means something, because it only happens about once every 200 rolls.

We ran the math. We ran the playtests --- dozens of them, with hundreds of players, over thousands of rolls. The 3d6 curve makes GMing easier too: you can set difficulty modifiers knowing the dice will cluster around the middle, not swing wildly from "godlike" to "incompetent" on consecutive turns. Consistency is the friend of good storytelling. The dice support the fiction instead of fighting it.

]
, 
title: 
[
3d6 Instead of d20: Your Training Matters More Than Your Luck
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#block[
#callout(
body: 
[
You know what slows combat down more than anything? Rolling to hit, then rolling damage, then adding modifiers, then rolling again because someone cast a buff. Round after round. Four players, five monsters, two rolls each per attack --- the math multiplies fast.

In #emph[Heroes of Legend], weapons and spells have fixed damage values for Weak, Standard, and Strong outcomes. One roll tells you everything. You rolled a 16? That's Strong. Your longsword does 5 Strong damage. Subtract armor. Done. Next player.

This speeds up combat without sacrificing tactical depth. The interesting decisions --- positioning, maneuver choice, which enemy to target, whether to use an ability --- those are still there. We just cut out the arithmetic that wasn't adding fun. You get more combat in less time. That means more story, more exploration, more moments that aren't about arithmetic.

]
, 
title: 
[
Flat Damage: One Roll Per Attack
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#block[
#callout(
body: 
[
The old model says fighters can't learn magic and wizards can't swing swords. We think that's boring. Under the Discipline system, anyone can learn anything --- it just costs more if it's outside your class's wheelhouse.

A Protector who wants to throw a fireball needs to buy Fire and Energy Disciplines at triple cost. It'll take them levels to get there. But they #emph[can] get there. That's the difference between "no" and "yes, but expensive." Your class gives you a starting point and cheaper access to certain paths. It doesn't build walls.

We've seen what this does at the table. Characters develop in unexpected directions. The Blade who dabbles in Illusion magic. The Arcanist who learns to use a longsword --- badly, but determinedly. These aren't "broken builds." They're stories. And stories are why we're all here.

]
, 
title: 
[
Disciplines: No Class-Locked Skills
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#block[
#callout(
body: 
[
I've played a wizard in a system with spell slots. The party fought through six encounters. I was conservative with my spells, hoarding them for the final battle. We reached the boss. Everyone looked at me. I opened my mouth and said the least heroic words ever uttered at a gaming table: "I'm out of spell slots."

That's not a character moment. That's a scheduling error.

In #emph[Heroes of Legend], magic always fires. No mana. No slots. No "sorry, I used my good spell already." When you cast, the spell goes off. The roll determines whether it's a Weak sputter, a Standard blast, or a Strong inferno. You're never useless. You're never out of options. Your fire burns until #emph[you] decide it stops.

Adept and Master spells have per-encounter and per-session limits, not because we want you counting gas, but because Master-tier effects reshape the battlefield. Those limits are about spotlight management, not resource attrition. When you unleash #emph[Volcanic Eruption], it should be a moment everyone remembers --- not something you do three times before lunch.

]
, 
title: 
[
No Spell Slots: Magic Always Fires
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
= The Last Ember
<sec-chapter-opening-fiction>
#figure([
#box(image("chapters/../assets/images/page008-img004.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 4: Opening Fiction
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 4 --- Opening fiction header art (Player's Scene). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Kael pressed his back against the cold stone, breath misting in the darkness. Somewhere above, the temple groaned, ancient foundations shifting after centuries of silence. His sword hand trembled, but not from fear. The flame crawling up the blade's edge answered to him now, and it was #emph[hungry].

"Anything?" Lyra whispered beside him, her fingers tracing the runes carved into the archway. They glowed faintly blue, Knowledge, she'd said. Old Elvish. Warding glyphs.

"Just darkness," Kael said. "And something breathing."

Roric grunted, hefting his tower shield. The metal groaned, Armor Disciplines, three of them, forged into plate that had turned aside dragon fire. "Let it breathe. I'll give it something to choke on."

Zara said nothing. She rarely did. But Kael felt the air tighten, Energy gathering, the tang of ozone before lightning. She had three Wind Disciplines now. Whatever was in that darkness, it was about to meet a storm.

The glyphs flared. The warding shattered.

And the darkness #emph[moved].

Kael was first through the breach, fire blazing along his blade. #emph[3d6: 5, 4, 6, 15 plus Brawn plus skill, Strong.] The flame struck true, illuminating something vast and many-legged. It shrieked.

Lyra was already moving, her voice cutting through the chaos. "The eyes! Strike the eyes!" Knowledge had its uses.

Roric's shield slammed down, Protection flaring, a wall of steel between the monster and his friends. Zara's winds howled.

They were four heroes against the dark.

They were enough.

#horizontalrule
The thing had too many legs. That was Kael's first thought, followed immediately by the second, which was that it also had too many teeth, and the third, which was that it was moving toward Lyra.

Not on his watch.

He drove forward, flame licking from his longsword, every step a choice. The creature's attention flicked toward him, good. That was the point. The Blade draws the eye. The Blade makes the opening. The Blade trusts that someone else will finish what he starts.

Behind him, Zara's voice rose, not a shout, never a shout, but a single word in a language that predated human speech. The air around her cracked. Three Wind Disciplines didn't just summon a breeze. They summoned a hurricane in a bottle, compressed into a space the size of a fist, and then they #emph[released] it.

The creature staggered. Half its legs lost purchase on the stone floor. It skidded sideways, shrieking, and slammed into the far wall with a sound like a tree splitting in a storm.

"Now!" Lyra shouted.

Roric was already there. He didn't run, Protectors don't run. They #emph[arrive]. One moment he was beside Zara, shield raised. The next he was planted between the monster and his friends, tower shield braced, the metal humming with the impact of something that had tried to get past him and failed.

"Whatever you're going to do," Roric growled, "do it."

Lyra's hands were a blur. She wasn't casting, she was #emph[building]. A pinch of sulfur from her belt pouch. A thread of silver wire. A drop of something viscous and black that smoked when it hit the air. The Odd didn't follow the rules of magic. The Odd #emph[negotiated] with them.

"Kael!" she called. "Clear!"

He didn't ask questions. He dove sideways, rolled, came up with his blade still burning.

Lyra hurled the mixture.

It wasn't a fireball, fireballs were for Arcanists with their formulas and their precision. This was something older and meaner. It hit the creature's carapace and #emph[stuck], sizzling, eating through chitin and whatever passed for flesh beneath. The thing screamed, a sound that had no business coming from anything with a mouth.

"Zara, #emph[now!]"

Zara's second word was different. Not a command. An invitation.

The wind that answered wasn't the controlled storm of before. It was raw and hungry and it #emph[wanted] to burn. It found Lyra's concoction and the flame on Kael's blade and it fed on both, whipping them into a cyclone of fire that wrapped around the creature like a shroud.

The screaming stopped.

The fire died.

The thing, what was left of it, crumpled into a heap of smoking chitin and silence.

For a long moment, nobody spoke. The temple groaned again, settling. Dust sifted down from the ceiling. Somewhere far above, a bird called, a normal bird, a living bird, a bird that had no idea what had just happened sixty feet below it.

Roric lowered his shield. "Is it dead?"

"Very," Lyra said, trying to catch her breath. "Definitely. Probably. I'm not poking it to check."

Zara walked past them both, her robes still crackling with residual static. She knelt beside the creature's remains and studied them with the detached interest of someone examining a particularly interesting beetle. "It was a guardian," she said quietly. "Not the thing we came for. The real threat is deeper."

Kael sheathed his sword. The flame winked out, leaving the blade dark and ordinary. "Then we go deeper."

"Kael." Lyra's voice had changed, the manic energy of combat draining away, replaced by something Kael had learned to recognize. She was thinking. That was always dangerous. "The glyphs on the archway. They weren't just a ward. They were a #emph[message]. Someone wanted this place sealed. Someone who knew what they were doing."

"The same someone who built the guardian?"

"No." She shook her head. "The guardian was added later. The glyphs are older. Much older. Whoever sealed this temple wasn't trying to keep us out." She looked at the darkness ahead, the passage that led deeper into the earth. "They were trying to keep something #emph[in]."

Roric shifted his grip on his shield. "Anyone else thinking we should maybe not go deeper?"

"Anyone else thinking that's exactly why we have to?" Kael replied.

Zara stood. Her eyes were distant, the look she got when the winds were whispering things only she could hear. "There's magic ahead. Old magic. Sleeping magic." She paused. "It's starting to wake up."

Kael looked at his companions, his friends, his family, the only people in the world he trusted to have his back when the darkness moved. Lyra, with her pockets full of chaos and her grin full of trouble. Roric, with his shield and his stubbornness and his refusal to let anyone die on his watch. Zara, who spoke to storms and listened to the wind and never, ever flinched.

"All right," he said. "Here's the plan. Roric takes point. Zara stays behind him, I want you ready to hit whatever comes at us before it gets close. Lyra, you're with me. We find what's sleeping and we decide whether to wake it up or put it back to bed. Questions?"

"You're assuming I'll follow the plan," Lyra said.

"I'm assuming you'll do something more interesting than the plan, and that's why you're with me."

She grinned. "Fair."

They moved into the darkness, four heroes against whatever the ancient world had seen fit to bury. Behind them, the guardian's remains smoked and cooled. Ahead of them, something stirred, something old, something patient, something that had been waiting for a very long time.

The temple groaned once more.

And then it was silent.

The Last Ember was still burning.

#horizontalrule
#emph[To be continued in your game.]

#part[Character Creation]
= Two-Phase Creation
<two-phase-creation>
﻿\# Creating Your Hero {\#sec-chapter-character-creation}

#figure([
#box(image("chapters/../assets/images/page014-img014.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 5: Character Creation
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 5 --- Character creation chapter art. Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Building a hero takes about twenty minutes if you know what you want, or a pleasant hour if you're still exploring. Either way, you'll end up with someone worth playing. Here's how it works.

#block[
#callout(
body: 
[
Heroes of Legend uses a two-phase creation system. You build your hero's background first (Level 0, who they were before adventure called), then layer on their class training (Level 1, who they've become). Each phase has its own pool of Development Points. You spend them all or lose them, no banking. This isn't a spreadsheet. It's a story.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#block[
#callout(
body: 
[
If you've built a few heroes and you're tired of counting DP, here's your speed run. Skip the step-by-step and follow this sequence:

+ #strong[Attributes:] Spread +2, +1, +1, +0, +0, -1 (sum = +3). Put the +2 in your class's primary attribute.
+ #strong[Ancestry & Culture:] Pick any combo that fits your concept. Write down the Discipline and trait.
+ #strong[Background DP:] Take 8 + Knowledge + Fortitude DP. Buy 3-4 Novice skills and 1-2 Novice abilities. Spend every point.
+ #strong[Class:] Pick your class. Record the class Discipline and signature ability.
+ #strong[Class DP:] 8 DP. Buy 2-3 favored skills at Novice and 1-2 more abilities. Spend every point.
+ #strong[Equipment:] Take the class starting kit. Don't optimize, the first adventure will give you better gear anyway.
+ #strong[Name & Backstory:] Roll one Motivation and one Trinket from the tables below. Make up a name. Done.

You'll have a playable, effective hero in ten minutes. The nuance, the Adept maneuvers, the talent chains, the weird multiclass combos, that comes with levels. For now, you just need someone who can swing a sword and survive the first session.

]
, 
title: 
[
Quick-Build: For Experienced Players
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Phase One: Background (Level 0)
<phase-one-background-level-0>
This is who your hero was #emph[before] they picked up a sword or opened a spellbook. Every hero comes from somewhere.

=== Step 1: Concept
<step-1-concept>
Who is your hero, in one sentence? Not their stats. Not their class. Their #emph[deal]. A disgraced knight seeking redemption. A fae-touched herbalist who talks to bees. A dwarven smith who's never seen the sun and really, really wants to. Write it down. Everything else flows from this.

=== Step 2: Attributes
<step-2-attributes>
Assign scores to your six attributes that total #emph[exactly +3]:

#strong[Brawn, Fortitude, Agility, Guile, Knowledge, Reason]

Each starts at +0. Max +2, min -2. Drop one into the negatives to fund a strength elsewhere, but the sum across all six must be 3. See #strong[?\@sec-chapter-attributes] for the full breakdown.

=== Step 3: Ancestry
<step-3-ancestry>
Choose your species. Each grants a Discipline and a trait:

#figure([
#table(
  columns: (35.71%, 39.29%, 25%),
  align: (auto,auto,auto,),
  table.header([Ancestry], [Discipline], [Trait],),
  table.hline(),
  [#strong[Human]], [Any one], [#strong[Versatile:] +1 DP at Level 0],
  [#strong[Elf]], [Archery or Blades], [#strong[Elven Grace:] once per session, reroll one die],
  [#strong[Dwarf]], [Axes or Armor], [#strong[Sturdy:] +2 maximum HP],
  [#strong[Halfling]], [Blades or Archery], [#strong[Lucky:] add one boon to any roll, once per session],
)
], caption: figure.caption(
position: top, 
[
Table 2.1: Ancestries
]), 
kind: "quarto-float-tbl", 
supplement: "Table", 
)
<tbl-ancestries>


See #strong[?\@sec-chapter-ancestries] for full details.

=== Step 4: Culture
<step-4-culture>
Your upbringing within your ancestry. Each culture grants a +1 bonus to one skill of your choice from its two options, plus either #emph[two specific Disciplines] that define its traditions, or #emph[one free Discipline] for adaptable cultures.

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Culture], [Skill Bonus], [Disciplines],),
  table.hline(),
  [#strong[Human]], [], [],
  [Imperial], [Persuasion or History], [Any one (free)],
  [Nomadic], [Survival or Animal Handling], [Archery + Polearms],
  [Coastal], [Athletics or Navigation], [Polearms + Protection],
  [#strong[Elf]], [], [],
  [High Elf], [Arcana or History], [Energy + Blades],
  [Wood Elf], [Stealth or Nature], [Animal + Archery],
  [Twilight Elf], [Deception or Insight], [Water + Blades],
  [#strong[Dwarf]], [], [],
  [Mountain], [Craft or Athletics], [Armor + Axes],
  [Deep], [Resilience or Lore], [Axes + Protection],
  [Hill], [History or Persuasion], [Any one (free)],
  [#strong[Halfling]], [], [],
  [Riverfolk], [Acrobatics or Sleight of Hand], [Blades + Archery],
  [Burrower], [Stealth or Survival], [Protection + Blades],
  [Wanderer], [Streetwise or Performance], [Any one (free)],
)
See #strong[?\@sec-chapter-ancestries] for full descriptions of each culture.

=== Step 5: Spend Background DP
<step-5-spend-background-dp>
Your hero didn't spring from the earth fully formed. They had a life before this, years of work, study, mistakes, and hard-won lessons. That life is what Background DP represents.

You have #strong[8 + Knowledge + Fortitude] Development Points to spend.

#block[
#callout(
body: 
[
#strong[Knowledge] measures education and capacity to learn. #strong[Fortitude] measures stamina, how much training your body could endure before it gave out. Together, they represent how much you absorbed from your upbringing.

A farm kid with +2 Fortitude learned through years of grueling physical labor. A temple scholar with +2 Knowledge learned through decades of study. A character with both advantages is exceptional. A character with neither had a harder start, and hard starts make the best stories.

]
, 
title: 
[
Why Knowledge and Fortitude?
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
These points represent your #strong[entire life] before Level 1. They do not carry over into your class training. Spend every last one. Unspent Background DP is potential you never realized, lessons you could have learned but didn't.

#strong[What You Can Buy]

At Level 1, you are a #strong[Novice]. You cannot buy Adept or Master tier anything, those unlock later, through experience.

Costs below are #strong[X1 (Favored)], your class may multiply these. See #strong[?\@sec-chapter-classes] for your class's multipliers. Abilities are always 1/2/4 DP regardless of class.

#table(
  columns: (37.04%, 37.04%, 25.93%),
  align: (auto,auto,auto,),
  table.header([Purchase], [Cost (X1)], [Notes],),
  table.hline(),
  [#strong[Skill (Novice)]], [1 DP], [+1 bonus. Adept (2 DP) at Level 3. Master (3 DP) at Level 7.],
  [#strong[Ability (Novice)]], [1 DP], [Martial, magical, or talent, all abilities follow 1/2/4 DP. Adept at Level 3. Master at Level 7.],
  [#strong[Discipline (first rank)]], [1 DP], [First rank in a given type. No level gate.],
  [#strong[Discipline (second rank)]], [2 DP], [Deepening the same type. Stacks for ability prereqs.],
  [#strong[Discipline (third rank)]], [4 DP], [Mastery. Three ranks in Fire = serious flame.],
)
These represent everything your hero learned growing up. A farm kid might take Athletics and Animal Handling. A temple acolyte might take Religion and Medicine. A street thief might take Stealth and Sleight of Hand. Make it make sense for your concept, the DA will notice.

#strong[General Disciplines]

All characters begin with #strong[3 General Disciplines]. These are wildcards: you assign each one to any Discipline type you choose, right now, for free. They represent natural aptitude, the things you were born with, not the things you trained for.

Your ancestry and culture also grant Disciplines (see Steps 3 and 4). Between General, ancestry, and culture, a starting hero typically has 5-7 Disciplines before spending a single DP. That's your foundation. Spend your Background DP to build on it.

#pagebreak()
#figure([
#box(image("chapters/../assets/images/page015-img015.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 6: Character Creation Second
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 6 --- Character creation second art. Placeholder; final art TBD. Dimensions: 679×679.]

#pagebreak()
== Phase Two: Class (Level 1)
<phase-two-class-level-1>
Now your hero finds their calling. This is where they become exceptional.

=== Step 6: Choose Your Class
<step-6-choose-your-class>
#figure([
#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Class], [Role], [Vibe],),
  table.hline(),
  [#strong[Protector]], [Tank, defender], ["Stand behind me."],
  [#strong[Blade]], [Assassin, precision], ["Strike once. Strike true."],
  [#strong[Arcanist]], [Arcane caster], ["Fire answers to me."],
  [#strong[Shepherd]], [Divine guide], ["The light guides my hand."],
  [#strong[Intellect]], [Scholar, strategist], ["I've read about this."],
  [#strong[Odd]], [Chaos wildcard], ["I have a trick for that."],
  [#strong[Leader]], [Commander], ["Together, we are unstoppable."],
  [#strong[Unbalanced]], [High-risk power], ["Power has a price."],
)
], caption: figure.caption(
position: top, 
[
Table 2.2: Classes at a Glance
]), 
kind: "quarto-float-tbl", 
supplement: "Table", 
)
<tbl-classes>


Record your Class Discipline (one rank) and signature ability. See #strong[?\@sec-chapter-classes] for full writeups, including favored costs.

=== Step 7: Spend Class DP
<step-7-spend-class-dp>
You have #strong[8 DP] for your class training. Again: spend every one. This is where you buy skills and abilities, combat techniques, spells, and talents are all just abilities with different flavors. Your class lists favored skills (X1) and favored Disciplines (X1); everything else costs X2 or X3. Abilities always cost 1/2/4 DP, their real gate is Discipline prerequisites. Lean into what your class does best.

Adept-tier skills and abilities unlock at Level 3. Master-tier at Level 7. At Level 1, everything you buy is Novice. That's fine. Novice means you're trained. You'll deepen later.

=== Step 8: Equipment
<step-8-equipment>
Receive your class starting kit. Record weapons with their Weak, Standard, and Strong damage values. Record armor with its Damage Reduction. See #strong[?\@sec-chapter-equipment].

=== Step 9: Derived Stats
<step-9-derived-stats>
#figure([
#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Stat], [Formula],),
  table.hline(),
  [#strong[Health Points]], [10 + Brawn (at Level 1)],
  [#strong[HP per Level]], [+Brawn (minimum 1) each level after first],
  [#strong[Initiative]], [Agility modifier],
  [#strong[Movement]], [30 ft (reduced by heavy armor)],
  [#strong[Carry Slots]], [10 + (Brawn x 5)],
)
], caption: figure.caption(
position: top, 
[
Table 2.3: Derived Statistics
]), 
kind: "quarto-float-tbl", 
supplement: "Table", 
)
<tbl-derived-stats>


=== Step 10: Backstory Touches
<step-10-backstory-touches>
Roll or choose from the tables below. These are hooks for your DA, and for you.

#strong[Motivations (d6)]

#table(
  columns: (17.39%, 82.61%),
  align: (auto,auto,),
  table.header([d6], [Why You Adventure],),
  table.hline(),
  [1], [#strong[Glory:] You want songs sung about you.],
  [2], [#strong[Gold:] Wealth opens every door.],
  [3], [#strong[Justice:] Wrongs will be righted. By you.],
  [4], [#strong[Knowledge:] Secrets are the real treasure.],
  [5], [#strong[Protection:] Someone has to stand between the darkness and the innocent.],
  [6], [#strong[Redemption:] You're running from something. Or toward forgiveness.],
)
#strong[Trinkets (d6)]

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([d6], [The Thing You Carry],),
  table.hline(),
  [1], [A key that doesn't fit any lock you've found. Yet.],
  [2], [A locket with a portrait of someone you've never met.],
  [3], [A coin that always lands on its edge.],
  [4], [A letter, unopened. The seal is your family crest.],
  [5], [A smooth stone that hums faintly at midnight.],
  [6], [A child's drawing of you. You don't recognize the child.],
)
=== Step 11: Name
<step-11-name>
Choose a name fitting your ancestry and culture. Say it out loud. Does it feel right? Good. Welcome to Heroes of Legend.

#pagebreak()
== Worked Example: Makeva Quickfoot
<worked-example-makeva-quickfoot>
Let's build a character from scratch so you can see how the pieces fit together.

#strong[Step 1, Concept:] Charming sneak-thief with a heart of tarnished gold. Grew up on the docks, talks her way into places she shouldn't be, always has an exit strategy.

#strong[Step 2, Attributes (total must be +3):] Agility +1 (nimble), Guile +1 (silver tongue), Brawn +1 (can throw a punch when the talking stops). Fortitude +0, Knowledge +0, Reason +0. Sum = +3. ?

#strong[Step 3, Ancestry:] Halfling. Gains one Blades or Archery Discipline and the #strong[Lucky] trait (add one boon to any roll, once per session).

#strong[Step 4, Culture:] Riverfolk. +1 bonus to Acrobatics (she grew up scrambling across rigging and wet docks).

#strong[Step 5, Background DP (8 + Knowledge 0 + Fortitude 0 = 8 DP):]

- Stealth Novice (1 DP), she's good at not being seen
- Deception Novice (1 DP), she's better at being believed
- Sleight of Hand Novice (1 DP), quick fingers, quicker pockets
- Perception Novice (1 DP), reading a room keeps you alive
- Streetwise Novice (1 DP), knows every fence in the harbor district
- Acrobatics Novice (1 DP), never met a rooftop she couldn't cross
- Water Discipline (1 DP), the river's in her blood
- Lucky talent, Novice (1 DP), some people are just born fortunate

Total: 8 DP. All spent. ? \
Disciplines: Animal(1), Water(1), General(3)

#strong[Step 6, Class:] Odd. Gains 3 Disciplines from different categories (Archery, Animal, Water). Signature: #strong[Wildcard], once per session, roll a d6 table for a random bonus.

#strong[Step 7, Class DP (8 DP):]

- Archery Discipline (1 DP)
- Bow Fighting Novice (1 DP, favored)
- Stealth ? Adept (2 DP)
- Deception ? Adept (2 DP)
- Evasion Novice (1 DP)
- Dirty Fighting Novice (1 DP)

Total: 8 DP. All spent. ?

#strong[Step 8, Equipment:] Shortbow (W/S/S: 2/4/7), dagger (1/3/5), leather armor (DR 2), thieves' tools, 20 arrows.

#strong[Step 9, Derived Stats:] HP 10 (10 + Fort 0 + Know 0). Initiative +1. Movement 30 ft. Carry 15 slots.

#strong[Step 10, Backstory:] Motivation, Gold (she's saving for something, she won't say what). Trinket, a silver coin that always lands on its edge.

#strong[Step 11, Name:] Makeva Quickfoot. Her friends call her Mak. Her enemies don't call her anything, they never saw her coming.

= Your Attribute Scores
<your-attribute-scores>
﻿\# Attributes {\#sec-chapter-attributes}

#figure([
#box(image("chapters/../assets/images/page015-img016.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 7: Attributes Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 7 --- Attributes chapter art. Placeholder; final art TBD. Dimensions: 493×651.]

#pagebreak()
Your hero is defined by six numbers. Don't let that fool you, those six numbers will determine whether you bend iron bars, talk your way past the guards, or accidentally set the tavern on fire. They're simple. They're powerful. They're where your hero begins.

Here's what each attribute does, in plain language:

#table(
  columns: (32.35%, 17.65%, 50%),
  align: (auto,auto,auto,),
  table.header([Attribute], [Abbr], [What It Governs],),
  table.hline(),
  [#strong[Brawn]], [BR], [Hitting harder, lifting heavy things, looking imposing],
  [#strong[Fortitude]], [FO], [Staying alive, resisting poison, marching through blizzards],
  [#strong[Agility]], [AG], [Moving fast, dodging, picking locks, shooting straight],
  [#strong[Guile]], [GU], [Lying convincingly, charming nobles, picking pockets],
  [#strong[Knowledge]], [KN], [Remembering lore, identifying monsters, speaking ancient languages],
  [#strong[Reason]], [RE], [Solving puzzles, casting spells, crafting potions],
)
#pagebreak()
Attributes range from -2 to +2. Most ordinary people sit at +0. Heroes are different, you have strengths, and you have weaknesses. That's what makes you interesting.

#table(
  columns: (21.88%, 31.25%, 46.88%),
  align: (auto,auto,auto,),
  table.header([Score], [Modifier], [What It Means],),
  table.hline(),
  [-2], [-2], [A genuine liability. The barbarian who can't read. The wizard who gets winded climbing stairs.],
  [-1], [-1], [Below average. Not your thing. You manage, barely.],
  [+0], [+0], [Competent. Normal. You can handle yourself.],
  [+1], [+1], [Talented. This is a strength. People notice.],
  [+2], [+2], [Exceptional. Olympic-level. The thing you're known for.],
)
#block[
#callout(
body: 
[
With 3d6, most rolls land between 9 and 12. That's the bell curve at work, the dice cluster around the middle. A +1 bonus shifts the entire curve. A +2 bonus is enormous.

Compare this to a d20 system, where a +1 is just 5%. On 3d6, a +1 bonus is worth about 12.5% at the center of the curve, more than double the impact. This means every attribute point matters. Every skill rank matters. You feel the difference between Brawn +1 and Brawn +2 every single session.

The -2 to +2 range keeps the math tight. A hero with Brawn +2 and a hero with Brawn -1 are only 3 points apart on the same roll, but those 3 points on a bell curve are the difference between "I contribute regularly" and "I'm a liability in a fight." The range is narrow, but the impact is wide. That's intentional.

]
, 
title: 
[
The Bell Curve: Why -2 to +2 Is the Sweet Spot
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Creating Your Hero
<creating-your-hero>
Your six attribute scores must total #emph[exactly +3]. Every attribute starts at +0. Raising one to +1 costs one point from your pool. Raising it to +2 costs two points total. If you need more points, you can drop an attribute into the negatives, each -1 gives you an extra point. But the final sum across all six must be +3. No attribute may go below -2 or above +2.

A quick way to check: add up all six modifiers. They should equal 3. If they don't, adjust until they do.

#strong[Example:] Makeva wants a charming rogue. She puts +1 in Agility (nimble fingers), +1 in Guile (silver tongue), and +1 in Brawn (can handle herself in a scrap). Her final spread: Brawn +1, Fortitude +0, Agility +1, Guile +1, Knowledge +0, Reason +0. Sum: +1+0+1+1+0+0 = +3. She's quick, persuasive, and can throw a punch, but she's no scholar and no tank. That's a choice. Choices make characters.

At levels 4, 8, 12, 16, and 20, you may increase one attribute by +1 (up to the +2 maximum). Your hero grows as they adventure.

#pagebreak()
== What Your Attributes Give You
<what-your-attributes-give-you>
#strong[Health Points at Level 1:] 10 + Brawn. This is your staying power, how many hits you can take before you go down. A dwarf with Brawn +2 starts with 12 HP. A slight fae-touched wanderer with Brawn -1 starts with 9 HP. Brawn is muscle, bone, and sheer physical resilience. After Level 1, you gain your Brawn modifier in HP each level (minimum 1).

#strong[Initiative:] Your Agility modifier. Quick people go first. That's not a rule of the game, that's a rule of the universe.

#strong[Movement:] 30 feet per round for most heroes. Heavy armor and some conditions will slow you down.

#strong[Carrying Capacity:] 10 + (Brawn x 5) inventory slots. Stronger heroes carry more. The party's tank is also the party's pack mule.

#pagebreak()
== The Six Attributes, in Detail
<the-six-attributes-in-detail>
#strong[Brawn (BR):] This is the "lift the portcullis, bend the bars, arm-wrestle the ogre" attribute. When you swing a weapon, Brawn pushes your 3d6 roll toward the Strong tier, better Brawn means more damage, not because it adds to the damage number, but because it helps you land the telling blow. Brawn also determines how much you can carry and how far you can throw things. Like goblins. Or allies.

#strong[Fortitude (FO):] Your body's refusal to quit. Fortitude sets your Health Points, helps you shake off poison, and keeps you upright when the blizzard hits. It's the attribute you don't think about until you need it, and then it's the only one that matters. A hero with Fortitude +2 can drink the dwarven ale that puts everyone else under the table.

#strong[Agility (AG):] Speed, grace, precision. Agility gets you up the wall, through the window, and out the other side before the guards finish their card game. It governs ranged combat, stealth, lockpicking, and acrobatics. It also determines who acts first when swords come out. High Agility heroes dance through fights; low Agility heroes wade through them.

#strong[Guile (GU):] The art of winning without fighting. Guile covers deception, persuasion, intimidation, and every variety of social maneuvering. It's the difference between "Let me in" and "I'm the health inspector, you really want to open this door." A hero with Guile +2 doesn't need to draw their weapon because they already convinced you to put yours down.

#strong[Knowledge (KN):] What you know. Ancient history, arcane theory, monster weaknesses, noble lineages, the price of saffron in three different ports. Knowledge is the scholar's attribute, it governs lore, investigation, and identifying creatures. It also helps determine your starting Health Points and your early-life Development Points. Smart heroes live longer.

#strong[Reason (RE):] What you #emph[do] with what you know. Reason is the engine behind spellcasting, alchemy, crafting, and puzzle-solving. Knowledge tells you that trolls fear fire; Reason tells you how to make some. A wizard with Reason +2 doesn't just know spells, they understand #emph[why] spells work, which makes them devastatingly effective.

#block[
#callout(
body: 
[
Your attribute spread isn't just numbers, it's the first sentence of your hero's biography. Brawn +2, Knowledge -1? You grew up working, not reading. Guile +2, Fortitude -1? You survived on wit, not toughness. Every combination suggests a different life. Lean into it. The mechanics will follow.

]
, 
title: 
[
Attributes Are Your Story
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Worked Examples: Each Attribute in Play
<worked-examples-each-attribute-in-play>
Knowing what an attribute #emph[governs] is one thing. Seeing it at the table is another. Here's each attribute doing its job.

=== Brawn in Play
<brawn-in-play>
The party is trapped in a collapsing tomb. The stone door is grinding shut, they have one round to get out. Roric, the dwarf Protector with Brawn +2, braces himself against the door.

#strong[The roll:] 3d6 + Brawn (+2) + Athletics Novice (+1). Roric rolls 4, 5, 3 = 12 + 3 = 15. #strong[Strong.]

The door shudders. Roric's muscles cord, his boots skid on the stone, and the door #emph[stops.] He's holding it open through sheer strength. "Go!" The party scrambles through. Roric releases the door and dives after them as it slams shut. Everyone is alive because the dwarf was strong enough to say "not today."

#strong[If he'd rolled Weak (6 or less):] The door closes halfway. Roric is stuck on the wrong side. The party has a new problem, and a new rescue mission.

=== Fortitude in Play
<fortitude-in-play>
Lyra, the halfling Odd, has been bitten by a venomous spider. The venom is working through her system, the DA calls for a Fortitude save.

#strong[The roll:] 3d6 + Fortitude (+0). Lyra rolls 5, 2, 3 = 10. #strong[Standard.]

She feels the venom burn in her veins, but her body fights it off. She's woozy. She's sweating. She's going to have a spectacular bruise. But she's not poisoned, and she's still standing. Her Fortitude isn't exceptional, but it's enough. Sometimes enough is all you need.

#strong[If she'd rolled Strong (13+):] She shrugs it off completely. The spider's venom sack was nearly empty. She doesn't even feel it. The DA describes her as "annoyingly fine."

#strong[If she'd rolled Weak (1-6):] The Poisoned condition kicks in, disadvantage on all attacks. She's in trouble. The party needs to end this fight fast or get her an antidote.

=== Agility in Play
<agility-in-play>
Kael needs to cross a crumbling bridge over a chasm. The stone is cracked, the drop is fatal, and there's no time to find another way.

#strong[The roll:] 3d6 + Agility (+2) + Acrobatics (+0, he doesn't have the skill). Kael rolls 3, 6, 4 = 13 + 2 = 15. #strong[Strong.]

He moves like a cat. Foot to stone, weight shifting, never stopping. He's across in seconds. He doesn't even look back, because he knows he made it look easy, and that's the point.

#strong[If he'd rolled Weak (1-6):] A stone crumbles under his foot. He catches himself on the edge, his fingers are the only thing between him and the abyss. The DA gives the party one round to save him before he falls. The scene just escalated.

=== Guile in Play
<guile-in-play>
Ser Aldric, the party's Leader, needs to talk his way past a checkpoint manned by the city watch. The party is carrying weapons banned within the city walls, and they don't have permits.

#strong[The roll:] 3d6 + Guile (+1) + Persuasion Adept (+2). Aldric rolls 5, 4, 3 = 12 + 3 = 15. #strong[Strong.]

"Captain." Aldric clasps the guard's hand like an old friend. "We're on Crown business. Monster hunt. You know how it is, weapons check at the gate, paperwork, delays. The beast we're tracking doesn't wait for permits. I'd consider it a personal favor if you'd wave us through. Your name goes in my report. I'll make sure the captain of the watch hears about your… flexibility."

The guard hesitates. Then nods. "Crown business. Right. Move along." He waves them through. Aldric's Guile just saved the party an hour of bureaucracy and a night in a holding cell.

#strong[If he'd rolled Weak (1-6):] The guard's eyes narrow. "Crown business, you say? Let's see your writ." The party doesn't have one. The situation is now worse than if Aldric had said nothing. A bad lie is worse than no lie at all.

=== Knowledge in Play
<knowledge-in-play>
The party discovers an ancient mural in a sunken temple. It depicts a battle between winged figures and something vast and tentacled. Understanding this mural could reveal the temple's purpose, and its dangers.

#strong[The roll:] 3d6 + Knowledge (+2) + History Novice (+1). The Intellect rolls 2, 6, 4 = 12 + 3 = 15. #strong[Strong.]

"The Celestial War," she breathes. "Third Era. The winged figures are Solari, servants of the sun god. The tentacled thing is a Void Spawn. This temple wasn't built to worship anything. It was built to #emph[contain] something." She traces the mural to a sealed door. "And that door should stay closed until we know what's behind it."

The party now has critical information, and a terrifying choice. All because the Intellect knew her history.

#strong[If she'd rolled Weak (1-6):] "It's a battle scene. Very old. Could be religious, could be historical, I'd need more time to be sure." The party proceeds without the warning. The sealed door gets opened. The Void Spawn gets released. The Knowledge check that failed just became the party's next three sessions.

=== Reason in Play
<reason-in-play>
Zara, the party's Arcanist, is trying to disable an ancient magical ward blocking the temple's inner sanctum. The ward is complex, layers of protective energy woven together over centuries.

#strong[The roll:] 3d6 + Reason (+2) + Arcana Adept (+2). Zara rolls 1, 6, 5 = 12 + 4 = 16. #strong[Strong.]

She doesn't just disable the ward, she #emph[understands] it. "The outer layer is a deterrent, flash and noise. The inner layer is the real threat. Dispel the inner layer first, and the outer layer collapses on its own." She traces the correct sigils in the air. The ward flickers, hums, and fades. The door opens. Clean. Professional. Reason at work.

#strong[If she'd rolled Weak (1-6):] The ward triggers. A blast of force throws Zara across the room. She takes 2 damage and the ward is still active, now glowing brighter, pulsing with renewed energy. The party knows the ward is dangerous. They don't know how to disarm it. Reason failed, and now they need a new plan.

= Ancestry Is Flavor, Not Fate
<ancestry-is-flavor-not-fate>
﻿\# Ancestries & Cultures {\#sec-chapter-ancestries}

#figure([
#box(image("chapters/../assets/images/page016-img017.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 8: Ancestries Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 8 --- Ancestries & cultures chapter art. Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Your hero comes from somewhere. They have a people, a homeland, a way of life that shaped them before they ever picked up a sword. Ancestry is who you're born as. Culture is how you were raised. Together, they're the first chapter of your hero's story.

#block[
#callout(
body: 
[
A dwarf raised by elves is different from a dwarf raised in the mountain holds. Your ancestry gives you a Discipline and a trait, your biology, essentially. Your culture gives you skills and perspective, your upbringing. You can mix any ancestry with any culture. The gruff mountain dwarf raised by halfling riverfolk is not only allowed, it's #emph[interesting].

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#block[
#callout(
body: 
[
The system is built for unusual combinations. Here's what different mixes look like at the table:

#strong[Dwarf + Coastal Culture:] You grew up on the surface, working the docks. You're stronger than the human sailors and twice as stubborn. Your Axes Discipline came from splitting hull planks, not mining ore. The sea's salt is in your beard, and you don't trust anything that doesn't have a keel.

#strong[Elf + Nomadic Culture:] Your people left the ancient forests generations ago. You ride with the herds under open sky, your bow always strung. The other elves call you "the lost ones." You call yourselves "the free ones." Archery and Polearms, you hunt from horseback and fight from the saddle.

#strong[Halfling + Mountain Culture:] You were raised in dwarven halls, the only halfling in a clan of stoneworkers. You're short even for your kind, but your arms are corded from the forge. You wield a smith's hammer like other halflings wield a butter knife. The dwarves call you "Little Anvil." It's not an insult.

#strong[Human + Twilight Elf Culture:] You were adopted by twilight elves, raised in the half-light, trained in shadow and blade. You don't have elven grace or elven lifespan, but you have their training. Water Discipline flows through you. The darkness is your ally, not your enemy.

The rules support any combination. The stories are yours to tell. Pick what excites you. The DA will help you make it work in the world.

]
, 
title: 
[
Mixing Ancestry and Culture: The Combinator's Guide
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== The Four Ancestries
<the-four-ancestries>
#table(
  columns: (21.28%, 23.4%, 14.89%, 40.43%),
  align: (auto,auto,auto,auto,),
  table.header([Ancestry], [Discipline], [Trait], [You're Probably…],),
  table.hline(),
  [#strong[Human]], [Any one], [#strong[Versatile:] +1 DP at Level 0], [Ambitious, adaptable, everywhere],
  [#strong[Elf]], [Archery or Blades], [#strong[Elven Grace:] once per session, reroll one die of your 3d6 roll], [Ancient, graceful, a little haunted],
  [#strong[Dwarf]], [Axes or Armor], [#strong[Sturdy:] +2 maximum HP], [Resilient, tradition-bound, impossible to move],
  [#strong[Halfling]], [Blades or Archery], [#strong[Lucky:] add one boon to any roll, once per session], [Quick, cheerful, underestimated],
)
=== Human
<human>
#emph["We're not the strongest or the fastest. But we're still here, aren't we?"]

Humans are the most numerous and most varied of the ancestries. They build empires and burn them down. They forget history and rediscover it. What they lack in specialization they make up for in sheer adaptability, a human can be anything, and usually is.

I've fought beside humans for thirty years. I've seen a human farm girl pick up her father's sword and hold a bridge against six goblins. I've seen a human scholar talk a dragon into sparing a village, not with magic, just with words and sheer nerve. Humans don't live long enough to master any one thing, so they learn a little of everything. When the moment calls for something they don't know, they figure it out. That's the human gift. Not power. Adaptability.

Humans receive one Discipline of any type and one extra Development Point at Level 0. They're the only ancestry with no fixed Discipline, that flexibility is the human superpower.

#emph[Common human names:] Aldric, Brenna, Corwin, Della, Egon, Marta, Oswin, Petra, Rolf, Sigrid.

=== Elf
<elf>
#emph["The trees remember your great-grandfather. So do we."]

Elves live long enough to see mountains erode. They carry the weight of ancient pacts, forgotten wars, and songs written before human beings discovered fire. This makes them patient, precise, and occasionally insufferable at dinner parties.

An elf who's walked the world for three centuries has seen every trick, every betrayal, every miracle twice. They don't rush. They don't panic. When the party is scrambling and the torches are guttering and everyone's yelling at once, the elf is the one leaning against the wall, waiting for the right moment. That moment always comes. Elves have the patience to wait for it.

Elves receive one Archery Discipline (bow, precision, ranged mastery) or Blades Discipline (sword, finesse, dueling). Their #strong[Elven Grace] lets them reroll one die of their 3d6 roll, once per session, centuries of practice distill into a single perfect moment.

#emph[Common elf names:] Aelindra, Caerwyn, Elowen, Faelan, Illyria, Lirael, Orin, Sylvara, Theron, Vaelith.

=== Dwarf
<dwarf>
#emph["Measure twice. Strike once. Bury deep."]

Dwarves are built like the mountains they call home, solid, enduring, and extremely difficult to move once they've made up their minds. They invented metallurgy, perfected stonework, and hold grudges longer than most civilizations last.

Here's what you need to know about fighting alongside a dwarf: they will not retreat. They will not break. You can drop a ceiling on them and they'll crawl out of the rubble, dust off their beard, and ask if that's the best you've got. That +2 HP from Sturdy isn't just a number, it's a statement. Dwarves are harder to kill because they refuse to die.

Dwarves receive one Axes Discipline (brutal chopping, cleaving power) or Armor Discipline (heavy armor, damage soaking). Their #strong[Sturdy] constitution grants +2 maximum HP, that's two more hits they can shrug off with a grunt.

#emph[Common dwarf names:] Baldrek, Darin, Gorma, Haldra, Kazrik, Morin, Naldra, Rurik, Thaldrin, Ulfgar.

=== Halfling
<halfling>
#emph["Big things come in small packages. Also: breakfast, second breakfast, and elevenses."]

Halflings are small, quick, and possessed of an almost supernatural luck that makes other ancestries quietly furious. They don't build empires. They build communities, feast halls, and improbably comfortable burrows. They're underestimated constantly, which suits them perfectly.

I've watched a halfling pick a lock with a hairpin while a guard stood three feet away. I've seen a halfling talk a crime lord into retirement over a shared pipe and a bottle of something questionable. Halflings survive because the universe looks at them and thinks "what harm could they possibly do?", and by the time the universe realizes its mistake, the halfling is already three miles away with your wallet.

Halflings receive one Blades Discipline (daggers, short swords, quick strikes) or Archery Discipline (slings, thrown weapons, ranged precision). Their #strong[Lucky] trait lets them add one boon (an extra d6) to any 3d6 roll, once per session. When the moment is desperate and the odds are against you, the universe cuts you a break. That's not luck. That's being a halfling.

#emph[Common halfling names:] Bramble, Cora, Dabney, Eglantine, Finn, Lottie, Makeva, Nettle, Pip, Rufus, Tansy.

#pagebreak()
#figure([
#box(image("chapters/../assets/images/page016-img018.png", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 9: Ancestries Art Second
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 9 --- Ancestries & cultures second art. Placeholder; final art TBD. Dimensions: 681×1024.]

#pagebreak()
== Cultures
<cultures>
Your culture is how you were raised. It's not just flavor, it's the skills and Disciplines that shaped your hero before they ever held a sword. Each culture grants a #emph[\+1 skill bonus] and either #emph[two specific Disciplines] that define its traditions, or #emph[one free Discipline] for cultures built on adaptability. Pick the one that fits your story.

=== Human Cultures
<human-cultures>
#table(
  columns: (18%, 24%, 26%, 32%),
  align: (auto,auto,auto,auto,),
  table.header([Culture], [Skill Bonus], [Disciplines], [You Grew Up…],),
  table.hline(),
  [#strong[Imperial]], [Persuasion or History], [Any one (free choice)], [In the heart of an empire. Politics, protocol, and the art of getting what you want with a smile. Imperial education is broad, you found your own path.],
  [#strong[Nomadic]], [Survival or Animal Handling], [Archery + Polearms], [Following the herds, reading the stars. You can start a fire in a monsoon and never get lost. Bow for the hunt, lance for the fight.],
  [#strong[Coastal]], [Athletics or Navigation], [Polearms + Protection], [Salt in your hair, sand between your toes. You swim before you walk. Harpoon in hand, shield on arm, the sea provides, but it also threatens.],
)
=== Elf Cultures
<elf-cultures>
#table(
  columns: (18%, 24%, 26%, 32%),
  align: (auto,auto,auto,auto,),
  table.header([Culture], [Skill Bonus], [Disciplines], [You Grew Up…],),
  table.hline(),
  [#strong[High Elf]], [Arcana or History], [Energy + Blades], [Among spires of crystal and libraries of starlight. Raw magic flows through your education, and the blade dances in your hand.],
  [#strong[Wood Elf]], [Stealth or Nature], [Animal + Archery], [In forests so ancient the trees have opinions. You run with beasts, and your arrows find their mark before your prey knows you're there.],
  [#strong[Twilight Elf]], [Deception or Insight], [Water + Blades], [In the places between light and shadow. Your people walked away from the sun long ago, mastering the blade in darkness as cold and fluid as deep water.],
)
=== Dwarf Cultures
<dwarf-cultures>
#table(
  columns: (18%, 24%, 26%, 32%),
  align: (auto,auto,auto,auto,),
  table.header([Culture], [Skill Bonus], [Disciplines], [You Grew Up…],),
  table.hline(),
  [#strong[Mountain]], [Craft or Athletics], [Armor + Axes], [In the high peaks, where the air is thin and the stone is stubborn. You forge steel and wear it like a second skin. Your axe is an heirloom; your armor, a resume.],
  [#strong[Deep]], [Resilience or Lore], [Axes + Protection], [In halls carved miles beneath the surface. Darkness is comforting. You fight in tight tunnels where there's no room for fancy footwork, just your axe, your shield-arm, and the stone at your back.],
  [#strong[Hill]], [History or Persuasion], [Any one (free choice)], [In the foothills, trading with surface folk. You're the dwarf who explains dwarves to everyone else, you've picked up a little of everything.],
)
=== Halfling Cultures
<halfling-cultures>
#table(
  columns: (18%, 24%, 26%, 32%),
  align: (auto,auto,auto,auto,),
  table.header([Culture], [Skill Bonus], [Disciplines], [You Grew Up…],),
  table.hline(),
  [#strong[Riverfolk]], [Acrobatics or Sleight of Hand], [Blades + Archery], [On boats and barges, navigating rivers and trade routes. You can walk a gunwale in a storm. Dagger close, sling far, you're ready for whatever comes down the river.],
  [#strong[Burrower]], [Stealth or Survival], [Protection + Blades], [In cozy tunnels beneath the hills, hidden from big folk and their big problems. You know every root, every mushroom, every hidden exit. When trouble comes knocking, your blade is ready and your home is your fortress.],
  [#strong[Wanderer]], [Streetwise or Performance], [Any one (free choice)], [On the road, in the caravans, telling stories for supper. Home is wherever you hang your hat. You've learned a little of everything.],
)
= Classes Shape Costs, Not Limits
<classes-shape-costs-not-limits>
﻿\# Classes {\#sec-chapter-classes}

#figure([
#box(image("chapters/../assets/images/page017-img019.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 10: Classes Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 10 --- Classes chapter art (Culture art). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Your class is your hero's calling. It's not a job, it's who you are when the torches gutter and the door slams shut behind you. Eight classes. Eight ways to face the darkness. Pick the one that makes you grin.

#block[
#callout(
body: 
[
Your class gives you a Discipline, a signature ability, and cheaper access to certain skills and Disciplines. It does not restrict what you can buy, only what comes easily. A Protector who studies Arcana pays more for it. That's the point. Be unusual, just know it'll cost you.

]
, 
title: 
[
Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Class Overview
<class-overview>
#table(
  columns: (18.42%, 15.79%, 36.84%, 28.95%),
  align: (auto,auto,auto,auto,),
  table.header([Class], [Role], [L1 Discipline], [Signature],),
  table.hline(),
  [#strong[Protector]], [Tank, defender], [Armor], [#strong[Bastion], defensive stance],
  [#strong[Blade]], [Assassin, precision], [Blades], [#strong[Swift Blade] + #strong[Precise Stab]],
  [#strong[Arcanist]], [Arcane caster], [Energy], [#strong[Arcane Shield]],
  [#strong[Shepherd]], [Divine guide], [Protection], [#strong[Turn Undead]],
  [#strong[Intellect]], [Scholar, strategist], [Any one], [#strong[Knowledge Is Power]],
  [#strong[Odd]], [Chaos wildcard], [Any one (different category)], [#strong[Eccentric Spellcasting]],
  [#strong[Leader]], [Commander], [Protection], [#strong[Lead by Example]],
  [#strong[Unbalanced]], [High-risk power], [Any Elemental], [#strong[Edge of Chaos]],
)
#pagebreak()
== The Protector
<the-protector>
#emph["Stand behind me."]

The Protector stands at the vanguard, using body and armor as a shield for those in their care. You are the anchor, built on Brawn and Fortitude, trained to absorb blows that would fell lesser heroes. Your pride is not in the enemies you slay but in the allies who walk away unharmed because you stood in the gap. You pursue ever-better ways to fortify your resilience while keeping the ability to strike back when needed.

#strong[Class Discipline (L1):] Armor (1)

#strong[Signature, Bastion:] Spend your movement to enter a defensive stance. Add +1 to your Protection Value for the round. At higher levels, this bonus increases.

#strong[Favored Skills (X1):] Athletics, Endurance, Intimidation, Resilience, Blades Fighting, Axe Fighting, Polearms Fighting, Heavy Weapon Fighting, Unarmed Fighting

#strong[Favored Disciplines (X1):] Armor, Protection, Blades, Axes, Polearms, Heavy Weapon, Unarmed

#strong[Out of Class (X3):] All Elemental (Fire, Earth, Wind, Water), Energy, Life, Religion, Plants, Mind, Summon. You're a wall, not a wizard.

#block[
#callout(
body: 
[
You're not "the boring one." You're the reason the Blade gets to do their job without dying. Position yourself between the monster and the squishy people. Make the DA attack you, you can take it. When you raise your shield, everyone behind it breathes easier.

]
, 
title: 
[
The Protector's Mindset
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== The Blade
<the-blade>
#emph["Strike once. Strike true. Strike last."]

The Blade masters the art of finesse and precision, favoring the swift elegance of light blades. Your expertise lies in meticulously placed stabs, exploiting vulnerabilities with the sharpness and agility of your weapons. Keyed to Guile, you weave through the battlefield, striking with calculated precision, each strike as effective as it is lethal. You are the shadow on the wall, the final face your enemies see.

#strong[Class Discipline (L1):] Blades (1)

#strong[Signature, Swift Blade:] You may use Agility instead of Brawn when attacking with blades. Gain the #strong[Precise Stab] ability, bonus damage when exploiting an opening.

#strong[Favored Skills (X1):] Acrobatics, Deception, Perception, Sleight of Hand, Stealth, Blades Fighting, Bow Fighting, Thrown Weapon, Unarmed Fighting

#strong[Favored Disciplines (X1):] Blades, Archery, Unarmed

#strong[Out of Class (X3):] Armor, Heavy Weapon, Axes, and all magical Disciplines (Fire, Earth, Wind, Water, Energy, Life, Religion, Plants, Mind, Summon). You're precision, not brute force, and certainly not magic.

#block[
#callout(
body: 
[
A Blade doesn't trade blows, they choose the moment, the angle, the vulnerability, then strike once. If the fight is fair, you've already made a mistake. Use positioning, surprise, and your allies' distractions to create openings. Your damage comes from precision, not brute force.

]
, 
title: 
[
The Blade's Mindset
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
#figure([
#box(image("chapters/../assets/images/page031-img020.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 11: Classes Second Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 11 --- Classes chapter second art (Roles intro). Placeholder; final art TBD. Dimensions: 832×1024.]

#pagebreak()
== The Arcanist
<the-arcanist>
#emph["Fire answers to me."]

The Arcanist delves into the mysteries of arcane energies, mastering their manipulation to bend the fabric of reality. Your focus is harnessing these powerful forces, channeling them into spells that devastate foes and alter the course of battle. Keyed to Knowledge, you weave complex incantations with deep understanding, summoning energies that shimmer with potential. Every spell fires. Every single one. The question is never #emph[if], only how well.

#strong[Class Discipline (L1):] Energy (1)

#strong[Signature, Arcane Shield:] As a free action, raise a protective ward that increases your Evasion by +1 for the round. At higher levels, this shield grows stronger. Once per round.

#strong[Favored Skills (X1):] Alchemy, Arcana, History, Investigation, Lore (any)

#strong[Favored Disciplines (X1):] Energy and all Elemental types (Fire, Earth, Wind, Water), Mind, Summon. Magic is what you do.

#strong[Out of Class (X3):] All weapons (Blades, Axes, Polearms, Archery, Heavy Weapon, Unarmed), Armor, Protection, Religion. You didn't spend decades studying the arcane to swing a sword.

#block[
#callout(
body: 
[
There are no spell slots. No mana. No "I'm out of spells." Your magic always goes off. Weak hit? The spell still fires, just not as hard. This changes everything about playing a caster. You're never useless. You're never out of options.

]
, 
title: 
[
Magic Always Fires
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== The Shepherd
<the-shepherd>
#emph["The light guides my hand."]

The Shepherd stands as a beacon of guidance, providing moral direction and harnessing divine energies to aid allies. Your path is one of enlightenment, using a deep connection to the divine to inspire and protect those around you. Through word and deed, you channel power into abilities that heal, shield, and uplift your companions. Keyed to Reason, your wisdom discerns the right course in the murkiest of situations, offering light in darkness. You also stand as a bulwark against the undead, creatures that have slipped beyond death's reach fear your presence.

#strong[Class Discipline (L1):] Protection (1)

#strong[Signature, Turn Undead:] Call down divine energy that ignores armor and affects only undead creatures within your presence. Your faith burns what should not walk.

#strong[Favored Skills (X1):] Medicine, Nature, Religion, Survival

#strong[Favored Disciplines (X1):] Protection, Animal, Life, Religion, Plants

#strong[Out of Class (X3):] Elemental Disciplines, Heavy Weapon, Axes, Polearms, Archery, Armor, Summon. Your power flows from faith, not formulas.

#block[
#callout(
body: 
[
Healing in Heroes of Legend is precious. HP recovery is slow outside of magic. A Shepherd in the party changes the calculus of every fight. Your allies will love you. The DA will have to work harder to threaten them.

]
, 
title: 
[
Healing Matters
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== The Intellect
<the-intellect>
#emph["I've read about this."]

The Intellect embodies cerebral prowess and scholarly mastery. Your path is a relentless pursuit of knowledge, delving into ancient tomes, unlocking the mysteries of the universe. With a mind as sharp as a finely honed blade, you navigate the world through logic and reason. Keyed to Knowledge, you are not defined by brute strength but by cunning and foresight. Through tactical acumen and strategic planning, you outmaneuver foes with calculated precision, turning their own weaknesses against them. Your words carry weight, guiding allies through the darkest times.

#strong[Class Discipline (L1):] Any one (your choice, reflecting your field)

#strong[Signature, Knowledge Is Power:] Gain +1 to all Knowledge-based skill checks. This increases at higher levels.

#strong[Favored Skills (X1):] History, Investigation, Lore (any three), Medicine, Arcana

#strong[Favored Disciplines (X1):] Energy, Mind, Life, Religion, Plants

#strong[Out of Class (X3):] Armor, Heavy Weapon, Axes, Unarmed. Your mind is your weapon, you've never needed to throw a punch.

#block[
#callout(
body: 
[
The Intellect's secondary ability lets you spend your mobility for the turn to harness pure mental power, gaining insight, revealing weaknesses, or uncovering hidden information. You may not move, but you see what no one else can.

]
, 
title: 
[
Stop and Think
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== The Odd
<the-odd>
#emph["I have a trick for that."]

The Odd embodies eccentricity and peculiarity. With a demeanor that dances on the edge of madness and a style that defies convention, you bring chaos and unpredictability to every encounter. Keyed to Guile, your appearance is striking, mismatched clothing, bizarre accessories, an unusual hairstyle. In battle, you are a whirlwind of unorthodox tactics: spells with unconventional gestures, bizarre weapons wielded with deadly precision, strange powers that defy explanation. Your adversaries never know what to expect. Sometimes, neither do you.

#strong[Class Discipline (L1):] Any one, from a #strong[different category] than your ancestry and culture Disciplines (e.g., if you already have Weapon and Defense, take an Elemental or Energy).

#strong[Signature, Eccentric Spellcasting:] Choose one arcane ability and one divine ability. You ignore prerequisite Disciplines for these two (level requirements still apply). You need no arcane focus or holy symbol.

#strong[Favored Skills (X1):] Sleight of Hand, Stealth, Streetwise, Deception, Acrobatics

#strong[Favored Disciplines (X1):] Pick 3 Disciplines of your choice at Level 1. Everything else is X2.

#strong[Out of Class (X3):] None. The Odd can make anything work, you just don't get cost breaks on everything. Your real power is #emph[Eccentric Spellcasting]: free abilities that ignore prerequisites.

#block[
#callout(
body: 
[
Once per scene, the Odd can contort their body, speak in tongues, cackle, or otherwise terrify a target they can see. It's unsettling. It's effective. It's very, very you.

]
, 
title: 
[
You're Also Scary
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== The Leader
<the-leader>
#emph["Together, we are unstoppable."]

The Leader is a beacon of courage on the battlefield, leading from the front lines with valor and resolve. Keyed to Reason, your stirring speeches and tactical acumen rally allies to action, instilling confidence even in the face of adversity. Beyond command, you serve as mentor and confidant, recognizing and nurturing the potential within each member of your group. Driven by a clear vision and unwavering commitment, you guide your companions toward a brighter future. In your presence, unity flourishes.

#strong[Class Discipline (L1):] Protection (1)

#strong[Signature, Lead by Example:] When you land a telling blow on an enemy, grant one ally who witnessed it a +2 bonus on their next roll. Your actions inspire greatness in others.

#strong[Favored Skills (X1):] Persuasion, Resilience, Perception, Insight, Blades Fighting, Polearms Fighting

#strong[Favored Disciplines (X1):] Protection, Blades, Polearms, Energy

#strong[Out of Class (X3):] Elemental Disciplines, Plants, Summon. You lead from the front, not from a spellbook.

#block[
#callout(
body: 
[
The Leader's secondary ability is #strong[Battle Cry], a thunderous shout that grants all allies within earshot a momentary surge of courage. Fear effects are suppressed. Morale is restored. The party remembers why they follow you.

]
, 
title: 
[
Battle Cry
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
#figure([
#box(image("chapters/../assets/images/page033-img021.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 12: Classes Third Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 12 --- Classes chapter third art (Protector class). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
== The Unbalanced
<the-unbalanced>
#emph["Power has a price. I'm willing to pay."]

The Unbalanced is a wild card, embodying chaos and unpredictability in every action. Your demeanor is marked by erratic energy, veering between bouts of laughter and brooding intensity. Behind your unpredictable facade lies a mind that operates on its own unique wavelength, calculating the odds even as you appear to embrace madness. In battle, you unleash pent-up frenzy with ferocious abandon, your fighting style as unpredictable as your personality. You thrive on the chaos of combat, reveling in the uncertainty of the fray.

#strong[Class Discipline (L1):] Any one Elemental (Fire, Earth, Wind, or Water)

#strong[Signature, Edge of Chaos:] On a Strong hit, deal +4 bonus damage but roll on a d6 backlash table, self-damage, a fleeting condition, or an environmental surge that affects everyone, friend and foe alike.

#strong[Favored Skills (X1):] Arcana, Deception, Insight, Intimidation, Unarmed Fighting

#strong[Favored Disciplines (X1):] Your two opposing Elemental types, plus Energy and Unarmed.

#strong[Out of Class (X3):] The two Elemental types you didn't pick, all other weapons, Armor, and Protection. You channel chaos through your body and your spells, everything else is a distraction.

From Animal, Plants, Summon, Life, Religion, and Mind, pick 2 to be X1, 2 to be X2, and 2 to be X3. The chaos bends where you choose.

#block[
#callout(
body: 
[
You're not broken. You're balanced on a knife's edge between opposing forces, and that tension is your source of power. When it works, you're the most dangerous person in the room. When it doesn't, well, that's entertaining too. The party keeps you around because when everything goes wrong, you're the one who knows what to do with wrong.

]
, 
title: 
[
Embrace the Chaos
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Progression
<progression>
You gain Development Points each level (see #strong[?\@sec-chapter-advancement] for the full progression). Spend them all, they don't carry over.

#strong[Adept] abilities unlock at Level 3. #strong[Master] abilities unlock at Level 7. Until then, everything you buy is Novice.

#pagebreak()
== Costs
<costs>
Everything you buy has a cost multiplier based on your class:

#table(
  columns: (6.25%, 27.08%, 27.08%, 39.58%),
  align: (auto,auto,auto,auto,),
  table.header([], [X1 (Favored)], [X2 (Neutral)], [X3 (Out of Class)],),
  table.hline(),
  [#strong[Skill] (N / A / M)], [1 / 2 / 3 DP], [2 / 4 / 6 DP], [3 / 6 / 9 DP],
  [#strong[Discipline] (1st / 2nd / 3rd rank)], [1 / 2 / 4 DP], [2 / 4 / 8 DP], [3 / 6 / 12 DP],
  [#strong[Ability] (N / A / M)], [1 / 2 / 4 DP], [1 / 2 / 4 DP], [1 / 2 / 4 DP],
)
#strong[Abilities always cost 1/2/4 DP] regardless of class. Their real gate is Discipline prerequisites. A Fireball needs 2 Fire + 1 Energy, if those Disciplines cost you X3, you're paying 9 DP just for the prereqs before you even buy the ability. That's the brake on out-of-class magic, not the ability cost itself.

#strong[Skills] follow the same X1/X2/X3 structure. A Protector pays 3 DP for Arcana Novice, learnable, but expensive. Each skill's X1/X2/X3 classes are listed on its card in #strong[?\@sec-chapter-skills].

#strong[Table 5.X: Weapon & Defense Discipline Costs]

#table(
  columns: (12.5%, 11.36%, 7.95%, 11.36%, 11.36%, 11.36%, 7.95%, 9.09%, 17.05%),
  align: (auto,auto,auto,auto,auto,auto,auto,auto,auto,),
  table.header([Discipline], [Protector], [Blade], [Arcanist], [Shepherd], [Intellect], [Odd#super[\*]], [Leader], [Unbalanced#super[\*]],),
  table.hline(),
  [#strong[Blades]], [X1], [X1], [X3], [X2], [X2], [X2], [X1], [X3],
  [#strong[Axes]], [X1], [X3], [X3], [X3], [X3], [X2], [X2], [X3],
  [#strong[Polearms]], [X1], [X2], [X3], [X3], [X2], [X2], [X1], [X3],
  [#strong[Archery]], [X2], [X1], [X3], [X3], [X2], [X2], [X2], [X3],
  [#strong[Heavy Weapon]], [X1], [X3], [X3], [X3], [X3], [X2], [X2], [X3],
  [#strong[Unarmed]], [X1], [X1], [X3], [X2], [X3], [X2], [X2], [X1],
  [#strong[Protection]], [X1], [X2], [X3], [X1], [X2], [X2], [X1], [X3],
  [#strong[Armor]], [X1], [X3], [X3], [X3], [X3], [X2], [X2], [X3],
)
#strong[Table 5.X: Magic & Support Discipline Costs]

#table(
  columns: (12.5%, 11.36%, 7.95%, 11.36%, 11.36%, 11.36%, 7.95%, 9.09%, 17.05%),
  align: (auto,auto,auto,auto,auto,auto,auto,auto,auto,),
  table.header([Discipline], [Protector], [Blade], [Arcanist], [Shepherd], [Intellect], [Odd#super[\*]], [Leader], [Unbalanced#super[\*]],),
  table.hline(),
  [#strong[Fire]], [X3], [X3], [X1], [X3], [X2], [X2], [X3], [X1#super[\*]],
  [#strong[Earth]], [X3], [X3], [X1], [X3], [X2], [X2], [X3], [X1#super[\*]],
  [#strong[Wind]], [X3], [X3], [X1], [X3], [X2], [X2], [X3], [X1#super[\*]],
  [#strong[Water]], [X3], [X3], [X1], [X3], [X2], [X2], [X3], [X1#super[\*]],
  [#strong[Energy]], [X3], [X3], [X1], [X2], [X1], [X2], [X1], [X1],
  [#strong[Animal]], [X2], [X3], [X2], [X1], [X2], [X2], [X2], [--],
  [#strong[Plants]], [X3], [X3], [X2], [X1], [X1], [X2], [X3], [--],
  [#strong[Summon]], [X3], [X3], [X1], [X3], [X2], [X2], [X3], [--],
  [#strong[Life]], [X3], [X3], [X2], [X1], [X1], [X2], [X2], [--],
  [#strong[Religion]], [X3], [X3], [X3], [X1], [X1], [X2], [X2], [--],
  [#strong[Mind]], [X3], [X3], [X1], [X2], [X1], [X2], [X2], [--],
)
#super[\*] Unbalanced Elemental: pick two opposing types at Level 1, those become X1. The other two become #strong[X3].

#super[\*] Unbalanced: from Animal, Plants, Summon, Life, Religion, and Mind, pick 2 to be X1, 2 to be X2, and 2 to be X3. You decide where the chaos bends in your favor.

#super[\*] Odd: pick 3 Disciplines at Level 1, those become X1. Everything else is X2. No X3 restrictions.

#part[Core Mechanics]
= The Core Roll
<the-core-roll>
﻿\# Core Resolution Mechanics {\#sec-chapter-core-resolution}

#figure([
#box(image("chapters/../assets/images/page034-img022.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 13: Core Resolution Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 13 --- Core resolution chapter art (Blade class / dice mechanics). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
This is the chapter that makes the game work. Read it once. Bookmark it. Come back when you need it. Every roll you make, every sword swing, every spell, every silver-tongued lie, runs through the system on this page.

#pagebreak()
Here it is. The whole thing:

#strong[3d6 + Attribute Modifier + Skill Bonus + Difficulty Modifier]

That's it. Roll three dice. Add the relevant number from your character sheet. Add your skill if you have one. The DA adds or subtracts for difficulty. Look at the total. Something happens. Always.

#figure([
#table(
  columns: (26.92%, 23.08%, 50%),
  align: (auto,auto,auto,),
  table.header([Total], [Tier], [What Happens],),
  table.hline(),
  [1-8], [#strong[Weak]], [You succeed, but there's a catch. The door opens, as the guard rouses from his nap. Your blade draws blood, a scratch, not a wound. The spell fires, but fizzles at the edges.],
  [9-14], [#strong[Standard]], [Clean success. Expected outcome. Professional work. This is what competence looks like, the lock clicks, the arrow flies true, the ancient text yields its secrets.],
  [15-18+], [#strong[Strong]], [You crushed it. The thing you were trying to do? You did it so well that something extra happens. Extra damage. Bonus information. The crowd applauds. This is why you trained.],
)
], caption: figure.caption(
position: top, 
[
Table 6.1: Success Tiers
]), 
kind: "quarto-float-tbl", 
supplement: "Table", 
)
<tbl-success-tiers>


#block[
#callout(
body: 
[
A single twenty-sided die is a fickle god. Every number from 1 to 20 is equally likely, your carefully built character with +7 to Stealth has the same 5% chance of rolling a 1 as the clumsy ogre in plate mail. That's not how skill works in stories, and it shouldn't be how it works in games.

Three six-sided dice create a bell curve. Most rolls land between 9 and 12. That means your training, your attributes, your skill bonuses, your Disciplines, matters #emph[more] than the dice. A master thief almost always sneaks past the guard. A legendary blacksmith almost never ruins the blade. When the dice do produce a 3 or an 18, it #emph[means] something, because it only happens about once every 200 rolls. This system makes your choices matter more than your luck. We think that's how it should be.

]
, 
title: 
[
Why 3d6? A Designer's Note
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Attack Rolls: You Always Hit
<attack-rolls-you-always-hit>
In #emph[Heroes of Legend], when you swing your weapon or hurl a spell, #emph[you connect.] Every time. The question isn't whether you hit, it's whether you hit hard enough to matter.

Your 3d6 attack roll determines the damage tier:

#strong[Weak:] Apply the weapon or spell's Weak damage value. #strong[Standard:] Apply the Standard damage value. #strong[Strong:] Apply the Strong damage value. Add any critical effects.

Armor reduces incoming damage, every point of Armor subtracts 1 from the damage you take (minimum 1 damage from any hit). A goblin with no armor takes the full 5 from a Strong longsword strike. A knight in plate armor (Armor 3) would only take 2 from that same blow.

#block[
#callout(
body: 
[
Think about your favorite movie battle. The hero never stands there missing for six seconds while the audience checks their phones. Every exchange advances the fight, a clash, a parry, a glancing blow, a telling strike. That's what always-hit delivers. Combat moves fast. Every round, something changes. Your 3d6 roll isn't "do I hit?", it's "how much does this hurt?"

]
, 
title: 
[
Why Always-Hit Makes Better Fights
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Critical Hits (Three Natural 6s)
<critical-hits-three-natural-6s>
Three sixes. The dice come up 6, 6, 6. The table erupts. You just rolled a Critical.

Critical hits are automatic #emph[Strong] results. Then roll a d6 for your bonus:

#table(
  columns: (19.05%, 80.95%),
  align: (auto,auto,),
  table.header([d6], [Critical Effect],),
  table.hline(),
  [1], [#strong[Maximum Damage.] Deal the weapon's Strong damage twice.],
  [2], [#strong[Devastating Blow.] Target is stunned, prone, or disarmed, your choice.],
  [3], [#strong[Moment of Glory.] Take a bonus action or free move immediately.],
  [4], [#strong[Second Wind.] Recover 3 HP or regain one expended ability.],
  [5], [#strong[Inspired Strike.] One ally gains advantage on their next attack against this target.],
  [6], [#strong[Narrative Flourish.] Describe something epic. The DA makes it matter.],
)
Critical hits happen about once every 216 rolls. When they do, they should feel like a lightning strike. Let the player describe it. Let the table celebrate. This is why we play.

#pagebreak()
== Fumbles (Three Natural 1s)
<fumbles-three-natural-1s>
Snake eyes, but worse. Three 1s. Something has gone spectacularly wrong.

Fumbles are automatic failures. Then roll a d6 for the complication:

#table(
  columns: (23.53%, 76.47%),
  align: (auto,auto,),
  table.header([d6], [Complication],),
  table.hline(),
  [1], [#strong[Weapon Trouble.] Drop your weapon or jam your bow. Takes an action to fix.],
  [2], [#strong[Friendly Fire.] Nearest ally takes Weak damage from your wild swing.],
  [3], [#strong[Off Balance.] The next attack against you has advantage.],
  [4], [#strong[Gear Damage.] Armor degrades one step. Shield cracks. Bowstring snaps.],
  [5], [#strong[Spell Backfire.] Take your spell's Weak damage yourself. Magic is fickle.],
  [6], [#strong[Narrative Twist.] The DA introduces an unexpected complication. Be creative.],
)
Fumbles are rare, about 1 in 216 rolls, same as criticals. They should be dramatic, memorable, and occasionally hilarious. A good fumble isn't a punishment; it's a story beat.

#pagebreak()
== Difficulty Modifiers
<difficulty-modifiers>
Not every task is created equal. The DA sets a difficulty modifier based on how hard the thing you're attempting actually is:

#figure([
#table(
  columns: (29.41%, 32.35%, 38.24%),
  align: (auto,auto,auto,),
  table.header([Modifier], [Difficulty], [Description],),
  table.hline(),
  [+4], [Trivial], [You've done this a hundred times. Rolling is a formality.],
  [+2], [Easier than normal], [Favorable conditions. You have the high ground.],
  [+0], [Standard], [A fair test of your abilities.],
  [-2], [Harder than normal], [Adverse conditions. It's dark. It's raining. The guards are alert.],
  [-4], [Very difficult], [You're attempting something improbable. Be ready to fail.],
  [-6], [Near-impossible], [The kind of thing bards write songs about, if you pull it off.],
)
], caption: figure.caption(
position: top, 
[
Table 6.2: Difficulty Modifiers
]), 
kind: "quarto-float-tbl", 
supplement: "Table", 
)
<tbl-difficulty-modifiers>


#block[
#callout(
body: 
[
Only roll when failure is interesting. If the hero has time, tools, and training, they just succeed, no roll required. The dice come out when there's pressure, risk, or a genuine chance of things going sideways.

]
, 
title: 
[
When to Roll
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Worked Examples
<worked-examples>
#strong[Kael the Blade attacks the goblin chieftain.] Kael's Brawn is +2 and his Blade Fighting skill is Adept (+2). He rolls 4+3+5=12, then adds +2+2=16. #emph[Strong!] His longsword deals 5 Strong damage. The chieftain's crude leather gives Armor 1, so he takes 4 damage. The chieftain roars, he felt that one.

#strong[Lyra the Intellect identifies an ancient rune.] Knowledge +2, no skill, difficulty -2 (it's very old and partially worn). She rolls 2+4+4=10, adds +2 for Knowledge, subtracts 2 for difficulty, total 10. #emph[Standard.] She recognizes it as Old Elvish, a warding glyph meant to keep something #emph[in], not out. That's concerning.

#strong[Roric the Protector charges the troll.] Rolls 6, 6, 6. The table erupts. #emph[Critical!] Bonus roll: 4, Second Wind, recover 3 HP. Strong damage from his greataxe: 8. The troll's tough hide (Armor 2) reduces it to 6. Still, six damage in one swing, and Roric gets his breath back. The troll's expression changes from hunger to concern.

#strong[Makeva the Odd tries to pick a lock while guards approach.] Agility +1, Lockpicking Adept (+2), but it's dark (-2 difficulty) and she's rushing (-2 more). Total modifier: +1+2-2-2 = -1. She rolls 3+3+5=11, minus 1 = 10. #emph[Standard.] The lock clicks open just as the guards' torchlight rounds the corner. She slips through the door and eases it shut behind her. Close. Very close.

= Skill Tiers
<sec-skill-tiers>
﻿\# Skills {\#sec-chapter-skills}

#figure([
#box(image("chapters/../assets/images/page035-img023.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 14: Skills Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 14 --- Skills chapter art (Arcanist class). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Skills represent what your hero has learned to do. When the dice hit the table, your skill bonus is what separates "I tried" from "I succeeded." Every hero picks up skills in their background and class training. The ones you invest in define how you solve problems, with a blade, with a spell, with a silver tongue, or with your fists.

Here's the core loop: the DA calls for a roll. You grab 3d6. You add the attribute that matches what you're attempting. Then you add your skill bonus, +1 for Novice, +2 for Adept, +3 for Master. The DA adds or subtracts for difficulty. Compare the total to the success tiers. Something happens. Always.

#pagebreak()
Skills come in three tiers. Higher tiers mean bigger bonuses and unlock maneuvers, special combat or exploration techniques you can use by spending your Maneuver for the turn.

#table(
  columns: 5,
  align: (auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [DP Cost (X1)], [DP Cost (X2)], [DP Cost (X3)],),
  table.hline(),
  [#strong[Novice]], [+1], [1 DP], [2 DP], [3 DP],
  [#strong[Adept]], [+2], [2 DP], [4 DP], [6 DP],
  [#strong[Master]], [+3], [3 DP], [6 DP], [9 DP],
)
Your class determines your cost multiplier for each skill. A Protector pays X1 for Axe Fighting and X3 for Arcana. Check each skill's card below, the X1/X2/X3 columns tell you which classes get which rates. Abilities always cost 1/2/4 DP regardless of class; their real gate is Discipline prerequisites.

#pagebreak()
== How Skills Work in Play
<how-skills-work-in-play>
When you attempt something with a meaningful chance of failure and consequence, the DA sets a difficulty and you roll. The total, 3d6 + attribute + skill + difficulty modifier, determines your success tier.

#table(
  columns: (37.14%, 20%, 42.86%),
  align: (auto,auto,auto,),
  table.header([Success Tier], [Total], [What It Means],),
  table.hline(),
  [#strong[Weak]], [1-8], [You succeed, but there's a cost, complication, or reduced effect.],
  [#strong[Standard]], [9-14], [Clean success. You do the thing you set out to do.],
  [#strong[Strong]], [15-18+], [Exceptional success. Extra effect, bonus information, or added style.],
  [#strong[Critical]], [3-6], [Automatic Strong plus a special outcome. The table erupts.],
  [#strong[Fumble]], [3-1], [Automatic failure with a serious complication.],
)
=== Difficulty Modifiers
<difficulty-modifiers-1>
The DA sets difficulty based on how hard the task is in the fiction. These numbers are subtracted from (or added to) your roll.

#table(
  columns: (32.35%, 29.41%, 38.24%),
  align: (auto,auto,auto,),
  table.header([Difficulty], [Modifier], [Example Task],),
  table.hline(),
  [#strong[Trivial]], [+4], [Climbing a knotted rope. Remembering the king's name.],
  [#strong[Easy]], [+2], [Picking a simple lock. Tracking a creature through mud.],
  [#strong[Standard]], [+0], [Most tasks. The default difficulty.],
  [#strong[Hard]], [-2], [Picking a complex lock in the dark. Lying to a suspicious guard.],
  [#strong[Very Hard]], [-4], [Swimming in armor during a storm. Recalling a thousand-year-old spell.],
  [#strong[Nearly Impossible]], [-6], [Climbing a sheer ice wall with no tools. Convincing the king you're his long-lost heir.],
)
#block[
#callout(
body: 
[
If there's no consequence for failure and no pressure, don't roll dice. Just tell the story.

The barbarian with Brawn +2 wants to kick down a normal wooden door? It breaks. No roll. The ranger with Survival Adept wants to find edible berries in a temperate forest? They find them. No roll. Rolling dice when there's nothing at stake drains tension from the moments that #emph[do] matter.

Roll when failure is interesting. Roll when the outcome is uncertain. Roll when the table is leaning forward, waiting to see what happens. Never roll just because the rules say there's a skill for it. The rules serve the story, not the other way around.

]
, 
title: 
[
When NOT to Roll
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
=== Worked Example: Skill in Action, Different Tiers, Different Outcomes
<worked-example-skill-in-action-different-tiers-different-outcomes>
Makeva Quickfoot, a halfling Odd, is trying to pick the lock on a merchant's strongbox while the merchant is distracted at the front of the shop.

#strong[The setup:] Makeva has Agility +1 and Sleight of Hand at Adept (+2). The DA rules this is Hard difficulty (-2), the lock is quality dwarven work, and she's working fast. Total modifiers: +1 (Agility) +2 (skill) -2 (difficulty) = +1.

She rolls 3d6. Let's look at three possible outcomes:

#strong[Result A, She rolls 2, 1, 3 (total 6 + 1 = 7, Standard):] The lock clicks open with a soft #emph[snick.] She slips the strongbox open, pockets the ledger inside, and closes it again. The merchant hasn't noticed a thing. Clean. Professional.

#strong[Result B, She rolls 5, 6, 4 (total 15 + 1 = 16, Strong):] The lock practically opens itself. Not only does she get the ledger, but she spots a false bottom in the strongbox, a pouch of uncut gems the merchant wasn't declaring to the tax collector. Bonus loot, and bonus leverage if she ever needs it.

#strong[Result C, She rolls 1, 2, 2 (total 5 + 1 = 6, Weak):] The lockpick snaps. The strongbox is still locked, and now there's a piece of metal visibly wedged in the mechanism. She got the ledger, barely, but the merchant is going to know someone tampered with his box the moment he checks it. The DA makes a note: #emph[the town guard will be asking questions tomorrow.]

Same skill. Same modifiers. Three different stories, all driven by the dice.

=== Worked Example: Using a Skill Maneuver in Combat
<worked-example-using-a-skill-maneuver-in-combat>
Kael, a dwarf Blade, has Blades Fighting at Adept. His Adept maneuver is #strong[Riposte], when an enemy misses him in melee, he can spend his reaction to counterattack.

#strong[The fight:] Kael is squared off against a bandit captain. The captain swings, the DA rolls for the bandit's attack. Weak result: 2 damage. Kael's leather armor (DR 2) absorbs it completely. The blade scrapes off his pauldron.

#strong[Kael:] "He missed. Riposte."

Kael spends his reaction. He makes an immediate melee attack against the captain, 3d6 + Brawn (+1) + Blades Fighting (+2). He rolls 4, 5, 4 = 13 + 3 = 16. Strong. His longsword deals 5 Strong damage. The captain's armor (DR 1) reduces it to 4.

#strong[The fiction:] The captain overcommitted. His blade glanced off Kael's shoulder, and before he could recover his guard, Kael's sword was already sliding between his ribs. That's Riposte, you miss, you bleed.

#pagebreak()
== Skill List
<skill-list>
#table(
  columns: (18.92%, 16.22%, 29.73%, 35.14%),
  align: (auto,auto,auto,auto,),
  table.header([Skill], [Attr], [Discipline], [Description],),
  table.hline(),
  [#strong[Athletics]], [BR], [,], [Climbing, swimming, jumping, feats of strength],
  [#strong[Intimidation]], [BR], [,], [Frightening foes, coercion through force],
  [#strong[Blades Fighting]], [BR], [Blades], [Fighting with swords, daggers, and light blades],
  [#strong[Axe Fighting]], [BR], [Axes], [Fighting with axes, hatchets, and cleaving weapons],
  [#strong[Polearms Fighting]], [BR], [Polearms], [Fighting with spears, halberds, and reach weapons],
  [#strong[Heavy Weapon Fighting]], [BR], [Heavy Weapon], [Fighting with greatswords, mauls, and massive weapons],
  [#strong[Unarmed Fighting]], [BR], [Unarmed], [Fists, grappling, and improvised brawling],
  [#strong[Endurance]], [FO], [,], [Resisting fatigue, holding breath, forced marches],
  [#strong[Survival]], [FO], [Animal], [Tracking, foraging, navigating wilderness],
  [#strong[Resilience]], [FO], [,], [Resisting poison, disease, extreme temperatures],
  [#strong[Acrobatics]], [AG], [,], [Balancing, tumbling, escaping restraints],
  [#strong[Stealth]], [AG], [,], [Sneaking, hiding, moving silently],
  [#strong[Bow Fighting]], [AG], [Archery], [Fighting with longbows and shortbows],
  [#strong[Thrown Weapon]], [AG], [,], [Fighting with throwing knives, axes, and javelins],
  [#strong[Crossbow Fighting]], [AG], [,], [Fighting with crossbows],
  [#strong[Sleight of Hand]], [AG], [,], [Pickpocketing, lockpicking, legerdemain],
  [#strong[Deception]], [GU], [,], [Lying, bluffing, disguising intent],
  [#strong[Persuasion]], [GU], [,], [Diplomacy, negotiation, charm],
  [#strong[Streetwise]], [GU], [,], [Gathering information, underworld contacts],
  [#strong[Arcana]], [KN], [Energy], [Magical knowledge, spell identification],
  [#strong[History]], [KN], [,], [Lore, legends, past events],
  [#strong[Investigation]], [KN], [,], [Searching, deducing, finding clues],
  [#strong[Nature]], [KN], [Animal], [Plants, animals, natural phenomena],
  [#strong[Religion]], [KN], [,], [Gods, rituals, divine lore],
  [#strong[Alchemy]], [RE], [,], [Brewing potions, identifying substances],
  [#strong[Crafting]], [RE], [,], [Smithing, woodworking, creating items],
  [#strong[Medicine]], [RE], [Animal], [Healing, diagnosis, first aid],
  [#strong[Insight]], [RE], [,], [Reading people, detecting lies, intuition],
)
#pagebreak()
#figure([
#box(image("chapters/../assets/svg/placeholder-section.svg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 33: Skills Midpoint
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 33 --- Skills chapter midpoint. Placeholder for final art. Use placeholder-section.svg dimensions: 400×300.]

#pagebreak()
== Skill Cards
<skill-cards>
Each skill card shows your #emph[X1/X2/X3] class cost tier, then the #emph[Novice], #emph[Adept], and #emph[Master] tiers. Adept and Master each unlock a maneuver, powered by your Maneuver for the turn, with a Discipline requirement.

DP costs per tier are shown in #ref(<sec-skill-tiers>, supplement: [Chapter]) at the top of this chapter. X1 classes pay the lowest cost; X3 pay the highest.

=== Blades Fighting
<sec-skill-blades-fighting>
#emph[Brawn - Blades]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Protector, Blade, Leader], [Intellect, Shepherd, Odd], [Arcanist, Unbalanced], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Riposte], Counterattack when missed in melee. Disc: Blades (2).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Flurry], Second melee attack at -2. Disc: Blades (3).],
)
=== Axe Fighting
<sec-skill-axe-fighting>
#emph[Brawn - Axes]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Protector], [Leader, Odd], [Blade, Arcanist, Shepherd, Intellect, Unbalanced], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Cleave], Drop a foe to 0 HP, carry remaining damage to adjacent enemy. Disc: Axes (2).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Sunder], Next axe attack ignores 2 DR. Disc: Axes (3).],
)
=== Polearms Fighting
<polearms-fighting>
#emph[Brawn - Polearms]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Protector, Leader], [Blade, Intellect, Odd], [Arcanist, Shepherd, Unbalanced], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Brace], Set vs charge. If charged before next turn, attack auto-deals Strong damage. Disc: Polearms (2).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Sweep], Attack all adjacent foes with one roll. Disc: Polearms (3).],
)
=== Heavy Weapon Fighting
<heavy-weapon-fighting>
#emph[Brawn - Heavy Weapon]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Protector], [Leader, Odd], [Blade, Arcanist, Shepherd, Intellect, Unbalanced], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Crushing Blow], On Standard+ hit, knock target prone. Disc: Heavy Weapon (2).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Grand Slam], Attack all creatures in 10-ft cone with one roll. Disc: Heavy Weapon (3).],
)
=== Unarmed Fighting
<unarmed-fighting>
#emph[Brawn - Unarmed]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Protector, Blade, Unbalanced], [Shepherd, Odd, Leader], [Arcanist, Intellect], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Throw], While grappling, hurl target 10 ft. Lands prone, takes Weak unarmed damage. Disc: Unarmed (2).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Stunning Strike], On Strong unarmed hit, target Stunned until end of its next turn. Disc: Unarmed (3).],
)
=== Bow Fighting
<bow-fighting>
#emph[Agility - Archery]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Blade], [Protector, Intellect, Odd, Leader, Unbalanced], [Arcanist, Shepherd], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Pin Down], Target hit with bow has disadvantage on attacks until it moves 5 ft. Disc: Archery (2).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Twin Shot], Fire second arrow at same target at -2. Disc: Archery (3).],
)
=== Thrown Weapon
<thrown-weapon>
#emph[Agility - Blades or Archery]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Blade], [Protector, Shepherd, Intellect, Odd, Leader, Unbalanced], [Arcanist], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Ricochet], Bounces to second target within 10 ft for half damage. Disc: Blades (1) or Archery (1).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Crippling Throw], On Standard+ hit, target's movement halved until end of its next turn. Disc: Blades (2) or Archery (2).],
)
=== Crossbow Fighting
<crossbow-fighting>
#emph[Agility - Archery]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [,], [Protector, Blade, Shepherd, Intellect, Odd, Leader, Unbalanced], [Arcanist], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Steady Aim], Next crossbow shot ignores cover penalties. Disc: Archery (1).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Penetrating Bolt], Bolt pierces target; creature behind takes half damage. Disc: Archery (2).],
)
=== Athletics
<athletics>
#emph[Brawn - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Protector], [Blade, Shepherd, Intellect, Odd, Leader, Unbalanced], [Arcanist], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Powerful Leap], Double jump distance this turn.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Unstoppable], Ignore difficult terrain and cannot be slowed this turn.],
)
=== Endurance
<endurance>
#emph[Fortitude - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Protector], [Blade, Arcanist, Shepherd, Intellect, Odd, Leader, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Shake It Off], Automatically succeed on a save vs poison or disease.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Second Wind], Regain HP equal to Fortitude + level. Once per combat.],
)
=== Survival
<survival>
#emph[Fortitude - Animal]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Shepherd], [Protector, Blade, Arcanist, Intellect, Odd, Leader, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Tracker's Eye], Learn direction and distance of a creature that passed within the last hour. Disc: Animal (1).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Ambush], Become hidden. Remain hidden until you attack, cast, or move. Disc: Animal (2).],
)
=== Resilience
<resilience>
#emph[Fortitude - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Protector, Leader], [Blade, Arcanist, Shepherd, Intellect, Odd, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Iron Will], Reroll a failed save vs fear or charm.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Unbroken], Ignore one condition (Frightened, Poisoned, or Stunned) for 1 round.],
)
=== Acrobatics
<acrobatics>
#emph[Agility - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Blade, Odd], [Protector, Arcanist, Shepherd, Intellect, Leader, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Tumble], Move through an enemy's space without provoking.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Evasion], On successful save vs area effect, take no damage instead of half.],
)
=== Stealth
<stealth>
#emph[Agility - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Blade, Odd], [Protector, Shepherd, Intellect, Leader, Unbalanced], [Arcanist], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Vanish], Attempt Stealth check to hide even while observed.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Shadow Step], Move 20 ft to any shadow or concealed position. No opportunity attacks.],
)
=== Sleight of Hand
<sleight-of-hand>
#emph[Agility - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Blade, Odd], [Protector, Arcanist, Shepherd, Intellect, Leader, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Quick Draw], Draw and use an item as part of the same maneuver.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Disarm], Opposed check to knock held item from target's grasp.],
)
=== Deception
<deception>
#emph[Guile - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Blade, Odd, Unbalanced], [Protector, Arcanist, Shepherd, Intellect, Leader], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Feint], Next attack against you before your next turn is at disadvantage.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Double Bluff], On Standard+ Deception check, target believes lie for 1 minute, no further checks.],
)
=== Persuasion
<persuasion>
#emph[Guile - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Leader], [Protector, Blade, Arcanist, Shepherd, Intellect, Odd, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Rally], One ally within 30 ft loses Frightened.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Command], One ally within 30 ft takes an immediate move action.],
)
=== Streetwise
<streetwise>
#emph[Guile - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Odd], [Protector, Blade, Arcanist, Shepherd, Intellect, Leader, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Contacts], Once per session, "know a person" for info, shelter, or a small favor.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Read the Room], Instantly assess social power dynamics: authority, lies, exits.],
)
=== Arcana
<arcana>
#emph[Knowledge - Energy]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Arcanist, Intellect, Unbalanced], [Shepherd, Odd, Leader], [Protector, Blade], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Identify Spell], Learn spell being cast within 60 ft: name, tier, school. Disc: Energy (1).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Counterspell], Reaction + maneuver. Arcana check vs 7 + spell tier to disrupt casting. Disc: Energy (2).],
)
=== History
<history>
#emph[Knowledge - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Arcanist, Intellect], [Protector, Blade, Shepherd, Odd, Leader, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Lore Recall], Recall a relevant historical fact, legend, or piece of ancient knowledge.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Known Weakness], DA reveals one vulnerability, resistance, or special ability of a creature known to legend.],
)
=== Investigation
<investigation>
#emph[Knowledge - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Arcanist, Intellect], [Protector, Blade, Shepherd, Odd, Leader, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Eye for Detail], Automatically spot one hidden clue, secret door, or concealed creature.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Deduction], DA provides one coherent insight connecting gathered evidence.],
)
=== Nature
<nature>
#emph[Knowledge - Animal]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Shepherd], [Arcanist, Intellect, Odd, Unbalanced], [Protector, Blade, Leader], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Beast Lore], Identify creature's type, abilities, and vulnerabilities. Disc: Animal (1).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Commune], Speak with a natural beast for 1 minute. Disc: Animal (2).],
)
=== Religion
<religion>
#emph[Knowledge - Religion]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Shepherd], [Intellect, Odd, Leader, Unbalanced], [Protector, Blade, Arcanist], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Blessing], One ally within 30 ft gains +1 on all rolls until start of your next turn.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Smite], Next attack deals bonus radiant damage equal to your Knowledge.],
)
=== Alchemy
<alchemy>
#emph[Reason - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Arcanist], [Shepherd, Intellect, Odd, Unbalanced], [Protector, Blade, Leader], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Quick Mix], Identify a potion, poison, or substance by taste/smell. Quickly mix a simple remedy.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Alchemical Bomb], Hurl explosive up to 30 ft. 2d6 elemental (fire/acid/frost) in 10-ft radius.],
)
=== Crafting
<crafting>
#emph[Reason - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [,], [Protector, Blade, Arcanist, Shepherd, Intellect, Odd, Leader, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Field Repair], Temporarily restore a broken weapon, armor, or tool for the encounter.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Jury-Rig], Improvise a simple trap, barricade, or device. Lasts until end of scene.],
)
=== Medicine
<medicine>
#emph[Reason - Animal]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Shepherd, Intellect], [Protector, Blade, Arcanist, Odd, Leader, Unbalanced], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Field Dressing], Adjacent ally stabilizes (if dying) or regains 1d6 HP. Disc: Animal (1).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Battlefield Surgery], Remove one condition from adjacent ally, or heal 3d6 HP. Disc: Animal (2).],
)
=== Insight
<insight>
#emph[Reason - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Unbalanced], [Protector, Blade, Arcanist, Shepherd, Intellect, Odd, Leader], [,], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Read Intent], Learn target's next intended action (attack, flee, cast, negotiate).],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Perfect Counter], Choose a creature. Its next attack against you is at disadvantage.],
)
=== Intimidation
<intimidation>
#emph[Brawn - , ]

#table(
  columns: (17.14%, 20%, 11.43%, 11.43%, 11.43%, 28.57%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Tier], [Bonus], [X1], [X2], [X3], [Maneuver],),
  table.hline(),
  [#strong[Novice]], [+1], [Protector, Unbalanced], [Blade, Shepherd, Intellect, Odd, Leader], [Arcanist], [,],
  [#strong[Adept]], [+2], [,], [,], [,], [#strong[Menacing Glare], One foe within 30 ft must make an immediate Morale Check.],
  [#strong[Master]], [+3], [,], [,], [,], [#strong[Terrifying Presence], All foes within 30 ft make a Morale Check at disadvantage.],
)
= Disciplines
<sec-chapter-disciplines>
#figure([
#box(image("chapters/../assets/images/page036-img024.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 15: Disciplines Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 15 --- Disciplines chapter art (Shepherd class). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Disciplines are the signature mechanic of #emph[Heroes of Legend.] They're how the game knows what your hero has mastered. Not just skills, #emph[domains of power.] Fire. Blades. Protection. The forces and forms your character has attuned to through training, study, or sheer stubborn repetition.

Here's the important part: #strong[Disciplines are prerequisites, not rolls.] You don't roll your Fire Discipline. You don't add your Blades Discipline to an attack. Disciplines are the gate, you need them to #emph[unlock] skills, abilities, and talents. Once you've got them, they represent permanent mastery. No expiration. No forgetting.

#pagebreak()
== What Are Disciplines?
<what-are-disciplines>
A Discipline represents a domain of expertise or power your hero has internalized. It's the difference between "I picked up a sword once" and "I've trained with blades for ten years." Between "I read a book about fire" and "Fire answers when I call."

#strong[Example:] A warrior with 3 Blade Disciplines has spent years mastering swords, every angle, every grip, every weakness in every guard. A mage with 3 Fire Disciplines doesn't just cast flames, they #emph[understand] flame, the way a shipwright understands wood. A ranger with 2 Animal Disciplines has bonded with the wild in ways city-folk will never comprehend.

You don't roll Disciplines. You #emph[collect] them. They're permanent markers on your character sheet that say: "I've earned this."

#pagebreak()
== The Discipline Taxonomy
<the-discipline-taxonomy>
#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Category], [Discipline], [Represents],),
  table.hline(),
  [#strong[Elemental]], [#strong[Fire]], [Flame, heat, passion, destruction],
  [], [#strong[Earth]], [Stone, stability, endurance, crafting],
  [], [#strong[Wind]], [Air, speed, storms, precision],
  [], [#strong[Water]], [Ice, flow, healing, adaptation],
  [#strong[Weapon]], [#strong[Blades]], [Swords, daggers, finesse and precision],
  [], [#strong[Axes]], [Axes, cleavers, brutal chopping power],
  [], [#strong[Polearms]], [Spears, halberds, reach and control],
  [], [#strong[Archery]], [Bows, crossbows, ranged precision],
  [], [#strong[Heavy Weapon]], [Greatswords, greataxes, mauls, two-handed power],
  [], [#strong[Unarmed]], [Fists, gauntlets, grappling, close-quarters combat],
  [#strong[Defense]], [#strong[Protection]], [Shields, warding, guarding allies],
  [], [#strong[Armor]], [Heavy armor proficiency, damage soaking],
  [#strong[Primal]], [#strong[Animal]], [Beasts, nature, shapeshifting, instinct],
  [#strong[Arcane]], [#strong[Energy]], [Raw magical force, metamagic, spellcraft],
)
Fourteen Disciplines. Five categories. Your hero's path through them defines everything they can do.

#pagebreak()
== Acquiring Disciplines
<acquiring-disciplines>
=== Starting Disciplines
<starting-disciplines>
Every character begins with #strong[3 General Disciplines.] These are flexible, they can substitute for any specific Discipline at the Novice tier. Need 1 Fire for a Firebolt? A General Discipline covers it. Need 2 Fire for a Fireball? That's Adept, you need the real thing. General Disciplines get you started, but they won't carry you to mastery.

=== Class Disciplines
<class-disciplines>
Your class hands you specific Disciplines at creation. These are your foundation, what your training, tradition, or sheer talent has already taught you:

#table(
  columns: (25%, 75%),
  align: (auto,auto,),
  table.header([Class], [Starting Disciplines],),
  table.hline(),
  [Protector], [2 Armor, 2 Protection],
  [Blade], [3 Blades],
  [Arcanist], [2 Fire, 1 Energy, 1 Wind (or any 4 elemental)],
  [Shepherd], [2 Protection, 2 Animal],
  [Intellect], [3 of any type (flexible)],
  [Odd], [3 of any type, must be from different categories],
  [Leader], [2 Protection, 1 Energy, 1 any],
  [Unbalanced], [2 of one type, 2 of its opposite (Fire/Water or Earth/Wind)],
)
=== Progression
<progression-1>
At levels 3, 6, 9, 12, 15, and 18, you gain one additional Discipline of your choice. Class-favored Disciplines, the ones your class gave you at creation, are always available. Cross-class Disciplines may require narrative justification or story events. Want your Blade to pick up Fire? Make it a story. Find a mentor. Touch a primordial flame. Earn it.

=== Magic Items
<magic-items>
Rare magic items may grant temporary or permanent Disciplines while attuned or wielded. A #emph[Sword of the Phoenix] might grant +1 Fire Discipline in your hands. Set it down, lose the power. These items are treasures, and the DA should make you work for them.

#pagebreak()
== Disciplines as Prerequisites
<disciplines-as-prerequisites>
Skills, abilities, and talents require specific Disciplines before you can learn them. No Disciplines, no purchase. It's that simple.

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Skill/Ability], [Disciplines Required], [Tier],),
  table.hline(),
  [Longsword], [2 Blades], [Adept],
  [Dagger], [1 Blade], [Novice],
  [Greataxe], [2 Axes], [Adept],
  [Fireball], [2 Fire + 1 Energy], [Adept],
  [Volcanic Eruption], [3 Fire + 1 Earth], [Master],
  [Chain Mail], [2 Armor], [Novice],
  [Shield Block], [1 Protection], [Novice],
  [Animal Companion], [2 Animal], [Adept],
  [Magic Missile], [1 Energy], [Novice],
  [Counterspell], [2 Energy + 1 Reason], [Adept],
)
=== General Disciplines Substitution
<general-disciplines-substitution>
General Disciplines substitute for specific Disciplines at Novice tier (1:1). At Master tier, two General Disciplines may substitute for one specific Discipline (2:1). General Disciplines cannot substitute at the Adept tier.

Need 1 Fire for Firebolt? A General covers it. Need 2 Fire for Fireball at Adept? You need the real thing, no substitutions. Need 3 Fire and 1 Earth for Volcanic Eruption but you only have 3 Fire? Two Generals stand in for that Earth, and the volcano answers. General gets you in the door. Adept demands commitment. Master rewards cleverness, but charges double for shortcuts.

#pagebreak()
== Worked Example: Building a Fire Mage
<worked-example-building-a-fire-mage>
Kael wants to burn the world. He's an Arcanist, his class gives him 2 Fire and 1 Energy at creation, plus 3 General Disciplines.

#strong[Novice (Firebolt):] Requires 1 Fire. Kael has 2 Fire. He qualifies without even touching his Generals. Firebolt is his immediately.

#strong[Adept (Fireball):] Requires 2 Fire + 1 Energy. Kael has exactly that, 2 Fire, 1 Energy. He qualifies at creation. Most casters need levels to reach Adept. Arcanists start closer to the flame.

#strong[Master (Volcanic Eruption):] Requires 3 Fire + 1 Earth. Kael's got 2 Fire and 1 Energy, he needs 1 more Fire and 1 Earth. Under the old system, this took twelve levels. Now? Two paths open to him.

#emph[Path of the Patient:] At level 3, Kael takes Fire, now 3 Fire, 1 Energy. At level 6, he takes Earth, now 3 Fire, 1 Earth, 1 Energy. He qualifies for Volcanic Eruption at level 6, with all three General Disciplines still in his pocket for other pursuits. He could branch into Protection for defense, Animal for a familiar, or bank them for cross-class talents. Six levels to master volcanic fury, and he's still got room to grow.

#emph[Path of the Specialist:] At level 3, Kael takes Fire, now 3 Fire, 1 Energy. He needs 1 Earth. At the Master tier, two General Disciplines substitute for one specific Discipline. Kael spends 2 of his 3 Generals to cover the Earth requirement. He qualifies for Volcanic Eruption at level 3, but he's burned most of his flexibility getting there fast.

Two paths. Same destination. One leaves you options. The other gets you there first. Both are valid. Both are #emph[earned.]

That's the Discipline system working as intended. Master spells should be achievable before your campaign's final act, but they should still mean something when you cast them. A level 6 Volcanic Eruption says "I committed to this." A level 3 Volcanic Eruption says "I committed to this #emph[and nothing else.]" Either way, when Kael calls down the mountain's fury, everyone at the table knows he paid for it.

= Talent Categories
<talent-categories>
﻿\# Talents & Abilities {\#sec-chapter-talents-abilities}

#figure([
#box(image("chapters/../assets/images/page037-img025.png", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 16: Talents Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 16 --- Talents & abilities chapter art (Intellect class). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Listen up. Talents are what you #emph[are]. Abilities are what you #emph[do]. One's always on, the other you have to activate. Both cost Development Points. Both define your hero. Don't confuse them.

Talents are passive. They modify your numbers, bend the rules in your favor, or grant you something you didn't have before. You buy them once and they just #emph[work], no activation, no maneuver cost, no "is it my turn yet?" They're the reason the Protector takes one more hit than everyone else and the Blade's crits leave a smoking crater.

Abilities are active. Spells, combat techniques, signature class powers, anything you have to #emph[decide] to use. You spend your Action or Maneuver, the ability fires, something happens. Abilities follow the same Novice ? Adept ? Master chain as everything else in this game. See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for spell chains specifically.

#pagebreak()
Before you start spending DP, know what you're buying. Talents fall into four buckets. Each one answers a different question about your hero.

#table(
  columns: (28.57%, 45.71%, 25.71%),
  align: (auto,auto,auto,),
  table.header([Category], [What It Governs], [Example],),
  table.hline(),
  [#strong[Defense]], [Staying alive. HP, DR, saves, resistances.], [Tough, Iron Will, Unbreakable],
  [#strong[Offense]], [Hitting harder. Bonus damage, extra attacks, critical effects.], [Weapon Focus, Death Blow, Spell Weaver],
  [#strong[Utility]], [Breaking the rules. Extra actions, rerolls, resource recovery.], [Lucky, Combat Reflexes, Arcane Reservoir],
  [#strong[Support]], [Helping allies. Healing boosts, protection auras, buffs.], [Shield Wall, Blessed Touch, Divine Intervention],
)
You don't need to balance across all four. A Blade stacks Offense and Utility. A Protector stacks Defense and Support. That's how it should be, lean into what your class does.

#pagebreak()
== DP Costs
<dp-costs>
#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Tier], [DP Cost], [Description],),
  table.hline(),
  [#strong[Novice]], [1 DP], [Basic competency],
  [#strong[Adept]], [2 DP], [Advanced mastery (requires Novice)],
  [#strong[Master]], [4 DP], [Legendary expertise (requires Adept)],
)
#block[
#callout(
body: 
[
Bonuses from #strong[different-named talents] always stack. Tough (+2 HP) plus Iron Will (+2 to fear/charm saves), no conflict, both apply.

Bonuses from the #strong[same talent taken multiple times] do #emph[not] stack unless the talent explicitly says so. You can't buy Tough three times for +6 HP. One and done.

Bonuses from a talent #strong[plus a skill or item] stack freely. Skill Focus (+1 to Stealth) stacks with your Stealth skill bonus (+1/+2/+3) and with any magic item bonus. The game assumes you'll stack. Build accordingly.

The one exception: #strong[Discipline Master] (Master talent). It makes one Discipline count as #emph[two] for meeting prerequisites. This doesn't stack with itself, you can't take it twice for the same Discipline to make it count as three. But you #emph[can] take it for different Disciplines. A high-level Arcanist might have Discipline Master (Fire) and Discipline Master (Energy), meeting the prerequisites for spells that would otherwise be out of reach.

]
, 
title: 
[
Talent Stacking: What Does and Doesn't Combine
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== General Talents
<general-talents>
Available to all classes. These are the talents any hero can pick up, regardless of calling. They're bread-and-butter, not flashy, but reliable.

#table(
  columns: (25%, 18.75%, 31.25%, 25%),
  align: (auto,auto,auto,auto,),
  table.header([Talent], [Tier], [Category], [Effect],),
  table.hline(),
  [#strong[Alert]], [Novice], [Utility], [+2 initiative. You react before others even register the threat.],
  [#strong[Arcane Sensitivity]], [Novice], [Magic], [+1 to spell attack rolls for one Discipline of your choice. You sense the flow of magic before others see it coming.],
  [#strong[Field Medic]], [Novice], [Support], [When you restore HP to an ally (spell, kit, or ability), restore 1 additional HP. You've learned to stanch wounds with whatever is at hand.],
  [#strong[Fleet-Footed]], [Novice], [Utility], [+5 ft Speed. Whether from a lifetime in the wilds or too many close calls in narrow alleys, you move faster than your enemies expect.],
  [#strong[Lucky]], [Novice], [Utility], [Reroll one natural 1 per session. Fate favors you, or you're just too stubborn to fail.],
  [#strong[Shield Bearer]], [Novice], [Defense], [+1 DR while wielding a shield. This is training, not enchantment, it stacks with magic shield bonuses.],
  [#strong[Skill Focus]], [Novice], [Utility], [+1 to one skill (stacks with tier bonus). Pick your specialty and own it.],
  [#strong[Tough]], [Novice], [Defense], [+2 max HP. You can take a hit that would drop anyone else.],
  [#strong[Weapon Training]], [Novice], [Offense], [+1 damage with one specific weapon (e.g., longsword, greataxe, shortbow). Narrower than Weapon Focus but available to any class.],
  [#strong[Brutal Critical]], [Adept], [Offense], [On a Strong attack result, add +2 damage. Your strikes find gaps in armor that others miss.],
  [#strong[Bulwark]], [Adept], [Defense], [#emph[Requires Shield Bearer.] When you take the Defend action, adjacent allies gain +1 DR until the start of your next turn. You don't just protect yourself, you hold the line.],
  [#strong[Combat Reflexes]], [Adept], [Utility], [One extra reaction per round. While others hesitate, you act.],
  [#strong[Discipline Collector]], [Adept], [Utility], [Gain one additional General Discipline. Your training has been broader than most.],
  [#strong[Dungeon Delver]], [Adept], [Utility], [+2 to all checks to detect traps, secret doors, and hidden mechanisms. You've learned that dungeons punish the unobservant.],
  [#strong[Inspiring Presence]], [Adept], [Support], [Once per encounter, as a Maneuver, one ally within 30 ft can immediately reroll a failed saving throw. They take the new result. Your confidence is contagious.],
  [#strong[Iron Will]], [Adept], [Defense], [+2 to all saves vs fear and charm. Your mind is a fortress.],
  [#strong[Spell Reservoir]], [Adept], [Magic], [#emph[Requires Arcane Sensitivity.] Once per session, regain the use of one Novice or Adept spell you've already cast. Magic flows through you more freely than through others.],
  [#strong[Discipline Master]], [Master], [Utility], [One specific Discipline counts as 2 for prerequisites. You haven't just mastered a discipline, you've transcended its normal limits.],
  [#strong[Indomitable]], [Master], [Defense], [Once per session, when you would drop to 0 HP, drop to 1 HP instead and gain temporary HP equal to your level. You refuse to fall.],
  [#strong[Legendary Resilience]], [Master], [Defense], [Once per session, when you fail a saving throw, you may choose to succeed instead. Your will reshapes reality in the moment it matters most.],
  [#strong[Spell Storm]], [Master], [Magic], [Once per session, when you cast a spell that targets a single creature, it instead targets all creatures of your choice within a 15-ft radius of the original target. You don't cast spells, you unleash them.],
)
=== Worked Example: Building a Talent Chain
<worked-example-building-a-talent-chain>
Kael is a dwarf Blade at Level 4. He's got 3 DP to spend and he wants to become harder to kill without sacrificing his damage output. Here's his thought process.

#strong[Current build:] Brawn +1, Agility +2. Blades Fighting (Adept). Stealth (Adept). He's got #strong[Tough] (Novice) already, 12 HP instead of the base 10.

#strong[Option A, Defense stack:] Buy Tough ? Adept. That's not how Tough works, it doesn't have an Adept version. It's a one-tier talent. Cross that off.

#strong[Option B, Offense:] Buy #strong[Weapon Focus] (Adept, Blade class talent). +1 damage with blades. Cost: 2 DP. Remaining: 1 DP. He could grab #strong[Alert] (Novice) for +2 initiative, going first means one less attack coming his way.

#strong[Option C, Utility:] Buy #strong[Combat Reflexes] (Adept) for 2 DP. A second reaction per round means two opportunity attacks or two Shield Blocks. Then #strong[Lucky] (Novice) for 1 DP, reroll one natural 1 per session.

He goes with Option B. The +1 damage from Weapon Focus applies every single attack, forever. Combined with Alert, he's hitting harder #emph[and] sooner. At the table, that +1 from Weapon Focus turns a Weak (2 damage) into what would've been a borderline Standard (3 damage), and over a whole session, those extra points add up.

#pagebreak()
== Class Talents
<class-talents>
Each class has 2-3 exclusive talents. These define your class identity mechanically, you can't get them any other way.

#strong[Protector:] #strong[Shield Wall] (Adept), adjacent allies gain +1 DR. #strong[Unbreakable] (Master), once per session, ignore all damage from one attack.

#strong[Blade:] #strong[Weapon Focus] (Adept), +1 damage with chosen weapon category. #strong[Death Blow] (Master), on Critical, deal maximum Strong damage + roll critical bonus twice.

#strong[Arcanist:] #strong[Spell Weaver] (Adept), maintain two concentration spells. #strong[Arcane Reservoir] (Master), once per session, cast a Master spell twice.

#strong[Shepherd:] #strong[Blessed Touch] (Adept), healing spells always use Standard effect minimum. #strong[Divine Intervention] (Master), once per session, prevent an ally's death.

=== Worked Example: When Class Talents Combine
<worked-example-when-class-talents-combine>
Lyra is a halfling Odd, Level 7. She took #strong[Spell Weaver] (Adept) at Level 5, she can now maintain two concentration spells at once. At Level 7, she buys #strong[Arcane Reservoir] (Master) for 4 DP.

Here's how a tough fight plays out:

#strong[Round 1:] Lyra casts #emph[Wall of Wind] (Adept, concentration), a barrier of howling air that deflects arrows and slows enemies. Then she casts #emph[Haste] (Adept, concentration) on Kael. Two concentration spells, both running, because Spell Weaver says so. Kael now has an extra Action each turn and ranged attacks against the party are at -2.

#strong[Round 3:] The DA drops a Young Dragon on the party. It breathes lightning. The party is scattered, wounded, and the Wall of Wind won't stop a dragon's breath.

Lyra activates #strong[Arcane Reservoir.] She casts #emph[Chain Lightning] (Master), her most devastating spell. It fires. Strong result: 12 damage to the dragon, 6 to every creature within 15 feet of it. Then Arcane Reservoir kicks in: she casts it #emph[again]. Second roll: Standard, 8 more damage. The dragon has taken 20 damage in one turn from one caster.

That's the power of talent chains. Spell Weaver keeps her battlefield control running. Arcane Reservoir doubles her biggest gun. She spent 6 DP across two levels to build this combo. Every point paid off in that moment.

#pagebreak()
== Ability Chains
<ability-chains>
Abilities (including spells) follow the same Novice ? Adept ? Master chain structure. See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for spell chains. The key distinction: #strong[talents are always on; abilities must be activated.] A Protector with Shield Wall doesn't "activate" it, allies within reach just get +1 DR. A Blade using Precise Stab must spend their Maneuver and declare the ability. Know which is which before the dice hit the table.

#block[
#callout(
body: 
[
New players see the talent list and want it all. Here's the hard truth: a hero with twelve Novice talents spread across four categories is worse than a hero with three focused Adept talents that reinforce each other.

Pick a direction. If you're building a damage-dealer, stack Offense. Weapon Focus + Death Blow + Lucky (to fish for crits). If you're the party's shield, stack Defense. Tough + Iron Will + Unbreakable. The DP economy rewards focus. A scattered build is a weak build.

That said, one Utility talent is almost always worth it. #strong[Lucky] (1 DP) has saved more heroes than any other single purchase. #strong[Combat Reflexes] (2 DP) doubles your reactions. #strong[Skill Focus] (1 DP) can turn a dabbler into a specialist. Grab one, then get back to your core build.

]
, 
title: 
[
The Trap of "Buy Everything"
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#part[Magic]
= Magic System
<sec-chapter-magic-system>
#figure([
#box(image("chapters/../assets/images/page038-img026.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 17: Magic System Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 17 --- Magic system chapter art (Odd class). Placeholder; final art TBD. Dimensions: 680×989.]

#pagebreak()
Let's get one thing straight before we start: in #emph[Heroes of Legend], magic always fires. Always. No spell slots. No mana pool. No "sorry, I used my good spell already." When you cast, the magic happens. Your fire burns until #emph[you] decide it stops. The only question is how hard.

This changes everything about playing a caster. You're never useless. You're never out of options. Every round, you have something to do, and that something will have an effect.

#pagebreak()
== Always Fires: The Core Rule
<always-fires-the-core-rule>
You don't roll to cast. You roll to determine #emph[effect strength.] The spell goes off. The magic flows. Your 3d6 roll tells you whether the result is a sputter, a blast, or an inferno.

Every spell in this game has three outcomes built right into its stat block:

- #strong[Weak:] The spell fires but underperforms. The firebolt singes instead of ignites. The heal knits flesh but leaves a scar. You got the job done, barely.
- #strong[Standard:] Clean, expected result. Professional spellwork. This is what the spell was designed to do, and you did it.
- #strong[Strong:] The magic surges. Extra damage, bonus effects, wider areas. The spell doesn't just work, it #emph[dominates.] This is why you became a caster.

That's it. One roll. Three outcomes. No separate casting check, no concentration roll, no spell failure percentage. Roll 3d6 + Knowledge + relevant skill. Read the result. Magic happens.

#pagebreak()
== Spell Chains: Novice ? Adept ? Master
<spell-chains-novice-adept-master>
Spells don't exist in isolation. They're organized into #strong[chains], three-tier progressions where each spell builds on the one before it. You start with the Novice version. You earn the Adept. You aspire to the Master.

#table(
  columns: 4,
  align: (auto,auto,auto,auto,),
  table.header([Chain], [Novice], [Adept], [Master],),
  table.hline(),
  [Fire Magic], [Firebolt], [Fireball], [Volcanic Eruption],
  [Ice Magic], [Ray of Frost], [Ice Storm], [Cone of Cold],
  [Lightning], [Shocking Grasp], [Lightning Bolt], [Chain Lightning],
  [Healing], [Cure Wounds], [Prayer of Healing], [Mass Heal],
  [Protection], [Shield], [Magic Circle], [Globe of Invulnerability],
  [Charm], [Charm Person], [Suggestion], [Dominate Person],
  [Illusion], [Minor Illusion], [Mirror Image], [Greater Invisibility],
  [Necromancy], [Chill Touch], [Animate Dead], [Finger of Death],
  [Divination], [Detect Magic], [Clairvoyance], [True Seeing],
  [Transmutation], [Enlarge/Reduce], [Polymorph], [Time Stop],
)
Every chain follows the same logic: Novice is your workhorse, Adept is your heavy hitter, Master is your "everyone remember where we parked the horses" moment.

#pagebreak()
== Discipline Prerequisites
<discipline-prerequisites>
Spells don't care about your level. They care about your #strong[Disciplines.] Want to throw a Fireball? You need 2 Fire and 1 Energy, not "level 5 wizard." The Discipline system follows a clean doubling progression: #strong[Novice spells require 1 Discipline, Adept require 2, Master require 4.] A dedicated caster can reach Adept spells at creation and Master spells by level 6, or even level 3, if they're willing to pay the General premium.

At the Master tier, one additional rule applies: #strong[no single Discipline type may exceed 3.] Every Master spell blends at least two types. Volcanic Eruption isn't just "more fire", it's fire and earth working together. This ensures Master spells represent broad magical mastery, not narrow specialization.

General Disciplines follow a tiered substitution rule: at Novice, one General substitutes for one specific Discipline (1:1). At Master, two General Disciplines substitute for one specific Discipline (2:1). General Disciplines cannot substitute at the Adept tier. This means a clever caster can reach Master spells early by burning General Disciplines, but it's expensive, and those Generals won't be available for other pursuits.

#table(
  columns: (12.96%, 11.11%, 27.78%, 48.15%),
  align: (auto,auto,auto,auto,),
  table.header([Spell], [Tier], [Discipline Req], [Effect Range (W / S / St)],),
  table.hline(),
  [Firebolt], [Novice], [1 Fire], [W: 2 / S: 3 / St: 5 + ignite],
  [Fireball], [Adept], [2 Fire + 1 Energy], [W: 6 (5ft) / S: 9 (15ft) / St: 12 (20ft)],
  [Volcanic Eruption], [Master], [3 Fire + 1 Earth], [W: 9 (20ft) / S: 15 (30ft) / St: 21 (40ft) + terrain hazard],
)
Look at that jump from Firebolt to Volcanic Eruption. One Discipline. Two Disciplines. Four Disciplines. Novice spells are tools. Adept spells are weapons. Master spells are #emph[events.] The Discipline requirements make sure you earn the difference, but they don't make you wait half a campaign to do it.

#pagebreak()
== Cantrips
<cantrips>
Cantrips are the spells you learn before you learn "real" spells. Minor magic. Parlor tricks that grew teeth.

Cantrips require #strong[no Discipline prerequisites.] Every caster knows all cantrips in their tradition, arcane or divine. These are your at-will abilities: #emph[Prestidigitation, Light, Mage Hand, Thaumaturgy, Guidance.] Small effects. Infinite uses. No roll required unless the cantrip says otherwise.

They won't win a fight. They'll start one, or end one creatively. Never underestimate a caster who knows exactly what their cantrips can do.

#pagebreak()
== Arcane vs.~Divine Magic
<arcane-vs.-divine-magic>
Two traditions. Two philosophies. Same engine underneath.

#strong[Arcane] (Arcanist, Odd, Unbalanced): Fire, Wind, Water, Earth, and Energy spells. Arcane casters manipulate natural forces through study, talent, or sheer force of will. They're scientists of the impossible, or artists of the unstable. Damage is their language. Destruction is their punctuation.

#strong[Divine] (Shepherd, some Leaders): Protection, Animal, Life, and Religion spells. Divine casters channel power from a higher source, gods, nature, ancestors, the light between stars. They heal. They ward. They burn what shouldn't exist, like undead and demons. Their magic is a relationship, not a formula.

Some classes blur the line. The Odd steals from both traditions. The Unbalanced channels opposing elements through their own body. The game doesn't build walls between arcane and divine, it just asks what you're willing to pay.

#pagebreak()
== Limitations
<limitations>
Magic is powerful. That's the point. But there are brakes. Not to frustrate you, to make your biggest spells feel like #emph[moments.]

#strong[Per-Encounter:] Adept and Master spells can only be used once per combat. You can't chain-cast Fireball every round. Choose your moment. Make it count.

#strong[Per-Session:] Master-tier spells are once per session. When you unleash Volcanic Eruption or Time Stop, the table should go quiet. These spells reshape encounters. They're not your default attack, they're your signature. Use them when it matters most.

#strong[Concentration:] Some ongoing spells, illusions, wards, enchantments, require concentration. You can only maintain one concentration spell at a time. If you take damage while concentrating, make a Fortitude save to hold the spell together. Concentration is about focus. Lose focus, lose the spell.

#block[
#callout(
body: 
[
I've seen what happens when a caster can drop their biggest spell every round. Combat becomes a fireworks display with no tension. The Blades and Protectors might as well put their dice away.

The per-session limit on Master spells isn't about resource management, it's about spotlight management. When you cast Volcanic Eruption, #emph[everyone] should remember it. That means you can't do it three times before lunch.

The Veteran Adventurer

]
, 
title: 
[
Why Limits on Master Spells?
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Worked Example: Casting a Fireball
<worked-example-casting-a-fireball>
Lyra is an Odd with 2 Fire and 1 Energy. She's facing a cluster of goblins huddled behind a barricade. Time for a Fireball.

#strong[The roll:] Lyra's Knowledge is +1, and she has Arcana at Adept (+2). The goblins are packed tight, Standard difficulty, no modifier. She rolls 3d6: 5, 3, 4 = 12. Plus 1 (Knowledge), plus 2 (Arcana) = 15. #emph[Strong.]

#strong[The effect:] Fireball's Strong damage is 12 in a 20-foot radius. Everything in that circle takes 12 fire damage unless it has resistance. The goblins have no armor and no resistance. Four goblins, twelve damage each. The barricade, wooden, dry, catches fire. The goblins' formation collapses into screaming chaos.

#strong[The aftermath:] The Fireball is per-encounter. Lyra won't cast it again this fight. But she doesn't need to. She just cleared the room. Now she draws her dagger and lets the Protector handle cleanup while she looks for her next opening.

That's how magic works in #emph[Heroes of Legend.] No "sorry, I missed." No "I'm out of mana." Just one roll, one result, and a room full of consequences.

= Arcane Cantrips
<arcane-cantrips>
﻿\# Arcane Spells {\#sec-chapter-arcane-spells}

#figure([
#box(image("chapters/../assets/images/page039-img027.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 18: Arcane Spells Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 18 --- Arcane spells chapter art (Leader class). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Fire is the first magic. It's the magic of anger, of hunger, of the campfire that keeps the dark at bay. Every mage starts with fire, and most never stop.

But fire's just the beginning. Ice that freezes blood in the veins. Lightning that jumps from foe to foe like it's choosing favorites. Acid that doesn't just burn, it #emph[unmakes.] Force magic that hits like a battering ram made of pure will. Illusions that make trained soldiers stab at shadows. The cold arithmetic of necromancy. The whisper that becomes a command. The body reshaped into something faster, harder, deadlier.

Arcane magic is the art of telling the universe to sit down and shut up, and making it listen. You don't ask. You don't pray. You #emph[impose.]

This chapter contains every arcane spell in the game. They're organized by element, then by chain. Each chain is a path: Novice to Adept to Master. Walk it. Earn it. Then set the world on fire.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

#pagebreak()
Cantrips are minor spells. The magic you learn before you learn #emph[real] magic. They don't require Disciplines, they don't cost anything to learn, and you can cast them as often as you like, at-will, every round, all day. Every arcane caster knows all of these.

They won't win a fight by themselves. But they'll start one, end one, or change the terms of one. Never underestimate a caster who knows exactly what their cantrips can do.

=== Arcane Mark (Cantrip)
<arcane-mark-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Permanent until dispelled #strong[Target:] One surface or object

#strong[Description:] You inscribe your personal sigil, invisible to normal sight, onto any surface. The mark is unique to you. It can be made visible with a word, and it glows under magical detection.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The mark is faint. Detection spells reveal it, but the image is blurry.],
  [Standard (9-14)], [Clean, permanent mark. Visible on command, unmistakably yours.],
  [Strong (15-18+)], [The mark is flawless. You may also sense when any creature touches it within 100 feet for the next 24 hours.],
)
#emph[Your signature on the world. Some mages use it to claim territory. Some to leave messages. Some to remind an enemy who burned their house down.]

=== Dancing Lights (Cantrip)
<dancing-lights-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] Up to 4 points in range

#strong[Description:] You create up to four torch-bright orbs of light that hover and move at your command. Each sheds light in a 10-foot radius. You can combine them into a single glowing humanoid shape.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Two dim orbs. Light radius halved. They flicker.],
  [Standard (9-14)], [Four bright orbs or one glowing shape. Full control of movement.],
  [Strong (15-18+)], [The lights are dazzling. One creature of your choice within the light radius has disadvantage on its next attack.],
)
#emph[Better than a torch. Worse than a fireball. But they don't go out in the rain, and they'll follow you down any hole you're stupid enough to climb into.]

=== Frost Touch (Cantrip)
<frost-touch-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature or object

#strong[Description:] Your hand erupts in freezing cold. A creature you touch takes 1d6 ice damage. A liquid you touch freezes solid in a 1-foot cube for 1 minute. A small object becomes brittle.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d4 ice damage. Liquid chills but doesn't freeze.],
  [Standard (9-14)], [1d6 ice damage. Liquid freezes solid.],
  [Strong (15-18+)], [1d6+2 ice damage. Target's next physical action has disadvantage as cold numbs their limbs.],
)
#emph[The first spell every ice mage learns. Touch a lock. Touch a rope. Touch a throat. Cold solves problems heat can't.]

=== Ghost Sound (Cantrip)
<ghost-sound-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One point in range

#strong[Description:] You create a sound that originates from a point you choose, footsteps, a whispered voice, a door slamming, a growl. The sound can be as quiet as a breath or as loud as a scream.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [One brief, obvious sound. Anyone listening gets a Reason check to recognize it as magical.],
  [Standard (9-14)], [Sustained or repeating sounds. Believable enough to distract or mislead.],
  [Strong (15-18+)], [Complex audio, a full sentence in a recognizable voice, or a soundscape (approaching guards, a wolf pack circling).],
)
#emph[The oldest trick in the book. Still works. Guards have been chasing phantom footsteps since the first wizard figured out this spell, and guards will be chasing them long after you're dust.]

=== Mage Hand (Cantrip)
<mage-hand-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One unattended object up to 10 pounds

#strong[Description:] A spectral, floating hand appears at a point you choose. It can manipulate objects, open doors, pull levers, or deliver items. The hand can't attack or activate magic items.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The hand is clumsy. Fine manipulation fails. Objects may be dropped.],
  [Standard (9-14)], [Precise control. The hand can turn keys, pour liquids, or lift up to 10 pounds.],
  [Strong (15-18+)], [The hand is preternaturally deft. It can pick pockets, disarm simple traps, or deliver a potion to an ally's lips mid-combat.],
)
#emph[You will use this spell more than any other. You will open things you shouldn't open. You will touch things you shouldn't touch. You will learn. Or you won't.]

=== Prestidigitation (Cantrip)
<prestidigitation-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] 10 feet #strong[Duration:] Up to 1 hour #strong[Target:] See below

#strong[Description:] The workhorse of minor magic. You may produce one of the following effects at a time: light or snuff a candle, clean or soil an object, chill or warm a drink, create a harmless sensory effect (a shower of sparks, a faint breeze, a whisper of perfume), or color a small object for 1 hour. You can have up to three non-instantaneous effects active at once.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [One effect. It's crude, the sparks are dull, the cleaning is smeary.],
  [Standard (9-14)], [Up to three simultaneous effects. Each works exactly as intended.],
  [Strong (15-18+)], [Your effects are especially vivid or lasting. The perfume lingers for hours. The sparks are bright enough to briefly distract. The cleaning removes stains that have been there for years.],
)
#emph[This is the spell that separates wizards from lantern-bearers. Anyone can throw fire. Making a goblin warlord's dinner taste like ashes from thirty feet away? That's art.]

=== Spark (Cantrip)
<spark-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Instantaneous #strong[Target:] One flammable object

#strong[Description:] You snap your fingers and produce a pinpoint of intense heat. It ignites one flammable object that isn't being worn or carried, paper, dry wood, oil, cloth, gunpowder.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The object smolders. It may catch fire after 1 round if left alone.],
  [Standard (9-14)], [Immediate ignition. The object catches fire and burns normally.],
  [Strong (15-18+)], [The flame leaps. Adjacent flammable objects also catch fire.],
)
#emph[Every Pyromancer's first spell. Also their last, if they're not careful about where they point it. Fire doesn't care about your intentions. Fire cares about what's flammable.]

=== Static Shock (Cantrip)
<static-shock-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] A spark of electricity arcs from your fingertip to the target. Deals 1d6 lightning damage. Metal-armored targets take +1 damage.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d4 lightning damage. The target feels a tingle.],
  [Standard (9-14)], [1d6 lightning damage. +1 vs.~metal armor.],
  [Strong (15-18+)], [1d6+2 lightning damage. The spark chains to one additional target within 10 feet for half damage.],
)
#emph[The crackle before the storm. Doesn't look like much. Hurts more than it looks. Aim for the one in plate.]

=== Acid Splash (Cantrip)
<acid-splash-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Instantaneous #strong[Target:] One creature or object

#strong[Description:] You hurl a glob of corrosive acid. Deals 1d6 acid damage. Against objects, the acid ignores 1 point of hardness.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d4 acid damage. The acid sizzles weakly.],
  [Standard (9-14)], [1d6 acid damage. Ignores 1 hardness against objects.],
  [Strong (15-18+)], [1d6+2 acid damage. The acid clings, target takes 1d4 additional acid damage at the start of its next turn.],
)
#emph[Not flashy. Not dramatic. But acid doesn't care how thick your armor is. It finds the gaps. It always finds the gaps.]

=== Whisper (Cantrip)
<whisper-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] 120 feet #strong[Duration:] Instantaneous #strong[Target:] One creature you can see

#strong[Description:] You send a short message, up to 25 words, directly into the mind of a creature you can see. The target recognizes you as the sender if it knows you. The target cannot reply.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The message is garbled. Key words may be lost.],
  [Standard (9-14)], [Clear message. 25 words, perfectly delivered.],
  [Strong (15-18+)], [The message carries emotional weight, urgency, calm, menace. The target understands not just the words but the intent behind them.],
)
#emph[No hand signals. No shouting across a crowded room. Just your voice in their skull. Use it to coordinate. Use it to intimidate. Use it to remind the DA's villain that you know exactly where they sleep.]

#horizontalrule
#pagebreak()
#pagebreak()
== Fire Chains
<fire-chains>
Fire is the element of first resort and last resort. It burns. It spreads. It doesn't ask permission and it doesn't apologize. Fire mages aren't subtle, they're #emph[effective.] Every fire chain starts with a single flame and ends with a conflagration that reshapes the battlefield. If you're going to walk this path, invest in fire resistance. Your allies will thank you.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Firebolt Chain
<firebolt-chain>
#strong[Disciplines:] Fire #emph[The fundamental fire chain. Point. Burn. Repeat. From a flicker to an inferno.]

==== Firebolt (Novice)
<firebolt-novice>
#strong[Disciplines:] 1 Fire #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Instantaneous #strong[Target:] One creature or object

#strong[Description:] You fling a bolt of fire from your palm. A clean, focused strike, the first combat spell every fire mage masters.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d6 fire damage. The bolt singes but doesn't catch.],
  [Standard (9-14)], [2d6 fire damage. Flammable objects ignite.],
  [Strong (15-18+)], [3d6 fire damage. The target catches fire, taking 1d4 ongoing fire damage at the start of each turn until an action is spent putting it out.],
)
#emph[Your first real spell. Not a cantrip. Not a trick. This is the moment you stop being someone who knows magic and start being a mage.]

==== Fireball (Adept)
<fireball-adept>
#strong[Disciplines:] 2 Fire, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 100 feet #strong[Duration:] Instantaneous #strong[Target:] 15-foot radius

#strong[Description:] A bright streak flashes from your pointing finger, then explodes in a roaring sphere of flame. Everything in the radius takes fire damage. Nothing in the radius is having a good day.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 fire damage in a 10-foot radius. Flames sputter at the edges.],
  [Standard (9-14)], [4d6 fire damage in a 15-foot radius. Flammable objects ignite. The heat is visible from a mile away at night.],
  [Strong (15-18+)], [6d6 fire damage in a 20-foot radius. Targets near the center take +1d6. The ground smolders for 1 minute.],
)
#emph[This is the spell that ends encounters and starts wars. When you cast Fireball, the battlefield changes. So does your reputation. Aim carefully. Your allies are flammable too.]

==== Inferno (Master)
<inferno-master>
#strong[Disciplines:] 3 Fire, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 150 feet #strong[Duration:] Instantaneous #strong[Target:] 30-foot radius

#strong[Description:] You call down a column of white-hot fire from the sky. The air screams. The ground fuses to glass. This is not a spell, it's a verdict.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [3d6 fire damage in a 20-foot radius. The column falters.],
  [Standard (9-14)], [6d6 fire damage in a 30-foot radius. Targets in the center 10 feet take +2d6. Structures take double damage.],
  [Strong (15-18+)], [9d6 fire damage in a 40-foot radius. The area becomes a hazard for 1 minute, any creature entering or ending its turn there takes 2d6 fire damage. The ground is molten glass.],
)
#emph[When the Arcanist who taught you Firebolt sees you cast Inferno, they won't be proud. They'll be terrified. Good. That's the idea.]

=== Burning Hands Chain
<burning-hands-chain>
#strong[Disciplines:] Fire #emph[Close-range devastation. When they're in your face and you need them not to be.]

==== Burning Hands (Novice)
<burning-hands-novice>
#strong[Disciplines:] 1 Fire #strong[Casting Time:] 1 action #strong[Range:] Self (15-foot cone) #strong[Duration:] Instantaneous #strong[Target:] All creatures in a 15-foot cone

#strong[Description:] A sheet of flame erupts from your outstretched fingers, engulfing everything in front of you. Your personal space, redefined by fire.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d3 fire damage to all targets in the cone. The flames are thin.],
  [Standard (9-14)], [1d6 fire damage to all targets in a 15-foot cone. Flammable objects ignite.],
  [Strong (15-18+)], [2d6 fire damage to all targets in a 15-foot cone. Targets at the edge still take half damage.],
)
#emph[For when subtlety has failed. For when the goblins are in your face and your Protector is on the other side of the room. For when "get away from me" needs to be a statement of fact, not a request.]

==== Wall of Fire (Adept)
<wall-of-fire-adept>
#strong[Disciplines:] 2 Fire, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] A line up to 40 feet long and 15 feet high

#strong[Description:] A roaring curtain of flame springs into existence. One side burns, the other is merely uncomfortably warm. You choose which side is which.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The wall is 20 feet long, 10 feet high. 2d6 fire damage to creatures passing through.],
  [Standard (9-14)], [40-foot wall, 15 feet high. 3d6 fire damage to creatures entering or starting their turn inside. Creatures within 10 feet of the hot side take 1d6.],
  [Strong (15-18+)], [60-foot wall, 20 feet high. 4d6 to those inside. The wall arcs into a ring or corridor shape of your choice.],
)
#emph[Fire doesn't just destroy, it divides. A Wall of Fire is a battlefield editor. It says: "This side is yours. That side is pain." Place it well and the enemy has to choose between burning and retreating. Either way, you win.]

==== Volcanic Eruption (Master)
<volcanic-eruption-master>
#strong[Disciplines:] 3 Fire, 1 Earth #strong[Casting Time:] 1 action #strong[Range:] 100 feet #strong[Duration:] Instantaneous (terrain persists 1 minute) #strong[Target:] 20-foot radius cylinder, 40 feet high

#strong[Description:] The ground erupts. Lava, ash, and superheated rock blast upward in a column that would make a volcano nod in respect. The terrain becomes a hazard of fire and stone.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [3d6 fire damage in a 15-foot radius. The ground cracks but doesn't fully breach.],
  [Standard (9-14)], [4d6 fire damage + 1d6 bludgeoning from falling debris in a 20-foot radius. Area becomes difficult terrain for 1 minute.],
  [Strong (15-18+)], [6d6 fire damage + 2d6 bludgeoning in a 25-foot radius. The area becomes lava field, 2d6 fire damage per round to anyone standing in it. Creatures knocked prone by the shockwave.],
)
#emph[This is what happens when Fire meets Earth. A Master-tier spell that doesn't just burn the battlefield, it remakes it. When you cast Volcanic Eruption, the terrain is yours for the rest of the fight. Plan accordingly.]

=== Scorching Ray Chain
<scorching-ray-chain>
#strong[Disciplines:] Fire #emph[Precision fire. Multiple beams. Multiple targets. Maximum efficiency for minimum flame.]

==== Scorching Ray (Novice)
<scorching-ray-novice>
#strong[Disciplines:] 1 Fire #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Instantaneous #strong[Target:] Up to 2 creatures

#strong[Description:] Two rays of searing fire shoot from your fingertips. You can direct them at the same target or split them between two.

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [One ray. 1d6 fire damage.],
  [Standard (9-14)], [Two rays. Each deals 1d8 fire damage.],
  [Strong (15-18+)], [Three rays. Each deals 1d8 fire damage.],
)
#emph[Why burn one thing when you can burn several? Scorching Ray is efficiency dressed in flame. Two goblins, two rays, one very surprised goblin chieftain wondering where his escorts went.]

==== Flame Strike (Adept)
<flame-strike-adept>
#strong[Disciplines:] 2 Fire, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 80 feet #strong[Duration:] Instantaneous #strong[Target:] 10-foot radius, 30 feet high

#strong[Description:] A vertical column of divine-seeming fire roars down from above. Half the damage is fire, half is radiant energy that burns the soul as well as the flesh. Undead and fiends hate this spell.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 damage (half fire, half radiant) in a 5-foot radius.],
  [Standard (9-14)], [4d6 damage (half fire, half radiant) in a 10-foot radius. Undead and fiends have disadvantage on any save against it.],
  [Strong (15-18+)], [6d6 damage in a 15-foot radius. Undead and fiends take the full damage as radiant. The column persists for 1 round, damaging anyone who enters.],
)
#emph[The gods don't have a monopoly on holy fire. When an arcanist calls down Flame Strike, they're making a point: "I don't need a deity. I have physics." The undead don't appreciate the distinction.]

==== Meteor Swarm (Master)
<meteor-swarm-master>
#strong[Disciplines:] 3 Fire, 1 Earth #strong[Casting Time:] 1 action #strong[Range:] 200 feet #strong[Duration:] Instantaneous #strong[Target:] Four 20-foot radius spheres

#strong[Description:] You point at the sky and four blazing meteors answer. Each one strikes a point you choose and detonates. This is the spell that ends campaigns. Use it wisely, you get one per session.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Two meteors. Each deals 3d6 fire + 1d6 bludgeoning in a 15-foot radius.],
  [Standard (9-14)], [Four meteors. Each deals 4d6 fire + 2d6 bludgeoning in a 20-foot radius.],
  [Strong (15-18+)], [Four meteors. Each deals 6d6 fire + 3d6 bludgeoning in a 25-foot radius. Overlapping damage stacks. Structures are obliterated.],
)
#emph[When someone asks "what's the biggest spell you know," this is the answer. Four rocks from the sky. Each one a Fireball's angry older brother. You can target them anywhere you can see. Four problems. Four solutions. One very quiet battlefield afterward.]

#horizontalrule
#pagebreak()
#pagebreak()
== Ice Chains
<ice-chains>
Ice magic is control dressed as destruction. Fire burns and moves on, ice #emph[stays.] It locks down terrain, freezes enemies in place, and makes the battlefield yours at the speed of dropping temperature. Ice mages don't need to be the fastest person in the room. By the time the fight starts, nobody else can move.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Frost Ray Chain
<frost-ray-chain>
#strong[Disciplines:] Water #emph[The fundamental ice chain. A beam of killing cold that grows longer and deadlier with each tier.]

==== Frost Ray (Novice)
<frost-ray-novice>
#strong[Disciplines:] 1 Water #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] A beam of pale blue light streaks toward your target. Where it hits, flesh freezes solid. Movement slows. The cold bites deep.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d6 ice damage. Target's speed is unaffected.],
  [Standard (9-14)], [2d6 ice damage. Target's speed is halved until the end of its next turn.],
  [Strong (15-18+)], [3d6 ice damage. Target's speed is reduced to 5 feet until the end of its next turn.],
)
#emph[Heat is fast. Cold is patient. A Frost Ray doesn't just hurt, it reminds the target that they're meat, and meat freezes. Aim for the legs. A frozen enemy is a solved problem.]

==== Ice Storm (Adept)
<ice-storm-adept>
#strong[Disciplines:] 2 Water, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 100 feet #strong[Duration:] Instantaneous (ice persists 1 minute) #strong[Target:] 20-foot radius, 40 feet high

#strong[Description:] Hailstones the size of fists hammer down in a roaring cylinder of ice and wind. The ground becomes a sheet of frozen death. Anything caught in the storm is battered, frozen, and left wondering what happened.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 ice damage in a 10-foot radius. Light snowfall, no terrain effect.],
  [Standard (9-14)], [3d6 ice damage + 1d6 bludgeoning in a 20-foot radius. Area becomes slippery, creatures moving through it must make an Agility check or fall prone.],
  [Strong (15-18+)], [4d6 ice damage + 2d6 bludgeoning. The ice layer is thick, the area is difficult terrain for 1 minute, and creatures starting their turn there take 1d4 ongoing ice damage.],
)
#emph[The sky doesn't care about your plans. Ice Storm is weather weaponized. It doesn't discriminate, doesn't hesitate, and doesn't stop until everything in the circle is frozen, prone, and reconsidering their life choices.]

==== Blizzard (Master)
<blizzard-master>
#strong[Disciplines:] 3 Water, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 150 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] 40-foot radius

#strong[Description:] You summon a howling blizzard. Wind shrieks. Snow blinds. The cold is so intense that exposed skin freezes in seconds. Creatures inside the storm can barely see, barely move, barely survive.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 ice damage per round in a 20-foot radius. Light obscurement.],
  [Standard (9-14)], [3d6 ice damage per round in a 40-foot radius. Heavy obscurement, attacks into or out of the storm have disadvantage. Difficult terrain.],
  [Strong (15-18+)], [4d6 ice damage per round in a 50-foot radius. Total obscurement within the storm. Creatures ending their turn inside must make a Fortitude check or gain 1 level of exhaustion from the cold.],
)
#emph[Blizzard is not a strike. It's a siege. You drop it on the enemy formation and watch them freeze, stumble, and die. You can maintain concentration and move it. A 40-foot radius of "you don't want to be here" that follows your will. Ice magic's final answer to the question "how do I control the entire battlefield?"]

=== Freeze Solid Chain
<freeze-solid-chain>
#strong[Disciplines:] Water #emph[Single-target ice control. Trap them, crack them, shatter them.]

==== Chill Touch (Novice)
<chill-touch-novice>
#strong[Disciplines:] 1 Water #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] Your hand glows with cold blue light. You reach out and the chill sinks through armor, skin, and bone. The target's flesh goes numb and white.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d6 ice damage. The target shivers but functions normally.],
  [Standard (9-14)], [2d6 ice damage. The target's next attack has disadvantage as numbness sets in.],
  [Strong (15-18+)], [3d6 ice damage. The target is immobilized until the end of its next turn, frozen in place, unable to move.],
)
#emph[Touch-range ice. Dangerous to deliver, devastating when it lands. When the enemy Blade closes distance and expects an easy kill, Chill Touch reminds them that mages have teeth at every range.]

==== Freeze Solid (Adept)
<freeze-solid-adept>
#strong[Disciplines:] 2 Water, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] Ice erupts around the target, encasing them in a frozen shell. They can't move. They can barely breathe. The ice creaks as they struggle, and every struggle makes it tighter.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The target is restrained for 1 round. 1d6 ice damage.],
  [Standard (9-14)], [The target is restrained and takes 2d6 ice damage. At the start of each of its turns while restrained, it takes 1d6 additional ice damage. It may attempt a Brawn check to break free.],
  [Strong (15-18+)], [The target is fully encased in ice, restrained, blinded, and takes 3d6 ice damage. Ongoing damage is 2d6 per turn. Breaking free requires a Hard Brawn check, and each attempt causes 1d6 damage from the cracking ice.],
)
#emph[The moment a charging ogre realizes it can't move its legs. Ice doesn't negotiate. Ice doesn't care about momentum, rage, or how many villages you've destroyed. Ice says "stop," and you stop.]

==== Glacial Prison (Master)
<glacial-prison-master>
#strong[Disciplines:] 3 Water, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] The target is sealed inside a pillar of ancient ice, the kind that's been frozen since before the world had names for things. Time nearly stops inside the prison. The cold is absolute.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Target is restrained in a shell of ice. 3d6 ice damage. Breakable with a Standard Brawn check.],
  [Standard (9-14)], [Target is imprisoned, restrained, blinded, silenced. 4d6 ice damage initially, 2d6 per round. Breaking free requires a Hard Brawn check (two successes needed).],
  [Strong (15-18+)], [Target is perfectly sealed. Takes 6d6 ice damage. Cannot take actions, cannot be targeted by allies, frozen in stasis. Breaking free requires three Hard Brawn checks. The prison has 30 HP and can be shattered by allies with attacks.],
)
#emph[This is what the old ice holds. Not just cold, stillness. The Glacial Prison doesn't just trap an enemy. It removes them from the fight entirely. One moment the enemy warlord is rallying her troops. The next, she's a statue in a block of ice older than her bloodline. Finish the fight. Deal with her later.]

=== Frost Armor Chain
<frost-armor-chain>
#strong[Disciplines:] Water #emph[Defensive ice magic. Armor yourself in the cold. Let your enemies freeze on contact.]

==== Frost Armor (Novice)
<frost-armor-novice>
#strong[Disciplines:] 1 Water #strong[Casting Time:] 1 action #strong[Range:] Self #strong[Duration:] 1 minute #strong[Target:] Self

#strong[Description:] A thin layer of magically hardened ice coats your body. It doesn't restrict movement, but it turns aside blades and numbs anyone who gets too close.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [+1 Armor for 1 minute. The ice is patchy.],
  [Standard (9-14)], [+2 Armor for 1 minute. Creatures striking you in melee take 1d4 ice damage from the numbing cold.],
  [Strong (15-18+)], [+2 Armor for 1 minute. Melee attackers take 1d6 ice damage. You gain resistance to fire damage while the armor holds, the ice absorbs the heat before it reaches you.],
)
#emph[Armor that bites back. Frost Armor is for the mage who plans to get hit and wants the enemy to regret it. It won't stop a greataxe, but it'll make the greataxe-wielder think twice about swinging again.]

==== Ice Shield (Adept)
<ice-shield-adept>
#strong[Disciplines:] 2 Water, 1 Protection #strong[Casting Time:] 1 reaction (when hit by an attack) #strong[Range:] Self #strong[Duration:] Instantaneous (shield lasts 1 round) #strong[Target:] Self

#strong[Description:] A disk of solid ice materializes between you and an incoming attack. The blow shatters against it. For the rest of the round, the shield orbits you, deflecting follow-up strikes.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Reduce the triggering attack's damage by 1d6. Shield shatters.],
  [Standard (9-14)], [Reduce damage by 2d6. The shield persists for the round, +2 Armor against all subsequent attacks until your next turn.],
  [Strong (15-18+)], [Reduce damage by 3d6. Shield persists with +3 Armor. Anyone striking you in melee while the shield is up takes 2d4 ice damage.],
)
#emph[The difference between a dead mage and a mage who needs a new robe. Ice Shield is a reaction, you cast it when the axe is already swinging. It's the spell that turns a killing blow into a chipped blade and a very surprised enemy.]

==== Frozen Aegis (Master)
<frozen-aegis-master>
#strong[Disciplines:] 3 Water, 1 Protection #strong[Casting Time:] 1 action #strong[Range:] Self #strong[Duration:] Concentration, up to 1 minute #strong[Target:] Self

#strong[Description:] You encase yourself in a suit of crystalline ice armor that moves with you like a second skin. Spikes of frozen death protrude from every surface. You are a glacier with a pulse.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [+2 Armor. Melee attackers take 1d6 ice damage. Speed reduced by 5 feet.],
  [Standard (9-14)], [+3 Armor. Melee attackers take 2d6 ice damage. You are immune to cold damage. Fire attacks against you have disadvantage, the ice fights back.],
  [Strong (15-18+)], [+4 Armor. Melee attackers take 3d6 ice damage. Cold immunity. Fire resistance. Once during the spell's duration, you can shatter the Aegis as a reaction to negate all damage from one attack, the armor explodes outward, dealing 4d6 ice damage to all creatures within 10 feet.],
)
#emph[You want to know what it feels like to be untouchable? Cast Frozen Aegis. Walk into the middle of the enemy formation. Watch them break their weapons on you. Watch their breath freeze in their lungs. You're not avoiding the fight, you're the terrain now.]

#horizontalrule
#pagebreak()
#pagebreak()
== Lightning Chains
<lightning-chains>
Lightning doesn't ask. Lightning doesn't warn. One moment there's air, the next, there's a white-hot line burned across your vision and the smell of ozone where your enemy used to be. Lightning mages are fast, loud, and merciless. Their spells leap from target to target like the universe is playing favorites. If fire is a hammer, lightning is a scalpel made of thunder.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Lightning Bolt Chain
<lightning-bolt-chain>
#strong[Disciplines:] Wind #emph[The fundamental lightning chain. A line of destruction that pierces everything in its path.]

==== Shock (Novice)
<shock-novice>
#strong[Disciplines:] 1 Wind #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] Electricity arcs from your hand into the target. Muscles seize. Nerves scream. The target learns, for one brief moment, what it feels like to be a lightning rod.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d6 lightning damage. Target flinches but acts normally.],
  [Standard (9-14)], [2d6 lightning damage. Metal-armored targets take +2 damage. Target's next reaction is unavailable, nerves are jangling.],
  [Strong (15-18+)], [3d6 lightning damage. Target is dazed, it can take either an action or a move on its next turn, not both.],
)
#emph[Touch-range lightning. The riskiest delivery method for the most reliable disabling effect. When the enemy Blade closes the gap and thinks they've got you dead to rights, grab their helmet. Show them what dead to rights actually means.]

==== Lightning Bolt (Adept)
<lightning-bolt-adept>
#strong[Disciplines:] 2 Wind, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self (60-foot line) #strong[Duration:] Instantaneous #strong[Target:] All creatures in a 5-foot-wide, 60-foot line

#strong[Description:] A stroke of lightning blasts from your outstretched hand in a straight line. Everything in that line, friend, foe, furniture, takes the full force. Lightning doesn't curve. Lightning doesn't apologize.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 lightning damage in a 30-foot line.],
  [Standard (9-14)], [4d6 lightning damage in a 60-foot line. Metal-armored targets take +1d6.],
  [Strong (15-18+)], [6d6 lightning damage in an 80-foot line. The bolt pierces through the first target and continues, no cover benefits. Targets in metal armor are stunned for 1 round.],
)
#emph[The line is both the spell's strength and its weakness. A fireball hits a circle, easy to aim, messy at the edges. A Lightning Bolt hits exactly what's in front of you and nothing else. Position yourself. Line up the shot. Let the thunder do the rest.]

==== Chain Lightning (Master)
<chain-lightning-master>
#strong[Disciplines:] 3 Wind, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 100 feet #strong[Duration:] Instantaneous #strong[Target:] One primary target, then up to 6 secondary targets

#strong[Description:] A bolt of lightning strikes your primary target, then splits, arcing to up to six other creatures of your choice within 30 feet of the primary. The lightning chooses. The lightning doesn't miss.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Primary: 3d6 lightning damage. Arcs to 2 secondary targets for 1d6 each.],
  [Standard (9-14)], [Primary: 6d6 lightning damage. Arcs to 4 secondary targets for 3d6 each.],
  [Strong (15-18+)], [Primary: 9d6 lightning damage. Arcs to 6 secondary targets for 4d6 each. The primary target is stunned for 1 round. Metal-armored secondary targets take +1d6.],
)
#emph[This is the spell that makes lightning mages grin. One bolt. Seven targets. The enemy formation goes from "tactical positioning" to "screaming chaos" in the time it takes to blink. Chain Lightning doesn't just hurt, it humiliates. The enemy commander watches his entire front line convulse simultaneously.]

=== Thunderclap Chain
<thunderclap-chain>
#strong[Disciplines:] Wind #emph[Sonic devastation. Not just lightning, the thunder that comes with it.]

==== Static Field (Novice)
<static-field-novice>
#strong[Disciplines:] 1 Wind #strong[Casting Time:] 1 action #strong[Range:] Self (10-foot radius) #strong[Duration:] Concentration, up to 1 minute #strong[Target:] Self (aura)

#strong[Description:] The air around you crackles with static electricity. Tiny arcs jump from your body to nearby creatures and objects. Anyone close enough to hit you gets a shock for their trouble.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d4 lightning damage to one creature entering or starting its turn in the field.],
  [Standard (9-14)], [1d6 lightning damage to any creature entering or starting its turn within 10 feet of you.],
  [Strong (15-18+)], [1d6 lightning damage in the aura. Creatures damaged have disadvantage on attacks against you while they remain in the field, their muscles won't cooperate.],
)
#emph[Close-range insurance. Static Field says "the area around me is not safe for you." It won't stop a determined enemy, but it'll make them pay for every step. Good for mages who find themselves surrounded more often than they'd like.]

==== Thunderclap (Adept)
<thunderclap-adept>
#strong[Disciplines:] 2 Wind, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self (20-foot radius) #strong[Duration:] Instantaneous #strong[Target:] All creatures within 20 feet

#strong[Description:] You slam your hands together and a thunderous shockwave erupts outward. The sound is deafening. The force is concussive. Anyone close enough to hear it is close enough to feel it.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 sonic damage in a 10-foot radius. Creatures are pushed 5 feet back.],
  [Standard (9-14)], [3d6 sonic damage in a 20-foot radius. Creatures are pushed 10 feet and deafened for 1 round.],
  [Strong (15-18+)], [4d6 sonic damage in a 25-foot radius. Creatures are pushed 15 feet, deafened for 1 minute, and knocked prone. Fragile objects in the area shatter.],
)
#emph[When they've surrounded you. When the Protector is down. When the only way out is through. Thunderclap clears your immediate vicinity with extreme prejudice. It's not elegant. It's not subtle. It's a hammer made of noise, and everyone within twenty feet is a nail.]

==== Storm Call (Master)
<storm-call-master>
#strong[Disciplines:] 3 Wind, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 200 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] 50-foot radius cylinder, 100 feet high

#strong[Description:] You point at the sky and the sky answers. A churning thunderhead coalesces above the battlefield. Lightning strikes where you direct. Thunder rolls. The storm is yours to command, each round, you call down another bolt.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Storm forms. One lightning strike per round: 2d6 lightning damage to one target. 30-foot radius.],
  [Standard (9-14)], [One strike per round: 4d6 lightning damage to one target within the storm, plus 2d6 sonic to all within 10 feet of the strike. 50-foot radius.],
  [Strong (15-18+)], [Two strikes per round. Each: 4d6 lightning to primary + 2d6 sonic to adjacent. You choose targets. The entire storm area is difficult terrain from wind and rain. Flying creatures are grounded.],
)
#emph[You don't throw lightning anymore. You become the storm. Every round for up to a minute, you pick someone in that 50-foot circle and the sky deletes them. The enemy can't formation up. They can't take cover. They can't fly over it. Storm Call is area denial on a divine scale, and you're the god holding the thunderbolts.]

#horizontalrule
#pagebreak()
#pagebreak()
== Acid Chains
<acid-chains>
Acid is the patient element. It doesn't explode. It doesn't freeze. It #emph[eats.] Acid magic corrodes armor, dissolves barriers, and keeps hurting long after the initial splash. Acid mages are methodical. They don't need to kill you this round, they just need the acid to finish its work before you finish yours. Spoiler: it will.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Caustic Spray Chain
<caustic-spray-chain>
#strong[Disciplines:] Earth #emph[Ranged acid attacks. Splash them, spray them, dissolve them.]

==== Acid Splash, Greater (Novice)
<acid-splash-greater-novice>
#strong[Disciplines:] 1 Earth #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] A concentrated orb of green-black acid hurtles toward your target. On impact, it bursts, the acid clings, smokes, and keeps eating through whatever it touches.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d6 acid damage. The acid sizzles and fades.],
  [Standard (9-14)], [2d6 acid damage. Target takes 1d4 ongoing acid damage at the start of its next turn.],
  [Strong (15-18+)], [3d6 acid damage. Ongoing damage is 1d6 and persists for 2 rounds. Armor's effectiveness is reduced by 1 until repaired.],
)
#emph[The first real acid spell. It's not the initial splash you should fear, it's what the acid does in the seconds after. While the enemy is still figuring out where you hit them, the acid is already three layers deeper.]

==== Caustic Spray (Adept)
<caustic-spray-adept>
#strong[Disciplines:] 2 Earth, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self (30-foot cone) #strong[Duration:] Instantaneous #strong[Target:] All creatures in a 30-foot cone

#strong[Description:] A torrent of corrosive acid sprays from your hands in a wide arc. Everything in front of you gets a chemical bath. Armor hisses. Flesh bubbles. The smell is unforgettable, and unforgivable.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 acid damage in a 15-foot cone.],
  [Standard (9-14)], [3d6 acid damage in a 30-foot cone. Targets take 1d4 ongoing damage for 2 rounds.],
  [Strong (15-18+)], [4d6 acid damage in a 30-foot cone. Ongoing damage is 1d6 for 3 rounds. Armor effectiveness reduced by 2 until repaired.],
)
#emph[For when one target isn't enough. Caustic Spray is the "I hate everything in this general direction" spell. It's messy. It's cruel. It'll ruin the furniture. But when a formation of armored soldiers is advancing on your position, "messy and cruel" is exactly what you need.]

==== Dissolve (Master)
<dissolve-master>
#strong[Disciplines:] 3 Earth, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Instantaneous (acid pool persists 1 minute) #strong[Target:] One creature or object

#strong[Description:] You point, and the target begins to come apart at the molecular level. Flesh runs like wax. Metal sloughs away in sheets. Stone crumbles. This is not damage, this is unmaking. The acid leaves a pool where the target stood.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [4d6 acid damage. Target's armor is reduced by 2 permanently until magically repaired.],
  [Standard (9-14)], [6d6 acid damage. Target loses any non-magical damage resistance for 1 minute. Armor reduced by 3. Acid pool (10-foot radius) deals 2d6 to anyone entering it.],
  [Strong (15-18+)], [9d6 acid damage. Target is partially dissolved, lose a limb, a weapon, or a piece of armor (DA's choice based on context). Acid pool is 15-foot radius, deals 3d6 per round, persists 1 minute.],
)
#emph[Dissolve is not a combat spell. It's a statement. You're telling the target that they are temporary, that their armor, their flesh, their very form is just a suggestion, and you've decided to revoke it. The pool it leaves behind ensures nobody else wants to stand where they stood.]

=== Corrode Chain
<corrode-chain>
#strong[Disciplines:] Earth #emph[Acid that targets equipment and barriers. Strip their defenses. Open the way.]

==== Corrode (Novice)
<corrode-novice>
#strong[Disciplines:] 1 Earth #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Instantaneous #strong[Target:] One object or piece of armor

#strong[Description:] A thin stream of acid eats into a specific target, a lock, a hinge, a shield, a breastplate. The acid is precise. It only destroys what you point it at.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The object is pitted and weakened. A second application will destroy it.],
  [Standard (9-14)], [A small object (lock, hinge, strap) is destroyed. Armor loses 1 point of effectiveness permanently. A shield is weakened, the next solid hit shatters it.],
  [Strong (15-18+)], [A medium object (door, shield, weapon) is destroyed. Armor loses 2 points. The acid splashes to an adjacent object for half effect.],
)
#emph[Locked door? Rusted mechanism? Enemy in plate mail who thinks they're invincible? Corrode is the answer. It's not flashy, but it solves problems that fire and lightning can't touch. Every party needs someone who can dissolve a lock.]

==== Melt Armor (Adept)
<melt-armor-adept>
#strong[Disciplines:] 2 Earth, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Instantaneous #strong[Target:] One creature in armor

#strong[Description:] The target's armor begins to smoke, then bubble, then run like hot wax. The metal or leather doesn't just weaken, it flows. Anyone inside is having a very bad day, and when the armor's gone, they're just meat.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Target's armor loses 1 point of effectiveness. 1d6 acid damage to the wearer.],
  [Standard (9-14)], [Armor loses 2 points. 2d6 acid damage. The armor is visibly ruined, straps melt, plates warp.],
  [Strong (15-18+)], [Armor loses 3 points (minimum 0). 3d6 acid damage. If armor reaches 0, the target takes an additional 2d6 as the acid reaches bare skin. Armor must be fully replaced.],
)
#emph[The great equalizer. That knight in full plate with Armor 4? Now they have Armor 1 and second-degree acid burns. Melt Armor doesn't just hurt, it changes the math of the entire fight. Your Blade will thank you. The knight won't.]

==== Acid Pit (Master)
<acid-pit-master>
#strong[Disciplines:] 3 Earth, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 100 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] 15-foot radius, 20 feet deep

#strong[Description:] The ground collapses into a seething pit of acid. Anything standing there falls in. The walls are slick with corrosive slime, climbing out is nearly impossible. The acid at the bottom doesn't stop eating until you stop concentrating.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [10-foot radius, 10 feet deep. 2d6 acid damage per round to creatures inside. Climbing out requires a Standard Agility check.],
  [Standard (9-14)], [15-foot radius, 20 feet deep. 3d6 acid damage per round. Walls are coated, climbing checks are Hard. Creatures inside also lose 1 Armor per round from corrosion.],
  [Strong (15-18+)], [20-foot radius, 30 feet deep. 4d6 acid damage per round. Climbing is Near-Impossible without magic or flight. Armor loss is 2 per round. The pit also dissolves non-magical weapons and shields dropped into it.],
)
#emph[The battlefield now has a hole full of death. Acid Pit is terrain control taken to its logical extreme. Drop it under the enemy's heavy hitters and watch them try to climb out while their armor dissolves around them. Some spells kill. Acid Pit makes the enemy wish they were dead.]

#horizontalrule
#pagebreak()
#pagebreak()
#figure([
#box(image("chapters/../assets/svg/placeholder-section.svg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 34: Arcane Spells Midpoint
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 34 --- Arcane spells chapter midpoint. Placeholder for final art. Use placeholder-section.svg dimensions: 400×300.]

#pagebreak()
== Force Chains
<force-chains>
Force magic is will made manifest. No fire, no ice, no lightning, just pure telekinetic energy hitting with the subtlety of a falling keep. Force spells bypass elemental resistance. They shatter barriers. They move objects and creatures with the same casual disregard for physics. Force mages don't burn you or freeze you. They just #emph[move] you, often through a wall.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Magic Missile Chain
<magic-missile-chain>
#strong[Disciplines:] Energy #emph[Pure force. Unerring. Unavoidable. The signature of the force mage.]

==== Magic Missile (Novice)
<magic-missile-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 80 feet #strong[Duration:] Instantaneous #strong[Target:] Up to 3 creatures

#strong[Description:] Bolts of shimmering force dart from your fingertips and streak unerringly toward your targets. Magic Missile doesn't miss. It doesn't care about cover, concealment, or armor. It finds its mark. Always.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1 missile. 1d4+1 force damage.],
  [Standard (9-14)], [3 missiles. Each deals 1d4+1 force damage. Can target different creatures or the same one.],
  [Strong (15-18+)], [5 missiles. Each deals 1d4+1 force damage. One target of your choice struck by at least two missiles is staggered, its next attack has disadvantage.],
)
#emph[The reliability spell. When the enemy has cover. When they're invisible. When they're running away and you're out of clever ideas. Magic Missile doesn't care about any of that. It cares about one thing: hitting what you point at. It's never let a mage down.]

==== Force Lance (Adept)
<force-lance-adept>
#strong[Disciplines:] 2 Energy #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] A concentrated beam of telekinetic force slams into the target like a battering ram made of light. The impact doesn't just hurt, it throws the target backward. Walls, cliffs, and hard surfaces compound the damage.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 force damage. Target is pushed 5 feet.],
  [Standard (9-14)], [4d6 force damage. Target is pushed 15 feet. If it strikes a solid surface, add 1d6.],
  [Strong (15-18+)], [6d6 force damage. Target is pushed 30 feet. Striking a surface adds 2d6 and knocks the target prone. If pushed off a ledge, standard falling damage applies on top.],
)
#emph[Force Lance turns the environment into a weapon. A push isn't just displacement, it's an opportunity. That enemy caster on the battlement? They're not on the battlement anymore. That ogre in front of the stone pillar? The ogre and the pillar are now one. Permanently.]

==== Disintegrate (Master)
<disintegrate-master>
#strong[Disciplines:] 3 Energy, 1 Fire #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Instantaneous #strong[Target:] One creature or object

#strong[Description:] A thin green ray springs from your finger. Whatever it touches is reduced to fine gray dust. Not burned. Not shattered. #emph[Unmade.] Creatures killed by Disintegrate leave only a pile of ash and the memory that they existed.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [4d6 force damage. The target's outermost layer (clothing, skin, armor surface) is dusted.],
  [Standard (9-14)], [8d6 force damage. A creature reduced to 0 HP by this damage is disintegrated, dust, no body, no resurrection short of a Master-tier divine spell. A 10-foot cube of non-magical matter is instantly destroyed.],
  [Strong (15-18+)], [12d6 force damage. Disintegration as above. A 15-foot cube of matter destroyed. Magical barriers and wards of Adept tier or lower are automatically broken by the ray.],
)
#emph[The final word in an argument. Disintegrate doesn't wound. It deletes. There is no body to bury. There is no armor to loot. There is a thin layer of dust and the smell of ozone. When you cast this spell, you're not fighting anymore. You're editing reality.]

=== Telekinesis Chain
<telekinesis-chain>
#strong[Disciplines:] Energy #emph[Move objects. Move creatures. Move the world.]

==== Push (Novice)
<push-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Instantaneous #strong[Target:] One creature or object up to 50 pounds

#strong[Description:] An invisible wave of force shoves your target. Not enough to kill, enough to reposition. Enough to make someone standing on a ledge suddenly not standing on a ledge.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Target is pushed 5 feet. Creatures larger than human-size are unaffected.],
  [Standard (9-14)], [Target is pushed 10 feet or knocked prone (your choice). Objects up to 50 pounds fly 15 feet.],
  [Strong (15-18+)], [Target is pushed 20 feet and knocked prone. Or you may pull the target 10 feet toward you instead.],
)
#emph[The first lesson of force magic: you don't need to hurt something to neutralize it. Gravity does the hurting for you. Push is a geometry spell. Master the geometry of the battlefield, and you'll kill more enemies with ledges and pits than you ever will with fireballs.]

==== Levitate (Adept)
<levitate-adept>
#strong[Disciplines:] 2 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 10 minutes #strong[Target:] One creature or object up to 500 pounds

#strong[Description:] The target floats. Straight up, if you want, up to 20 feet per round, or hangs suspended in place. No saving throw for objects. Creatures can resist if unwilling, but once they're up, they're up. And there's nothing to push off against.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Target levitates 5 feet. Unwilling creatures get a Reason check to resist. Duration 1 minute.],
  [Standard (9-14)], [Target levitates up to 20 feet per round. Objects up to 500 pounds. Unwilling creatures get a Standard Reason check. Duration 10 minutes.],
  [Strong (15-18+)], [As Standard, but unwilling creatures have disadvantage on the resistance check. You can move the target horizontally as well, 10 feet per round.],
)
#emph[Flight at the speed of thought. Yours, not theirs. Levitate an enemy melee fighter and they're a pinata. Levitate yourself and you're a sniper nest. Levitate the heavy gate and your party walks through. This spell is limited only by your creativity and your concentration.]

==== Telekinesis (Master)
<telekinesis-master>
#strong[Disciplines:] 3 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 10 minutes #strong[Target:] One creature or object up to 1,000 pounds

#strong[Description:] You seize a creature or object with raw telekinetic force and move it however you like, up, down, sideways, into a wall, off a cliff, through a window. Fine control is possible. Combat applications are numerous and deeply satisfying.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Move up to 250 pounds. 20 feet per round. Unwilling creatures get a Standard Reason check.],
  [Standard (9-14)], [Move up to 1,000 pounds. 30 feet per round. Unwilling creatures get a Hard Reason check. You may use the held creature as a weapon, slam it into another target for 4d6 force damage to both.],
  [Strong (15-18+)], [Move up to 2,000 pounds. 60 feet per round. Unwilling creatures have disadvantage on the check. You may restrain a held creature in place, it cannot move or act physically until it breaks free. You may also manipulate held objects with the precision of your own hands, pull levers, open chests, write letters.],
)
#emph[This is the spell that makes you wonder why you ever bothered with fire. Pick up the enemy commander. Hold them thirty feet in the air. Shake them. Ask if they'd like to reconsider their life choices. Telekinesis is not just combat magic, it's problem-solving magic. Every locked door, every pit trap, every heavy object between you and your goal is now subject to your will.]

=== Arcane Barrier Chain
<arcane-barrier-chain>
#strong[Disciplines:] Energy #emph[Defensive force magic. Shields. Walls. Impenetrable barriers of pure will.]

==== Shield (Novice)
<shield-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 reaction (when hit by an attack) #strong[Range:] Self #strong[Duration:] 1 round #strong[Target:] Self

#strong[Description:] A shimmering disk of force interposes itself between you and an incoming attack. The blow skids off the barrier like a knife off plate. The shield lingers for a moment, guarding against follow-up strikes.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [+1 Armor against the triggering attack only.],
  [Standard (9-14)], [+2 Armor until your next turn. Negates Magic Missile entirely.],
  [Strong (15-18+)], [+3 Armor until your next turn. Negates Magic Missile. The attacker takes 1d4 force feedback, the shield pushes back.],
)
#emph[When you see the axe coming and your life flashes before your eyes. Shield is a reaction, it's the spell that says "no" to a hit that already landed. Every force mage learns it. Every force mage uses it. It saves lives. It ends killing blows. It makes enemy Blades weep with frustration.]

==== Arcane Barrier (Adept)
<arcane-barrier-adept>
#strong[Disciplines:] 2 Energy, 1 Protection #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] A 10-foot by 10-foot plane, or a 5-foot radius dome

#strong[Description:] A wall of shimmering force springs into existence. It's transparent but solid, arrows bounce, spells splash, charging enemies get a face full of invisible wall. You shape it as a flat wall or a protective dome.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Wall has 15 HP. 10-foot square. Blocks physical projectiles.],
  [Standard (9-14)], [Wall has 30 HP. 15-foot square or 10-foot dome. Blocks physical and magical projectiles of Adept tier or lower. Creatures cannot pass through.],
  [Strong (15-18+)], [Wall has 50 HP. 20-foot square or 15-foot dome. Blocks everything short of a Master-tier spell. Allies behind the barrier have +2 Armor against attacks that originate from the other side.],
)
#emph[Cover on demand. Arcane Barrier is a portable wall, drop it between your party and the incoming arrow storm. Drop it in a doorway to seal a room. Drop it as a dome over a downed ally while the healer works. Force magic's answer to "we need a Protector right now."]

==== Prismatic Wall (Master)
<prismatic-wall-master>
#strong[Disciplines:] 3 Energy, 1 Protection #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 10 minutes #strong[Target:] A wall up to 30 feet long, 15 feet high, or a 10-foot radius sphere

#strong[Description:] A wall of layered, multicolored light springs into being. Each layer has a different destructive property. Passing through the wall means enduring all seven layers in sequence. Few things survive the trip. Nothing enjoys it.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Wall has 3 layers (fire, ice, lightning). Each deals 2d6 damage of its type to creatures passing through. 20-foot wall.],
  [Standard (9-14)], [Wall has 5 layers (fire, ice, lightning, acid, force). Each deals 3d6. 30-foot wall. Creatures passing through are also blinded for 1 round.],
  [Strong (15-18+)], [Full 7-layer wall (fire, ice, lightning, acid, force, necrotic, radiant). Each deals 4d6. Creatures passing through must make a Fortitude check for each layer or suffer that layer's secondary effect (burned, frozen, shocked, corroded, crushed, drained, blinded). The wall can be shaped as a 15-foot sphere.],
)
#emph[The wall at the end of the world. Prismatic Wall is not a barrier, it's a test. A test that almost everything fails. Seven layers of escalating magical destruction. Even if something survives the fire and the ice, the necrotic layer drains its life and the radiant layer burns what's left. This is the spell you cast when you need to say "this side is mine, that side is death, and the conversation is over."]

#horizontalrule
#pagebreak()
#pagebreak()
== Illusion Chains
<illusion-chains>
Illusion magic is the art of the lie that becomes truth. You don't burn the enemy, you make them burn their own allies. You don't become invisible, you convince the light that you were never there. Illusionists don't win fights with power. They win by making the enemy fight the wrong battle.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Phantasmal Image Chain
<phantasmal-image-chain>
#strong[Disciplines:] Energy #emph[Create convincing illusions. From a ghost sound to a full sensory assault.]

==== Minor Image (Novice)
<minor-image-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] A 5-foot cube

#strong[Description:] You create a static visual illusion, an object, a wall, a crate, a false door. It looks real until inspected. It can't move, make sound, or emit light, but in dim light or at a distance, it's indistinguishable from the real thing.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The image is slightly off, wrong shadows, odd proportions. Anyone within 10 feet notices automatically.],
  [Standard (9-14)], [Convincing static image. Physical inspection (touching it) reveals the illusion. Creatures must make a Reason check to disbelieve at a distance.],
  [Strong (15-18+)], [The image is perfect, it even casts appropriate shadows and reflects ambient light correctly. Reason checks to disbelieve have disadvantage.],
)
#emph[The first lie every illusionist tells. Minor Image is a box that isn't there, a wall that doesn't exist, a hole that's just floor. Will it fool a dragon? Probably not. Will it fool the goblin guard who's been on shift for eight hours and just wants his dinner? Almost certainly.]

==== Major Image (Adept)
<major-image-adept>
#strong[Disciplines:] 2 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 10 minutes #strong[Target:] A 20-foot cube

#strong[Description:] A full sensory illusion, sight, sound, smell, and even heat or cold. The image can move, speak, and react to the world around it in a pre-programmed way. A dragon that roars and shakes the ground. A collapsed tunnel that smells of fresh earth. A squadron of reinforcements cresting the hill.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [One sense is convincing. Others are absent or crude. 10-foot cube. Duration 1 minute.],
  [Standard (9-14)], [Full sensory illusion. 20-foot cube. Reacts to stimuli according to a simple script you set. Creatures must physically interact to automatically disbelieve. Duration 10 minutes.],
  [Strong (15-18+)], [As Standard, but the illusion is interactive, it responds plausibly to unexpected events for 1 round before the script breaks. Creatures disbelieving have disadvantage on the Reason check.],
)
#emph[Now you're not just lying, you're directing a play with the enemy as the audience. Major Image can be anything: a false army, a friendly face, a bottomless pit where the floor used to be. The enemy won't know what's real until they touch it, and by then, your Blade is already behind them.]

==== Phantasmal Force (Master)
<phantasmal-force-master>
#strong[Disciplines:] 3 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] You reach into a single creature's mind and build a reality only they can see. A swarm of insects devouring their flesh. The floor turning to lava beneath their feet. Their own sword writhing into a serpent in their grip. The target believes the illusion completely, and the damage is real because the target's mind makes it real.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 psychic damage per round. The illusion is static, a wall of fire, a pit. The target can attempt a Reason check each round to break free.],
  [Standard (9-14)], [4d6 psychic damage per round. The illusion is dynamic and responds to the target's actions. Reason checks are Hard. The target acts as if the illusion is completely real, it will avoid phantom hazards, fight phantom enemies, and ignore actual threats.],
  [Strong (15-18+)], [6d6 psychic damage per round. The illusion is a full sensory takeover. The target is effectively blinded and deafened to the real world. Reason checks are Near-Impossible. The target may attack allies it perceives as monsters or flee from imaginary threats.],
)
#emph[This is not a trick. This is an invasion. You're inside their head, building a nightmare tailored to their fears, and their own brain is doing the damage for you. Phantasmal Force turns an enemy's strongest asset, their mind, into a weapon pointed at their own throat.]

=== Invisibility Chain
<invisibility-chain>
#strong[Disciplines:] Energy #emph[Hide yourself. Hide others. Hide from reality itself.]

==== Blur (Novice)
<blur-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self #strong[Duration:] Concentration, up to 1 minute #strong[Target:] Self

#strong[Description:] Your form shimmers and blurs, making you frustratingly difficult to target. Arrows seem to pass through you. Sword swings connect with air where your shoulder should be. You're not invisible, you're just not quite where they think you are.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Attacks against you have a -1 penalty. The blur is noticeable, enemies know something is off.],
  [Standard (9-14)], [Attacks against you have disadvantage. Your position is known, you're just hard to hit.],
  [Strong (15-18+)], [Disadvantage on attacks against you. The first attack that misses you each round automatically targets an adjacent creature of your choice instead.],
)
#emph[Not invisibility, something almost better. Blur makes you a frustrating target without making you an unseen one. Enemies know where you are. They just can't land the hit. And when their axe passes through your afterimage and buries itself in the goblin next to you? That's not your problem.]

==== Invisibility (Adept)
<invisibility-adept>
#strong[Disciplines:] 2 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 hour #strong[Target:] One creature

#strong[Description:] The target vanishes from sight. Not camouflaged, #emph[gone.] They're still there. They still make sound, leave tracks, and can be detected by other means. But light no longer acknowledges them. The target remains invisible until they attack or cast a spell.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The target is translucent rather than fully invisible. Stealth checks have advantage. Duration 1 minute.],
  [Standard (9-14)], [Full invisibility. Attacks against the invisible creature have disadvantage. The invisibility breaks if the target attacks or casts a spell. Duration 1 hour.],
  [Strong (15-18+)], [As Standard, but the invisibility persists through one attack or spell cast. The target flickers back into visibility for a moment, then fades again. Only a second offensive action breaks the spell fully.],
)
#emph[The classic. Touch the rogue. Watch them disappear. Wait for the screaming to start from the enemy backline. Invisibility doesn't win fights, it wins fights before they start. Reconnaissance. Ambushes. The kind of positioning that turns a fair fight into an execution.]

==== Greater Invisibility (Master)
<greater-invisibility-master>
#strong[Disciplines:] 3 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] Perfect invisibility. The target vanishes and stays vanished, attacking, casting, shouting, none of it breaks the spell. For one minute, the target is a ghost with a sword, a fireball with no visible source, a death sentence delivered from empty air.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Invisibility that persists through movement and non-offensive actions. Breaks on attack. Duration 30 seconds (5 rounds).],
  [Standard (9-14)], [Full invisibility. Does not break on attack or spellcasting. Attacks from invisibility have advantage. Enemies attacking the target have disadvantage. Duration 1 minute.],
  [Strong (15-18+)], [As Standard, but attacks from invisibility are automatic Strong results against unaware targets. The target is also silenced, no footfalls, no breathing, no verbal spell components audible to others.],
)
#emph[This is the spell that makes assassins weep with envy. One minute of absolute invisibility. Attack, and you stay hidden. Cast, and the magic has no visible origin. You're not a combatant anymore, you're a poltergeist with a grudge and a very sharp knife. Greater Invisibility doesn't tilt the odds. It throws the odds out the window and replaces them with certainty.]

#horizontalrule
#pagebreak()
#pagebreak()
== Charm Chains
<charm-chains>
Charm magic is the whisper that becomes a command. It doesn't burn. It doesn't freeze. It simply makes the enemy #emph[agree] with you. Against a charmed foe, the deadliest sword arm in the realm becomes a hand offering you a cup of tea. Charm mages are diplomats, interrogators, and puppet-masters. They win conflicts without leaving scorch marks, but the scars they leave run deeper.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Befriend Chain
<befriend-chain>
#strong[Disciplines:] Energy #emph[Make them like you. Make them trust you. Make them yours.]

==== Befriend (Novice)
<befriend-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] 1 hour #strong[Target:] One humanoid creature

#strong[Description:] Your words take on a honeyed quality. The target regards you as a friendly acquaintance, someone they'd like to help, within reason. They won't fight for you or betray their deepest loyalties, but a door held open, a question answered, a guard looking the other way? That's just being neighborly.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The target is merely cordial. They'll hear you out but offer no special treatment.],
  [Standard (9-14)], [The target treats you as a friend for 1 hour. They'll offer reasonable assistance and won't attack you. They get a Reason check if you ask for something dangerous.],
  [Strong (15-18+)], [The target is genuinely charmed. They'll go out of their way to help. Reason checks to resist unreasonable requests have disadvantage.],
)
#emph[The spell that opens more doors than any battering ram. Befriend doesn't enslave, it just makes the world a little friendlier. The guard who was going to report you is now the guard who "didn't see anything." The merchant who was going to gouge you now offers the "friends and family" price. Use it wisely. Friendships forged by magic don't survive the spell's expiration.]

==== Suggestion (Adept)
<suggestion-adept>
#strong[Disciplines:] 2 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Concentration, up to 8 hours #strong[Target:] One creature

#strong[Description:] You speak a short, reasonable-sounding command, and the target feels an overwhelming urge to obey. "Your horse looks tired. You should give it to me." "These aren't the travelers you're looking for." "You should go home and rethink your life." The suggestion must sound plausible, you can't order someone to jump off a cliff, but within those bounds, you'd be amazed what sounds reasonable to a charmed mind.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The suggestion must be something the target was already inclined to do. Duration 1 hour.],
  [Standard (9-14)], [The target follows any reasonable-sounding suggestion for up to 8 hours or until the task is complete. Obviously harmful suggestions automatically fail. The target gets a Reason check to resist if the suggestion conflicts with their core values.],
  [Strong (15-18+)], [The target follows the suggestion with enthusiasm. They'll rationalize away minor contradictions. Duration extends to 24 hours. The Reason check to resist has disadvantage.],
)
#emph[The voice that sounds like their own better judgment. Suggestion doesn't overpower the will, it sidesteps it entirely. The target thinks obeying was their idea. This is the spell that turns enemies into assets, guards into escorts, and hostile witnesses into character references.]

==== Dominate (Master)
<dominate-master>
#strong[Disciplines:] 3 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] You seize total control of the target's body and mind. They are your puppet. You decide where they move, what they say, who they attack. They're aware of what's happening, trapped inside their own skull, screaming, but their body obeys only you.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [You control the target's movement for 1 round. They cannot take actions you don't command, but they can resist commands that are directly self-destructive.],
  [Standard (9-14)], [Full control for 1 minute. You dictate movement, actions, and speech. The target gets a Reason check to resist each round. Directly suicidal commands grant advantage on the check.],
  [Strong (15-18+)], [Full control for 1 minute. The target's Reason checks have disadvantage. You can force them to attack allies, reveal secrets, or take actions against their nature. When the spell ends, the target has no memory of what they did under your control.],
)
#emph[This is the dark side of charm magic. Dominate doesn't persuade, it possesses. You reach into a creature's mind, take the wheel, and drive them wherever you want. In combat, you turn the enemy's strongest fighter against their own side. Outside combat, you have a key that opens any mouth and any door. The ethical implications are between you and whatever gods you answer to.]

=== Confusion Chain
<confusion-chain>
#strong[Disciplines:] Energy #emph[Disrupt the mind. Scramble thought. Turn order into chaos.]

==== Daze (Novice)
<daze-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] A sharp psychic pulse rattles the target's mind. For a crucial moment, they forget what they were doing, their weapon wavers, their spell fizzles, their tactical genius evaporates into static.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The target hesitates. Its next action is delayed until the end of the initiative order.],
  [Standard (9-14)], [The target loses its next action entirely, it stands blinking, mind blank.],
  [Strong (15-18+)], [The target loses its next action and its reaction until the end of its next turn. It also provokes attacks of opportunity from all adjacent creatures.],
)
#emph[A moment of mental silence in the middle of a fight. Daze doesn't hurt. It doesn't last. But in combat, a single missed action is the difference between victory and a body on the floor. Time it right, when the enemy caster is about to unleash, when the enemy Blade has your healer cornered, and Daze is as deadly as any fireball.]

==== Confusion (Adept)
<confusion-adept>
#strong[Disciplines:] 2 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] 15-foot radius

#strong[Description:] A wave of psychic chaos washes over the area. Creatures caught in it lose the ability to distinguish friend from foe, danger from safety, smart decisions from catastrophic ones. They act randomly, attacking allies, fleeing phantom threats, or standing paralyzed with indecision.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d4 creatures in the area are affected for 1 round. Random behavior: attack nearest creature, flee, or do nothing.],
  [Standard (9-14)], [All creatures in a 15-foot radius are affected for 1 minute. Each round, each affected creature rolls 1d6: 1-2 attack nearest creature, 3-4 flee from nearest creature, 5-6 act normally. Reason check each round to shake it off.],
  [Strong (15-18+)], [As Standard, but the radius is 25 feet. Affected creatures have disadvantage on the Reason check. The first round automatically produces the worst possible result for each creature.],
)
#emph[Battlefield chaos in a can. Confusion doesn't kill anyone itself, it makes the enemy kill each other. Drop it on the enemy formation and watch their carefully planned tactics dissolve into a bar brawl. The ogre attacks the goblin. The commander flees from her own standard-bearer. The archer shoots the ceiling. Somewhere, a god of trickery is laughing.]

==== Mass Confusion (Master)
<mass-confusion-master>
#strong[Disciplines:] 3 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 100 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] 30-foot radius

#strong[Description:] A torrent of psychic chaos floods the battlefield. Dozens of minds are scrambled simultaneously. The enemy army becomes a mob of individuals fighting shadows, fleeing allies, and screaming at things only they can see. The formation collapses. The battle becomes a riot.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 creatures in a 20-foot radius affected by Confusion (as the Adept spell) for 1d4 rounds.],
  [Standard (9-14)], [All creatures in a 30-foot radius affected for 1 minute. Confusion effects. Additionally, affected creatures cannot communicate, their speech comes out as gibberish. Spellcasters in the area must make a Reason check to cast.],
  [Strong (15-18+)], [All creatures in a 40-foot radius affected. Confusion effects. No communication. Spellcasting requires a Hard Reason check. At the start of each round, one affected creature of your choice suffers a hallucination so vivid it takes 4d6 psychic damage.],
)
#emph[An entire enemy formation, reduced to screaming chaos. Mass Confusion is the spell that ends battles before the bloodshed begins. When the enemy can't tell their allies from their nightmares, your party doesn't need to fight, they just need to wait. Cleanup, not combat. The hard part is convincing your Blade not to wade in and start swinging anyway.]

#horizontalrule
#pagebreak()
#pagebreak()
== Necromancy Chains
<necromancy-chains>
Necromancy is the magic of the threshold, the doorway between life and death, and what happens when you hold it open. It drains life. It raises corpses. It reminds the living that their time is borrowed. Necromancers are feared for good reason. The power they wield is not evil by nature, but it's damn easy to use it that way.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Vampiric Touch Chain
<vampiric-touch-chain>
#strong[Disciplines:] Energy #emph[Drain life. Feed on the living. Trade their vitality for yours.]

==== Chill Touch, Greater (Novice)
<chill-touch-greater-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] Your hand becomes a conduit to the grave. Your touch drains warmth and vitality, not enough to kill, but enough to remind the target of their mortality. The stolen life energy knits your wounds closed.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1d6 necrotic damage. You regain 1 HP.],
  [Standard (9-14)], [2d6 necrotic damage. You regain HP equal to half the damage dealt (round up).],
  [Strong (15-18+)], [3d6 necrotic damage. You regain HP equal to the damage dealt. Excess healing becomes temporary HP that lasts 1 minute.],
)
#emph[Touch of the grave. Chill Touch is a necromancer's first taste of the transaction: their life for yours. It's a dangerous spell, you have to be close enough to touch. But when you're wounded and the enemy is in your face, swapping some of their vitality for yours feels less like dark magic and more like justice.]

==== Vampiric Touch (Adept)
<vampiric-touch-adept>
#strong[Disciplines:] 2 Energy, 1 Water #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature per round

#strong[Description:] Your hand drips with shadow. For the spell's duration, you can make a melee spell attack each round, your touch drains life in great, gasping quantities and feeds it directly into you. This isn't a one-time transaction. This is a feeding.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2d6 necrotic damage per touch. Heal for half. Spell lasts 3 rounds.],
  [Standard (9-14)], [4d6 necrotic damage per touch. Heal for half. You can make one touch attack each round for 1 minute.],
  [Strong (15-18+)], [6d6 necrotic damage per touch. Heal for half. Each successful touch also weakens the target, it has disadvantage on its next attack. You gain +1 Armor (stacks up to +3) as stolen vitality shields you.],
)
#emph[The spell that makes you a monster, in the best possible way. Vampiric Touch turns you into a melee threat that gets stronger as the fight goes on. Every round, you hurt them and heal yourself. The math of attrition bends in your favor. Your allies may look at you differently afterward. Let them. You're still standing.]

==== Finger of Death (Master)
<finger-of-death-master>
#strong[Disciplines:] 3 Energy, 1 Water #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] You point, and death answers. Negative energy, the raw stuff of un-life, pours through your finger in a black ray. A creature killed by this spell doesn't just die. It rises, immediately, as a zombie under your control. Forever.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [4d6 necrotic damage. Target is sickened, disadvantage on attacks for 1 round.],
  [Standard (9-14)], [8d6 necrotic damage. A humanoid killed by this damage rises at the start of your next turn as a zombie permanently under your control (max 1 zombie from this spell at a time).],
  [Strong (15-18+)], [12d6 necrotic damage. A creature killed rises as a zombie. You may have up to 3 Finger of Death zombies at once. The zombie retains the base physical stats it had in life.],
)
#emph[The signature spell of necromancy. Finger of Death doesn't just kill, it recruits. Every enemy you drop with this spell becomes another soldier in your growing army. The BBEG's most loyal lieutenant? Now she's your most loyal lieutenant. She's not happy about it. She doesn't get a vote.]

=== Animate Dead Chain
<animate-dead-chain>
#strong[Disciplines:] Energy #emph[Raise the fallen. Build your army from the enemy's casualties.]

==== Raise Skeleton (Novice)
<raise-skeleton-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 minute #strong[Range:] Touch #strong[Duration:] 1 hour #strong[Target:] One corpse or pile of bones

#strong[Description:] You infuse a dead body with a spark of animating energy. The skeleton pulls itself free of the rotting flesh, or assembles itself from scattered bones, and stands awaiting your command. It's mindless, obedient, and completely disposable.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The skeleton is fragile, 5 HP, attacks at -2. Duration 10 minutes.],
  [Standard (9-14)], [Skeleton has 10 HP. Uses your Proficiency for attacks. Simple commands only, guard, attack, carry. Duration 1 hour.],
  [Strong (15-18+)], [As Standard, but the skeleton has 15 HP and can follow moderately complex commands, "guard this door and attack anyone who isn't wearing a blue cloak." Duration 2 hours.],
)
#emph[Your first soldier. Raise Skeleton gives you an extra pair of bony hands, a flanking partner, a trap-tester, a silent sentry who doesn't need to sleep. It won't win fights on its own, but it'll take hits meant for you. And there's something to be said for sending a skeleton through every doorway first.]

==== Animate Dead (Adept)
<animate-dead-adept>
#strong[Disciplines:] 2 Energy, 1 Earth #strong[Casting Time:] 1 minute #strong[Range:] Touch #strong[Duration:] 24 hours #strong[Target:] Up to 3 corpses

#strong[Description:] You reach into the space between life and death and pull. Multiple corpses stir. Flesh knits with shadow. Eyes that saw nothing now see only your will. You raise up to three skeletons or zombies, or reassert control over undead you've already created.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1 skeleton or zombie. 10 HP. Simple commands. Duration 1 hour.],
  [Standard (9-14)], [Up to 3 skeletons/zombies. Each has 15 HP. They act on your initiative as a group. You can give them a standing order they'll follow until completed. Duration 24 hours.],
  [Strong (15-18+)], [Up to 5 undead. 20 HP each. They can follow moderately complex orders. One of them may be a zombie that retains fragments of its living skills, it can use one weapon proficiency or skill it had in life.],
)
#emph[Now you have a squad. Animate Dead turns a fresh battlefield into a recruitment drive. Three bodies become three soldiers. They don't complain. They don't need pay. They don't question orders. The living have limits. The dead have your permission.]

==== Create Undead (Master)
<create-undead-master>
#strong[Disciplines:] 3 Energy, 1 Earth #strong[Casting Time:] 1 hour #strong[Duration:] Permanent until destroyed #strong[Target:] Up to 3 corpses

#strong[Description:] This is not animation, it's creation. You forge undead with purpose and power. Ghouls with paralytic claws. Wights that drain life with every strike. These are not mindless servants, they're weapons with instincts, loyal only to you, existing only to fulfill your commands.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [2 ghouls. 25 HP each. Claw attack (2d6 slashing + paralysis on Strong). Simple commands. Permanent.],
  [Standard (9-14)], [3 ghouls or 1 wight. Ghouls as above. Wight: 40 HP, longsword (4d6 slashing), life drain touch (3d6 necrotic, heals wight). Intelligent enough for tactical commands. Permanent.],
  [Strong (15-18+)], [3 wights or 1 wraith. Wights as above. Wraith: 50 HP, incorporeal, touch deals 4d6 necrotic + 1d6 Constitution damage. Can phase through walls. Intelligent and malevolent. Permanent.],
)
#emph[This is the spell that makes kingdoms nervous. Create Undead gives you permanent, intelligent, self-directed minions. They don't expire at dawn. They don't forget their orders. They wait in the dark, forever, for your command. Use this spell carefully. The dead remember who made them, and they're patient.]

#horizontalrule
#pagebreak()
#pagebreak()
== Transmutation Chains
<transmutation-chains>
Transmutation is the magic of becoming. It reshapes flesh, bone, and steel. It speeds the body beyond natural limits. It turns skin to stone and stone to diamond. Transmuters are engineers of the physical form. They don't destroy, they transform. What emerges from their magic is stronger, faster, and harder than what went in.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Haste Chain
<haste-chain>
#strong[Disciplines:] Energy #emph[Speed beyond nature. Move faster, hit harder, do more.]

==== Enhance (Novice)
<enhance-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] You infuse the target with magical vigor. Muscles twitch with energy. Reflexes sharpen. For the next minute, they're just a little bit better at everything physical, not superhuman, but the best version of themselves.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [+1 to one physical attribute (Brawn, Fortitude, or Agility) for 1 minute.],
  [Standard (9-14)], [+1 to two physical attributes for 1 minute. Target's speed increases by 5 feet.],
  [Strong (15-18+)], [+1 to all three physical attributes for 1 minute. Speed +10 feet. Target gains one additional reaction during the duration.],
)
#emph[The first transmutation most mages learn. Enhance doesn't transform, it optimizes. Your Blade hits a little harder. Your Protector holds the line a little longer. Your own legs carry you a little faster when it's time to not be where the dragon is breathing.]

==== Haste (Adept)
<haste-adept>
#strong[Disciplines:] 2 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] Time bends around the target. They move in a blur, striking twice where they'd strike once, crossing the battlefield between heartbeats, catching arrows out of the air. When the spell ends, the target crashes hard. Haste is a loan, and the body always pays it back with interest.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Target gains +1 action per round (attack or move only). Speed +10. Duration 3 rounds. No crash.],
  [Standard (9-14)], [Speed doubled. +2 Armor (time to dodge). One additional action per round, attack, move, or use an object. Duration 1 minute. When the spell ends, the target loses its next action (crash).],
  [Strong (15-18+)], [As Standard, but speed tripled. The additional action can be anything except casting a spell of Adept tier or higher. The target's attacks have advantage against creatures that haven't acted yet this round. Crash is only a lost reaction.],
)
#emph[The best buff in the game, bar none. Haste turns your Blade into a food processor. Your Protector into a wall that's everywhere at once. Yourself into a problem that's already solved by the time the enemy realizes there's a problem. The crash at the end is real, but if the fight's not over by then, you used Haste wrong.]

==== Time Stop (Master)
<time-stop-master>
#strong[Disciplines:] 3 Energy, 1 Wind #strong[Casting Time:] 1 action #strong[Range:] Self #strong[Duration:] 2-5 rounds of apparent time #strong[Target:] Self

#strong[Description:] You step between the ticks of the clock. Time stops for everyone but you. The world freezes, arrows hang in the air, spells pause mid-detonation, enemies are statues. You have a handful of subjective rounds to act before reality catches up and remembers it was supposed to be moving.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Time stops for 1d2 rounds. You cannot directly harm creatures during the stop, offensive spells and attacks break the effect. You can move, manipulate objects, and cast non-offensive spells.],
  [Standard (9-14)], [Time stops for 1d4+1 rounds. You can act freely, attack, cast, move, use items. Damage is applied simultaneously when time resumes. You cannot affect creatures outside a 30-foot radius of your starting position.],
  [Strong (15-18+)], [Time stops for 1d4+2 rounds. No range limit on your actions. You may cast one Master-tier spell during the stop without expending its per-session use, the time magic pays the cost. When time resumes, all your actions resolve in the order you performed them.],
)
#emph[This is why transmuters are terrifying. Time Stop gives you 12 to 30 seconds of subjective time in a frozen world. Walk through the enemy formation. Place a Fireball at every exit. Read the villain's diary over their shoulder. Empty their component pouch. Then resume time and watch everything happen at once. The ultimate transmutation isn't changing matter, it's changing the rules of cause and effect.]

=== Stone Skin Chain
<stone-skin-chain>
#strong[Disciplines:] Energy #emph[Transform your body. Become harder. Become untouchable.]

==== Stone Skin (Novice)
<stone-skin-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self #strong[Duration:] Concentration, up to 10 minutes #strong[Target:] Self

#strong[Description:] Your skin hardens and grays, taking on the texture and resilience of granite. You move a little slower, but blades that would have cut deep now chip and skitter across your surface.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [+1 Armor. Speed reduced by 5 feet. Duration 1 minute.],
  [Standard (9-14)], [+2 Armor. Resistance to non-magical slashing and piercing damage. Speed reduced by 5 feet. Duration 10 minutes.],
  [Strong (15-18+)], [+3 Armor. Resistance to all non-magical physical damage. No speed reduction, the stone moves with you.],
)
#emph[Armor for the naked mage. Stone Skin is the spell you cast before the fight starts, when you know you're walking into a storm of steel. You're harder to hurt, harder to move, harder to kill. The enemy will break their weapons on you, and you'll still be standing when they run out of sharp things.]

==== Iron Body (Adept)
<iron-body-adept>
#strong[Disciplines:] 2 Energy, 1 Earth #strong[Casting Time:] 1 action #strong[Range:] Self #strong[Duration:] Concentration, up to 1 minute #strong[Target:] Self

#strong[Description:] Your flesh transmutes to living iron. You're heavier, denser, and almost impossible to damage with conventional weapons. Your fists hit like warhammers. Fire, ice, and lightning wash over you with diminished effect. You are, for one minute, a walking siege engine.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [+3 Armor. Unarmed strikes deal 2d6 bludgeoning. Speed halved. Duration 3 rounds.],
  [Standard (9-14)], [+4 Armor. Unarmed strikes deal 3d6 bludgeoning. Resistance to fire, ice, and lightning. Immune to poison and disease. Speed halved. You weigh 500 pounds, wooden floors may not support you. Duration 1 minute.],
  [Strong (15-18+)], [+5 Armor. Unarmed strikes deal 4d6. Resistance to all elemental damage. Immune to poison, disease, and critical hits. Speed is normal, the iron is somehow weightless to you. You can punch through stone walls.],
)
#emph[You are now the party's Protector, regardless of what your character sheet says. Iron Body doesn't make you harder to hurt. It makes hurting you a bad idea. Walk into melee. Let them swing. When their blades shatter and their spells fizzle, smile with your iron teeth and remind them why transmuters don't need bodyguards.]

==== Diamond Form (Master)
<diamond-form-master>
#strong[Disciplines:] 3 Energy, 1 Earth #strong[Casting Time:] 1 action #strong[Range:] Self #strong[Duration:] Concentration, up to 1 minute #strong[Target:] Self

#strong[Description:] Your body crystallizes into living diamond. Light refracts through you in prismatic bursts. You are nearly invulnerable, the hardest substance in existence, shaped like a person, moving with lethal purpose. Spells bounce off you. Weapons shatter on contact. You are the pinnacle of defensive transmutation, and for one minute, nothing in the world can break you.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [+4 Armor. Unarmed strikes deal 3d6. Resistance to all damage. Speed halved. Duration 3 rounds.],
  [Standard (9-14)], [+5 Armor. Unarmed strikes deal 4d6. Resistance to all damage. Immune to critical hits and precision damage. Spells of Adept tier or lower reflect off you, the caster takes the effect instead. Duration 1 minute.],
  [Strong (15-18+)], [+6 Armor. Unarmed strikes deal 5d6. Immunity to all damage except force. Spells of any tier that target only you are reflected. Your body emits bright light in a 30-foot radius, undead and fiends in the light take 2d6 radiant damage per round. You can walk through walls by crystallizing and recrystallizing on the other side.],
)
#emph[This is what perfection looks like. Diamond Form is the ultimate defensive transmutation, your body becomes the hardest substance in creation, and magic itself bounces off your crystalline skin. For one minute, you're not a combatant. You're a force of nature. The enemy can't hurt you, can't spell you, can't stop you. When the diamond mage walks into the room, the room changes. Usually by evacuating.]

#horizontalrule
#pagebreak()
#pagebreak()
== Arcane Spell Quick Reference
<arcane-spell-quick-reference>
#table(
  columns: (15.56%, 13.33%, 22.22%, 28.89%, 20%),
  align: (auto,auto,auto,auto,auto,),
  table.header([Spell], [Tier], [Category], [Disciplines], [Summary],),
  table.hline(),
  [Arcane Mark], [Cantrip], [Universal], [None], [Inscribe permanent invisible sigil],
  [Dancing Lights], [Cantrip], [Universal], [None], [Create up to 4 moving light orbs],
  [Frost Touch], [Cantrip], [Ice], [None], [Touch deals 1d6 ice, freezes liquids],
  [Ghost Sound], [Cantrip], [Illusion], [None], [Create sounds from a distance],
  [Mage Hand], [Cantrip], [Force], [None], [Spectral hand manipulates objects],
  [Prestidigitation], [Cantrip], [Universal], [None], [Minor magical tricks and effects],
  [Spark], [Cantrip], [Fire], [None], [Ignite flammable objects at range],
  [Static Shock], [Cantrip], [Lightning], [None], [1d6 lightning, +1 vs.~metal armor],
  [Acid Splash], [Cantrip], [Acid], [None], [1d6 acid, ignores 1 hardness],
  [Whisper], [Cantrip], [Universal], [None], [Send 25-word mental message],
  [], [], [], [], [],
  [Firebolt], [Novice], [Fire], [1 Fire], [2d6 fire, ignites objects],
  [Fireball], [Adept], [Fire], [2 Fire, 1 Energy], [4d6 fire in 15-ft radius],
  [Inferno], [Master], [Fire], [3 Fire, 1 Energy], [6d6 fire in 30-ft radius, terrain hazard],
  [], [], [], [], [],
  [Burning Hands], [Novice], [Fire], [1 Fire], [1d6 fire in 15-ft cone],
  [Wall of Fire], [Adept], [Fire], [2 Fire, 1 Energy], [3d6 fire, 40-ft wall, concentration],
  [Volcanic Eruption], [Master], [Fire], [3 Fire, 1 Earth], [4d6 fire + 1d6 bludgeoning, 20-ft radius, lava field],
  [], [], [], [], [],
  [Scorching Ray], [Novice], [Fire], [1 Fire], [Two rays, 1d8 fire each],
  [Flame Strike], [Adept], [Fire], [2 Fire, 1 Energy], [4d6 (half radiant) in 10-ft radius],
  [Meteor Swarm], [Master], [Fire], [3 Fire, 1 Earth], [Four 20-ft meteors, 4d6 fire + 2d6 bludgeoning each],
  [], [], [], [], [],
  [Frost Ray], [Novice], [Ice], [1 Water], [2d6 ice, slows target],
  [Ice Storm], [Adept], [Ice], [2 Water, 1 Wind], [3d6 ice + 1d6 bludgeoning, 20-ft radius, slippery terrain],
  [Blizzard], [Master], [Ice], [3 Water, 1 Wind], [3d6 ice/round, 40-ft radius, heavy obscurement],
  [], [], [], [], [],
  [Chill Touch], [Novice], [Ice], [1 Water], [2d6 ice, touch, disadvantage on next attack],
  [Freeze Solid], [Adept], [Ice], [2 Water, 1 Energy], [Restrain + 2d6 ice, ongoing damage],
  [Glacial Prison], [Master], [Ice], [3 Water, 1 Energy], [Imprison in ice, 4d6 initial + 2d6/round],
  [], [], [], [], [],
  [Frost Armor], [Novice], [Ice], [1 Water], [+2 Armor, melee attackers take 1d4 ice],
  [Ice Shield], [Adept], [Ice], [2 Water, 1 Protection], [Reaction: reduce damage by 2d6, +2 Armor for round],
  [Frozen Aegis], [Master], [Ice], [3 Water, 1 Protection], [+3 Armor, cold immunity, can shatter for 4d6 AoE],
  [], [], [], [], [],
  [Shock], [Novice], [Lightning], [1 Wind], [2d6 lightning, touch, dazes target],
  [Lightning Bolt], [Adept], [Lightning], [2 Wind, 1 Energy], [4d6 lightning in 60-ft line],
  [Chain Lightning], [Master], [Lightning], [3 Wind, 1 Energy], [6d6 primary + 3d6 to 4 secondary targets],
  [], [], [], [], [],
  [Static Field], [Novice], [Lightning], [1 Wind], [1d6 lightning aura, 10-ft radius],
  [Thunderclap], [Adept], [Lightning], [2 Wind, 1 Energy], [3d6 sonic in 20-ft radius, pushes + deafens],
  [Storm Call], [Master], [Lightning], [3 Wind, 1 Energy], [4d6 lightning strike/round, 50-ft radius storm],
  [], [], [], [], [],
  [Acid Splash, Greater], [Novice], [Acid], [1 Earth], [2d6 acid, 1d4 ongoing],
  [Caustic Spray], [Adept], [Acid], [2 Earth, 1 Energy], [3d6 acid in 30-ft cone, ongoing damage],
  [Dissolve], [Master], [Acid], [3 Earth, 1 Energy], [6d6 acid, destroys armor, leaves acid pool],
  [], [], [], [], [],
  [Corrode], [Novice], [Acid], [1 Earth], [Destroy small object, reduce armor by 1],
  [Melt Armor], [Adept], [Acid], [2 Earth, 1 Energy], [Reduce armor by 2, 2d6 acid to wearer],
  [Acid Pit], [Master], [Acid], [3 Earth, 1 Energy], [15-ft pit, 3d6 acid/round, dissolves armor],
  [], [], [], [], [],
  [Magic Missile], [Novice], [Force], [1 Energy], [3 missiles, 1d4+1 force each, never misses],
  [Force Lance], [Adept], [Force], [2 Energy], [4d6 force, pushes target 15 ft],
  [Disintegrate], [Master], [Force], [3 Energy, 1 Fire], [8d6 force, turns target to dust],
  [], [], [], [], [],
  [Push], [Novice], [Force], [1 Energy], [Push target 10 ft or knock prone],
  [Levitate], [Adept], [Force], [2 Energy, 1 Wind], [Float target up to 20 ft/round],
  [Telekinesis], [Master], [Force], [3 Energy, 1 Wind], [Move up to 1,000 lbs, 30 ft/round],
  [], [], [], [], [],
  [Shield], [Novice], [Force], [1 Energy], [Reaction: +2 Armor for 1 round],
  [Arcane Barrier], [Adept], [Force], [2 Energy, 1 Protection], [30 HP force wall, 15-ft square or 10-ft dome],
  [Prismatic Wall], [Master], [Force], [3 Energy, 1 Protection], [7-layer wall, 3d6/layer, blocks everything],
  [], [], [], [], [],
  [Minor Image], [Novice], [Illusion], [1 Energy], [Static visual illusion, 5-ft cube],
  [Major Image], [Adept], [Illusion], [2 Energy, 1 Wind], [Full sensory illusion, 20-ft cube, can move],
  [Phantasmal Force], [Master], [Illusion], [3 Energy, 1 Wind], [Psychic assault, 4d6/round, target believes illusion],
  [], [], [], [], [],
  [Blur], [Novice], [Illusion], [1 Energy], [Disadvantage on attacks against you],
  [Invisibility], [Adept], [Illusion], [2 Energy, 1 Wind], [Invisible 1 hour, breaks on attack],
  [Greater Invisibility], [Master], [Illusion], [3 Energy, 1 Wind], [Invisible 1 minute, stays invisible while attacking],
  [], [], [], [], [],
  [Befriend], [Novice], [Charm], [1 Energy], [Target treats you as friend for 1 hour],
  [Suggestion], [Adept], [Charm], [2 Energy, 1 Wind], [Target follows reasonable command, up to 8 hours],
  [Dominate], [Master], [Charm], [3 Energy, 1 Wind], [Full control of target for 1 minute],
  [], [], [], [], [],
  [Daze], [Novice], [Charm], [1 Energy], [Target loses next action],
  [Confusion], [Adept], [Charm], [2 Energy, 1 Wind], [Creatures in 15-ft radius act randomly],
  [Mass Confusion], [Master], [Charm], [3 Energy, 1 Wind], [30-ft radius, confusion + no communication],
  [], [], [], [], [],
  [Chill Touch, Greater], [Novice], [Necromancy], [1 Energy], [2d6 necrotic, heal half damage],
  [Vampiric Touch], [Adept], [Necromancy], [2 Energy, 1 Water], [4d6 necrotic/round, heal half, concentration],
  [Finger of Death], [Master], [Necromancy], [3 Energy, 1 Water], [8d6 necrotic, killed targets rise as zombies],
  [], [], [], [], [],
  [Raise Skeleton], [Novice], [Necromancy], [1 Energy], [Animate 1 skeleton for 1 hour],
  [Animate Dead], [Adept], [Necromancy], [2 Energy, 1 Earth], [Raise up to 3 skeletons/zombies for 24 hours],
  [Create Undead], [Master], [Necromancy], [3 Energy, 1 Earth], [Create permanent ghouls, wights, or wraith],
  [], [], [], [], [],
  [Enhance], [Novice], [Transmutation], [1 Energy], [+1 to two physical attributes, 1 minute],
  [Haste], [Adept], [Transmutation], [2 Energy, 1 Wind], [Double speed, +1 action/round, 1 minute],
  [Time Stop], [Master], [Transmutation], [3 Energy, 1 Wind], [Freeze time for 1d4+1 rounds],
  [], [], [], [], [],
  [Stone Skin], [Novice], [Transmutation], [1 Energy], [+2 Armor, resist non-magical physical],
  [Iron Body], [Adept], [Transmutation], [2 Energy, 1 Earth], [+4 Armor, 3d6 unarmed, elemental resist],
  [Diamond Form], [Master], [Transmutation], [3 Energy, 1 Earth], [+5 Armor, reflect spells, near-invulnerable],
)
= Divine Cantrips
<divine-cantrips>
﻿\# Divine Spells {\#sec-chapter-divine-spells}

#figure([
#box(image("chapters/../assets/images/page040-img028.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 19: Divine Spells Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 19 --- Divine spells chapter art (Unbalanced class). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Divine magic isn't earned, it's given. You don't study it. You don't master it through repetition and force of will. You open yourself to something bigger than you, a god, a cause, the light between stars, and it flows through you. Or it doesn't. That part's not up to you.

But once it does? Once you're a conduit for divine power? You heal wounds that should be fatal. You raise barriers that turn aside demons. You see truth that lies hidden behind lies and shadow. You burn what shouldn't exist and shield what should. The power isn't yours, but the choice of how to use it always is.

Divine magic doesn't throw fireballs. It doesn't dissolve armor or dominate minds. It heals. It protects. It reveals. These are the spells that keep your party alive when the dungeon wants them dead, that ward the camp against things that hunt in the dark, that answer questions no mortal should be able to answer. Arcane magic dominates the battlefield. Divine magic makes sure there's a battlefield left to dominate.

This chapter contains every divine spell in the game. Shepherds use them. Some Leaders use them. Anyone who's ever knelt before something greater and felt it kneel back.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

#pagebreak()
Divine cantrips are minor blessings, small miracles that cost nothing and ask nothing in return. They don't require Disciplines, they don't cost anything to learn, and you can invoke them as often as you like. Every divine caster knows all of these.

They won't turn the tide of battle. They'll steady a shaky hand, light a dark corridor, and remind the dying that someone is still fighting for them. Sometimes that's enough.

=== Guidance (Cantrip)
<guidance-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] You lay a hand on an ally and whisper a prayer. For the next minute, they feel the presence of something greater, a steadying hand on their shoulder, a whisper of confidence at the back of their mind.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The target gains +1 on the next skill check they make within 1 minute.],
  [Standard (9-14)], [+2 on the next skill check within 1 minute.],
  [Strong (15-18+)], [+2 on the next skill check. If that check succeeds, the target also gains advantage on their next check within the same minute, the blessing compounds.],
)
#emph[The simplest prayer. The most reliable help. When your ally is about to attempt something stupid and heroic, give them Guidance. It won't make the stupid part less stupid, but it might make the heroic part work.]

=== Light (Cantrip)
<light-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] 1 hour #strong[Target:] One object

#strong[Description:] You touch an object and it begins to glow with pure, steady radiance, not fire, not magic-light, but something closer to daylight. The light is warm on allies and harsh on creatures of darkness.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Dim light in a 10-foot radius. Duration 10 minutes.],
  [Standard (9-14)], [Bright light in a 20-foot radius, dim for another 20 feet. Duration 1 hour.],
  [Strong (15-18+)], [As Standard, but undead and fiends in the bright light have disadvantage on attacks, the radiance burns them with its mere presence.],
)
#emph[Not a torch. Not a lantern. Light is a piece of dawn you can carry in your pocket. Use it to banish shadows. Use it to blind things that hate the sun. Use it to remind your party that even in the deepest dark, someone brought the day with them.]

=== Resistance (Cantrip)
<resistance-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] A shimmering shield of divine energy settles over the target, thin as a prayer, strong as faith. It turns aside the first touch of poison, the first lick of flame, the first whisper of dark magic.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [+1 on the target's next Fortitude check within 1 minute.],
  [Standard (9-14)], [+2 on the next Fortitude check. If the check is against poison, disease, or necrotic damage, the bonus is +3.],
  [Strong (15-18+)], [+2 on the next Fortitude check. The target also reduces the first instance of poison, disease, or necrotic damage they take within the duration by 1d6.],
)
#emph[When you know the wyvern's sting is coming. When the crypt's air tastes of old death. When the evil wizard's finger is pointing at your Protector. Resistance won't make you immune, but it might make you survive.]

=== Virtue (Cantrip)
<virtue-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] 1 minute #strong[Target:] One creature

#strong[Description:] You speak a word of divine encouragement over an ally. For the next minute, a faint glow suffuses their skin, the physical manifestation of borrowed vitality. It won't save them from a killing blow, but it might keep them standing long enough to deliver one.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The target gains 1d4 temporary HP for 1 minute.],
  [Standard (9-14)], [1d6 temporary HP for 1 minute. If these temporary HP absorb a hit, the attacker takes 1 radiant damage, the light bites back.],
  [Strong (15-18+)], [1d6+2 temporary HP for 1 minute. Attacker takes 1d4 radiant on contact. The target also feels a surge of confidence, immune to fear for the duration.],
)
#emph[A breath of borrowed courage. Virtue is the spell you cast on the ally who's about to do something brave and probably fatal. It won't make them invincible, but it'll make them feel invincible. Sometimes that's the same thing.]

=== Thaumaturgy (Cantrip)
<thaumaturgy-cantrip>
#strong[Disciplines:] None #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Up to 1 minute #strong[Target:] See below

#strong[Description:] A display of minor divine power, the kind that makes mortals kneel and skeptics reconsider. You may produce one of the following effects: your voice booms three times louder, you cause flames to flicker or brighten, the ground trembles faintly, an unseen wind stirs, or your eyes blaze with inner light. These are signs and portents. Use them accordingly.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [One minor effect. It's obviously supernatural but not overwhelming.],
  [Standard (9-14)], [Three simultaneous effects. Your presence is unmistakably divine. Bystanders who aren't actively hostile are awed, social checks against them have advantage.],
  [Strong (15-18+)], [Your display is terrifying or awe-inspiring (your choice). Hostile creatures of Novice tier or lower must make a Reason check or flee for 1 round. The ground actually shakes. The fire actually roars.],
)
#emph[The calling card of divine power. When you need a crowd's attention. When you need a bandit chief to reconsider their life choices. When you need everyone in the room to understand that you speak for something bigger than yourself. Thaumaturgy doesn't win arguments, but it makes sure everyone listens.]

#horizontalrule
#pagebreak()
#pagebreak()
== Healing Chains
<healing-chains>
Healing is the heart of divine magic. It's why Shepherds are welcomed in every village, why armies march with a healer in every company, why the dying gasp prayers to gods they've never worshipped before. Healing magic knits flesh, purges poison, and, at its highest reaches, calls souls back from the threshold. It's not flashy. It's not destructive. It's the reason your party is still alive.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Heal Wounds Chain
<heal-wounds-chain>
#strong[Disciplines:] Water #emph[The fundamental healing chain. Touch them. Heal them. Send them back into the fight.]

==== Heal Wounds (Novice)
<heal-wounds-novice>
#strong[Disciplines:] 1 Water #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] Your hands glow with warm, golden light as you channel divine energy into the target. Flesh knits. Blood stops flowing. Pain recedes. This is the first miracle every healer learns, and it never stops being one.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Restore 1d6+1 HP. The wound closes but leaves a scar.],
  [Standard (9-14)], [Restore 2d6+2 HP. Bleeding stops immediately.],
  [Strong (15-18+)], [Restore 3d6+3 HP. The healing is so complete that minor scars fade and the target feels a surge of vitality, gain advantage on their next physical action.],
)
#emph[The spell that says "not today." Heal Wounds won't bring back the dead, but it'll keep the living on their feet. In a game where every hit connects, healing isn't optional, it's survival. Learn this spell. Love this spell. Your party will love you for it.]

==== Restoration (Adept)
<restoration-adept>
#strong[Disciplines:] 2 Water, 1 Protection #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] A deeper healing, more than flesh and blood. Restoration purges what ails the body and mind: disease, poison, blindness, paralysis. It doesn't just close wounds. It makes the target whole.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Restore 2d6+2 HP. End one minor condition (dazed, deafened, sickened).],
  [Standard (9-14)], [Restore 4d6+4 HP. End one major condition (blinded, paralyzed, poisoned) or one disease.],
  [Strong (15-18+)], [Restore 6d6+6 HP. End one major condition AND one minor condition, or end two major conditions. The target also gains advantage on Fortitude checks for the next hour.],
)
#emph[Healing-plus. Restoration is what you cast when Heal Wounds isn't enough, when the poison is in their blood and their eyes have gone glassy. It's the difference between "they'll live" and "they'll fight." In the middle of combat, that difference is everything.]

==== Mass Heal (Master)
<mass-heal-master>
#strong[Disciplines:] 3 Water, 1 Protection #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Instantaneous #strong[Target:] Up to 6 creatures

#strong[Description:] Divine light erupts from you in a wave, washing over every ally in range. Wounds close simultaneously. The dying gasp and sit up. The broken rise and reach for their weapons. This isn't healing, it's a second wind for the entire party, delivered by the hand of a god who isn't done with them yet.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Up to 3 creatures restore 3d6+3 HP each.],
  [Standard (9-14)], [Up to 6 creatures restore 6d6+6 HP each. One condition removed from each target.],
  [Strong (15-18+)], [Up to 6 creatures restore 9d6+9 HP each. All minor conditions removed. One major condition removed per target. Creatures at 0 HP who receive this healing immediately stand up and can act on their next turn.],
)
#emph[The spell that turns a TPK into a victory. Mass Heal is the panic button for when everything has gone wrong, when three party members are down and the other two are one hit away. One cast. Six allies. Enough healing to reset the entire fight. This is why gods made healers. This is why healers are never the first target, because the enemy knows what happens if they leave you standing.]

=== Purify Chain
<purify-chain>
#strong[Disciplines:] Water #emph[Cleanse corruption. Purge affliction. Restore what was lost.]

==== Purify (Novice)
<purify-novice>
#strong[Disciplines:] 1 Water #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature, object, or 5-foot cube

#strong[Description:] Divine light scours corruption from the target. Poisoned food becomes wholesome. Tainted water runs clear. A festering wound cleans itself. The spell doesn't heal, it cleanses. What was befouled is made pure.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Purify one dose of weak poison or spoiled food. A festering wound stops worsening.],
  [Standard (9-14)], [Purify a 5-foot cube of food, water, or air. Remove one disease or poison from a creature. Cleanse a cursed object of minor enchantment.],
  [Strong (15-18+)], [Purify a 10-foot cube. Remove one disease and one poison simultaneously. A cursed object of Adept tier or lower is cleansed, the curse breaks.],
)
#emph[Not as dramatic as a heal, but sometimes more important. The well in the plague village. The feast the suspicious baron laid out. The dagger your rogue just picked up that's whispering her name. Purify is the answer. Clean water and clean food have saved more lives than any battle spell ever will.]

==== Cleanse (Adept)
<cleanse-adept>
#strong[Disciplines:] 2 Water, 1 Protection #strong[Casting Time:] 1 minute #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] A deeper purification, this spell reaches into the target's very essence and burns away what shouldn't be there. Curses unravel. Possession breaks. Magical compulsions shatter like glass. The target may feel like they've been scrubbed from the inside out. They have.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Remove one curse or magical compulsion of Novice tier. The target is shaken, disadvantage on their next action.],
  [Standard (9-14)], [Remove one curse, possession, or magical compulsion of Adept tier or lower. Remove all poisons and diseases.],
  [Strong (15-18+)], [As Standard, but the cleansing is so complete that the target becomes immune to the removed effect for 24 hours, the same curse cannot re-afflict them. The target also heals 2d6 HP from the purifying energy.],
)
#emph[When the curse has taken root. When the ghost is wearing your friend's face. When the charm spell has been running for days and nobody remembers who the real person is anymore. Cleanse is the reset button. It's brutal, the target will feel every moment of the purification, but they'll be themselves again when it's done.]

==== Resurrection (Master)
<resurrection-master>
#strong[Disciplines:] 3 Water, 1 Protection #strong[Casting Time:] 1 hour #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One dead creature

#strong[Description:] You reach across the threshold between life and death and pull someone back. The soul, departed, drifting, already turning toward whatever comes next, hears your call and answers. The body knits. The heart beats. The eyes open. This is not healing. This is reversal. The universe does not approve, but the universe doesn't get a vote.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The target returns to life with 1 HP. They are disoriented, disadvantage on all actions for 1 hour. They remember fragments of what lay beyond.],
  [Standard (9-14)], [The target returns with HP equal to half their maximum. They are weak but functional. They remember being dead, the memory will never fully fade.],
  [Strong (15-18+)], [The target returns at full HP. They bring something back with them, a fragment of knowledge from beyond, a vision of what's coming, a name they shouldn't know. The DA decides what they learned. They also gain advantage on death-related checks for the next week, death has lost its mystery.],
)
#emph[The ultimate divine spell. Resurrection is why people pray. It's why kings keep Shepherds at their side. It's why your party will drag your body through three levels of dungeon rather than leave you behind. Casting it costs you, not in mana, but in something deeper. The gods notice when you reach past death. They always notice.]

=== Bolster Chain
<bolster-chain>
#strong[Disciplines:] Water #emph[Ongoing healing. Keep them standing. Keep them fighting.]

==== Bolster (Novice)
<bolster-novice>
#strong[Disciplines:] 1 Water #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] You infuse the target with a trickle of ongoing divine vitality. It's not a burst of healing, it's a steady stream. Small wounds close as they open. Fatigue burns away. For the next minute, the target is just a little bit harder to put down.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Target regains 1 HP at the start of each turn for 3 rounds.],
  [Standard (9-14)], [Target regains 2 HP at the start of each turn for 1 minute (10 rounds).],
  [Strong (15-18+)], [Target regains 3 HP per round for 1 minute. Additionally, the first time they drop to 0 HP during the duration, they immediately regain 1d6 HP and stay standing.],
)
#emph[Healing over time. Bolster is for the Protector who's holding the line while everyone else escapes. For the Blade who's dueling the enemy champion. For anyone who needs to stay upright just a little longer. It won't outpace a dragon's breath, but it'll turn a dozen small cuts from fatal to forgettable.]

==== Regeneration (Adept)
<regeneration-adept>
#strong[Disciplines:] 2 Water, 1 Protection #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] The target's body awakens to its own capacity for healing, accelerated a hundredfold. Flesh crawls as it knits. Severed blood vessels reconnect. Even shattered bone begins to grind back into place. The target isn't just being healed, they're being #emph[remade] in real time.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Target regains 3 HP per round for 3 rounds. Bleeding stops.],
  [Standard (9-14)], [Target regains 5 HP per round for 1 minute. Lost fingers or minor appendages begin to regrow, fully restored by the spell's end.],
  [Strong (15-18+)], [Target regains 8 HP per round for 1 minute. A lost limb regrows over the duration. The target cannot die from hit point loss while Regeneration is active, they stabilize at 0 HP and continue to heal.],
)
#emph[When Bolster isn't enough. Regeneration is the spell you cast on the ally who's already down, already bleeding out, already halfway to the grave. It doesn't just heal, it rebuilds. Watch their eyes flutter open. Watch their hand grow back. Watch the enemy's expression change from triumph to horror.]

==== True Life (Master)
<true-life-master>
#strong[Disciplines:] 3 Water, 1 Protection #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] 1 hour #strong[Target:] One creature

#strong[Description:] You pour so much divine vitality into the target that death itself becomes a temporary inconvenience. For the next hour, the target heals faster than they can be hurt. Their body glows faintly. Their blood shimmers. They are, for a short time, more alive than anyone in the room, and life, true life, does not go gently.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Target regains 5 HP per round for 3 rounds. They have advantage on death checks.],
  [Standard (9-14)], [Target regains 10 HP per round for 1 hour. They are immune to poison, disease, and necrotic damage. If reduced to 0 HP, they automatically stabilize and continue regenerating, only a killing blow that deals more than 20 damage in a single hit can truly kill them.],
  [Strong (15-18+)], [As Standard, but the target also radiates an aura of vitality, all allies within 15 feet regain 3 HP per round. The target's maximum HP increases by 20 for the duration. They are, for all practical purposes, immortal for the next hour.],
)
#emph[This is what the gods give their chosen. True Life is not a combat spell, it's a declaration. For one hour, one creature in your party is functionally unkillable. Send them into the dragon's jaws. Send them through the trapped corridor. Send them to hold the bridge against a hundred foes. They'll be standing when it's over. They'll be standing, and they'll be smiling.]

=== Remove Affliction Chain
<remove-affliction-chain>
#strong[Disciplines:] Water #emph[Target specific ailments. Cure the incurable.]

==== Soothe (Novice)
<soothe-novice>
#strong[Disciplines:] 1 Water #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] Your touch calms the body's rebellion. Pain fades. Muscles unclench. The mind quiets. Soothe doesn't cure disease or close wounds, it simply tells the body that everything is going to be all right. And for a little while, the body believes it.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Remove one minor condition (dazed, sickened, frightened). Restore 1 HP.],
  [Standard (9-14)], [Remove one minor condition. Restore 1d6+1 HP. The target feels genuinely comforted, they know, somehow, that someone is looking out for them.],
  [Strong (15-18+)], [Remove up to two minor conditions. Restore 2d6+2 HP. The target gains temporary immunity to the removed conditions for 10 minutes, their body remembers the calm.],
)
#emph[The smallest healing spell. Not for wounds, for everything else. The nausea after the poison trap. The ringing ears after the thunderclap. The creeping dread after the third near-death experience this hour. Soothe is the spell you cast when an ally just needs a moment. A breath. A reminder that they're not alone.]

==== Remove Affliction (Adept)
<remove-affliction-adept>
#strong[Disciplines:] 2 Water, 1 Protection #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] You name the affliction and it flees. Blindness peels away from the eyes. Deafness cracks and falls silent. Paralysis releases its grip. The target is not healed in the traditional sense, they are #emph[freed.] Whatever held them is gone, banished by the authority of the divine.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Remove one condition: blinded, deafened, or paralyzed. The condition fades over 1 round rather than instantly.],
  [Standard (9-14)], [Remove one condition instantly: blinded, deafened, paralyzed, or petrified. Target can act immediately.],
  [Strong (15-18+)], [Remove any one condition (including stunned, unconscious from non-lethal sources). The target gains advantage on checks against that condition type for 24 hours, it won't take hold again easily.],
)
#emph[The surgical strike of divine magic. Remove Affliction doesn't heal HP, it solves specific, devastating problems. The medusa's gaze. The banshee's wail. The ghoul's paralytic claws. When a party member is locked down and the enemy is closing in, this spell doesn't just help, it changes the math entirely.]

==== Miracle Cure (Master)
<miracle-cure-master>
#strong[Disciplines:] 3 Water, 1 Protection #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One creature

#strong[Description:] You don't cast this spell, you pray it. And something answers. The incurable is cured. The permanent becomes temporary. The congenital defect present since birth unravels in a wash of golden light. This is the spell for things that aren't supposed to be fixable. The universe makes an exception.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Remove one long-term condition (blindness, deafness, a lingering curse). The effect is permanent but the target is exhausted, gain 1 level of exhaustion that fades after a long rest.],
  [Standard (9-14)], [Cure one condition normally considered permanent: congenital blindness, a birth defect, a curse passed through bloodlines. Also restores 6d6+6 HP and removes all temporary conditions.],
  [Strong (15-18+)], [As Standard, but the miracle also cures one condition the target didn't know they had, a latent disease, a dormant curse, a genetic weakness. The target also gains a permanent +1 to Fortitude checks against the cured condition type. They've been touched by something holy, and it left a mark.],
)
#emph[The spell you cast when everything else has failed. When the curse has a name older than the kingdom. When the disease laughs at Restoration. When the child was born blind and the parents have spent their life savings on healers who shook their heads. Miracle Cure is why people believe. It's why they journey to distant temples and kneel before forgotten altars. Sometimes, just sometimes, someone kneels back.]

#horizontalrule
#pagebreak()
#pagebreak()
== Protection Chains
<protection-chains>
Protection magic is the shield arm of the divine. It wards the innocent, guards the faithful, and draws lines across the battlefield that evil cannot cross. Protection spells don't hurt the enemy, they make the enemy's efforts irrelevant. A fireball that never lands. A sword that never connects. A demon that reaches for your ally and finds only light.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Shield of Faith Chain
<shield-of-faith-chain>
#strong[Disciplines:] Protection #emph[Personal and targeted protection. The divine shield.]

==== Shield of Faith (Novice)
<shield-of-faith-novice>
#strong[Disciplines:] 1 Protection #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Concentration, up to 10 minutes #strong[Target:] One creature

#strong[Description:] A shimmering field of divine energy envelops the target, turning aside blows with whispered prayers. Blades skid off invisible barriers. Arrows curve in flight. The target isn't wearing armor, they're wearing faith.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [+1 Armor for 1 minute.],
  [Standard (9-14)], [+2 Armor for 10 minutes. The first attack that hits the target each round has its damage reduced by 1.],
  [Strong (15-18+)], [+2 Armor for 10 minutes. Damage reduction applies to all attacks. Against undead and fiends, the bonus increases to +3 Armor, they recoil from the divine light.],
)
#emph[The bread and butter of divine protection. Shield of Faith is simple, reliable, and always welcome. Cast it on your Protector to make an iron wall into a mythic one. Cast it on your Blade to let them fight with reckless abandon. Cast it on yourself, you're the healer, and the enemy knows it.]

==== Sanctuary (Adept)
<sanctuary-adept>
#strong[Disciplines:] 2 Protection, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 minute #strong[Target:] One creature

#strong[Description:] The target is wrapped in an aura of profound peace. Enemies find their eyes sliding away, their attacks hesitating, their will to harm evaporating. They #emph[can] attack the protected creature, but every fiber of their being tells them not to. Those who push through find their blows strangely weak.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Enemies must make a Reason check to target the protected creature. Attacks that succeed deal -2 damage. Duration 3 rounds.],
  [Standard (9-14)], [Enemies must make a Reason check to target the creature. On failure, they must choose a different target or lose the attack. On success, damage is halved. Duration 1 minute.],
  [Strong (15-18+)], [As Standard, but the Reason check has disadvantage. Undead and fiends automatically fail, they cannot approach within 10 feet of the target. If the protected creature attacks, the spell ends.],
)
#emph["Don't hit me" in spell form. Sanctuary is for the non-combatant caught in combat, the scholar you're escorting, the wounded ally you're stabilizing, yourself when you need one round to get a Mass Heal off. It's not invisibility. It's something stranger, the divine assertion that this person is not part of the fight, and the fight should look elsewhere.]

==== Holy Aegis (Master)
<holy-aegis-master>
#strong[Disciplines:] 3 Protection, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self (30-foot radius) #strong[Duration:] Concentration, up to 1 minute #strong[Target:] All allies within 30 feet

#strong[Description:] You raise your holy symbol and a dome of radiant light erupts outward, sheltering every ally in range. Inside the Aegis, the air is calm. Outside, the storm of battle rages, but it cannot cross the threshold. Enemies may enter, but they pay for every step. Allies within are shielded, healed, and blessed.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [All allies within 20 feet gain +2 Armor. Duration 3 rounds.],
  [Standard (9-14)], [All allies within 30 feet gain +2 Armor and resistance to necrotic and radiant damage. At the start of each ally's turn, they regain 2 HP. Enemies entering the Aegis take 2d6 radiant damage. Duration 1 minute.],
  [Strong (15-18+)], [As Standard, but the radius is 40 feet. Allies also have advantage on Fortitude and Reason checks. Enemies inside the Aegis at the start of their turn take 3d6 radiant damage. The Aegis moves with you. Undead and fiends cannot enter, they burn at the boundary.],
)
#emph[The ultimate protective spell. Holy Aegis turns the battlefield into sacred ground. Your party fights inside a bubble of divine favor, healing every round, resisting dark magic, and watching enemies burst into flame just for getting too close. When you raise the Aegis, you're not just protecting your allies. You're consecrating the battlefield. This ground is yours now. The enemy is trespassing.]

=== Bless Chain
<bless-chain>
#strong[Disciplines:] Protection #emph[Enhance your allies. Bless their efforts. Make them more than they were.]

==== Bless (Novice)
<bless-novice>
#strong[Disciplines:] 1 Protection #strong[Casting Time:] 1 action #strong[Range:] 30 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] Up to 3 creatures

#strong[Description:] You speak a benediction over your allies, and something listens. For the next minute, their hands are steadier, their aim truer, their minds clearer. A divine whisper guides their strikes and guards their thoughts.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [1 ally gains +1 on attack rolls for 1 minute.],
  [Standard (9-14)], [Up to 3 allies gain +1 on all attack rolls and Reason checks for 1 minute.],
  [Strong (15-18+)], [Up to 3 allies gain +1 on attack rolls, Reason checks, and Fortitude checks. Additionally, the first time each ally rolls a Weak result during the duration, they may reroll, the blessing intervenes.],
)
#emph[The spell that makes everyone better. Bless isn't flashy, but a +1 on every attack roll across three party members adds up fast. Over a five-round combat, that's fifteen attacks, and fifteen chances for the blessing to turn a Weak into a Standard, or a Standard into a Strong. Your party won't notice the difference. The enemy will.]

==== Divine Favor (Adept)
<divine-favor-adept>
#strong[Disciplines:] 2 Protection, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self #strong[Duration:] Concentration, up to 1 minute #strong[Target:] Self

#strong[Description:] You become the instrument of divine wrath, or divine mercy, depending on what's needed. Your weapon glows with holy light. Your strikes burn with radiant fire. For one minute, you are not just a caster. You are a warrior blessed by something greater, and everything you hit is going to feel it.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Your weapon attacks deal +1d4 radiant damage. Duration 3 rounds.],
  [Standard (9-14)], [Your weapon attacks deal +1d6 radiant damage. Undead and fiends take +2d6 instead. Duration 1 minute.],
  [Strong (15-18+)], [Your weapon attacks deal +2d6 radiant damage (+3d6 vs.~undead/fiends). Once during the duration, you may declare an attack a "divine strike", it automatically hits at the Strong tier.],
)
#emph[For the Shepherd who needs to wade into melee. For the Leader who wants to lead from the front. Divine Favor turns a support caster into a holy terror. Your mace isn't just a mace anymore, it's a delivery system for divine judgment. The undead don't just fear you. They burn at your approach.]

==== Crusader's Mantle (Master)
<crusaders-mantle-master>
#strong[Disciplines:] 3 Protection, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self (30-foot radius) #strong[Duration:] Concentration, up to 1 minute #strong[Target:] All allies within 30 feet

#strong[Description:] Divine wrath settles over you like a cloak and extends to every ally nearby. Weapons burst into flame, not ordinary fire, but holy radiance that sears the wicked and leaves the innocent untouched. Your party becomes a holy shock force: every strike blessed, every arrow sanctified, every blade a burning testament.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Allies within 15 feet deal +1d4 radiant damage on weapon attacks. Duration 3 rounds.],
  [Standard (9-14)], [Allies within 30 feet deal +1d6 radiant damage on weapon attacks (+2d6 vs.~undead/fiends). Allies also emit dim light in a 10-foot radius, darkness effects within the mantle are suppressed. Duration 1 minute.],
  [Strong (15-18+)], [As Standard, but the bonus is +2d6 radiant (+3d6 vs.~undead/fiends). The first time each ally hits an enemy during the duration, that enemy is marked with divine light, attacks against marked enemies have advantage for 1 round. The battlefield is bathed in holy radiance.],
)
#emph[Your party is now an army of the divine. Crusader's Mantle turns every ally into a holy warrior, their weapons burn with sacred fire, their presence banishes darkness, and the enemy formation becomes a shooting gallery of illuminated targets. When the paladin order rides to war, this is the spell their high priest casts before the charge. Nothing survives the charge.]

=== Ward Chain
<ward-chain>
#strong[Disciplines:] Protection #emph[Static protections. Glyphs. Circles. Barriers that hold.]

==== Ward (Novice)
<ward-novice>
#strong[Disciplines:] 1 Protection #strong[Casting Time:] 1 minute #strong[Range:] Touch #strong[Duration:] 8 hours #strong[Target:] One doorway, container, or 10-foot square

#strong[Description:] You trace a glyph of protection onto a threshold. When a creature of a type you specify crosses it, the ward triggers, a flash of light, a clap of thunder, a silent alarm in your mind. The ward doesn't stop intruders. It announces them. And you'll be ready.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The ward triggers with a faint glow visible within 30 feet. You know it triggered if you're within 100 feet. Duration 1 hour.],
  [Standard (9-14)], [You specify a creature type (undead, humanoid, beast, etc.). When such a creature crosses, you receive a mental alert if within 1 mile. The creature is briefly outlined in silver light, visible to all. Duration 8 hours.],
  [Strong (15-18+)], [As Standard, but you may specify up to three creature types or one specific individual you've met. The ward also deals 2d6 radiant damage to the triggering creature.],
)
#emph[The spell that lets you sleep through the night. Ward the camp perimeter. Ward the dungeon door behind you. Ward the treasure chest before you open it. Knowledge is power, and knowing something is coming before it arrives is the difference between a prepared party and a total party kill.]

==== Magic Circle (Adept)
<magic-circle-adept>
#strong[Disciplines:] 2 Protection, 1 Energy #strong[Casting Time:] 1 minute #strong[Range:] Touch #strong[Duration:] 1 hour #strong[Target:] 10-foot radius circle

#strong[Description:] You inscribe a circle of protection on the ground, chalk, salt, or pure divine light. Creatures of a type you specify cannot cross the boundary. They cannot attack creatures inside. Their magic fizzles at the edge. The circle is a statement: this space is not yours, and you are not welcome here.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The circle hedges out creatures of one type. They have disadvantage on attacks against creatures inside. Duration 10 minutes.],
  [Standard (9-14)], [Creatures of the chosen type cannot enter the circle, cannot attack across it, and have disadvantage on spells cast into it. Inside creatures have +2 Armor against attacks from outside. Duration 1 hour.],
  [Strong (15-18+)], [As Standard, but the circle also prevents teleportation and planar travel into or out of the area. Creatures of the chosen type inside when the circle is cast are trapped, they cannot leave. Duration 2 hours.],
)
#emph[The summoner's nightmare. Magic Circle is for when you know what's hunting you and need a guaranteed safe zone. Camp inside one when the werewolves are prowling. Trap a demon inside one while you negotiate. Cast one around the ritual altar before the cultists finish their spell. The circle doesn't judge. It just holds.]

==== Divine Barrier (Master)
<divine-barrier-master>
#strong[Disciplines:] 3 Protection, 1 Energy #strong[Casting Time:] 1 action #strong[Range:] 60 feet #strong[Duration:] Concentration, up to 1 minute #strong[Target:] A 20-foot radius dome or 30-foot wall

#strong[Description:] A wall of solid divinity, not force, not magic, but something purer, seals the battlefield. The barrier is opaque to evil, transparent to the faithful. Enemy spells shatter against it. Enemy creatures burn at its touch. Your allies pass through freely, their weapons trailing holy light as they emerge.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [A 15-foot wall or 10-foot dome. Blocks physical attacks and Novice-tier spells. +2 Armor to allies behind it. Duration 3 rounds.],
  [Standard (9-14)], [A 30-foot wall or 20-foot dome. Blocks all attacks and spells of Adept tier or lower. Undead and fiends touching it take 4d6 radiant damage. Allies inside have resistance to all damage from outside sources. Duration 1 minute.],
  [Strong (15-18+)], [As Standard, but the barrier also blocks Master-tier spells, nothing crosses without your permission. Allies inside regenerate 5 HP per round. Enemies of a type you specify are blinded while inside or adjacent to the barrier. The dome can encompass structures.],
)
#emph[The final word in protective magic. Divine Barrier doesn't just shield, it divides the world into "safe" and "not safe" with absolute clarity. Drop it over your party when the dragon breathes. Seal a building against the zombie horde. Create a hemisphere of "no" that even the most powerful enemy magic cannot penetrate. When the Divine Barrier goes up, the fight changes. Your side just became the winning side.]

#horizontalrule
#pagebreak()
#pagebreak()
#figure([
#box(image("chapters/../assets/svg/placeholder-section.svg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 35: Divine Spells Midpoint
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 35 --- Divine spells chapter midpoint. Placeholder for final art. Use placeholder-section.svg dimensions: 400×300.]

#pagebreak()
== Divination Chains
<divination-chains>
Divination is the magic of knowing. It sees what's hidden, identifies what's unknown, and sometimes, at its highest reaches, peers into what hasn't happened yet. Diviners are the party's eyes and ears. They find the trap before it triggers. They read the villain's plans in ancient texts. They ask questions of beings who were old when the world was young, and they get answers.

#emph[See #ref(<sec-chapter-magic-system>, supplement: [Chapter]) for how spellcasting works.]

=== Detect Magic Chain
<detect-magic-chain>
#strong[Disciplines:] Energy #emph[Sense magical energies. Identify enchantments. Uncover hidden lore.]

==== Detect Magic (Novice)
<detect-magic-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self (30-foot radius) #strong[Duration:] Concentration, up to 10 minutes #strong[Target:] Self (sensory aura)

#strong[Description:] Your eyes film over with silver light. For the duration, magical auras become visible, glowing halos around enchanted objects, colored mist trailing from active spells, dark stains where curses linger. You see magic the way others see color: obvious, informative, and everywhere once you know how to look.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [You sense the presence of magic within 30 feet. No details, just "something is magical nearby." Duration 1 minute.],
  [Standard (9-14)], [You see magical auras within 30 feet. You can identify the school or general type of magic (fire, illusion, necromancy, divine, etc.). Duration 10 minutes.],
  [Strong (15-18+)], [As Standard, but you also sense the relative strength of each aura (Novice/Adept/Master tier) and whether it's beneficial, harmful, or neutral. You can concentrate on one aura to learn its specific spell name if you've encountered it before.],
)
#emph[The spell that saves parties from cursed swords and trapped altars. Detect Magic is never a wasted cast. That suspicious throne? Glowing with necromancy, don't sit. That plain dagger in the trash heap? Radiating Adept-tier enchantment, grab it. Knowledge is survival. This spell gives you knowledge.]

==== Identify (Adept)
<identify-adept>
#strong[Disciplines:] 2 Energy, 1 Water #strong[Casting Time:] 1 minute (or 1 hour for complex items) #strong[Range:] Touch #strong[Duration:] Instantaneous #strong[Target:] One object or creature

#strong[Description:] You hold an object, close your eyes, and #emph[listen.] The magic within speaks to you, its name, its purpose, its command word, its history. Curses reveal themselves reluctantly. Artifacts share their secrets eagerly. By the time you open your eyes, you know the item better than its creator did.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Learn the item's basic properties and whether it's cursed. No command words or detailed history.],
  [Standard (9-14)], [Learn all properties, command words, number of charges (if any), and the item's name and creator. Identify curses and how to break them. For artifacts with complex histories, you receive flashes of key events.],
  [Strong (15-18+)], [As Standard, but you also learn one secret about the item that even its creator may not have known, a hidden property, a dormant power, a destiny tied to the item. The DA decides what this secret is.],
)
#emph[The spell that answers "what does this do?" Identify turns mysterious loot into known assets. That glowing sword? Now you know it's a Flame Tongue, command word "ignis," 3 charges, bursts into fire on command. That ring the villain was wearing? Cursed, don't put it on until you've cast Cleanse. Knowledge isn't just power. It's insurance.]

==== Legend Lore (Master)
<legend-lore-master>
#strong[Disciplines:] 3 Energy, 1 Water #strong[Casting Time:] 10 minutes #strong[Range:] Self #strong[Duration:] Instantaneous #strong[Target:] One creature, object, or location you can name

#strong[Description:] You don't just identify, you #emph[remember.] The universe holds memories of everything that ever mattered, and this spell gives you access. You speak a name, a person, a place, an artifact, and the universe tells you its story. Not everything. But enough. The important parts. The parts that were legendary.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [You receive 1d3 significant facts about the subject, public knowledge or commonly known legends.],
  [Standard (9-14)], [You receive a full account of the subject's legendary history: its creation, its major deeds, its famous wielders or inhabitants, its known powers and weaknesses. If the subject has ever been the focus of a prophecy, you learn the gist of it.],
  [Strong (15-18+)], [As Standard, but you also learn one piece of information that has been deliberately hidden, forgotten, or erased from history, the true name of the demon bound in the sword, the location of the lich's phylactery, the identity of the traitor who brought down the ancient kingdom.],
)
#emph[The spell that solves mysteries. Legend Lore is why ancient libraries still matter, you can cast it on any named thing, anywhere, and learn what the world knows about it. The villain's true name. The artifact's hidden weakness. The dungeon's original purpose. When the party is stuck, when the clues have run dry, when the only way forward is through a door that requires a password lost to time, cast Legend Lore. The universe remembers. Now you do too.]

=== True Seeing Chain
<true-seeing-chain>
#strong[Disciplines:] Energy #emph[See through deception. Pierce illusion. Witness truth.]

==== See Invisible (Novice)
<see-invisible-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 action #strong[Range:] Self #strong[Duration:] Concentration, up to 10 minutes #strong[Target:] Self

#strong[Description:] Your eyes flicker with silver fire. Invisible creatures become visible, not solid, but outlined in faint luminescence, like heat shimmer on a cold day. Hidden doors glow. Ethereal watchers are revealed. Nothing can hide from you by simply not being there.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [You sense the presence of invisible creatures within 30 feet but cannot pinpoint their location. Duration 1 minute.],
  [Standard (9-14)], [Invisible creatures and objects within 60 feet are visible to you as translucent outlines. Hidden doors and secret compartments glow faintly. Duration 10 minutes.],
  [Strong (15-18+)], [As Standard, but you also see into the Ethereal Plane, creatures phasing through walls, ghosts lurking between worlds. You can target ethereal creatures with spells as if they were material.],
)
#emph[The counter to invisibility. When the assassin strikes from nowhere. When the treasure vault has a guardian nobody can see. When the ghost won't show itself. See Invisible removes the advantage of being unseen. The invisible rogue smirking in the corner? You're looking right at them. Wave.]

==== True Seeing (Adept)
<true-seeing-adept>
#strong[Disciplines:] 2 Energy, 1 Water #strong[Casting Time:] 1 action #strong[Range:] Touch #strong[Duration:] Concentration, up to 1 hour #strong[Target:] One creature

#strong[Description:] The target's eyes open, truly open, for the first time. Illusions become transparent. Shapechangers writhe between forms, their true shape burning through the false one like fire through paper. Hidden truths reveal themselves in glowing script only the target can read. For one hour, the target sees the world as it actually is, and it is never quite the same afterward.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [Target sees through illusions of Novice tier. Shapechangers flicker, their true form is visible in peripheral vision. Duration 10 minutes.],
  [Standard (9-14)], [All illusions and visual deceptions of Adept tier or lower are transparent. Shapechangers are seen in their true form. Secret doors and hidden compartments glow. Magical darkness is merely dim. Duration 1 hour.],
  [Strong (15-18+)], [As Standard, but Master-tier illusions are also transparent. The target sees the true alignment of creatures as a faint aura. The target automatically knows when someone is lying, not what the truth is, but that the words are false.],
)
#emph[The truth, the whole truth, and nothing but. True Seeing is the spell that strips away every layer of deception. The disguised assassin. The illusory wall. The polymorphed dragon pretending to be a merchant. One touch, one hour, and your party's scout becomes a lie detector with perfect vision. The villain's schemes look a lot less clever when you can see every thread.]

==== Foresight (Master)
<foresight-master>
#strong[Disciplines:] 3 Energy, 1 Water #strong[Casting Time:] 1 minute #strong[Range:] Touch #strong[Duration:] 8 hours #strong[Target:] One creature

#strong[Description:] You touch an ally and give them the one thing no amount of training can provide: a glimpse of what's coming. For the next eight hours, the target experiences flashes of precognition, they know where the axe will fall before the swing begins, they feel the trap trigger before their foot lands, they hear the lie before it's spoken. The future whispers to them, and they listen.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [The target has advantage on initiative rolls and cannot be surprised for 1 hour. They sense danger a heartbeat before it arrives.],
  [Standard (9-14)], [For 8 hours: advantage on all attack rolls, checks, and initiative. Enemies have disadvantage on attacks against the target. The target cannot be surprised. Once during the duration, the target may declare that they foresaw a specific event and automatically succeed on one check related to it.],
  [Strong (15-18+)], [As Standard, but the target also gains a single moment of perfect clarity, once during the duration, they may ask the DA one question about an immediate future event (within the next minute) and receive a truthful answer of up to 25 words. The target also knows the exact moment the spell will end, down to the second. They feel time running out.],
)
#emph[The ultimate divination. Foresight doesn't show the future, it makes the future a known quantity. For eight hours, one member of your party is operating on information the enemy doesn't have: what's about to happen. They dodge attacks before they're thrown. They find traps before they're set. They make decisions with the confidence of someone who's already seen how this plays out. This is the spell that turns a hero into a legend, and a legend into a prophecy.]

=== Commune Chain
<commune-chain>
#strong[Disciplines:] Energy #emph[Ask questions. Get answers. Speak to powers beyond mortal ken.]

==== Augury (Novice)
<augury-novice>
#strong[Disciplines:] 1 Energy #strong[Casting Time:] 1 minute #strong[Range:] Self #strong[Duration:] Instantaneous #strong[Target:] Self

#strong[Description:] You cast the bones, read the entrails, or simply close your eyes and listen. You pose a question about a course of action you plan to take within the next 30 minutes, and the divine sends back a sign: Weal (good fortune), Woe (ill fortune), Weal and Woe (mixed), or Nothing (the outcome is too uncertain or the question too vague).

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [You receive a one-word omen: Weal, Woe, or Nothing. It may be cryptic.],
  [Standard (9-14)], [You receive a clear omen with a brief accompanying vision or sensation, a flash of fire for danger, a sense of peace for safety. You understand the general nature of the outcome.],
  [Strong (15-18+)], [The omen is detailed. You also learn which aspect of the plan carries the greatest risk or reward, "the left passage leads to treasure, but the guardian is awake."],
)
#emph[The spell for when you're standing at a crossroads, literally or figuratively. Augury won't solve your problems, but it'll tell you which path leads to glory and which leads to a very compressed expiration. Cast it before opening doors. Cast it before accepting quests. Cast it before trusting the smiling stranger. The gods see farther than you do. Let them.]

==== Divination (Adept)
<divination-adept>
#strong[Disciplines:] 2 Energy, 1 Water #strong[Casting Time:] 1 action (ritual: 10 minutes) #strong[Range:] Self #strong[Duration:] Instantaneous #strong[Target:] Self

#strong[Description:] You ask a single question and receive a direct answer, not a cryptic omen, not a vision, but words. A short phrase. A name. A location. The answer comes from a divine source: your deity, their servants, or the accumulated wisdom of the faithful who came before. The source knows more than you do, but it is not omniscient. It can be wrong, but it almost never is.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [You receive a short, possibly cryptic answer of 1-3 words. It's accurate but may lack context.],
  [Standard (9-14)], [You receive a direct answer of up to 10 words. It addresses your question specifically and truthfully, to the best of the divine source's knowledge.],
  [Strong (15-18+)], [You receive an answer of up to 25 words, plus relevant context the source thinks you should know, "The lich's phylactery is in the crypt beneath the old temple. It's guarded by a death knight who was once the lich's son. He can be redeemed."],
)
#emph[Direct answers to direct questions. Divination is the investigator's best friend and the DA's worst nightmare. "Who murdered the king?" "Where is the artifact hidden?" "What is the villain's true name?" You get one question. Make it count. The answer will be true, which doesn't mean you'll like it.]

==== Commune (Master)
<commune-master>
#strong[Disciplines:] 3 Energy, 1 Water #strong[Casting Time:] 1 minute #strong[Range:] Self #strong[Duration:] 1 minute (3 questions) #strong[Target:] Self

#strong[Description:] You open a direct channel to your deity, or to one of their senior servants. Your eyes roll back. Your voice doubles, triples, becomes a chorus. For one minute, you are the mouthpiece of a god. You may ask three questions before the connection fades. The entity on the other end answers truthfully, it is a god, or close enough, but it speaks in its own voice, with its own agenda, and it may choose to tell you more than you asked.

#table(
  columns: (52.94%, 47.06%),
  align: (auto,auto,),
  table.header([Outcome], [Effect],),
  table.hline(),
  [Weak (1-8)], [You reach a lesser servant, an angel, a spirit guide, a saint. Two questions. Answers are brief and literal. The servant cannot lie, but may omit.],
  [Standard (9-14)], [Direct communion with your deity or their archangel equivalent. Three questions. Answers are truthful and complete to the entity's knowledge. The entity may offer unsolicited advice or warnings, it has its own concerns.],
  [Strong (15-18+)], [As Standard, but the connection is unusually clear. You may ask five questions. The entity is favorably disposed and answers with enthusiasm, offering insights beyond your questions. After the communion ends, you retain a lingering connection, once in the next 24 hours, you may ask one additional question as if casting Divination.],
)
#emph[You speak with a god. Not pray to one, speak with one. Commune is the pinnacle of divine magic: direct access to a being of incomprehensible power and knowledge. The answers you receive will be true. They may also be terrifying. They may reveal things you weren't ready to know. The gods don't see the world the way mortals do. When you ask "how do we defeat the dark lord," and the god answers "you don't, but your daughter will," you'll understand why most Shepherds use this spell sparingly. Some truths are too heavy to carry.]

#horizontalrule
#pagebreak()
#pagebreak()
== Divine Spell Quick Reference
<divine-spell-quick-reference>
#table(
  columns: (15.56%, 13.33%, 22.22%, 28.89%, 20%),
  align: (auto,auto,auto,auto,auto,),
  table.header([Spell], [Tier], [Category], [Disciplines], [Summary],),
  table.hline(),
  [Guidance], [Cantrip], [Blessing], [None], [+2 on next skill check],
  [Light], [Cantrip], [Blessing], [None], [Bright light 20-ft radius, 1 hour],
  [Resistance], [Cantrip], [Blessing], [None], [+2 on next Fortitude check],
  [Virtue], [Cantrip], [Blessing], [None], [1d6 temp HP, 1 minute],
  [Thaumaturgy], [Cantrip], [Blessing], [None], [Minor divine displays and omens],
  [], [], [], [], [],
  [Heal Wounds], [Novice], [Healing], [1 Water], [Touch, restore 2d6+2 HP],
  [Restoration], [Adept], [Healing], [2 Water, 1 Protection], [Restore 4d6+4 HP, cure one condition],
  [Mass Heal], [Master], [Healing], [3 Water, 1 Protection], [Up to 6 targets, 6d6+6 HP each],
  [], [], [], [], [],
  [Purify], [Novice], [Healing], [1 Water], [Cleanse poison, disease, or 5-ft cube],
  [Cleanse], [Adept], [Healing], [2 Water, 1 Protection], [Remove curses, possession, compulsion],
  [Resurrection], [Master], [Healing], [3 Water, 1 Protection], [Return dead creature to life],
  [], [], [], [], [],
  [Bolster], [Novice], [Healing], [1 Water], [Ongoing 2 HP/round, 1 minute],
  [Regeneration], [Adept], [Healing], [2 Water, 1 Protection], [5 HP/round, regrow limbs, 1 minute],
  [True Life], [Master], [Healing], [3 Water, 1 Protection], [10 HP/round, near-immortal, 1 hour],
  [], [], [], [], [],
  [Soothe], [Novice], [Healing], [1 Water], [Remove minor condition, restore 1d6+1 HP],
  [Remove Affliction], [Adept], [Healing], [2 Water, 1 Protection], [Cure blindness, deafness, paralysis],
  [Miracle Cure], [Master], [Healing], [3 Water, 1 Protection], [Cure any condition, including permanent],
  [], [], [], [], [],
  [Shield of Faith], [Novice], [Protection], [1 Protection], [+2 Armor, 10 minutes],
  [Sanctuary], [Adept], [Protection], [2 Protection, 1 Energy], [Enemies must check to attack target],
  [Holy Aegis], [Master], [Protection], [3 Protection, 1 Energy], [30-ft aura, +2 Armor, 2 HP/round to allies],
  [], [], [], [], [],
  [Bless], [Novice], [Protection], [1 Protection], [3 allies, +1 attacks and Reason checks],
  [Divine Favor], [Adept], [Protection], [2 Protection, 1 Energy], [Self, +1d6 radiant on weapon attacks],
  [Crusader's Mantle], [Master], [Protection], [3 Protection, 1 Energy], [Allies in 30 ft, +1d6 radiant on attacks],
  [], [], [], [], [],
  [Ward], [Novice], [Protection], [1 Protection], [Alarm glyph on doorway, 8 hours],
  [Magic Circle], [Adept], [Protection], [2 Protection, 1 Energy], [10-ft circle, blocks creature type, 1 hour],
  [Divine Barrier], [Master], [Protection], [3 Protection, 1 Energy], [30-ft wall or 20-ft dome, blocks all],
  [], [], [], [], [],
  [Detect Magic], [Novice], [Divination], [1 Energy], [See magical auras, 30-ft radius],
  [Identify], [Adept], [Divination], [2 Energy, 1 Water], [Learn all item properties and curses],
  [Legend Lore], [Master], [Divination], [3 Energy, 1 Water], [Learn legendary history of named subject],
  [], [], [], [], [],
  [See Invisible], [Novice], [Divination], [1 Energy], [See invisible creatures, 60-ft range],
  [True Seeing], [Adept], [Divination], [2 Energy, 1 Water], [See through illusions, shapechangers, 1 hour],
  [Foresight], [Master], [Divination], [3 Energy, 1 Water], [Advantage on everything, 8 hours],
  [], [], [], [], [],
  [Augury], [Novice], [Divination], [1 Energy], [Omen: Weal/Woe for planned action],
  [Divination], [Adept], [Divination], [2 Energy, 1 Water], [Direct answer to one question],
  [Commune], [Master], [Divination], [3 Energy, 1 Water], [Speak directly with deity, 3 questions],
)
#part[Combat & Equipment]
= Initiative: Who Goes First
<initiative-who-goes-first>
﻿\# Combat {\#sec-chapter-combat}

#figure([
#box(image("chapters/../assets/images/page075-img029.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 20: Combat Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 20 --- Combat chapter art (Character traits / combat). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Listen up. This is the chapter that keeps your hero alive.

Combat in #emph[Heroes of Legend] is fast, cinematic, and unforgiving. Attacks always hit. Every swing changes the board. Your job isn't to avoid getting hit, it's to hit them harder than they hit you, and to make sure you're still standing when the dust clears.

#pagebreak()
When blades come out, everyone rolls. #strong[1d6 + Agility modifier.] Highest goes first. Ties go to the higher Agility score; if it's still tied, roll off.

That's it. No convoluted surprise rounds. No phases. Roll, sort, go.

Initiative is simple by design. Combat already has enough moving parts --- action economy, maneuvers, reactions, cover, conditions. You don't need a complex initiative system on top of all that. You need to know who's up next so you can plan your turn while the goblins are swinging. The 1d6 keeps things moving and gives Agility heroes a consistent edge without letting them monopolize the first round. The quick always go first. Sometimes the lucky go first too. That's combat.

#pagebreak()
== The Combat Round
<the-combat-round>
On your turn, you get three things. Use them or lose them, they don't carry over.

#table(
  columns: (27.03%, 27.03%, 45.95%),
  align: (auto,auto,auto,),
  table.header([Resource], [Per Turn], [What You Can Do],),
  table.hline(),
  [#strong[Action]], [1], [Attack, cast a spell, activate an ability, Dash (double move)],
  [#strong[Movement]], [1], [Move up to your Speed. Break it up, move, act, move.],
  [#strong[Maneuver]], [1], [Basic maneuvers (Defend, Shove, etc.) or skill-granted maneuvers],
  [#strong[Reaction]], [1/round], [Opportunity attack, shield block, triggered abilities],
  [#strong[Free]], [Unlimited], [Talk, drop an item, draw a weapon, gesture],
)
#block[
#callout(
body: 
[
You can trade your #strong[Action] for an extra #strong[Movement] or #strong[Maneuver]. You cannot trade a Maneuver for a second Action. You get one big thing per turn. Make it count.

]
, 
title: 
[
Trading Down, Never Up
]
, 
background_color: 
color.mix((rgb("#CC1914"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#CC1914")
, 
icon: 
fa-exclamation()
, 
body_background_color: 
brand-color.background
)
]
=== Basic Maneuvers
<basic-maneuvers>
These maneuvers are free for everyone. No skill required. No Discipline check. Just something every combat-trained hero knows how to do. You spend your Maneuver for the turn and the effect happens.

#figure([
#table(
  columns: (55.56%, 44.44%),
  align: (auto,auto,),
  table.header([Maneuver], [Effect],),
  table.hline(),
  [#strong[Defend]], [+2 Protection Value until your next turn.],
  [#strong[Disengage]], [Move 5 ft without provoking opportunity attacks.],
  [#strong[Aid]], [Ally within 30 ft gains +2 on their next roll before your next turn.],
  [#strong[Shove]], [Opposed Brawn vs Brawn/Agility. Push target 5 ft (10 ft on Strong).],
  [#strong[Grapple]], [Initiate a grapple (see #ref(<sec-grappling>, supplement: [Section])).],
  [#strong[Command]], [A companion, familiar, or mount under your control takes an extra move.],
  [#strong[Catch Breath]], [Regain HP equal to your Fortitude score (min 1). Once per combat.],
  [#strong[Search]], [Active Investigation check to spot a hidden creature or clue.],
  [#strong[Stand Up]], [Rise from prone.],
  [#strong[Use Item]], [Drink a potion, apply a salve, or activate a simple device.],
)
], caption: figure.caption(
position: top, 
[
Table 13.1: Basic Combat Maneuvers
]), 
kind: "quarto-float-tbl", 
supplement: "Table", 
)
<tbl-basic-maneuvers>


Skill-granted maneuvers are listed on each skill's card in #strong[?\@sec-chapter-skills]. They're typically more powerful than basics and require Adept or Master rank. You earn those. They're not free.

#pagebreak()
== Making an Attack
<making-an-attack>
Attacks always hit. Say it with me: #emph[always hit.] When you swing your weapon or hurl a spell, you connect. The question isn't whether, it's how hard.

Roll 3d6 + modifiers. The total determines your damage tier:

- #strong[Weak:] Glancing blow. Apply the weapon's Weak damage value.
- #strong[Standard:] Solid hit. Apply Standard damage.
- #strong[Strong:] Devastating strike. Apply Strong damage.
- #strong[Critical (three 6s):] Maximum Strong damage plus a bonus effect from the Critical table (#strong[?\@sec-chapter-core-resolution]).

That's one roll. No separate damage dice. No "did I hit?" anxiety. Roll once, read the damage, move on.

#block[
#callout(
body: 
[
Think about your favorite fantasy fight scenes. How often does the hero swing and completely miss? Almost never. They clash. They parry. They take glancing blows. Contact happens.

The always-hit rule means every round advances the fight. Nobody whiffs three rounds in a row while the table checks their phones. Nobody spends their whole turn to accomplish nothing. Something #emph[always] happens.

This also means fights are inherently dangerous. You can't stack AC so high that goblins need a natural 20 to touch you. Every attack lands, armor reduces damage instead of preventing hits. The knight in plate mail still gets knocked around. They just stay standing longer.

The math supports it too. With the 3d6 bell curve, Weak results cluster around the middle just like everything else. A typical attack lands Standard or Weak, consistent, predictable, but never wasted. Combat moves. The tension comes from #emph[who's still standing], not from #emph[who finally rolled high enough to participate.]

]
, 
title: 
[
Why Always-Hit?
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Damage Types
<damage-types>
Not all wounds are created equal. A slash bleeds. A burn blisters. A psychic assault leaves no mark on the body but the mind remembers. Damage types exist so the fiction and the mechanics speak the same language --- when the troll's flesh sizzles at the touch of your firebolt, the rules should reflect that.

#strong[Physical:] Slashing, Piercing, Bludgeoning. These are the bread and butter of combat. Swords slash, arrows pierce, hammers bludgeon. Most armor protects against all three equally, but some creatures care deeply about the distinction --- skeletons laugh at piercing arrows but crumble under bludgeoning maces.

#strong[Elemental:] Fire, Cold, Lightning, Acid, Poison. The primal forces, channeled through magic or alchemy. Elemental damage bypasses most physical armor entirely, but many creatures have natural resistances --- fire elementals shrug off flames, frost giants wade through blizzards.

#strong[Magical:] Force, Radiant, Necrotic, Psychic. The esoteric damage types. Force is raw magical energy, the wizard's hammer. Radiant is divine light, the shepherd's fire. Necrotic is death made manifest, the unbalancing touch. Psychic attacks the mind directly --- the brain has no armor.

Resistances and vulnerabilities modify damage of specific types. A creature resistant to Fire takes half damage from your Firebolt (round down). A creature vulnerable to Slashing takes double from your longsword. The DA will tell you when it matters --- part of the game's fun is discovering, through play, that the shambling horror in the swamp stops regenerating when you hit it with fire.

#pagebreak()
== Conditions
<conditions>
Conditions are the status effects that change how a creature behaves in combat. They come from spells, abilities, maneuvers, and environmental hazards. Each condition tells you exactly what it does and how it ends.

#figure([
#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Condition], [Effect], [Ends],),
  table.hline(),
  [#strong[Blinded]], [Attacks reduced one tier], [Source duration],
  [#strong[Charmed]], [Cannot attack charmer], [Save ends],
  [#strong[Deafened]], [Perception disadvantage], [Source duration],
  [#strong[Frightened]], [Cannot approach source], [Save ends],
  [#strong[Grappled]], [Speed 0], [Escape action],
  [#strong[Incapacitated]], [No actions], [Source duration],
  [#strong[Invisible]], [Cannot be targeted directly], [Attack/action ends],
  [#strong[Paralyzed]], [Incapacitated + auto-crit if hit], [Save ends],
  [#strong[Poisoned]], [Disadvantage on attacks], [Save ends],
  [#strong[Prone]], [Melee adv vs you, ranged disadv], [Stand up (move)],
  [#strong[Restrained]], [Speed 0, attack disadv], [Escape action],
  [#strong[Stunned]], [Incapacitated + cannot move], [Save ends],
  [#strong[Unconscious]], [Incapacitated + prone + unaware], [Healing or save],
)
], caption: figure.caption(
position: top, 
[
Table 13.2: Conditions
]), 
kind: "quarto-float-tbl", 
supplement: "Table", 
)
<tbl-conditions>


#pagebreak()
== Surprise
<surprise>
You don't always see the fight coming. When one side catches the other flat-footed, the ambushing side acts first in the opening round, regardless of initiative rolls. Surprised targets take a -2 penalty on their first roll. They're reacting, not acting. That half-second of hesitation costs them.

To determine surprise, the ambushing side rolls Stealth opposed by the target's passive Insight (Knowledge score + 7). Standard or Strong success means surprise is achieved. Weak means the target heard something, a snapped twig, a hissed whisper, and is ready.

#quote(block: true)[
#strong[DA Guidance:] Don't let the party surprise every encounter just because the rogue has high Stealth. Surprise requires genuine tactical advantage, darkness, distraction, or terrain. Walking up to a guard in plain sight and saying "I hide" isn't surprise. It's comedy.
]

#pagebreak()
== Grappling
<sec-grappling>
Sometimes you don't want to kill them. Sometimes you want to hold them still while your friends ask questions. Or choke them out. Or throw them off a bridge. Grappling covers all of it.

To initiate a grapple, make a Brawn (Athletics) roll opposed by the target's Brawn (Athletics) or Agility (Acrobatics), their choice. They'll pick whichever they're better at, obviously.

#table(
  columns: (50%, 50%),
  align: (auto,auto,),
  table.header([Result], [Effect],),
  table.hline(),
  [#strong[Weak]], [You grab hold but don't control. Target is Grappled but can still act freely.],
  [#strong[Standard]], [Firm hold. Target is Grappled and Restrained.],
  [#strong[Strong]], [Complete control. Target is Grappled, Restrained, and you may move them at half speed.],
)
While grappling, you may use your Action to:

- #strong[Pin:] Force another opposed roll. Strong result adds Incapacitated.
- #strong[Throw:] End the grapple. Target is knocked Prone adjacent to you and takes Weak unarmed damage.
- #strong[Choke:] Target begins suffocating. They can hold breath for Fortitude + 2 rounds before things get desperate.

#quote(block: true)[
#emph[A grappled creature can still fight back.] The Grappled condition only stops movement, a grappled spellcaster can still cast. The Restrained condition imposes disadvantage on attacks but doesn't prevent them. Grabbing the enemy wizard doesn't end the fight. It starts a new one.
]

#pagebreak()
== Two-Weapon Fighting
<two-weapon-fighting>
A blade in each hand. It looks good. It #emph[feels] good. Here's how it works.

When you wield a weapon in each hand, you may attack with both as a single Action. The off-hand weapon deals damage one tier lower:

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Primary Result], [Off-Hand Result],),
  table.hline(),
  [Strong], [Standard],
  [Standard], [Weak],
  [Weak], [1 damage],
)
The off-hand weapon must have the #strong[Light] property (Dagger, Shortsword, Handaxe) unless you have the #strong[Dual Wielder] talent, which removes that restriction.

#strong[Example:] Kael wields a longsword (primary) and shortsword (off-hand). He rolls 3d6 and lands a Standard hit, 3 damage from the longsword. The shortsword drops a tier to Weak, 2 more damage. Total: 5. Two blades, one roll, clean result.

#pagebreak()
== Non-Lethal Attacks
<non-lethal-attacks>
Not every enemy needs to die. When you reduce a creature to 0 HP with a melee attack, you can pull the blow. Declare it non-lethal. The creature falls Unconscious but stable at 0 HP instead of bleeding out. They'll wake up with a headache and, hopefully, a newfound appreciation for answering questions.

Ranged attacks and spells can't be made non-lethal --- arrows and fireballs don't do "gentle." You can't ask a lightning bolt to hold back. Unless the spell specifically says otherwise (like #emph[Sleep]), assume ranged and magic are lethal. If you want prisoners, put the bow away and draw steel.

#quote(block: true)[
#emph[Why this matters:] Prisoners have information. Killing the only goblin who knows the dungeon layout means you're wandering blind. The cultist you spared might know the villain's true name. The bandit leader, once disarmed and facing a choice between talking and bleeding, becomes your best source of intelligence. Sometimes the most powerful thing you can do is leave someone alive, and talking. The dead don't negotiate.
]

#pagebreak()
== Morale
<morale>
NPCs and monsters don't fight to the death by default. Most creatures want to #emph[live.] When the fight turns against them, they break. Use morale to keep combat short and believable.

When a creature faces overwhelming odds, the DA calls for a #strong[Morale Check.] The creature rolls 3d6 with no modifiers:

#table(
  columns: (44.44%, 55.56%),
  align: (auto,auto,),
  table.header([Result], [Behavior],),
  table.hline(),
  [#strong[Strong (13+)]], [Stands firm. Gains +1 on its next attack.],
  [#strong[Standard (7-12)]], [Wavers but stays. Disadvantage on its next attack.],
  [#strong[Weak (1-6)]], [Flees or surrenders. Fight's over for this one.],
)
A creature automatically checks morale when:

- Reduced below half HP for the first time
- Its leader is defeated
- Half its group has fallen
- The party demonstrates overwhelming force (DA's call)

#quote(block: true)[
#emph[DA Guidance:] Use morale to keep combat from becoming a slog. When the goblins' leader falls and three of their friends are down, the remaining two should break and run, not fight to 0 HP while the party mops up. Morale makes fights feel alive and saves table time. The goblins want to go home too.
]

#pagebreak()
== Dying and Death
<dying-and-death>
0 HP. You're down. The world goes dark. But the story's not over, not yet.

At 0 HP, you fall Unconscious. Each round on your turn, roll 3d6 with no modifiers:

#table(
  columns: (47.06%, 52.94%),
  align: (auto,auto,),
  table.header([Result], [Outcome],),
  table.hline(),
  [#strong[Strong (13+)]], [You stabilize at 1 HP. You're back in the fight, barely.],
  [#strong[Standard (7-12)]], [You remain unconscious but stable. Not getting worse.],
  [#strong[Weak (1-6)]], [Take 1 wound. You're still dying.],
  [#strong[Fumble (3-1)]], [Death. The table goes quiet.],
  [#strong[Critical (3-6)]], [You snap awake at half HP. Someone up there likes you.],
)
An ally can stabilize you with a Medicine check (Standard difficulty) or any healing effect. Once stable, you're unconscious at 0 HP but no longer rolling to survive.

#pagebreak()
== Cover
<cover>
Use the terrain. A pillar, a flipped table, a crouching ally --- anything between you and incoming fire helps. Cover is free armor. It doesn't cost a Maneuver, doesn't require a skill, doesn't use an Action. It just requires you to think about where you're standing before the arrows start flying.

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Cover], [Attacker Penalty],),
  table.hline(),
  [#strong[Half cover]], [-1 to attack roll],
  [#strong[Three-quarters cover]], [-3 to attack roll],
  [#strong[Full cover]], [Cannot be targeted],
)
Positioning matters. If you're standing in the open trading shots with archers, you're doing it wrong. Get behind something. Make them work for it. The difference between a dead hero and a living one is often the pillar they hid behind during the first volley. Use the terrain. It's the one ally that never misses a session.

#pagebreak()
#pagebreak()
#figure([
#box(image("chapters/../assets/svg/placeholder-section.svg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 36: Combat Midpoint
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 36 --- Combat chapter midpoint. Placeholder for final art. Use placeholder-section.svg dimensions: 400×300.]

#pagebreak()
== Worked Example: A Full Combat Round
<worked-example-a-full-combat-round>
The party faces a Knight of the Iron Circle (Challenge 3) and two Cultists (Challenge 1/2) in a torchlit temple chamber. Initiative order: Lyra (Odd) 5, Kael (Blade) 4, Knight 3, Cultists 2, Roric (Protector) 1.

#strong[Round 1, Lyra's Turn:]

Lyra sees the cultists chanting, they're building toward something. She decides to disrupt them.

"I cast #emph[Gust] at the cultists. Wind Discipline, Novice."

She rolls 3d6 + Reason (+1) + no skill. Rolls 3, 4, 4 = 11 + 1 = 12. #strong[Standard.] The gust slams into both cultists, they must make Fortitude saves or be knocked Prone. Cultist 1 fails (rolls 4). Cultist 2 passes (rolls 10). One cultist goes sprawling, his chant broken. Lyra spends her Maneuver to Defend, +2 Protection Value.

#strong[Round 1, Kael's Turn:]

Kael sees the Knight advancing on Roric. He moves 15 ft to flank, drawing his longsword as a free action.

"I attack the Knight. Blades Fighting Adept."

Rolls 3d6 + Brawn (+1) + Blades Fighting (+2). Rolls 5, 4, 5 = 14 + 3 = 17. #strong[Strong.] Longsword Strong damage: 5. Knight's plate armor: DR 4. 5 - 4 = 1 damage. The blade finds a gap at the Knight's gorget, a thin line of blood. Not a killing blow, but the Knight knows Kael can hurt him.

Kael uses his Maneuver: #strong[Riposte] is ready if the Knight swings at him.

#strong[Round 1, Knight's Turn:]

The Knight assesses the threat. The Blade just drew blood. The Protector is a wall. The Odd is in the back. Tactical decision: kill the one who can actually hurt him.

"I attack the Blade." Rolls for the Knight. Longsword: 3d6 + Brawn (+2). Rolls 6, 3, 2 = 11 + 2 = 13. #strong[Standard.] Longsword Standard damage: 4. Kael's leather armor: DR 2. 4 - 2 = 2 damage. Kael drops from 11 HP to 9 HP.

"Shield Block," Kael declares, spending his reaction. The Knight's Standard drops to Weak: 3 damage - DR 2 = 1 damage. Kael drops to 10 HP instead of 9. The Knight's blade skids off Kael's raised buckler.

"Riposte!" Kael spends his reaction, wait. He already used his reaction for Shield Block. He gets one reaction per round. No Riposte. The Knight's attack stands, and Kael's counter never comes. That's the tradeoff. Shield Block saved him HP. Riposte would have cost him HP but dealt damage back. Kael chose survival.

#strong[Round 1, Cultists' Turn:]

Cultist 1 stands up from Prone (uses half his movement). Cultist 2, still standing, hurls a #strong[Dark Bolt] at Lyra, the one who knocked his friend down.

Rolls 3d6 + Guile (+1). Rolls 2, 5, 5 = 12 + 1 = 13. #strong[Standard.] Dark Bolt Standard damage: 3 necrotic. Lyra has no armor. She takes 3 damage. The bolt of shadow slams into her shoulder, cold and wrong. She drops to 7 HP.

#strong[Round 1, Roric's Turn:]

Roric has been waiting. The Knight is focused on Kael. The cultists are clustered. Time to be the Protector.

"I move to engage the Knight. Attack with my warhammer."

Rolls 3d6 + Brawn (+2) + Heavy Weapon Fighting Novice (+1). Rolls 3, 3, 2 = 8 + 3 = 11. #strong[Standard.] Warhammer Standard damage: 4. Knight's armor: DR 4. 4 - 4 = 0 damage. The hammer rings off the Knight's breastplate. Sparks. No blood. But Roric's not done.

"Maneuver: I'm using #strong[Menacing Glare] from Intimidation Adept." The Knight must make a Morale Check. The DA rolls for the Knight: 3d6. Rolls 2, 1, 4 = 7. #strong[Standard.] The Knight wavers, disadvantage on his next attack.

#strong[End of Round 1.] The party has dealt 2 total damage to the Knight (Kael's 1, Roric's 0). The cultists dealt 3 to Lyra. The Knight dealt 1 to Kael (reduced from 2 by Shield Block). Nobody is down. Everyone is engaged. The next round will be decisive.

#strong[Round 2, Lyra's Turn:]

Lyra's shoulder burns from the Dark Bolt, but she's an Odd, when things go wrong, she gets interesting.

"I cast #emph[Spark] at the standing cultist. Fire Discipline, Novice. Then I use my Odd ability, #strong[Wildcard.]"

Spark roll: 3d6 + Reason (+1). Rolls 6, 6, 1 = 13 + 1 = 14. #strong[Strong.] Spark Strong damage: 4 fire. Cultist has no armor. 4 damage straight through. The cultist screams as fire catches his robes.

Wildcard: Lyra rolls a d6 on the chaos table, 4. "Enemies within 15 ft take 1 damage." The Knight and both cultists are within range. Each takes 1 damage. The Knight's armor reduces it to 0, but the cultists both take it. The standing cultist has now taken 5 damage, he's at 1 HP.

#strong[Round 2, Kael's Turn:]

The Knight is wavering from Roric's Menacing Glare. Kael sees the opening.

"Attack the Knight again."

Rolls 3d6 + Brawn (+1) + Blades Fighting (+2). Rolls 4, 6, 5 = 15 + 3 = 18. #strong[Strong.] Longsword Strong damage: 5. Knight's DR: 4. 5 - 4 = 1 damage. Total damage on Knight: 3 (2 from earlier attacks + 1 now). The blade slips under the Knight's pauldron, deeper this time. The Knight grunts.

Kael uses his Maneuver to #strong[Flurry] (Master maneuver, but wait, Kael is only Adept. He can't use Flurry). He uses #strong[Defend] instead, +2 PV. Smart. He's the Knight's target and he knows it.

#strong[The Knight's Morale:]

The Knight has taken 3 damage, not much, but he's down to 17 HP from 20. Both cultists are bloodied. One is at 1 HP. The party is coordinated and the Protector hasn't even been hit yet. The DA calls for a Morale Check.

Knight rolls 3d6: 3, 2, 1 = 6. #strong[Weak.] The Knight lowers his sword. "Enough," he growls. "You fight well. The Iron Circle withdraws." He drags the wounded cultist to his feet. They retreat into the shadows of the temple.

The party could press the attack, but Lyra is at 7 HP, Kael is at 10, and the Knight might have reinforcements. They let them go.

#strong[Total combat time at the table:] About 8 minutes. Two full rounds. Everyone acted. Damage was exchanged. The Knight broke on morale. The story advanced. That's #emph[Heroes of Legend] combat.

#pagebreak()
== Worked Example: The Ambush
<worked-example-the-ambush>
The party has tracked a bandit scout to a forest clearing. The bandit doesn't know they're here. The party wants him alive for questioning.

#strong[Surprise Check:] Lyra rolls Stealth: 3d6 + Agility (+2) + Stealth Adept (+2). Result: 5, 6, 4 = 15 + 4 = 19. #strong[Strong.] The bandit's passive Insight is 7 (Knowledge 0 + 7). 19 beats 7 easily. Surprise achieved.

#strong[Round 1 (Surprise Round):] The party acts. The bandit does not.

#strong[Kael] moves 30 ft through the underbrush, drawing his shortsword. "I grapple him from behind."

Grapple roll: 3d6 + Brawn (+1) + Athletics Novice (+1). Bandit opposes with Brawn (+0). Kael: 4, 3, 5 = 12 + 2 = 14. Bandit: 2, 4, 1 = 7. #strong[Strong.] Kael has the bandit in a full lock, Grappled, Restrained, and controlled. The bandit can't move, can't reach his weapon, and Kael can drag him wherever he wants.

#strong[Lyra] moves up, dagger drawn. "Talk. Where's your camp?"

The bandit is Restrained, outnumbered four to one, and caught completely off guard. The DA rules this is an automatic Morale Check at disadvantage. Bandit rolls: 1, 3, 2 = 6. #strong[Weak.] "North! Two miles north! Old watchtower! Please don't kill me!"

Combat over. One roll. The ambush worked because the party used Stealth, positioning, and overwhelming force, not because they rolled high on a damage die.

#block[
#callout(
body: 
[
If you're DAing for a group that's new to #emph[Heroes of Legend], here's how to make combat sing from the first session.

#strong[Start small.] One enemy per hero. No lieutenants, no reinforcements, no lair actions. Let the players learn the action economy, Action, Movement, Maneuver, before you add complexity.

#strong[Announce the turn order at the top of every round.] "Kael, you're up. Lyra, you're next. Then the goblins. Roric, you're after them." Players stop asking "whose turn is it?" when they can see the on-deck circle.

#strong[Use physical tokens for reactions.] Give each player a poker chip or a coin. When they spend their reaction, they flip it over. At the start of their turn, they flip it back. It's a visual reminder that they have one reaction per round, and it prevents the "wait, did I already use my reaction?" conversation.

#strong[Describe damage, not numbers.] "The goblin's blade skips off your pauldron, you feel the impact but no pain" is better than "You take 0 damage." The fiction matters more than the arithmetic. Players remember the time the dragon's claw sent them flying across the room. They don't remember the time they took 7 piercing damage.

#strong[End fights when they're over.] When the outcome is certain, the last two goblins are surrounded, wounded, and outnumbered, don't play out two more rounds of cleanup. The goblins surrender or flee. Move to the aftermath. Combat is a pacing tool, not a punishment.

]
, 
title: 
[
Running Combat for New Players
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
= Social Conflict
<sec-chapter-social-conflict>
#figure([
#box(image("chapters/../assets/images/page079-img030.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 21: Social Conflict Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 21 --- Social conflict chapter art (Basic Mechanics). Placeholder; final art TBD. Dimensions: 579×557.]

#pagebreak()
Not every battle is fought with swords. Sometimes the most dangerous weapon in the room is a well-timed word.

Social conflict covers everything from haggling with a merchant to negotiating a peace treaty between warring kingdoms. The same 3d6 engine drives it all, roll your dice, add your attribute, add your skill, compare to success tiers. The difference is the stakes: instead of hit points, you're gambling with trust, reputation, and information.

#pagebreak()
== Social Skills
<social-skills>
Four skills carry the weight of social encounters. Know which one fits the moment.

#strong[Deception (Guile):] Lying convincingly. False identities, forged documents, "Of course I'm supposed to be here." The Blade's favorite. The Protector's last resort.

#strong[Persuasion (Guile):] Diplomatic negotiation. Building rapport, finding common ground, making reasonable people see reason. The Leader's primary tool. The Intellect's backup plan.

#strong[Intimidation (Brawn):] Threats and coercion. "I wasn't asking." Works fast, burns bridges faster. The Unbalanced lives here. Everyone else visits when patience runs out.

#strong[Insight (Reason):] Reading truth from lies. Catching the twitch, the hesitation, the glance at the exit. Passive Insight is your Knowledge score + 7, that's the number the DA uses when someone's lying to you and you're not actively looking for it.

#pagebreak()
== NPC Attitudes
<npc-attitudes>
Every NPC your party encounters has an attitude. It's the starting point for every social roll. Shift it in your favor, and doors open. Shift it the wrong way, and you're talking to a slammed gate.

#table(
  columns: (25.64%, 25.64%, 48.72%),
  align: (auto,auto,auto,),
  table.header([Attitude], [Response], [Mechanical Effect],),
  table.hline(),
  [#strong[Hostile]], [Will oppose actively.], [Need Strong result to shift to Neutral. Standard fails, they dig in harder.],
  [#strong[Neutral]], [Indifferent. Doesn't care about you either way.], [Standard result gains cooperation for a single request.],
  [#strong[Friendly]], [Inclined to help. You've made a good impression.], [Weak result sufficient for minor favors. Standard opens real doors.],
  [#strong[Allied]], [Will risk themselves for you.], [No roll needed for reasonable requests. They're on your side.],
)
Attitudes shift based on your actions, both in and out of social conflict. Insult a Friendly NPC and they drop to Neutral. Save a Hostile NPC's child and they might climb to Neutral or even Friendly. The fiction drives the numbers, not the other way around.

#pagebreak()
== Extended Social Conflicts
<extended-social-conflicts>
For high-stakes negotiations, convincing the king to commit troops, talking down the assassin with a blade at the queen's throat, negotiating surrender with the bandit lord, run social encounters as multi-round conflicts.

Here's the structure:

+ #strong[Set the stakes.] What does each side want? What happens if negotiations fail?
+ #strong[Determine attitudes.] Where does each NPC start on the attitude scale?
+ #strong[Round by round.] Each round, one PC makes a social skill roll. The DA roleplays the NPC's response based on the result.
+ #strong[First to 3 successes wins.] The conflict resolves in the winning side's favor.
+ #strong[Failures shift attitudes negatively.] Each failed roll pushes the NPC one step toward Hostile. At Hostile, further failures may end the conversation, or start a different kind of fight.

#block[
#callout(
body: 
[
A failed social roll shouldn't mean "the conversation stops." It means the conversation takes a turn you didn't want.

Failed to persuade the guard? He doesn't slam the gate, he calls his sergeant over. Now you're talking to someone with more authority and more suspicion. The scene escalates, but it doesn't end.

Failed to deceive the merchant? She doesn't kick you out, she raises the price. "I know what you're doing. Twenty percent surcharge for wasting my time." You can still buy the thing. It just costs more.

The worst outcome in a social scene is "nothing happens." Keep the fiction moving. Every roll should change the situation, even if it's not in the party's favor.

]
, 
title: 
[
Failing Forward in Social Encounters
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Worked Example: A Full Social Conflict Scene
<worked-example-a-full-social-conflict-scene>
The party needs passage through the Ironwood, a dense forest controlled by the Thornwood elves. The elven warden at the border crossing is Neutral: she doesn't know these travelers, doesn't trust them, but hasn't been given a reason to turn them away yet. The party's Leader, Ser Aldric, takes the lead.

#strong[The stakes:] Passage through the Ironwood. Fail, and the party must take the mountain pass, adding a week to their journey and costing them the element of surprise against the cult they're chasing.

#strong[Round 1, Opening Gambit:]

#strong[Aldric (the player):] "I approach the warden with open hands. 'We have no quarrel with the Thornwood. We hunt a cult that's kidnapped children from three villages. They passed this way two days ago.'"

#strong[The DA:] "The warden's expression doesn't change, but her eyes flick toward the treeline. 'Children, you say.' She's listening. Give me a Persuasion roll. Standard difficulty, she's Neutral, and your cause is sympathetic."

#emph[Aldric rolls:] 3d6 + Guile (+1) + Persuasion Adept (+2). Result: 4, 5, 3 = 12 + 3 = 15. #strong[Strong.]

#strong[The DA:] "The warden uncrosses her arms. 'We found tracks, heavy boots, dragging something. They went east, toward the old barrows. You'll need a guide. The barrows are… unsettled.' That's one success. She's shifted to Friendly."

#strong[Round 2, The Lieutenant Objects:]

#strong[The DA:] "Before the warden can assign a guide, her lieutenant steps forward. He's older, scarred, and clearly doesn't like outsiders. 'Warden. These #emph[humans] could be lying. They could be the cultists, spinning a story to get past us.' He's Hostile."

#strong[Lyra (the player):] "I step up beside Aldric. 'Lieutenant. Look at us. We're exhausted, we're armed for a fight, and we're asking permission instead of forcing our way through. Cultists don't ask.' Can I use Insight to read what's really bothering him?"

#strong[The DA:] "Roll Insight. Standard difficulty."

#emph[Lyra rolls:] 3d6 + Reason (+1) + Insight Novice (+1). Result: 5, 2, 4 = 11 + 2 = 13. #strong[Strong.]

#strong[The DA:] "You catch it, a microexpression when he said 'humans.' He lost someone to human bandits. Years ago. This isn't about you. It's about old wounds. You can use that."

#strong[Lyra:] "I soften my voice. 'We're not them. Whoever hurt your people, we're hunting the same kind of monster.' Persuasion, using the Insight lead."

#emph[Lyra rolls:] 3d6 + Guile (+1) + Persuasion (no skill, just attribute). DA gives +1 for the Insight advantage. Result: 3, 6, 5 = 14 + 2 = 16. #strong[Strong.]

#strong[The DA:] "The lieutenant stares at Lyra for a long moment. Then he nods once, a single, sharp motion. 'Warden. I'll guide them myself.' Two successes."

#strong[Round 3, The Warden's Price:]

#strong[The DA:] "The warden raises a hand. 'One condition. The cult lairs in the old barrows. If you find something there that belongs to the Thornwood, an artifact, a tome, a spirit-stone, you bring it back to us. The barrows are elven graves. What's buried there is ours.'"

#strong[Aldric:] "Agreed. We're not grave robbers. You have my word."

#strong[The DA:] "She's already Friendly, and this is a reasonable request. No roll needed, she trusts you. Three successes. The conflict is won."

#strong[Outcome:] The party gains passage through the Ironwood, a guide who knows the terrain, and an ally in the Thornwood elves, all because they worked the social conflict round by round instead of rolling once and hoping for the best.

#pagebreak()
== Why Run Extended Social Conflicts
<why-run-extended-social-conflicts>
The single-roll approach works fine for buying a sword or asking directions. But for moments that define the story, extended conflicts give every player a chance to contribute. The Blade might read the room with Insight. The Arcanist might use Arcana to identify the magical wards on the negotiation chamber, information that becomes a bargaining chip. The Protector might just stand there looking unstoppable, giving the party's face a +1 circumstance bonus from sheer presence.

Let the party stack their skills. Social encounters are team efforts. The person rolling Persuasion is just the one delivering the final line, everyone else is feeding them the setup.

#block[
#callout(
body: 
[
In a lot of games, one player builds the "party face", max Charisma, max social skills, and handles every conversation while the rest of the table checks their phones. Don't let that happen.

Spread the social spotlight. The dwarf with Brawn +2 and no social skills can still contribute by standing behind the negotiator, arms crossed, looking like a wall of muscle. That's worth a +1 circumstance bonus, and it keeps the dwarf's player engaged.

The wizard with Knowledge +2 can drop a historical reference that earns the NPC's respect. The ranger can mention a shared enemy. Everyone has something to add. Your job as DA is to ask: "What's your character doing while they talk?" The answer might not require a roll, but it should always require attention.

]
, 
title: 
[
The "Face" Problem, And How to Avoid It
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
= Weapons
<weapons>
﻿\# Equipment {\#sec-chapter-equipment}

#figure([
#box(image("chapters/../assets/images/page095-img037.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 22: Equipment Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 22 --- Equipment chapter art (Health & healing). Placeholder; final art TBD. Dimensions: 713×693.]

#pagebreak()
Your hero is going to need gear. A sword, some armor, a rope, a torch, a bedroll, and probably a ten-foot pole because someone at the table has read about pit traps. Equipment is the stuff between your hero and a bad day. Choose it well.

The tables in this chapter list weapons by damage tier, armor by damage reduction, and adventuring gear by utility and cost. Prices are in gold pieces (gp), the standard currency of the realms. A laborer earns about 1 gp a month. A suit of plate armor costs more than most villagers see in a lifetime. Keep that in mind when you're haggling with the blacksmith --- you're not just buying gear, you're spending someone's annual salary.

#pagebreak()
Every weapon has fixed Weak, Standard, and Strong damage values. No damage dice, the 3d6 roll already determined how well you struck.

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Weapon], [Disciplines Required], [Damage (W/S/St)],),
  table.hline(),
  [Unarmed], [,], [1 / 1 / 2],
  [Dagger], [1 Blade], [1 / 2 / 3],
  [Shortsword], [2 Blades], [2 / 3 / 4],
  [Longsword], [1 Blade, 1 Heavy Weapon], [2 / 3 / 5],
  [Greatsword], [1 Blade, 2 Heavy Weapons], [3 / 5 / 8],
  [Handaxe], [1 Axe], [2 / 3 / 5],
  [Battleaxe], [1 Axe, 1 Heavy Weapon], [3 / 4 / 6],
  [Greataxe], [1 Axe, 2 Heavy Weapons], [3 / 5 / 8],
  [Spear], [1 Polearm], [2 / 3 / 4],
  [Halberd], [1 Polearm, 1 Axe], [3 / 5 / 7],
  [Shortbow], [1 Archery], [2 / 3 / 4],
  [Longbow], [2 Archery], [3 / 4 / 6],
  [Crossbow], [1 Archery, 1 Heavy Weapon], [3 / 5 / 7],
)
#block[
#callout(
body: 
[
Weapons don't just require more of the same Discipline, they require specific combinations. A Longsword needs #emph[Blade training AND Heavy Weapon training]. A Halberd needs #emph[Polearm AND Axe]. This means your Discipline choices define your fighting style. A warrior with 2 Blades and 1 Heavy Weapon can wield a Shortsword with precision or a Longsword with power, but a Greatsword (1 Blade + 2 Heavy Weapons) requires deeper investment in the Heavy Weapon path.

#strong[Heavy Weapon] Discipline represents training with large, two-handed weapons that rely on momentum and raw force rather than finesse. It gates access to the highest damage tiers.

]
, 
title: 
[
Discipline Combinations, Build Your Fighting Style
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#strong[Properties:]

- #strong[Versatile], +1 damage when wielded two-handed (Longsword only)
- #strong[Finesse], may use Agility modifier instead of Brawn on the 3d6 attack roll
- #strong[Reach], can attack targets 10 ft away (Spear, Halberd)
- #strong[Thrown], can be thrown (range 20/60 ft: Dagger, Handaxe, Spear)
- #strong[Light], can be used as an off-hand weapon for two-weapon fighting (Dagger, Shortsword, Handaxe)
- #strong[Loading], requires a Bonus Action to reload between shots (Crossbow only)

#pagebreak()
== Armor
<armor>
Armor provides damage reduction (DR), subtract from incoming physical damage.

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Armor], [Discipline Req], [DR],),
  table.hline(),
  [Padded], [,], [-1],
  [Leather], [,], [-2],
  [Studded Leather], [1 Armor], [-2],
  [Chain Shirt], [1 Armor], [-3],
  [Breastplate], [2 Armor], [-4],
  [Chain Mail], [2 Armor], [-5],
  [Plate], [3 Armor], [-6],
)
Shields: #strong[Buckler] (1 Protection, +1 DR), #strong[Shield] (1 Protection, +2 DR), #strong[Tower Shield] (2 Protection, +3 DR, provides half cover).

#pagebreak()
== Encumbrance
<encumbrance>
Slot-based system. You have 10 + (Brawn x 5) slots. Most items take 1 slot. Armor takes 2-4 slots. Two-handed weapons take 2 slots.

#pagebreak()
#figure([
#box(image("chapters/../assets/svg/placeholder-section.svg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 37: Equipment Midpoint
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 37 --- Equipment chapter midpoint. Placeholder for final art. Use placeholder-section.svg dimensions: 400×300.]

#pagebreak()
== Adventuring Gear
<adventuring-gear>
The general store doesn't sell magic swords. It sells rope, rations, and the thousand small items that separate a prepared adventurer from a corpse. Here's what's on the shelf.

#table(
  columns: (23.08%, 23.08%, 26.92%, 26.92%),
  align: (auto,auto,auto,auto,),
  table.header([Item], [Cost], [Slots], [Notes],),
  table.hline(),
  [#strong[Backpack]], [2 gp], [2\*], [Holds up to 30 slots of gear. Items stored inside don't count against your encumbrance, but the backpack itself takes 2 slots on your person. Retrieving a stored item takes a Maneuver.],
  [#strong[Bedroll]], [1 gp], [2], [A warm bedroll and blanket. Required for a full rest in the wild. Without one, you recover half HP (rounded down) from rest.],
  [#strong[Chalk (5 pieces)]], [5 cp], [0], [Mark walls, leave signals, draw ritual circles. Breaks easily. Costs nothing.],
  [#strong[Crowbar]], [2 gp], [1], [Advantage on Brawn checks to force open doors, chests, or grates. Makes a loud noise, no subtlety. Can be used as an improvised weapon (1/1/2 damage).],
  [#strong[Fishing Tackle]], [1 gp], [1], [Hook, line, and tackle. With a body of water and 1 hour, make a Knowledge check (Standard 9-14) to catch enough fish to feed one person for the day. On a Strong result, feed two.],
  [#strong[Grappling Hook]], [2 gp], [1], [Hooks onto ledges, branches, or battlements. Attach a rope and throw, range 30 ft. Requires a Brawn or Agility check (Standard) to set securely.],
  [#strong[Hammer]], [1 gp], [1], [Drives pitons, breaks things, nails doors shut. Can be used as an improvised weapon (1/1/2 damage).],
  [#strong[Healer's Kit]], [5 gp], [1], [Bandages, salves, and splints. 10 uses. When you stabilize a dying creature or restore HP during a short rest, add +1 HP per use expended. Without a kit, you can't use the Medicine skill to restore HP during rests.],
  [#strong[Ink & Pen]], [10 gp], [0], [Write letters, copy maps, forge documents. The ink lasts for roughly 20 pages. The pen is a quill, replace it when the cat gets it.],
  [#strong[Lantern (hooded)]], [5 gp], [1], [Bright light 30 ft, dim light 30 ft. The hood can be closed to reduce light to a 5-ft radius, useful for stealth. Burns for 6 hours per flask of oil.],
  [#strong[Manacles]], [2 gp], [1], [Restrains a creature of Small or Medium size. Escape requires an Agility check (Strong 17-20) or a Brawn check (Strong 17-20) to break. Without the key, they're not coming off quietly.],
  [#strong[Mirror (steel)]], [5 gp], [0], [Polished steel, not glass, it won't shatter when the fireball hits. Useful for looking around corners, signaling with reflected light, and confirming you're not a vampire.],
  [#strong[Oil (flask)]], [1 sp], [1], [Fuel for lanterns (6 hours). Can be thrown and ignited as an improvised attack, 2 fire damage on hit, and the target takes 1 ongoing fire damage until they spend an action to put it out.],
  [#strong[Parchment (5 sheets)]], [1 gp], [0], [Blank parchment. Maps, letters, wanted posters with your face on them, parchment is the medium of adventure.],
  [#strong[Pitons (set of 10)]], [5 sp], [1], [Iron spikes for climbing or securing ropes. Each piton supports 300 lbs when properly hammered into stone. Climbing a piton-anchored rope requires no check.],
  [#strong[Pouch (belt)]], [5 sp], [0\*], [Holds up to 50 coins or small items. Does not take a slot, it straps to your belt. The coins inside don't count against encumbrance. Be honest about what fits.],
  [#strong[Rations (1 day)]], [5 sp], [1], [Dried meat, hardtack, and dried fruit. Tastes like regret. One day without food: -1 to all rolls. Three days: -2. Five days: you're dying.],
  [#strong[Rope, Hemp (50 ft)]], [1 gp], [2], [Coarse, heavy, reliable. Supports 500 lbs. Can be cut with a blade (1 round) or burned through (2 rounds in fire).],
  [#strong[Rope, Silk (50 ft)]], [10 gp], [1], [Lightweight and strong. Supports 700 lbs. Half the bulk of hemp rope. Quieter when uncoiled, no rough fibers scraping against stone.],
  [#strong[Sack (large)]], [1 sp], [1\*], [A coarse sack that holds 1 cubic foot or 30 lbs of material. The sack takes 1 slot but its contents don't count, until it tears. One sharp edge and your loot is on the floor.],
  [#strong[Shovel]], [2 gp], [2], [Digs graves, trenches, and latrines. Buries treasure. Unearths treasure. The shovel has seen more adventuring than most bards.],
  [#strong[Spyglass]], [100 gp], [1], [Magnifies distant objects. Reduce the difficulty of visual Perception checks at long range by one tier (Strong becomes Standard, Standard becomes Weak). Objects beyond 1 mile are still indistinct.],
  [#strong[Tent (2-person)]], [2 gp], [3], [Canvas shelter. Keeps rain off, holds heat. Sleeping in a tent during severe weather negates the exhaustion penalty for exposure. Two people can squeeze in, three if you're very good friends.],
  [#strong[Thieves' Tools]], [25 gp], [1], [Lockpicks, files, and tension wrenches in a leather roll. Required for lockpicking and disabling mechanical traps. Without these, you can't make Thievery checks to pick locks. If you break a pick (fumble), replacement picks cost 5 gp.],
  [#strong[Torch (bundle of 3)]], [1 sp], [1], [Bright light 15 ft, dim light 15 ft. Burns for 1 hour. Can be used as an improvised weapon, 1 fire damage on hit. Wind, rain, or being dropped in water extinguishes.],
  [#strong[Waterskin]], [2 sp], [1], [Holds a half-gallon of water. One day without water: -1 to all rolls. Two days: -2. Three days: you're dying. In hot climates or heavy exertion, double the consumption rate.],
)
#strong[Coins and Encumbrance:] 100 coins of any denomination take 1 slot. A pouch holds up to 50 coins slot-free. A sack holds up to 300 coins before it tears. After your first dragon hoard, invest in a wagon.

#block[
#callout(
body: 
[
A new hero begins with 50 gp to purchase equipment. Most adventurers start with a backpack, bedroll, waterskin, 3 days of rations, a torch bundle, and weapons appropriate to their fighting style. The rest is personal taste, some carry chalk and parchment, others carry a crowbar and a bad attitude. Both are valid.

]
, 
title: 
[
Starting Gear
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Mounts & Vehicles
<mounts-vehicles>
A good horse is the difference between arriving fed and rested and arriving half-dead with blisters. A wagon is the difference between carrying out treasure and leaving it behind for the next batch of idiots. Pay attention.

=== Mounts
<mounts>
Mounts use a simplified stat block, HP, Speed, carrying capacity, and any special traits. They don't roll attacks (you do, from the saddle), but they can be targeted in combat. A dead horse is a tragedy. A dead horse in the middle of a chase is a catastrophe.

#table(
  columns: (17.07%, 14.63%, 12.2%, 17.07%, 17.07%, 21.95%),
  align: (auto,auto,auto,auto,auto,auto,),
  table.header([Mount], [Cost], [HP], [Speed], [Carry], [Special],),
  table.hline(),
  [#strong[Riding Horse]], [75 gp], [20], [60 ft], [400 lbs], [,],
  [#strong[Warhorse]], [400 gp], [35], [50 ft], [500 lbs], [Trained for combat. Does not require Animal Handling checks to control in battle.],
  [#strong[Pony]], [30 gp], [15], [40 ft], [200 lbs], [Suitable for Small riders only. Can navigate narrow tunnels and dense forest without penalty.],
  [#strong[Riding Dog]], [50 gp], [12], [40 ft], [100 lbs], [Keen Smell: +2 to tracking checks made with the dog's assistance. Suitable for Small riders only.],
  [#strong[Draft Horse]], [50 gp], [25], [40 ft], [800 lbs], [Built for hauling, not riding. Disadvantage on any check involving speed or agility.],
  [#strong[Camel]], [100 gp], [22], [50 ft], [500 lbs], [Desert Adapted: no penalties for heat or sand. Can go 5 days without water.],
  [#strong[Mule]], [8 gp], [15], [30 ft], [400 lbs], [Stubborn: once per session, may reroll a failed check to resist being moved, frightened, or coerced.],
)
#strong[Mount gear:] Saddle (10 gp), saddlebags (4 gp, hold 50 lbs), bit and bridle (2 gp), barding (light: 50 gp, +1 DR to mount; heavy: 200 gp, +3 DR to mount, Speed reduced by 10 ft). Feed costs 5 cp per day per mount. Stabling at an inn costs 5 sp per night.

#block[
#callout(
body: 
[
Give the horse a name. It'll die in session three and you'll all be genuinely upset. This is correct. This is the game working as intended.

]
, 
title: 
[
Naming Your Mount
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
=== Mounted Combat
<mounted-combat>
Fighting from horseback isn't just "combat but taller." It changes the geometry of the fight. Use it.

#strong[Charge Attack:] Here's the big one. When you move at least 20 feet in a straight line before making a melee attack from a mount, your damage tier increases by one step:

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Normal Result], [Charge Result],),
  table.hline(),
  [Weak], [Standard],
  [Standard], [Strong],
  [Strong], [Strong + 1d6],
)
The charge must be in a straight line, no zigzagging through trees. The mount must have a clear path. The target must be within reach at the end of the movement. The mount can continue moving after the attack if it has movement remaining. A warhorse at full gallop with a lance is the closest thing to a thunderbolt you'll ever ride.

#strong[Controlling a Mount:] You direct your mount using the Command maneuver, no roll required for trained mounts (warhorses, riding horses with riders who have Animal Handling). For untrained mounts or in chaotic situations (explosions, dragon fear, the horse just took an arrow), the DA may require an Animal Handling check (Standard) to keep control.

#strong[Fighting from a Moving Mount:] Ranged attacks made from a moving mount suffer a -2 penalty. The horse's gait throws off your aim. If you have Animal Handling at Adept or higher, this penalty is reduced to -1. At Master rank, you ignore it entirely, you could thread an arrow through a keyhole at full gallop.

#strong[Mount Death:] When your mount drops to 0 HP, it collapses. You're coming off. Make an Agility check (Standard 9-14) or take 1d6 falling damage and land Prone. On a Strong result, you leap clear and land on your feet, no damage, no Prone, all style.

#strong[Dismounting:] Costs half your movement in normal circumstances. Emergency dismount (throwing yourself clear) is a free action but requires the same Agility check as mount death, you're choosing to take the risk before the horse goes down.

#strong[Mounted vs.~Foot:] Attacks against a mounted target from the ground suffer -1 (you're reaching up). Attacks from a mounted target against someone on foot gain +1 (gravity is on your side). These modifiers cancel if both combatants are mounted or both are on foot.

#block[
#callout(
body: 
[
A party of four on horseback charging a line of goblins is one of the great joys of this game. The charge damage boost turns a Standard hit into a Strong one, and Strong into something legendary. Encourage your players to use terrain, momentum, and positioning. A mounted combatant who stands still might as well be on foot.

]
, 
title: 
[
The Cavalry Arrives
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
=== Vehicles
<vehicles>
Sometimes you need to move more than yourself. Trade goods, siege equipment, the dragon's hoard you just liberated. Vehicles get it done.

#table(
  columns: 7,
  align: (auto,auto,auto,auto,auto,auto,auto,),
  table.header([Vehicle], [Cost], [HP], [Speed], [Crew], [Passengers], [Cargo],),
  table.hline(),
  [#strong[Cart]], [50 gp], [30], [Draft animal], [1], [3], [500 lbs],
  [#strong[Wagon]], [100 gp], [50], [Draft animal], [1], [6], [2,000 lbs],
  [#strong[Carriage]], [300 gp], [40], [Draft animal (-2)], [1], [4], [200 lbs],
  [#strong[Chariot]], [150 gp], [25], [Draft animal (-2)], [1], [1], [50 lbs],
  [#strong[Small Boat]], [200 gp], [40], [Oars or sail], [2], [4], [500 lbs],
  [#strong[River Barge]], [800 gp], [80], [Oars or sail], [4], [10], [5 tons],
  [#strong[Coastal Ship]], [5,000 gp], [200], [Sail], [10], [30], [10 tons],
  [#strong[Warship]], [10,000 gp], [300], [Sail + oars], [40], [60], [5 tons],
)
#strong[Vehicle Rules:]

- #strong[Speed:] A vehicle drawn by draft animals moves at the animal's Speed while carrying up to its listed cargo capacity. Exceeding cargo capacity halves Speed. Doubling it stops the vehicle entirely, the axle's not made of magic.
- #strong[Crew:] The listed number is the minimum required to operate the vehicle. Half crew means Speed is halved. No crew means the vehicle drifts (water) or stops (land).
- #strong[Vehicle HP:] When a vehicle reaches 0 HP, it's destroyed, a cart collapses, a ship breaks apart. Repairs cost 10% of the vehicle's value per HP restored and require a craftsperson and 1 day per 5 HP.
- #strong[Combat on Vehicles:] Characters on a moving vehicle use the vehicle's Speed for relative positioning but act on their own initiative. The DA may call for Agility checks (Standard) to keep footing during sharp turns, collisions, or rough terrain. Falling off a wagon is embarrassing. Falling off a ship in a storm is a death sentence. Know the difference.
- #strong[Upgrades:] Vehicles can be reinforced (+10 HP, costs 25% of base price), armored (+2 DR for passengers, costs 50% of base price), or outfitted with weapon mounts (ballista platform on a ship, crossbow mount on a wagon). Weapon mounts require a crew member to operate and use the weapon's normal damage values.

#block[
#callout(
body: 
[
For vehicle vs.~vehicle chases, a wagon fleeing bandits on horseback, a ship outrunning pirates, use a simple contest. Each side rolls 1d6 each round. The side with the higher Speed rating gains +1 to the roll. First side to 3 successes wins (escape or capture). On a tie, something happens, a wheel hits a rock, a sail tears, a horse stumbles. The DA narrates the complication.

]
, 
title: 
[
Chases
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
= Armor & Shields
<sec-chapter-armor-shields>
#figure([
#box(image("chapters/../assets/images/page101-img039.png", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 23: Armor Illustration
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 23 --- Armor & shields chapter art (Magic items / armor). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Armor isn't about avoiding hits. Hits happen, that's the always-hit rule in action. Armor is about surviving them. Every point of Damage Reduction is one more swing you can take before you go down. Choose wisely.

Shields are different. They don't reduce damage passively, they give you a reaction that downgrades an incoming hit. Armor says "I can take it." A shield says "You'll have to do better than that."

#pagebreak()
== How Armor Works
<how-armor-works>
When you take physical damage, subtract your Damage Reduction (DR) from the damage value. The remainder is what you actually lose from your HP. Simple.

#strong[Example:] Kael wears leather armor (DR 2). A goblin's shortsword hits him for Weak damage (2). 2 - 2 = 0. The blade scrapes off his hardened leather pauldron. He feels the impact. He doesn't feel the steel.

If the goblin lands a Standard hit (3 damage), Kael takes 1 HP. The armor didn't stop it, but it turned a solid hit into a scratch.

#pagebreak()
== Armor Table
<armor-table>
#table(
  columns: (17.95%, 28.21%, 12.82%, 23.08%, 17.95%),
  align: (auto,auto,auto,auto,auto,),
  table.header([Armor], [Discipline], [DR], [Stealth], [Notes],),
  table.hline(),
  [#strong[Padded]], [,], [-1], [,], [Quilted layers. Cheap, uncomfortable, better than nothing.],
  [#strong[Leather]], [,], [-2], [,], [Boiled and shaped. The adventuring standard.],
  [#strong[Studded Leather]], [1 Armor], [-2], [,], [Leather reinforced with rivets. Light and quiet, the rogue's choice.],
  [#strong[Chain Shirt]], [1 Armor], [-3], [Disadv], [Worn under clothing. Flexible, concealable, noisy when you move.],
  [#strong[Breastplate]], [2 Armor], [-4], [,], [Solid chest protection. Leaves arms free for spellcasting.],
  [#strong[Half Plate]], [2 Armor], [-4], [Disadv], [Plates on vitals, chain everywhere else. The pragmatic heavy option.],
  [#strong[Chain Mail]], [2 Armor], [-5], [Disadv], [Full-body rings. Loud. Heavy. Effective.],
  [#strong[Plate]], [3 Armor], [-6], [Disadv], [The pinnacle of protection. When you absolutely need to be the last one standing.],
)
=== Armor and Spellcasting
<armor-and-spellcasting>
Armor interferes with the precise gestures and somatic control that spellcasting demands. The heavier the armor, the harder it is to channel magic through your body.

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Armor Type], [Spellcasting Penalty],),
  table.hline(),
  [Padded, Leather, Studded Leather], [None, full mobility, full casting],
  [Chain Shirt], [-1 to spell attack rolls],
  [Breastplate], [-1 to spell attack rolls],
  [Half Plate, Chain Mail], [-2 to spell attack rolls],
  [Plate], [-3 to spell attack rolls],
)
#block[
#callout(
body: 
[
Yes, you can put your Arcanist in Plate. It'll cost you, 3 Armor Discipline ranks at likely X3 cost, plus the armor itself. And you'll cast every spell at -3. Is it worth it?

For most casters: no. You're spending DP to make yourself worse at your primary job. But for a specific build, the battle mage who wades into melee, the front-line Shepherd who heals under fire, a Breastplate (no Stealth penalty, only -1 to casting) might save your life more often than it costs you a spell tier.

The game doesn't forbid any combination. It just makes you pay for unusual choices. That's the Discipline philosophy in one sentence.

]
, 
title: 
[
The Arcanist in Armor
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Shields
<shields>
A shield is an active defense. You're not just wearing it, you're using it. When an attack comes in, you can throw the shield in its path.

#strong[Buckler:] 1 Protection, +1 DR. Small, strapped to the forearm. Leaves your hand free for a second weapon or a wand.

#strong[Shield:] 1 Protection, +2 DR. The standard. Wood and iron, carried in the off hand.

#strong[Tower Shield:] 2 Protection, +3 DR, half cover. A portable wall. You move at -5 ft speed while carrying it. You can plant it as a maneuver to grant three-quarters cover to one ally directly behind you.

=== Shield Block (Reaction)
<shield-block-reaction>
When you are hit by an attack, you may use your reaction to interpose your shield. Reduce the damage tier by one step: #strong[Strong ? Standard, Standard ? Weak, Weak ? 1 damage.] You must be wielding a shield and be aware of the attack.

Shield Block cannot reduce damage below 1. It can be used against melee attacks, ranged attacks, and spell attacks, anything you can see coming.

#quote(block: true)[
#strong[DA Guidance:] Let the player declare Shield Block after hearing the damage tier result, not before. This makes shields feel active and tactical rather than just a passive DR bonus.
]

#pagebreak()
== Worked Example: Choosing Your Armor
<worked-example-choosing-your-armor>
Roric is building a dwarf Protector at Level 1. He has Brawn +2, Fortitude +1, and the Armor Discipline from his class. He wants to be the party's wall. Here's how he weighs his options:

#strong[Option A, Chain Mail (DR 5, 2 Armor Disc):] He has the Discipline requirement. He pays 1 DP for Armor (2), his class favors it at X1. Total DR: 5. He's a fortress. Downside: Stealth disadvantage, and spellcasters in the party can't rely on him for quiet infiltration.

#strong[Option B, Breastplate + Shield (DR 4 + Shield Block):] Breastplate needs 2 Armor Discipline, he has that. Shield adds +2 DR and the Shield Block reaction. Total passive DR: 6. Plus he can react to downgrade one hit per round. This is the tank build. The shield costs extra coin, but coin is replaceable. Heroes aren't.

#strong[Option C, Plate (DR 6, 3 Armor Disc):] At Level 1, he can't afford Armor (3), that's 4 DP even at X1. But he plans for it. At Level 3, he'll buy the third rank and commission a suit of plate. For now, he takes Option B.

Roric goes with Option B. The Breastplate + Shield gives him DR 6, a Shield Block reaction, and he can still move at full speed. At Level 3, he'll reassess. But for now, he's exactly where he needs to be: between the monsters and his friends.

#pagebreak()
== Worked Example: Shield Block in Combat
<worked-example-shield-block-in-combat>
Roric is holding a choke point against three goblins. He's got his Shield (DR +2) and Chain Mail (DR 5). Total DR: 7. The goblins aren't getting through easily.

#strong[Goblin 1 attacks:] The DA rolls. Standard hit, 3 damage. Roric's DR 7 absorbs it completely. The goblin's blade bounces off his pauldron with a sad #emph[ping.]

#strong[Goblin 2 attacks:] Strong hit, 5 damage. DR 7 absorbs it. Roric doesn't flinch.

#strong[Goblin 3 attacks:] The DA rolls a Critical, three 6s. The goblin's crude spear finds a gap in Roric's armor. Strong damage (5) plus a critical bonus. Total incoming: 7 damage.

#strong[Roric's player:] "Shield Block."

He spends his reaction. The damage tier drops: Critical ? Strong. The critical bonus is negated, the shield caught the spear point before it could twist. Damage is now 5 (Strong only). DR 7 absorbs it. The spear slams into Roric's shield, splintering the haft. Roric grunts. The goblin stares at his broken weapon in disbelief.

That's the power of a shield. Without it, Roric takes 7 damage, over half his HP. With it, he takes nothing, and the goblin is now unarmed.

#pagebreak()
== Donning & Doffing
<donning-doffing>
Light armor: 1 minute. Medium: 5 minutes. Heavy: 10 minutes. Shield: 1 action.

You won't always have time to suit up. If the party is ambushed while camping, the Protector fights in whatever they were sleeping in. Plan accordingly, or invest in the #strong[Endurance] skill, because sleeping in chain mail is exactly as unpleasant as it sounds.

#block[
#callout(
body: 
[
The best armor in the game won't save you from a bad position. DR reduces damage, it doesn't make you invincible. Five goblins all attacking the same target will eventually wear down even a Plate-armored Protector through sheer volume of Weak hits.

Use cover. Use positioning. Use the fact that you're harder to kill than everyone else to #emph[control where the fight happens.] The Protector's real armor isn't steel, it's standing in the right place at the right time.

]
, 
title: 
[
Armor Isn't Just Numbers
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
= Reading a Magic Item Entry
<reading-a-magic-item-entry>
﻿\# Magic Items {\#sec-chapter-magic-items}

#figure([
#box(image("chapters/../assets/images/page102-img040.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 24: Magic Items Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 24 --- Magic items chapter art. Placeholder; final art TBD. Dimensions: 654×654.]

#pagebreak()
Magic items are the treasures your hero will remember long after the hit points are tallied. A +1 sword is nice. A sword that bursts into flame when you speak its name, that's a story.

Magic items enhance heroes and may grant Disciplines. Some are always on. Some must be activated. All of them change what your hero can do.

#pagebreak()
Every magic item follows a simple format:

- #strong[Name:] What it's called. The name on the treasure hoard inventory.
- #strong[Rarity:] Uncommon, Rare, Very Rare, or Legendary. Rarity governs how often these appear and what level heroes should find them.
- #strong[Effect:] What it does. Always on, or activated.
- #strong[Attunement:] Whether it requires one of your three attunement slots.

#pagebreak()
== Core Magic Items
<core-magic-items>
#table(
  columns: (27.27%, 36.36%, 36.36%),
  align: (auto,auto,auto,),
  table.header([Item], [Rarity], [Effect],),
  table.hline(),
  [#strong[\+1 Weapon]], [Uncommon], [+1 damage to all tiers. The classic. Boring but reliable.],
  [#strong[Flame Tongue]], [Rare], [+1d6 fire damage on hit. Requires 1 Fire Discipline.],
  [#strong[Shield +1]], [Uncommon], [+1 DR while wielded.],
  [#strong[Cloak of Elvenkind]], [Uncommon], [Advantage on Stealth checks. The cloak shifts color to match its surroundings.],
  [#strong[Ring of Protection]], [Rare], [+1 DR, +1 to all saves. Simple. Powerful.],
  [#strong[Staff of Power]], [Very Rare], [+2 to spell damage tiers. Weak becomes Standard. Standard becomes Strong. Strong becomes devastating.],
  [#strong[Deck of Many Things]], [Legendary], [Draw a card. Fate unfolds. Some cards grant wishes. Some steal your soul. The deck has ended more campaigns than any dragon.],
)
#pagebreak()
#figure([
#box(image("chapters/../assets/svg/placeholder-section.svg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 38: Magic Items Midpoint
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 38 --- Magic items chapter midpoint. Placeholder for final art. Use placeholder-section.svg dimensions: 400×300.]

#pagebreak()
== Expanded Magic Items
<expanded-magic-items>
The following items showcase the range of what magic can do, from simple utility to battlefield-defining power. Each includes Weak/Standard/Strong effects where the item's power depends on a roll.

=== Blade of the Last Ember
<blade-of-the-last-ember>
#emph[Rare - Longsword - Requires Attunement - 1 Fire Discipline]

A sword forged from a fallen star. The blade is warm to the touch and glows faintly orange in darkness.

#strong[Always On:] +1 damage to all tiers. The bonus is fire damage.

#strong[Activated, Ember Burst (Maneuver, once per encounter):] You slam the blade into the ground. Fire erupts in a 10-ft radius around you.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [2 fire damage to all creatures in radius.],
  [#strong[Standard]], [4 fire damage. Creatures that fail a Fortitude save are Blinded until end of your next turn.],
  [#strong[Strong]], [6 fire damage. Creatures are Blinded (no save) and take 2 ongoing fire damage until they spend an action to put out the flames.],
)
=== Veilwalker's Shroud
<veilwalkers-shroud>
#emph[Uncommon - Cloak - Requires Attunement]

A cloak woven from shadow and spider silk. When you pull the hood up, the world forgets you're there.

#strong[Always On:] +1 to Stealth checks.

#strong[Activated, Step Between (Maneuver, once per encounter):] You vanish from your current position and reappear up to 30 ft away in any shadow or dimly lit area.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [You teleport but leave a faint shimmer for 1 round. Enemies know something moved.],
  [#strong[Standard]], [Clean teleport. You're hidden until you attack or take an obvious action.],
  [#strong[Strong]], [Clean teleport plus you become Invisible for 1 round.],
)
=== Stormcaller's Gauntlets
<stormcallers-gauntlets>
#emph[Rare - Gloves - Requires Attunement - 1 Wind Discipline]

Leather gloves crackling with trapped lightning. Your fingers leave faint arcs of static on everything you touch.

#strong[Always On:] Unarmed attacks deal lightning damage instead of physical.

#strong[Activated, Call Lightning (Action, once per encounter):] You point at a creature within 60 ft. A bolt of lightning descends from above.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [3 lightning damage. Target's hair stands on end. They know they were targeted.],
  [#strong[Standard]], [5 lightning damage. Target must make a Fortitude save or lose their reaction.],
  [#strong[Strong]], [8 lightning damage. Target is Stunned until end of your next turn.],
)
=== Chalice of Shared Mercy
<chalice-of-shared-mercy>
#emph[Rare - Wondrous Item - Requires Attunement - 1 Life Discipline]

A silver chalice that never tarnishes. Liquid poured into it glows with a soft golden light for 1 minute.

#strong[Activated, Shared Draught (Action, once per day):] You fill the chalice and drink. The healing flows through you to your allies.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [You regain 2 HP. One ally within 30 ft regains 2 HP.],
  [#strong[Standard]], [You regain 4 HP. Up to three allies within 30 ft each regain 3 HP.],
  [#strong[Strong]], [You regain 6 HP. All allies within 30 ft regain 5 HP and lose one condition of their choice.],
)
=== Titan's Girdle
<titans-girdle>
#emph[Very Rare - Belt - Requires Attunement]

A broad leather belt with a buckle of carved mountain stone. It's heavier than it looks, much heavier.

#strong[Always On:] Your Brawn score is treated as +3 for the purposes of carrying capacity, lifting, and breaking objects. Your Brawn modifier for attack and damage rolls is unchanged.

#strong[Always On:] You have advantage on Brawn checks to grapple, shove, or resist being moved.

=== Horn of the Dawn
<horn-of-the-dawn>
#emph[Uncommon - Wondrous Item - No Attunement]

A spiral horn carved from the tooth of some great celestial beast. When blown, it sounds like sunrise.

#strong[Activated, Dawn Call (Action, once per day):] You blow the horn. A wave of golden sound rolls outward.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [All allies within 60 ft lose the Frightened condition.],
  [#strong[Standard]], [All allies lose Frightened. Undead within 60 ft have disadvantage on their next attack.],
  [#strong[Strong]], [All allies lose Frightened and gain +1 on their next roll. Undead within 60 ft take 3 radiant damage.],
)
=== Mirror of Echoing Eyes
<mirror-of-echoing-eyes>
#emph[Rare - Wondrous Item - Requires Attunement]

A hand mirror framed in tarnished silver. The glass doesn't show your reflection, it shows what someone else is seeing.

#strong[Activated, Echo Sight (Action, once per session):] You speak the name of a creature you've met. The mirror shows you what they see, right now, for up to 1 minute.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [Flashes of imagery. You get a general sense of their location and what they're doing.],
  [#strong[Standard]], [Clear vision for 1 minute. You see through their eyes. They feel a faint unease, they know something is watching.],
  [#strong[Strong]], [Clear vision for 1 minute. They feel nothing. You may also hear what they hear.],
)
=== Boots of the Long Road
<boots-of-the-long-road>
#emph[Uncommon - Wondrous Item - No Attunement]

Sturdy leather boots, scuffed and comfortable. They never wear out. They never give you blisters. They always know the way home.

#strong[Always On:] Your overland travel speed increases by 50%. You and up to five companions ignore non-magical difficult terrain while traveling.

#strong[Always On:] Once you've walked a road, you can retrace your steps perfectly, even in darkness, even in fog. The boots remember.

=== Mantle of the Burning Shield
<mantle-of-the-burning-shield>
#emph[Very Rare - Cloak - Requires Attunement - 2 Fire Discipline]

A cloak of crimson scales. When danger threatens, the scales ignite, wrapping the wearer in a corona of protective flame.

#strong[Always On:] Resistance to fire damage.

#strong[Reaction, Burning Retort (once per encounter):] When a creature within 10 ft hits you with a melee attack, the mantle erupts. The attacker takes fire damage.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [3 fire damage. The creature is singed and angry.],
  [#strong[Standard]], [5 fire damage. The creature must succeed on a Morale Check or back away.],
  [#strong[Strong]], [8 fire damage. The creature is Blinded until end of its next turn.],
)
=== Locket of the Final Word
<locket-of-the-final-word>
#emph[Legendary - Wondrous Item - Requires Attunement]

A small silver locket containing a scrap of parchment. The ink on the parchment changes each time you open it. It always says exactly what you need to say, to one person, at one moment.

#strong[Activated, Final Word (Action, once per campaign):] You open the locket, read the words aloud, and speak directly to the heart of one creature that can hear you.

No roll. The creature's attitude shifts two steps toward Friendly. If it was Hostile, it becomes Neutral. If it was Neutral, it becomes Allied. The effect is permanent unless you betray the trust the locket creates.

The locket crumbles to dust after use. Some words can only be spoken once.

=== Frost Brand
<frost-brand>
#emph[Rare - Longsword - Requires Attunement - 1 Water Discipline]

A longsword with a blade of pale blue ice that never melts. Condensation beads on the hilt in warm weather. The grip is cold but never painful, like plunging your hand into a mountain stream.

#strong[Always On:] +1 damage to all tiers. The bonus is cold damage.

#strong[Activated, Frost Nova (Maneuver, once per encounter):] You drive the blade into the ground. A wave of bitter cold radiates outward in a 15-ft radius.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [2 cold damage to all creatures in radius. Ground becomes slick, creatures moving through the area must make an Agility check or fall Prone.],
  [#strong[Standard]], [4 cold damage. Creatures that fail a Fortitude save are Slowed (half Speed) until end of your next turn.],
  [#strong[Strong]], [6 cold damage. Creatures are Frozen in place (cannot move) until end of your next turn. The area remains difficult terrain for 1 minute.],
)
=== Thunder Maul
<thunder-maul>
#emph[Very Rare - Warhammer - Requires Attunement - 1 Earth Discipline]

A massive hammer with a head of clouded silver. When it strikes, the air cracks like a storm breaking. The haft thrums faintly in your hands, as if something inside is impatient to be released.

#strong[Always On:] +2 damage to all tiers. The bonus is thunder damage.

#strong[Activated, Shockwave (Action, once per encounter):] You slam the maul into the ground at your feet. A shockwave of concussive force erupts in a 20-ft cone.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [3 thunder damage. Creatures in the cone are pushed 5 ft away from you.],
  [#strong[Standard]], [5 thunder damage. Creatures are pushed 10 ft and must make a Fortitude save or be knocked Prone.],
  [#strong[Strong]], [8 thunder damage. Creatures are pushed 15 ft, knocked Prone, and Stunned until end of your next turn.],
)
=== Shadow Thorn
<shadow-thorn>
#emph[Rare - Dagger - Requires Attunement]

A dagger with a blade so dark it seems to absorb light. When you hold it, your own shadow stretches and twists, sometimes in directions the torchlight doesn't explain.

#strong[Always On:] +1 damage to all tiers. Attacks with Shadow Thorn ignore 1 point of DR from non-magical armor.

#strong[Activated, Shadow Step (Maneuver, once per encounter):] You throw the dagger at a shadow within 60 ft and step through. You vanish from your position and reappear where the dagger lands.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [You teleport to the shadow but the dagger doesn't return to your hand, it's embedded in the surface. You must retrieve it.],
  [#strong[Standard]], [Clean teleport. The dagger returns to your hand. Until the end of your next turn, your next attack with Shadow Thorn has advantage.],
  [#strong[Strong]], [Clean teleport plus you become Invisible until you attack or take an obvious action. The dagger returns to your hand.],
)
=== Sunbow
<sunbow>
#emph[Rare - Longbow - Requires Attunement - 1 Fire Discipline]

A longbow of pale golden wood, warm to the touch. When drawn, the string hums with light and the arrow nocked upon it ignites, not with fire, but with pure radiance. Dawn priests call it "the first ray."

#strong[Always On:] Arrows fired from the Sunbow deal radiant damage instead of physical. +1 damage to all tiers.

#strong[Activated, Blinding Volley (Action, once per encounter):] You fire an arrow that erupts in a burst of blinding light at a point within range. All creatures within 10 ft of the impact point must make a Fortitude save or be Blinded.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [Creatures in the radius are Dazzled (-1 to attack rolls) until end of your next turn. No damage.],
  [#strong[Standard]], [3 radiant damage to all creatures in radius. Creatures that fail their save are Blinded until end of your next turn.],
  [#strong[Strong]], [5 radiant damage. Creatures are Blinded (no save) until end of your next turn. Undead take double damage.],
)
=== Spellguard Shield
<spellguard-shield>
#emph[Rare - Shield - Requires Attunement]

A shield of silvered steel inlaid with faintly glowing runes. The runes pulse softly when magic is near, a heartbeat of warning against the arcane.

#strong[Always On:] +2 DR (as a standard shield). You have advantage on all saving throws against spells and magical effects.

#strong[Reaction, Spell Catch (once per encounter):] When a single-target spell targets you or an ally within 5 ft, you may interpose the shield. The spell is absorbed into the shield's runes and has no effect.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [The spell is negated but the shield's runes go dark, you cannot use Spell Catch again until you finish a long rest.],
  [#strong[Standard]], [The spell is negated. The shield stores one charge of the spell's energy, your next attack deals +2 damage of the absorbed spell's damage type.],
  [#strong[Strong]], [The spell is negated and reflected back at the caster. They suffer the spell's Weak effect.],
)
=== Adamantine Plate
<adamantine-plate>
#emph[Very Rare - Heavy Armor - Requires Attunement]

Full plate armor forged from star-metal, black iron veined with silver that gleams like captured constellations. It's impossibly heavy, impossibly strong, and it has turned aside blows that should have felled giants.

#strong[Always On:] DR 7 (Plate is normally 6). Any critical hit scored against you becomes a normal hit instead, roll damage as if the attack had scored a Standard success. This does not prevent fumble effects against you.

#strong[Always On:] You have resistance to non-magical bludgeoning, piercing, and slashing damage from creatures of Large size or smaller.

=== Bag of Holding
<bag-of-holding>
#emph[Uncommon - Wondrous Item - No Attunement]

A nondescript leather satchel, slightly larger than a coin purse. The interior is considerably less nondescript, it opens into an extradimensional space roughly 4 feet deep and 2 feet wide at the mouth.

#strong[Always On:] The bag can hold up to 500 pounds of gear while weighing only 15 pounds regardless of contents. Items placed inside must fit through the bag's opening (roughly 2 feet in diameter). Retrieving an item requires a Maneuver, the bag always produces the item you're thinking of, but you do have to reach in and find it.

#strong[Warning:] Piercing or tearing the bag from the inside destroys it and scatters its contents across the Astral Plane. Don't put the Immovable Rod in the Bag of Holding. Don't put the Bag of Holding in another Bag of Holding. These things have been tried. The craters are still there.

=== Rope of Climbing
<rope-of-climbing>
#emph[Uncommon - Wondrous Item - No Attunement]

Sixty feet of silken rope, fine as a finger's width and strong as steel cable. When you speak the command word, it animates, rising, coiling, and knotting itself with the patience of a trained serpent.

#strong[Activated, Animate Rope (Maneuver, at will):] You speak the command word and designate a destination within 60 ft. The rope rises and fastens itself securely to that point.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [The rope reaches the destination and holds. Climbing it requires an Athletics check (Standard 9-14).],
  [#strong[Standard]], [The rope knots itself at 5-ft intervals. Climbing requires no check.],
  [#strong[Strong]], [As Standard, plus the rope can tie itself into a harness around a willing creature and lift or lower them at a rate of 15 ft per round.],
)
=== Lantern of Revealing
<lantern-of-revealing>
#emph[Uncommon - Wondrous Item - No Attunement]

A brass lantern with lenses of violet glass. When lit, its flame burns a pale blue-violet and casts shadows that don't quite match the objects making them. Invisible things cast shadows too, and this lantern shows them all.

#strong[Always On:] When lit, the lantern sheds bright light in a 30-ft radius and dim light for an additional 30 ft. Within the bright light radius, invisible creatures and objects are visible as faint violet outlines. Hidden magical auras (including illusions and glyphs) are revealed as a soft shimmer.

#strong[Duration:] The lantern burns for 6 hours on a single flask of oil. The command word to light or extinguish it is usually etched on the bottom.

=== Immovable Rod
<immovable-rod>
#emph[Rare - Wondrous Item - No Attunement]

A flat iron rod, two feet long, with a single button at one end. It looks like a piece of scaffolding that someone forgot to install. Press the button. The rod freezes in place, not braced, not wedged, just #emph[fixed], as if the universe has decided this particular rod belongs exactly here and nowhere else.

#strong[Activated, Immovable (Maneuver, at will):] Press the button. The rod locks into its current position in space and does not move. It can support up to 8,000 pounds of weight before deactivating. A creature can force the rod to move by succeeding on a Brawn check (Strong 17-20). Press the button again to deactivate.

#strong[Creative uses (all confirmed by playtesters who should have been taking notes instead of experimenting):] Bar a door from the wrong side. Anchor a rope in midair. Stop a wagon. Pin a giant's cloak to the floor. Hang a hammock between nothing and nothing. Attach two Immovable Rods to a shield and create an instant ladder (the party's Arcanist will call this "a ladder", they're insufferable, but they're right).

=== Potion of Healing
<potion-of-healing>
#emph[Uncommon - Consumable - No Attunement]

A glass vial filled with a shimmering red liquid that catches the light like liquid ruby. It tastes of honey and mint and something faintly metallic, the taste of wounds closing.

#strong[Activated, Drink (Maneuver):] You uncork the vial and drink. Roll 3d6 (no modifiers, the potion's magic, not your skill, determines the outcome).

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [Restore 2 HP.],
  [#strong[Standard]], [Restore 5 HP.],
  [#strong[Strong]], [Restore 8 HP and lose one condition of your choice.],
)
#strong[Variants:] Greater Healing (Rare, 5/10/15 HP), Superior Healing (Very Rare, 10/20/30 HP). These follow the same W/S/S pattern and count as consumables. Greater potions are thick as syrup and glow with inner light. Superior potions are nearly black and taste of nothing at all, the absence of pain, bottled.

=== Elixir of Dragon's Breath
<elixir-of-dragons-breath>
#emph[Rare - Consumable - No Attunement]

A crystalline vial containing a swirling, iridescent vapor that never settles. The glass is warm against your skin. When you shake it, the vapor inside roils like a tiny storm. Drinking it feels like swallowing lightning.

#strong[Activated, Drink (Maneuver):] You drink the elixir. Choose acid, cold, fire, or lightning. You exhale a 30-ft cone of that energy type. The effect resolves immediately, you can't hold it in. Trust us, people have tried.

#table(
  columns: (61.9%, 38.1%),
  align: (auto,auto,),
  table.header([Success Tier], [Effect],),
  table.hline(),
  [#strong[Weak]], [3 damage of the chosen type to all creatures in the cone.],
  [#strong[Standard]], [5 damage. Creatures that fail an Agility save take full damage; those that succeed take half.],
  [#strong[Strong]], [8 damage. Creatures that fail an Agility save take full damage and suffer an ongoing 2 damage of the chosen type for 1 minute (Fortitude save ends). Those that succeed take half and suffer no ongoing effect.],
)
The elixir's potency fades after 24 hours once opened. An unopened vial keeps indefinitely, some have been found in dragon hoards centuries old, still swirling, still waiting.

=== Cloak of the Manta Ray
<cloak-of-the-manta-ray>
#emph[Uncommon - Wondrous Item - No Attunement]

A cloak of deep blue leather, smooth and faintly slick to the touch. When submerged in water, it unfurls into a flexible mantle that wraps your legs and arms, transforming you into something the sea recognizes as its own.

#strong[Always On:] While underwater, you gain a swimming Speed of 40 ft and can breathe water as easily as air. The cloak provides no protection against cold, pressure, or the things that hunt in the deep, it only makes you #emph[belong] there.

#strong[Always On:] You have advantage on all Agility checks made to swim, dive, or escape grappling creatures underwater.

#pagebreak()
== Attunement
<attunement>
A character may attune to #strong[3 magic items] at a time. Artifacts do not count against this limit. Attuning to an item requires a short rest, you're bonding with the item's magic, not just picking it up.

#block[
#callout(
body: 
[
Three slots sounds restrictive. It's meant to be. Magic items are force multipliers, and too many multipliers break the game's math.

When you find a fourth item you want to attune, you have to make a choice: which three define your hero? The Flame Tongue or the Stormcaller's Gauntlets? The Cloak of Elvenkind or the Mantle of the Burning Shield? These choices are character-defining. Make them count.

One veteran's advice: keep one attunement slot flexible. Dedicate two slots to your core build, the items that make your class work. Leave the third slot open for whatever the adventure throws at you. The Mirror of Echoing Eyes might be useless in nine sessions out of ten. In the tenth session, it solves the mystery and saves the kingdom. That's what the third slot is for.

]
, 
title: 
[
Attunement Is a Choice, Not a Limit
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
== Discipline Items
<discipline-items>
Some items grant temporary Disciplines while attuned. A #strong[Fire Opal] grants 1 Fire Discipline. A #strong[Blade Master's Gauntlet] grants 1 Blade Discipline. These count toward prerequisite requirements, they can unlock Adept and Master abilities just like purchased Disciplines.

#table(
  columns: (15%, 20%, 47.5%, 17.5%),
  align: (auto,auto,auto,auto,),
  table.header([Item], [Rarity], [Discipline Granted], [Notes],),
  table.hline(),
  [#strong[Fire Opal]], [Uncommon], [1 Fire], [Pulses with inner heat. Warm to the touch even in winter.],
  [#strong[Tear of the Sea]], [Uncommon], [1 Water], [A crystallized drop of elemental water. Never dries.],
  [#strong[Windseeker's Feather]], [Uncommon], [1 Wind], [A griffon feather that quivers when storms approach.],
  [#strong[Heartstone]], [Uncommon], [1 Earth], [A polished stone that hums faintly when placed on bare ground.],
  [#strong[Blade Master's Gauntlet]], [Rare], [1 Blades], [Supple leather inscribed with dueling forms. Your grip never slips.],
  [#strong[Saint's Reliquary]], [Rare], [1 Religion], [A fingerbone or scrap of vestment from a departed holy figure.],
  [#strong[Menagerie Collar]], [Rare], [1 Animal], [A leather collar. When worn, animals understand your intent.],
)
#block[
#callout(
body: 
[
The DA controls the flow of magic items. A good rule of thumb:

- #strong[Levels 1-3:] One Uncommon item per hero. Potions, scrolls, and a single +1 weapon for the party.
- #strong[Levels 4-6:] Two Uncommon, one Rare per hero. Discipline items start appearing.
- #strong[Levels 7-10:] Mostly Rare, one Very Rare for the party. Items with W/S/S effects become available.
- #strong[Levels 11+:] Very Rare and Legendary items. These should feel earned, quest rewards, not shop purchases.

Magic items aren't in every treasure hoard. When the party finds one, it should matter. The Blade who's been using the same longsword for five levels unsheathes a Flame Tongue for the first time, that's a moment. Milk it.

]
, 
title: 
[
Finding Magic Items
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#part[World & GM]
= Gaining Levels
<gaining-levels>
﻿\# Advancement {\#sec-chapter-advancement}

#figure([
#box(image("chapters/../assets/images/page103-img041.png", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 25: Advancement Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 25 --- Advancement chapter art (Titles). Placeholder; final art TBD. Dimensions: 572×572.]

#pagebreak()
Your hero doesn't stay the same person who kicked down their first door. Every adventure leaves a mark --- a new technique mastered, a spell perfected, a scar that tells a story. Advancement in #emph[Heroes of Legend] isn't about filling an XP bar. It's about your hero becoming more of who they already are, or surprising everyone by becoming someone new.

This chapter covers the mechanics: when you level, what you gain, and how to spend what you've earned. The stories behind those gains --- the mentor who trained you, the ancient text you deciphered, the near-death experience that unlocked something dormant --- those are yours to tell.

#pagebreak()
Levels are earned through adventure milestones, not experience points. When the party achieves something significant --- defeats a major enemy, completes a quest, resolves a story arc --- the DA awards a level. There's no tracking individual goblin kills. There's no calculating CR budgets. The story says "you've earned this," and you level up.

The expected pace is roughly one level every two to three sessions. At that rate, a weekly group reaches level 20 in about a year of play. Some tables move faster. Some move slower. The pace that's right for your group is the pace where leveling feels earned, not automatic. When the party hits a new level and the table goes "yes!", you're doing it right. When they barely notice, you're leveling too fast. When they're frustrated, too slow. Adjust.

#strong[Milestone examples:] The DA awards a level when the party: - Defeats a boss or major antagonist - Completes a significant quest or story arc - Achieves a personal character goal (the Blade avenges their master, the Intellect deciphers the lost codex) - Survives an ordeal that changes them (the dungeon that killed two hirelings, the negotiation that averted a war)

The DA decides. There's no formula. Trust your instincts --- you know when the party has earned it.

#pagebreak()
== Development Points
<development-points>
Development Points are the currency of growth. You spend them to buy skills, talents, and abilities. Every level gives you a fresh infusion, and every point spent is a choice about who your hero is becoming.

At each level, you gain 3--4 DP, with larger awards at milestone levels (1, 5, 10, 15, 20). The table below shows the full progression. Budget wisely --- DP don't carry over between levels, so spend every point before you level again. Unspent DP is potential left on the table.

#table(
  columns: (28%, 20%, 52%),
  align: (auto,auto,auto,),
  table.header([Level], [DP], [Other Gains],),
  table.hline(),
  [1], [4], [Class signature, Starting Disciplines],
  [2], [3], [,],
  [3], [3], [Progression Discipline],
  [4], [3], [Attribute increase (+1, max +2)],
  [5], [4], [Class feature upgrade],
  [6-14], [3/level], [Progression Discipline every 3 levels, attribute every 4],
  [15], [4], [Class feature upgrade],
  [16-19], [3/level], [Progression Discipline every 3 levels, attribute every 4],
  [20], [4], [Capstone],
)
Total DP at level 20: 64. Total Progression Disciplines: 6. Total attribute increases: 5.

#pagebreak()
== Group Reputation
<group-reputation>
The party's renown grows with their deeds. Reputation affects NPC attitudes, quest availability, and title eligibility.

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Rep], [Title], [Effect],),
  table.hline(),
  [1-3], [#strong[Unknown]], [Standard prices, no recognition],
  [4-6], [#strong[Known]], [10% discount at friendly establishments],
  [7-9], [#strong[Renowned]], [Free room and board, audiences with nobles],
  [10-14], [#strong[Heroic]], [Followers, stronghold, legendary quests],
  [15+], [#strong[Legendary]], [Immortalized in song and story],
)
#pagebreak()
== Reveling
<reveling>
Spend gold on legendary parties to boost reputation. 100 gp = +1 reputation for the session. Carousing may attract unwanted attention.

#pagebreak()
== Titles
<titles>
Earned titles grant mechanical benefits. Examples: #strong[Dragonslayer] (+1 damage vs dragons), #strong[Knight of the Realm] (free lodging at any inn), #strong[Archmage] (one free Adept spell chain).

#pagebreak()
== Retraining
<retraining>
At each level, you may exchange one skill rank or talent purchase for another of equal or lower DP cost. The DA may require narrative justification, finding a trainer, spending downtime, or a story event that prompts the change.

#strong[Example:] At level 5, Kael realizes he never uses his Novice Intimidation. He retrains it to Novice Athletics (both 1 DP). He spends a session training with Roric, the party's Protector, to justify the change.

#quote(block: true)[
#strong[Why this exists:] Players make choices at level 1 without knowing how the game actually plays. Retraining lets them correct early mistakes without feeling stuck. It also means a character's build can evolve with the story.
]

#pagebreak()
== Strongholds & Bases
<sec-strongholds>
At some point, you outgrow inn rooms and borrowed beds. You need walls that are yours. A place to hang your trophies, store your artifacts, and plan your next move without the barkeep listening in. That's a stronghold. This section covers how you get one, what it does for you, and how it grows with your legend.

=== Acquiring a Stronghold
<acquiring-a-stronghold>
You don't buy a stronghold at the general store. You earn it, or you take it.

#strong[Requirements:] - #strong[Reputation 7+] with at least one faction that has the resources to sponsor construction or cede territory (#ref(<sec-faction-system>, supplement: [Section])). You're not just "those adventurers who passed through last spring", you're a known quantity. - #strong[Gold:] 500-2,000 gp depending on size and condition. An abandoned border keep costs 500 gp and a lot of sweat. A purpose-built tower with running water and magical wards costs 2,000 gp. The price covers materials, labor, and the first month of upkeep. - #strong[Location:] A suitable site. The DA determines what's available, an abandoned watchtower, a cleared dungeon you've already bled in, land granted by a grateful noble. Finding the right spot is an adventure in itself.

#block[
#callout(
body: 
[
Acquiring a stronghold shouldn't be a shopping trip. The abandoned keep isn't empty, something's moved in since the last garrison left. The granted land comes with a catch, the noble wants you to clear out the bandits in the eastern hills first. Make the party #emph[work] for their walls. It makes walking through the front door for the first time feel earned.

]
, 
title: 
[
The Stronghold Quest
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
=== Class-Typed Strongholds
<class-typed-strongholds>
Your stronghold reflects who you are. A Blade's fortified keep doesn't look like an Arcanist's wizard tower. The type is determined by the majority of the party, or by whoever's funding the construction.

#table(
  columns: (47.22%, 25%, 27.78%),
  align: (auto,auto,auto,),
  table.header([Stronghold Type], [Classes], [Benefits],),
  table.hline(),
  [#strong[Fortified Keep]], [Blade, Protector, any martial], [+2 to combat training rolls. Can recruit 2d6 soldiers (see Followers). Armory and training grounds included.],
  [#strong[Wizard's Tower]], [Arcanist, Odd, any arcane], [+2 to spell research and crafting checks. Magic item creation takes half the normal time. Library and laboratory included.],
  [#strong[Sanctum]], [Any class with divine spells], [+2 to healing and divine ritual checks. Pilgrims bring 2d6 x 10 gp in offerings per month. Chapel and infirmary included.],
  [#strong[Hidden Safehouse]], [Any skilled/rogue-ish class], [+2 to information gathering and Stealth checks made from the stronghold. Black market access (rare items available for purchase). Secret passages and escape routes included.],
)
#strong[Mixed parties:] If the party includes a Blade, an Arcanist, and a cleric, they choose one primary type. The others can be added as upgrades (see Stronghold Upgrades below). A Fortified Keep with a Wizard's Tower addition is a fortress with a spire, expensive, impressive, and exactly the kind of thing that attracts dragons.

=== Stronghold Actions
<stronghold-actions>
Once per session, each character can take one stronghold action during downtime. This represents what you're doing with your base between adventures. You can't take the same action twice in a row.

#table(
  columns: (50%, 50%),
  align: (auto,auto,),
  table.header([Action], [Effect],),
  table.hline(),
  [#strong[Craft]], [Reduce the time required to craft one item by half. The stronghold's facilities, forge, library, chapel, provide the tools and space.],
  [#strong[Recruit]], [Gain 1d3 temporary followers for the next adventure. They're hirelings, not heroes, use the Guard or Bandit stat block from #strong[?\@sec-chapter-bestiary]. They follow reasonable orders but won't sacrifice themselves.],
  [#strong[Research]], [Study a known monster, location, or magical phenomenon. Gain +2 on all Knowledge and Reason checks related to the subject for the next session. The DA provides one concrete piece of intelligence.],
  [#strong[Rest]], [Full recovery of HP and removal of one condition or affliction. Additionally, gain temporary HP equal to your level for the next session. Real beds and hot meals make a difference.],
  [#strong[Fortify]], [Improve the stronghold's defenses. The stronghold gains +10 temporary HP and attackers suffer -2 on rolls to breach the walls until the end of the next session. Stacks with the Fortify faction action.],
  [#strong[Train]], [Gain a +2 bonus to one skill for the next session. This replaces (does not stack with) the Train faction action. Specialized facilities beat improvised practice.],
)
=== Followers
<followers>
When your reputation reaches Allied (+3) with a faction, or when your Group Reputation hits Heroic (10+), you attract followers. These aren't adventurers, they're people who believe in what you're doing and want to help.

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Source], [Followers Gained],),
  table.hline(),
  [Allied faction], [1d4 followers from that faction's ranks],
  [Heroic reputation (10+)], [1d6 followers drawn by your legend],
  [Stronghold established], [2d4 followers as staff and garrison],
)
#strong[Followers use simple NPC stat blocks] (Guard, Bandit, Cultist, see #strong[?\@sec-chapter-bestiary]). They maintain the stronghold, handle mundane tasks, and provide minor mechanical benefits:

- #strong[Garrison soldiers:] +1 to stronghold defense rolls for every 5 soldiers stationed.
- #strong[Scholars and sages:] Reduce Research action time by half (stack with the stronghold's Research benefit).
- #strong[Craftspeople:] Craft one common item (non-magical, value up to 25 gp) per session at no gold cost, just materials.
- #strong[Spies and informants:] Once per session, learn one rumor from a nearby settlement without spending an action.

#strong[Followers on adventures:] Followers can accompany the party as hirelings. They act on their own initiative and follow orders, but they're fragile, most have 4-8 HP. If a follower dies, replace them at the rate of one per session. The stronghold attracts new recruits. Word gets around that you pay well and don't get your people killed. You #emph[do] pay well, right?

#block[
#callout(
body: 
[
Don't treat followers as disposable. If the party uses their garrison as trap-finders or monster bait, morale collapses. Followers desert. Recruitment stops. The stronghold gains a negative reputation, "Don't sign on with those lunatics." Treat your people well and they'll walk into fire for you. Treat them poorly and you'll be mopping your own floors.

]
, 
title: 
[
Followers Are People
]
, 
background_color: 
color.mix((rgb("#EB9113"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#EB9113")
, 
icon: 
fa-exclamation-triangle()
, 
body_background_color: 
brand-color.background
)
]
=== Stronghold Upgrades
<stronghold-upgrades>
Spend gold to expand your stronghold's capabilities. Each upgrade requires the base stronghold to be established first. Upgrades take 1d4 weeks to complete and cost the listed amount.

#table(
  columns: (24.32%, 16.22%, 35.14%, 24.32%),
  align: (auto,auto,auto,auto,),
  table.header([Upgrade], [Cost], [Requirements], [Benefit],),
  table.hline(),
  [#strong[Library]], [300 gp], [Wizard's Tower or any stronghold], [+2 to all Research actions. Contains reference works on history, arcana, and nature.],
  [#strong[Armory]], [400 gp], [Fortified Keep or any stronghold], [+2 to Craft actions for weapons and armor. Weapons stored here gain +1 damage for the first round of the next siege.],
  [#strong[Chapel]], [300 gp], [Sanctum or any stronghold], [+2 to Rest actions. Allies within the stronghold may reroll one failed saving throw against fear or corruption per session.],
  [#strong[Workshop]], [350 gp], [Any stronghold], [+2 to Craft actions for gear, tools, and non-magical items. Crafting time reduced by one-third.],
  [#strong[Walls (Reinforced)]], [500 gp], [Any stronghold], [Stronghold HP increased by 25. Attackers suffer -2 on all rolls to breach, climb, or bypass walls.],
  [#strong[Secondary Stronghold Type]], [800 gp], [Base stronghold established], [Add the benefits of a second stronghold type. A Fortified Keep with a Library has both martial training grounds and arcane reference works.],
  [#strong[Teleportation Circle]], [1,500 gp], [Wizard's Tower, caster level 10+], [Permanent teleportation circle. Connects to one other circle you've attuned to. priceless when the orc army is three days away and you need reinforcements #emph[now].],
  [#strong[Vault]], [500 gp], [Any stronghold], [Secure storage with magical wards. Items stored here cannot be scryed upon. +4 to rolls against theft or tampering.],
)
#strong[Upkeep:] Strongholds cost 5% of their total value in gold per month for maintenance, staff wages, and supplies. A 1,000 gp stronghold costs 50 gp per month. If the party can't pay, the stronghold degrades, lose one upgrade per month of neglect, starting with the most expensive.

= Scene Management
<scene-management>
﻿\# Dungeon Architect's Guide {\#sec-chapter-gm-guidance}

#figure([
#box(image("chapters/../assets/images/page103-img042.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 26: GM Guidance Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 26 --- GM guidance chapter art (Titles / GM section). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
So you're the Dungeon Architect. You've read the rules, you've helped your players build their heroes, and now everyone's looking at you, waiting for the world to appear. No pressure.

This chapter is written for you. Not as a manual --- you don't need a manual, you need a fellow DA who's been behind the screen for thirty years and has the scar tissue to prove it. I've run sessions that collapsed into chaos. I've run sessions where the party spent three hours debating door hinges and loved every minute. I've run sessions where a single dice roll changed the entire campaign. Here's what I've learned: the rules serve the story. Your job isn't to enforce them. Your job is to use them to make the story better.

Everything in this chapter is advice. Take what works. Ignore what doesn't. Your table is different from mine. Your players are different from mine. The only metric that matters is whether everyone at your table --- including you --- is having a good time. If they are, you're doing it right, even if you're doing it differently than this book suggests.

#pagebreak()
A scene is a unit of story. It has a beginning (the party enters the throne room), a middle (they negotiate with the baron), and an end (the baron agrees to send troops, or throws them in the dungeon). Your job is to recognize when a scene has done its work and move on.

#strong[Start late, leave early.] Don't narrate the party walking through six empty corridors to reach the throne room. "After an hour of winding through the castle's lower halls, you're announced at the entrance to the great hall." Cut to the action. Similarly, when the negotiation concludes, don't roleplay the guards escorting the party back to the gate. "The baron's steward shows you to your rooms. You'll march at dawn." Scene over. Next.

#strong[Every scene should earn its place at the table.] Ask yourself: does this scene advance the plot, reveal character, or raise the stakes? If it does none of those things, cut it. Your players won't miss what they never saw, but they will remember the session that dragged because you insisted on roleplaying every shopkeeper interaction.

#strong[Use scene framing to control pace.] After a tense combat, give the party a quiet scene --- a campfire conversation, a victory toast at the tavern. After three quiet scenes, hit them with something urgent. Pace isn't about speed. It's about rhythm. Fast, slow, fast, slow. Your players' attention spans will thank you.

#strong[When in doubt, ask the table.] "Do you want to play out the journey, or shall we cut to the gates of Thornwall?" Sometimes players want the quiet scenes. Sometimes they want to get to the action. You're not a mind reader. Ask. It's not breaking immersion; it's respecting everyone's time.

#pagebreak()
== Setting Difficulty
<setting-difficulty>
The difficulty modifier is the simplest tool in your kit, and the one new DAs misuse most often. Here's how to wield it well.

#strong[The baseline is +0.] Standard difficulty means the task is a fair test of the hero's abilities. Picking a standard lock. Climbing a wall with handholds. Lying to a guard who has no reason to suspect you. When the fiction says "this is what the skill was made for," the modifier is +0. Don't add penalties just because you want the roll to be harder. The bell curve makes Standard results the most common outcome, and that's intentional --- competent heroes succeed at competent tasks.

#strong[Add bonuses when the situation favors the hero.] The guard is distracted (+2). The lock is rusty and half-broken (+2). The wall has plenty of handholds and the hero has a rope (+4). Generous bonuses make players feel smart for setting up advantages. If the rogue spent ten minutes creating a distraction before attempting the lock, reward that. The dice should reflect the fiction, not override it.

#strong[Add penalties when the situation fights back.] It's pitch dark (-2). The guard just watched his partner get stabbed and he's on high alert (-2). The lock is dwarven masterwork, the wall is sheer ice, the lie is being told to the king's spymaster (-4). Penalties make the world feel dangerous without making it feel unfair. The players should know #emph[why] the roll is harder. "The lock is dwarven masterwork" is information. "-4 because I said so" is frustration.

#strong[The golden rule: don't call for rolls when the outcome isn't in doubt.] The barbarian with Brawn +2 wants to kick down a normal wooden door? It breaks. No roll. The ranger with Survival Adept wants to find edible berries in a temperate forest? They find them. No roll. Rolling dice when there's nothing at stake drains tension from the moments that #emph[do] matter. Save the dice for when the table is leaning forward, waiting to see what happens.

#pagebreak()
== Encounter Building
<encounter-building>
Balancing combat encounters is more art than science, but the numbers give you a starting point. Here's how to think about it.

#strong[The basic math:] Compare total party Disciplines to total enemy threat. A standard encounter --- the kind the party should win while expending some resources and taking some damage --- matches the party's total Discipline count. A hard encounter has about 1.5 times that. A deadly encounter has double. But these are guidelines, not guarantees. Terrain, surprise, and player cleverness will swing fights further than any formula.

#strong[Action economy is everything.] Four goblins (four actions per round) are more dangerous than one ogre with the same total HP (one action per round). The side with more actions controls the board. When building encounters, count actions, not just hit points. A solo boss needs legendary actions or multiattack to keep up. A swarm of minions needs low HP so they drop fast and the action economy swings back toward the party.

#strong[Vary your encounter design.] Not every fight should be "kill all enemies." Mix in objectives: protect the ritual circle for three rounds, stop the cultist from reaching the alarm bell, escape the collapsing temple before the ceiling comes down. Objectives force players to make choices beyond "which enemy do I attack?" and those choices are where memorable combat lives.

#strong[Use waves.] Don't put every enemy on the board at the start of combat. Have reinforcements arrive on round 2 or 3. This lets you adjust difficulty on the fly --- if the party is struggling, the reinforcements never show. If they're steamrolling, more enemies pour through the door. Waves also keep combat from feeling static. The board changes. New threats appear. Players have to adapt.

#strong[Know when to end it.] When the outcome is certain --- the last two goblins are surrounded, wounded, and outnumbered --- don't play out two more rounds of cleanup. The goblins surrender or flee. Move to the aftermath. Combat is a pacing tool, not a punishment.

#pagebreak()
== Treasure Pacing
<treasure-pacing>
Treasure is the reward system. It's how the game says "you did something impressive, here's what you get." Pace it well and your players will chase every lead, explore every corner, and take risks they'd otherwise avoid. Pace it poorly and treasure becomes either meaningless or frustrating.

#strong[Magic items: 1--2 per level, per party.] Not per character --- per party. At level 3, the party of four should have found maybe three to six magic items total, and at least one of those should be consumable (a potion, a scroll, a single-use charm). Permanent items should feel significant. A +1 sword at level 2 is a big deal. By level 10, the party should have found maybe one Very Rare item and a handful of Rares. Legendary items are campaign capstones --- the whole party should remember the session where they earned one.

#strong[Gold should create choices.] If the party has enough gold to buy everything they want, gold stops mattering. If they're constantly broke, they stop caring about rewards. The sweet spot is where the party has to choose: do we upgrade the fighter's armor, or commission that potion of water breathing for the sunken temple? Do we spend our gold on a stronghold, or on bribing the city council? Choices create stories. "We bought plate armor" is a transaction. "We spent our last copper bribing the harbor master to look the other way while we smuggled the refugees out" is a story.

#strong[Consumables are your secret weapon.] Potions, scrolls, and single-use magic items are the easiest treasure to hand out because they don't permanently shift the party's power level. A potion of flight solves one encounter brilliantly. Boots of flight solve every encounter forever. Be generous with consumables. Be stingy with permanents. Your future self, trying to challenge a party that can all fly, will thank you.

#strong[Let players use their treasure creatively.] If the party wants to spend their gold on a tavern, let them. The tavern becomes a story engine --- rumors, rivals, arson, the health inspector who's actually a vampire. If they want to commission a custom magic item, work with them on the design. Make them quest for the rare component. The best treasure isn't found in a hoard; it's built over a campaign.

#pagebreak()
== NPC Creation
<npc-creation>
You don't need a full character sheet for every shopkeeper the party meets. Here's how to build NPCs fast, and how to make the ones who matter feel real.

#strong[The quick method:] Assign one attribute at +1 (their strength), one at -1 (their weakness), and the rest at 0. Give them one skill at Adept (+2) that defines their role --- the blacksmith has Craft, the guard captain has Intimidation, the courtier has Persuasion. That's enough for most interactions. The party doesn't need to know the apothecary's Brawn score. They need to know she can identify poisons and she has a dry sense of humor.

#strong[Give every NPC a want and a fear.] The guard captain #emph[wants] a quiet shift, and #emph[fears] anything that'll mean paperwork. The merchant #emph[wants] to sell the cursed amulet before it activates again, and #emph[fears] the party finding out why it's so cheap. A want and a fear take ten seconds to invent and give you everything you need to roleplay the NPC reactively. When the party does something unexpected --- and they always will --- you don't need to consult a stat block. You just ask: what does this person want, and what are they afraid of? The answer tells you how they respond.

#strong[Recycle and remix.] The helpful innkeeper from two towns ago? She's now the nervous apothecary with a different name and a different voice. The party won't notice. They interact with dozens of NPCs. You're the only one tracking them all. Save your creative energy for the NPCs who matter --- the recurring villain, the patron, the rival adventuring party. Everyone else can be built from templates.

#strong[Make the important ones specific.] The baron doesn't just "sit on a throne." He sits on a throne made from the hull of the ship that brought his ancestors to this land. The assassin doesn't just "wear black." She wears a silk scarf over the lower half of her face, and her eyes are the color of old coins. One specific detail makes an NPC memorable. Two makes them vivid. Three is showing off.

#pagebreak()
== Optional Rules
<optional-rules>
Every table is different. These rules let you tune the game's tone without breaking anything. Try one at a time. See how your group reacts. The game works fine without any of them --- these are seasoning, not ingredients.

#strong[Gritty Realism:] Short rests take 8 hours. Long rests take 1 full week of downtime. Use this when you want travel and exploration to feel grueling, when every resource decision matters, and when the party should dread the journey as much as the destination. Don't use this for dungeon crawls --- the pace will grind to a halt. Gritty realism works best in campaigns where combat is rare but consequential, and where the tension comes from attrition over days, not minutes.

#strong[Heroic Mode:] The party gains +1 Development Point per level. They'll have more skills, more talents, more abilities at every stage of the game. Use this for smaller parties (2--3 players) who need the extra power to handle standard encounters, or for groups who love character customization and want more toys to play with. Don't use this with optimization-heavy groups unless you're prepared for the party to punch above their weight consistently.

#strong[Discipline Crafting:] At level 10+, characters may combine 2 General Disciplines into 1 specific Discipline of their choice. This represents years of focused training paying off --- the generalist finally specializing. It's a late-game option for characters who've been sitting on General Disciplines and want to unlock Master-tier abilities in a specific domain. Limit this to once per character, or at most once per tier (levels 10, 15, 20). It's meant to enable character evolution, not to let players respec their entire build.

#pagebreak()
== Exploration & Travel
<exploration-travel>
Overland travel uses a simple pace system. Each day, the party covers distance based on terrain and pace.

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Terrain], [Normal Pace], [Forced March],),
  table.hline(),
  [Road/Grassland], [24 miles], [30 miles],
  [Forest/Hills], [18 miles], [24 miles],
  [Mountain/Swamp], [12 miles], [18 miles],
  [Desert/Tundra], [15 miles], [21 miles],
)
#strong[Navigation:] Each day, one character makes a Survival (Knowledge or Survival skill) roll. Standard result: stay on course. Weak result: veer off course (1d6 extra hours). Strong result: find a shortcut (-2 hours).

#strong[Random Encounters:] Roll 1d6 each day and night. On a 1, an encounter occurs. DA chooses or rolls from environment-specific tables.

#strong[Camping:] A long rest requires 8 hours of rest including sleep. Characters on watch may make Perception checks at -2 (tired eyes).

#quote(block: true)[
#strong[DA Guidance:] Travel is a pacing tool. Use it to build atmosphere, the oppressive silence of a swamp, the howling wind on a mountain pass. Skip travel entirely when the journey isn't the story. "After three days on the road, you arrive at the gates of Thornwall" is perfectly valid.
]

#pagebreak()
== Crafting
<crafting-1>
Characters with appropriate tools and skills can craft items during downtime.

#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Result], [Outcome],),
  table.hline(),
  [#strong[Weak]], [Item is functional but flawed. -1 to its primary use.],
  [#strong[Standard]], [Item crafted as intended. Takes normal time.],
  [#strong[Strong]], [Masterwork quality. +1 bonus or half the normal time.],
)
#strong[Time:] Crafting takes 1 day per 5 gp of the item's market value.

#strong[Materials:] Cost half the item's market price in raw materials.

#strong[Magic Items:] Require specific Disciplines, rare components, and a formula. Takes 1 week per tier (Novice/Adept/Master).

#pagebreak()
== Resource Management
<resource-management>
Keeping track of supplies adds tension to exploration.

#strong[Rations:] 1 per day per character. Without food, make a Fortitude (Endurance) roll each day. Standard result: function normally. Weak result: -1 to all rolls from fatigue.

#strong[Ammunition:] A quiver holds 20 arrows or bolts. After combat, recover half on a Standard+ Survival roll. On a Weak result, recover only 1d4.

#strong[Light:] Torches last 1 hour and illuminate 30 ft. Lanterns last 6 hours per flask of oil. Total darkness imposes -4 to any roll requiring sight.

#strong[Optional, Resource Dice:] For tables that prefer abstraction, use a Resource Die (d12?d10?d8?d6?d4?Depleted). Roll after each use; on a 1, the die steps down.

#pagebreak()
== Corruption
<corruption>
Proximity to dark magic, forbidden knowledge, and horrific events can corrupt a hero's spirit. The Unbalanced class embraces this, but any character can be affected.

#strong[Gaining Corruption:] The DA awards +1 Corruption for witnessing supernatural horrors, using forbidden artifacts, or making desperate bargains. The Unbalanced class gains Corruption as part of their class mechanic.

#strong[Corruption Threshold:] 10 + Fortitude modifier. When a character reaches their threshold, they gain a permanent affliction (DA chooses based on the source, nightmares, physical mutation, madness). At 15+, the character becomes unplayable.

#strong[Recovery:] 1 Corruption fades per week of rest. Atonement quests, divine intervention, or rare magic can remove larger amounts.

#quote(block: true)[
#strong[Why this exists:] Corruption gives weight to dark choices. When the party debates whether to read the forbidden tome, the cost is real, not abstract. It also gives the Unbalanced class a mechanical identity: they walk the edge willingly.
]

#pagebreak()
== Social Conflict (Extended)
<social-conflict-extended>
For high-stakes negotiations, interrogations, or trials, use extended social conflict.

Each round, one side makes a social skill roll (Persuasion, Deception, or Intimidation) opposed by the target's Insight or relevant attribute. The first side to 3 successes wins the conflict.

#table(
  columns: (50%, 50%),
  align: (auto,auto,),
  table.header([Result], [Effect],),
  table.hline(),
  [#strong[Weak]], [Your argument falters. Opponent gains 1 success.],
  [#strong[Standard]], [You score a point. Gain 1 success.],
  [#strong[Strong]], [Devastating point. Gain 2 successes.],
  [#strong[Critical]], [You break through entirely. Win the conflict immediately.],
  [#strong[Fumble]], [You offend or reveal weakness. Opponent gains 2 successes.],
)
#strong[Stakes must be declared before the conflict begins.] "If I win, the guard lets us pass. If you win, we're arrested." This keeps social encounters from becoming endless persuasion checks.

#pagebreak()
#pagebreak()
== Sample Adventure: The Sunken Vault
<sample-adventure-the-sunken-vault>
This is a starter adventure for level 1 characters. It teaches the core mechanics, skill checks, combat, and the success tier system, through play. Run it as your group's first session, or drop it into an ongoing campaign when the party passes through a river valley. Expected play time: 3-4 hours.

#block[
#callout(
body: 
[
This adventure is built to teach #emph[you] as much as your players. Each scene calls out which rules it introduces. Read the whole thing once before you run it. Then trust the system, the dice will do the work.

]
, 
title: 
[
For First-Time DAs
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
=== Adventure Hook
<adventure-hook>
The village of #strong[Thornwell] sits in the crook of the Greenwash River, a quiet farming community that's seen better days. Three weeks ago, an old dam upriver burst during a spring storm. The floodwaters carved a new channel through the valley, and exposed something that wasn't meant to be found. A stone doorway, sunk into the riverbank, covered in glyphs nobody in Thornwell can read. Livestock has gone missing. Something comes out at night and leaves wet footprints on the doorsteps. The village elder is desperate.

#strong[Read Aloud:]

#quote(block: true)[
#emph["Thornwell wasn't much to look at before the dam broke. Now it's less. Half the fields are mud. The mill wheel doesn't turn. And every morning, old Marta finds another sheep gone from her pasture, not eaten, not dragged off. Just gone. The tracks lead to the river. The tracks always lead to the river."]
]

The hook lands when the party arrives in Thornwell, whether they're passing through, answering a call for help, or chasing their own rumors of forgotten treasure. The elder approaches them within the hour. Strangers with weapons are rare in Thornwell. Strangers with weapons are exactly what Thornwell needs.

=== Scene 1: The Village
<scene-1-the-village>
#strong[Introduces:] Social interaction, gathering information, skill checks with consequences.

The party meets #strong[Elder Tamrin], a weathered woman in her sixties with hands like oak roots and eyes that have stopped being surprised by bad news. She offers the party 50 gp and the village's gratitude to investigate the exposed ruin and put a stop to whatever's prowling the night. She can be negotiated with, a Strong social result bumps the reward to 75 gp or secures a bonus (healing salves, torches, a mule).

#strong[What the villagers know (Standard Knowledge or Persuasion check):]

- The doorway appeared after the dam burst. It's old, older than any settlement in the valley. (Standard)
- The glyphs glow faintly blue at night. One of the farm boys touched them and his hand went numb for a day. (Standard)
- Three villagers have gone missing in the past two weeks, always at night, always near the river. (Standard)
- Before the dam was built, the elders used to warn children away from that bend in the river. Called it "the sinking ground." (Strong)
- There's a hermit living in the hills, old #strong[Corvus], who used to trade in old books and strange maps. He might know something about the glyphs. (Strong)

#block[
#callout(
body: 
[
Don't let this turn into an interrogation. Have Elder Tamrin offer tea. Have a child stare at the party's weapons. Have the village drunk insist the ruin is "a dragon's tooth" and try to sell them lucky charms. Social scenes teach players that talking is just as valid as stabbing, and often more useful.

]
, 
title: 
[
Running Social Scenes
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
#strong[Treasure opportunity:] If the party helps round up the missing livestock (Survival or Animal Handling, Standard), a farmer gifts them a healing poultice (heals 3 HP, one use).

=== Scene 2: The Approach
<scene-2-the-approach>
#strong[Introduces:] Skill challenges, success tier consequences, teamwork.

Reaching the temple requires navigating a half-mile of flood-ravaged terrain. The riverbank has collapsed into a maze of mud flats, standing pools, and unstable ground. It's not dangerous enough to kill anyone, but how well the party handles this approach determines what kind of shape they're in when they reach the vault.

Run this as a group skill challenge. Each character makes one skill check. They describe what they're doing, you assign the skill and difficulty. The party needs 3 successes before 2 failures.

#table(
  columns: (24%, 28%, 48%),
  align: (auto,auto,auto,),
  table.header([Task], [Skill], [Difficulty],),
  table.hline(),
  [Pick the safest path through the mud flats], [Survival (Knowledge)], [Standard],
  [Spot unstable ground before someone steps on it], [Perception (Knowledge or Reason)], [Standard],
  [Wade the flooded sections without losing gear], [Athletics (Brawn)], [Standard],
  [Climb the collapsed riverbank to the door], [Athletics (Brawn)], [Standard (Harder, -2 if already wet)],
  [Read the flow of the new channel to find a ford], [Nature (Knowledge)], [Standard],
)
#strong[Results by tier:]

#table(
  columns: (40%, 60%),
  align: (auto,auto,),
  table.header([Result], [Consequence],),
  table.hline(),
  [#strong[Weak]], [You make it, but at a cost. Lose 1d3 HP (slip, twisted ankle, swallowed river water). Or lose a piece of minor gear in the mud.],
  [#strong[Standard]], [Clean crossing. You're where you need to be.],
  [#strong[Strong]], [You find an advantage, a dry path, a shortcut, a stable ledge. The next character gains +2 on their check.],
)
#strong[Party outcome:]

- #strong[3+ successes before 2 failures:] The party arrives dry, together, and alert. No penalties going into Scene 3.
- #strong[2 failures:] The party arrives mud-splattered and separated. Each character loses 1d3 HP from minor injuries. The DA gets one "complication token" to use in Scene 3, a sudden collapse, a rising water level, an enemy reinforcement.
- #strong[3+ failures (exhausted all attempts):] The party arrives soaked, bruised, and loud. Each character loses 1d6 HP. The vault's guardians are alerted. They get a surprise round in Scene 3. Yeah, it's harsh. Welcome to adventuring.

#block[
#callout(
body: 
[
When the first check comes up Weak, narrate it vividly: #emph["Your boot sinks into what looked like solid ground. Mud the consistency of cold porridge swallows you to the knee. You wrench free, but you've lost your waterskin, and your dignity."] This teaches players that Weak results aren't "nothing happens." They're "something happens, and it's not what you wanted."

]
, 
title: 
[
The First Failure Matters
]
, 
background_color: 
color.mix((rgb("#EB9113"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#EB9113")
, 
icon: 
fa-exclamation-triangle()
, 
body_background_color: 
brand-color.background
)
]
=== Scene 3: The Flooded Vault
<scene-3-the-flooded-vault>
#strong[Introduces:] Combat basics, always-hit attacks, initiative, damage tiers, basic maneuvers, morale.

The stone door stands half-open, pried apart by the floodwaters. Beyond it, a broad chamber stretches into darkness. Ankle-deep water covers the floor. The walls are carved with faded reliefs, figures in robes, hands raised, faces worn smooth by centuries of current. Four stone sarcophagi line the walls. Three of them are open. The water ripples, though there's no wind.

#strong[Read Aloud:]

#quote(block: true)[
#emph["The vault door groans as you push it wide enough to slip through. The air inside is cold and wet and tastes of copper. Your torchlight catches the walls, figures in robes, their carved faces watching you with blank stone eyes. Water shimmers across the floor, dark as tea, hiding whatever lies beneath. The silence is the wrong kind of silence. The kind that's listening."]
]

Four #strong[Drowned Guardians] rise from the water when the party enters the central chamber. They're corpses in rusted chain, animated by whatever old magic lingers here. They don't speak. They don't breathe. They just stand up out of the shallow water and start walking toward the nearest living thing.

#block[
#callout(
body: 
[
#strong[Drowned Guardian (Challenge 1/2):] HP 6, DR 1 (rusted chain). Rusted Sword: 2/3/4 slashing. Slam: 1/2/3 bludgeoning. Waterlogged: moves at half speed on dry ground, normal speed in water. Undead Nature: immune to poison and charm. Vulnerable (Fire): damage tier +1 vs fire. Morale: mindless, fights until destroyed.

]
, 
title: 
[
Enemy Stat Blocks
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#strong[Tactics:] The guardians spread out, one per party member if possible. They're slow but relentless, they don't flank, they don't retreat, they just keep coming. If a guardian is reduced to 0 HP, it collapses into the water with a splash. On the next round, roll 1d6. On a 5-6, it rises again at 1 HP (the water heals them). The party needs to either destroy all four in quick succession or figure out that dragging a body out of the water stops the regeneration.

#strong[Environmental hazard:] Any character who ends their turn in the water must make an Agility check (Standard) or the current knocks them Prone. The water is only ankle-deep, falling in it is embarrassing, not dangerous. But Prone in combat is bad. Remember that standing up costs a Maneuver (#strong[?\@sec-chapter-combat]).

#strong[Teaching moment:] After the first round, pause and point out what just happened. "You all hit. Every attack connected. The question was how hard, and you saw the difference between a Weak scratch and a Strong blow. Now it's round two. What are you going to do differently?"

#block[
#callout(
body: 
[
This is your players' first combat. Narrate every hit. "Your blade skips off the rusted chain, Weak, 2 damage, but you've got its attention." "You drive your sword through its midsection, Standard, 3 damage. Water pours from the wound." Make the always-hit system feel visceral. They're not missing, they're carving through enemies. The tension is in #emph[how fast] they can put them down.

]
, 
title: 
[
Running This Fight
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
#strong[After the fight:] The water stills. One of the sealed sarcophagi has an inscription the party can now examine (Knowledge or Reason, Standard), it's a warning in Old Imperial: #emph["Here lies Kelvath, Warden of the Seal. May his rest be undisturbed. May the seal hold eternal."] The name "Kelvath" will matter in Scene 4.

=== Scene 4: The Inner Sanctum
<scene-4-the-inner-sanctum>
#strong[Introduces:] Combined skill + combat encounters, traps, puzzles, boss fights.

Beyond the main chamber, a short passage descends deeper. The water drains away here, channeled into grooves in the floor that glow with faint blue light. The passage opens into a circular sanctum. In the center, a stone pedestal holds a crystal sphere the size of a human head. The sphere pulses with the same blue light as the floor grooves. Around the pedestal, a ring of runes covers the floor, an active warding seal. And standing before the pedestal, one hand resting on the crystal, is #strong[Kelvath, the Drowned Warden.]

#strong[Read Aloud:]

#quote(block: true)[
#emph["The sanctum is a perfect circle, maybe forty feet across. The walls rise into darkness, you can't see the ceiling. The only light comes from the floor, blue lines tracing geometric patterns that all converge on a central pedestal. The crystal on that pedestal pulses like a heartbeat. And the figure beside it, a corpse in ornate armor, wearing a circlet of tarnished silver, turns its head toward you. Water drips from its beard. Its eyes are blue glass, and they see you."]
]

#strong[Kelvath, the Drowned Warden (Challenge 2):] HP 18, DR 3 (ancient plate). Warden's Blade: 3/4/6 slashing. Water Bolt: 2/3/5 cold (range 30 ft, at will). Tidal Surge (Recharge 5-6): all creatures within 15 ft take 2/4/6 cold and must make Brawn check (Standard) or be pushed 10 ft and knocked Prone. Undead Nature: immune to poison and charm. Seal-Bound: Kelvath cannot move more than 20 ft from the crystal pedestal. If the seal is broken, he loses this restriction, and gains +1 to all damage.

#strong[The Warding Seal:] The glowing runes around the pedestal are a magical seal, one that's been holding Kelvath here for three centuries. It's failing. The crystal is cracked. The seal will break on its own in 1d4+1 rounds (roll secretly at the start of combat). When it breaks, Kelvath's Seal-Bound restriction ends, and the sanctum begins to flood (water rises 1 ft per round thereafter).

#strong[The party has options:]

+ #strong[Fight Kelvath while the seal holds.] He's restricted to 20 ft from the pedestal, so ranged attackers can stay safe, but his Water Bolt outranges most spells and bows. This is a tactical puzzle: how do you use his tether against him?

+ #strong[Disable the seal early.] A character can reach the pedestal (move + Maneuver) and attempt an Arcana or Reason check (Hard, -2). Strong: the seal stabilizes for the remainder of the fight. Standard: the seal holds but the attempt costs you, the crystal lashes out, dealing 1d6 cold damage to the character. Weak: the seal shatters immediately. Oops.

+ #strong[Break the crystal.] The crystal has HP 10 and DR 2. Destroying it ends the seal, frees Kelvath from his tether, and causes the chamber to flood rapidly (2 ft per round). But it also removes the blue glow, and Kelvath's Water Bolt loses 1 damage tier without the crystal powering it. Choices.

#block[
#callout(
body: 
[
This is where the game shines. One character fights Kelvath. Another works the seal. A third keeps the party alive. This isn't "combat or puzzle", it's both, simultaneously. Encourage players to narrate quick. "I'm holding him off, work faster!" is a complete turn. Keep the pace up. The flooding clock creates tension; don't let it become a bookkeeping exercise.

]
, 
title: 
[
Running Combined Encounters
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
#strong[Morale:] Kelvath doesn't flee. He's been waiting three hundred years for someone to break the seal or put him down. He fights with grim purpose, not rage, not hunger, just duty worn down to a nub. When he reaches 0 HP, he lowers his blade, inclines his head once, a soldier's salute, and collapses into water that washes away into the glowing grooves.

#strong[Read Aloud:]

#quote(block: true)[
#emph["The warden's body hits the water and dissolves, armor, blade, circlet, all of it flowing into the blue-lit channels like ink into a stream. The crystal pulses once, twice, and goes dark. The groaning of ancient stone fills the chamber. This place is coming down. Time to run."]
]

If the party stays, the ceiling begins to collapse. They have 3 rounds to escape. Each round, a character must make an Agility check (Standard) to dodge falling debris or take 1d6 damage. The flooded vault in Scene 3 is now waist-deep and rising fast. Getting out is a sprint, not a fight.

=== Conclusion
<conclusion>
The party emerges from the vault, wet, exhausted, and alive. Behind them, the stone doorway collapses into the river with a sound like a giant exhaling. The glyphs go dark. Whatever was down there is done.

#strong[Treasure:] If the party searched the sanctum before fleeing (or if they go back later after the water recedes), they find: - Kelvath's circlet, a #strong[Circlet of the Warden] (magic item: once per day, grants +2 to a saving throw against being moved, knocked prone, or restrained by water, wind, or earth effects) - 120 gp in old imperial coin (worth double to a collector, standard to a merchant) - A #strong[Waterlogged Spell Scroll], contains one Novice spell of the DA's choice from the Arcane or Divine list

#strong[Advancement:] Completing "The Sunken Vault" is a milestone. The party advances to level 2. They've learned the core mechanics. They're ready for what comes next.

#strong[Hooks for Continuing:]

- The dam that burst wasn't an accident. Someone blew it. The hermit Corvus might know who, or what, wanted the vault opened.
- The crystal sphere wasn't just a prison. It was a key. Maps in the sanctum show four more vaults along the river. Kelvath was only one of five wardens.
- Back in Thornwell, Elder Tamrin has news: a rider arrived from the Baron's court while the party was in the vault. The Baron is offering a bounty on "river-spawned undead." And the bounty just doubled.
- One of the sarcophagi in the main chamber had a seal matching the party's warlock's pendant. Or the cleric's holy symbol. Or the fighter's family crest. The DA picks which character. The next adventure is personal.

#block[
#callout(
body: 
[
#emph[The Sunken Vault] teaches the game in layers. Scene 1 is social mechanics. Scene 2 is skill checks and success tiers. Scene 3 is combat basics. Scene 4 is the advanced course, combined encounters, tactical choice, and environmental pressure. By the time the party crawls out of that river, your players understand how #emph[Heroes of Legend] works. They may not understand #emph[why] they're covered in mud and grinning like fools. That part comes later.

]
, 
title: 
[
Design Notes
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#pagebreak()
#figure([
#box(image("chapters/../assets/images/page106-img043.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 27: GM Guidance Second Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 27 --- GM guidance chapter second art (Bestiary cover). Placeholder; final art TBD. Dimensions: 584×584.]

#pagebreak()
== Faction System
<sec-faction-system>
Factions make your world breathe. When the party leaves town, the Argent Circle doesn't freeze in place, they're researching, recruiting, scheming. This system tracks the party's standing with the powers that shape your world, and it gives them meaningful choices between adventures.

=== The Reputation Track
<the-reputation-track>
Every faction rates the party on a seven-point scale. This number moves, sometimes slowly, sometimes in a single session when the party does something spectacular or catastrophic.

#table(
  columns: (32.43%, 27.03%, 40.54%),
  align: (auto,auto,auto,),
  table.header([Reputation], [Standing], [What It Means],),
  table.hline(),
  [-3], [#strong[Hostile]], [The faction actively works against you. Bounties, assassins, sabotage.],
  [-2], [#strong[Suspicious]], [You're watched. Doors close when you approach. Prices double.],
  [-1], [#strong[Unfriendly]], [They'd rather not deal with you. Cold shoulders, curt answers.],
  [0], [#strong[Neutral]], [You're strangers. Standard prices, standard treatment.],
  [+1], [#strong[Friendly]], [You've done right by them. 10% discount on faction services. Access to faction-exclusive quests.],
  [+2], [#strong[Trusted]], [You're one of the family. 25% discount. Access to restricted areas and secret information.],
  [+3], [#strong[Allied]], [The faction would go to war for you. Followers, stronghold support, unique faction boons.],
)
=== Gaining and Losing Reputation
<gaining-and-losing-reputation>
Reputation changes when the party's actions align with, or against, a faction's interests. The DA assigns the shift based on significance. A minor favor isn't worth a full point. Handing the faction a legendary artifact might be worth two.

#table(
  columns: (29.63%, 70.37%),
  align: (auto,auto,),
  table.header([Action], [Reputation Change],),
  table.hline(),
  [Complete a faction-issued quest], [+1],
  [Defeat a faction's declared enemy], [+1],
  [Make a significant donation (100+ gp or equivalent)], [+1],
  [Critical success on a social roll with faction leadership (natural 6,6,6)], [+2],
  [Publicly champion the faction's cause], [+1],
  [Oppose the faction's stated goals], [-1],
  [Harm or kill a faction member], [-2],
  [Critical failure on a social roll with faction leadership (natural 1,1,1)], [-1],
  [Betray the faction's trust (sell secrets, break a pact)], [-3 (immediate Hostile)],
)
#strong[The floor and ceiling:] Reputation can't drop below -3 or rise above +3 without extraordinary circumstances. At -3, a faction has already decided you're the enemy, they're acting on it. At +3, they've already opened their vaults and their hearts, you'd need to save their entire order from annihilation to earn more.

#block[
#callout(
body: 
[
Don't let reputation become a spreadsheet. When the party hits Friendly with the Iron Pact, describe the mercenary captain buying them drinks. When they drop to Unfriendly with the Shadow Guild, describe the feeling of being watched from rooftops. Reputation isn't just a number, it's how the world reacts to the party's choices. Make them #emph[feel] it.

]
, 
title: 
[
Reputation as Story Engine
]
, 
background_color: 
color.mix((rgb("#00A047"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#00A047")
, 
icon: 
fa-lightbulb()
, 
body_background_color: 
brand-color.background
)
]
=== Reputation Benefits
<reputation-benefits>
Your standing with a faction determines what doors open, and which ones slam shut.

#strong[Friendly (+1):] - 10% discount on the faction's goods and services - Access to faction-exclusive quests and rumors - The faction will vouch for you with one allied group

#strong[Trusted (+2):] - 25% discount on the faction's goods and services - Access to restricted areas (arcane libraries, military barracks, hidden sanctuaries) - The faction shares secret information, monster weaknesses, political plots, rival movements - You may call in one significant favor per adventure (safe house, false identity, armed escort)

#strong[Allied (+3):] - 50% discount on the faction's goods and services - You attract 1d4 followers from the faction's ranks - The faction provides stronghold support, guards, scholars, craftspeople - Faction-specific boon (see example factions below) - The faction will take significant risks for you, including military support

#strong[Hostile (-3):] - The faction actively opposes you - Bounty hunters, assassins, and saboteurs target the party - Faction-aligned NPCs refuse to deal with you - The DA should make this cost #emph[felt], not every session, but often enough that the party considers making amends

=== Between-Session Faction Actions
<between-session-faction-actions>
At the end of each session, each player chooses one faction action. This represents what their character does during downtime, the days or weeks between adventures. You can't take the same action twice in a row. Mix it up.

#table(
  columns: (50%, 50%),
  align: (auto,auto,),
  table.header([Action], [Effect],),
  table.hline(),
  [#strong[Gather Information]], [Learn one rumor or piece of intelligence about a threat, location, or rival faction. The DA provides a concrete lead for the next session.],
  [#strong[Secure Resources]], [Gain one consumable item appropriate to the faction (healing potion from a divine order, acid vial from a thieves' guild, scroll from a mage circle).],
  [#strong[Spread Influence]], [Improve your reputation with one related faction by +1 (max +2). The Argent Circle puts in a good word for you with the Iron Pact.],
  [#strong[Train]], [Gain a +1 bonus to one skill for the next session only. Represents intense preparation for a specific challenge.],
  [#strong[Rest and Recover]], [Recover from one condition or affliction that would normally persist between sessions. The faction's healers, sages, or spiritual advisors tend to you.],
  [#strong[Fortify Position]], [If you have a stronghold, improve its defenses for the next session. If attacked, the stronghold gains +5 temporary HP.],
)
#block[
#callout(
body: 
[
Faction actions happen #emph[between] sessions. They're not a replacement for in-game roleplay, they're what happens during the weeks your character spends waiting for the next adventure hook. If a player says "I want to Gather Information" and the DA has nothing prepared, it's fine to make a note and deliver the intel at the start of next session. Don't hold up the game for a faction action.

]
, 
title: 
[
Action Economy Matters
]
, 
background_color: 
color.mix((rgb("#EB9113"), 15%), (brand-color.background, 85%))
, 
icon_color: 
rgb("#EB9113")
, 
icon: 
fa-exclamation-triangle()
, 
body_background_color: 
brand-color.background
)
]
=== Example Factions
<example-factions>
Here are three factions you can drop into any campaign. Each has goals, methods, and a unique boon for Allied parties. Customize the names to fit your world.

==== The Argent Circle
<the-argent-circle>
#emph["Knowledge is the only currency that doesn't devalue."]

Scholars, mages, and keepers of forbidden lore. The Argent Circle maintains libraries in a dozen cities and secret archives in a dozen more. They believe knowledge should be preserved, not necessarily shared. Their members wear silver rings etched with a spiral pattern, the symbol of eternity and the pursuit of truth.

#strong[Goals:] Recover lost texts and artifacts. Contain dangerous knowledge. Oppose those who would destroy libraries or suppress learning.

#strong[Methods:] Research, espionage, careful negotiation. The Circle doesn't fight wars, they fund them, spy on them, and write the histories afterward.

#strong[Allied Boon, Arcane Patronage:] Once per adventure, you may request a Novice spell scroll from the Circle's archives. Delivery takes 1d3 days. At higher levels, the DA may allow Adept scrolls for especially significant services.

==== The Iron Pact
<the-iron-pact>
#emph["The monsters don't care about your politics. We don't either."]

Mercenaries, monster hunters, and frontier wardens. The Iron Pact maintains chapterhouses along the wild edges of civilization, mountain passes, haunted forests, undermountain gates. They fight the things that go bump in the night so farmers can sleep. They're not romantic about it. It's a job.

#strong[Goals:] Hunt dangerous creatures. Protect frontier settlements. Recruit capable fighters. Get paid.

#strong[Methods:] Direct action. Iron Pact members favor overwhelming force and careful preparation. They research a monster's weakness, equip accordingly, and strike hard. They have no patience for glory hounds or lone wolves, the Pact fights as a unit or not at all.

#strong[Allied Boon, Pact Armory:] Once per adventure, you may requisition one weapon or suit of armor from the Pact's stores (value up to 200 gp). It must be returned after the mission or paid for at half price.

==== The Shadow Guild
<the-shadow-guild>
#emph["The truth lives in the dark. We just happen to live there too."]

Thieves, spies, and information brokers. The Shadow Guild doesn't exist, officially. Its members don't wear symbols or speak the Guild's name in public. But if you need a door opened, a secret uncovered, or a problem made to disappear, you find them. Or they find you.

#strong[Goals:] Control the flow of information. Protect the underworld's neutrality. Eliminate threats to the Guild's anonymity.

#strong[Methods:] Infiltration, blackmail, theft, and the careful cultivation of informants. The Guild rarely kills, dead bodies attract attention, and attention is bad for business. They prefer leverage.

#strong[Allied Boon, Shadow Network:] Once per adventure, you may call in a favor to learn one closely guarded secret about an NPC, location, or organization. The DA provides a concrete, actionable piece of intelligence. The Guild never reveals its sources.

= Reading a Stat Block
<reading-a-stat-block>
﻿\# Bestiary {\#sec-chapter-bestiary}

#figure([
#box(image("chapters/../assets/images/page106-img044.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 28: Bestiary Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 28 --- Bestiary chapter art (Bestiary cover). Placeholder; final art TBD. Dimensions: 503×503.]

#pagebreak()
Monsters use the same rules as heroes, attributes, skills, and W/S/S damage. If you can read a character sheet, you can read a stat block. The only difference is that monsters don't level up, don't have DP, and don't get death saves. When they hit 0 HP, they're done.

#pagebreak()
#table(
  columns: (35%, 65%),
  align: (auto,auto,),
  table.header([Field], [Description],),
  table.hline(),
  [#strong[Name]], [Creature type and challenge rating],
  [#strong[Attributes]], [B/F/A/G/K/R modifiers. Most monsters have 0s in attributes they don't use.],
  [#strong[HP]], [Health points. When this hits 0, the creature is defeated.],
  [#strong[DR]], [Damage reduction. Subtract from physical damage just like hero armor.],
  [#strong[Attacks]], [W/S/S damage per attack. Weak/Standard/Strong values.],
  [#strong[Abilities]], [Special powers. These override the normal rules, the stat block always wins.],
)
#pagebreak()
== Beasts
<beasts>
#strong[Wolf (Challenge 1/2):] HP 8, DR 0. Bite: 2/3/4. Pack Tactics: +1 to attacks when an ally is adjacent.

#strong[Dire Wolf (Challenge 1):] HP 14, DR 1. Bite: 3/4/6. Pack Tactics: +1 when ally adjacent. Knockdown: on Strong hit, target must succeed Agility check or be knocked Prone.

#strong[Bear (Challenge 2):] HP 20, DR 2. Claw: 3/4/6. Bite: 4/5/7. Multiattack: may make both Claw and Bite as one Standard Action.

#strong[Giant Spider (Challenge 1):] HP 10, DR 0. Bite: 1d4/1d6/1d8 + poison (Fortitude save or Poisoned condition). Web (Recharge): ranged attack that Restrains target on hit.

#strong[Swarm of Rats (Challenge 1/2):] HP 5, DR 0. Bites: automatic 1 damage to all in space. Immune to single-target attacks. Vulnerable to area effects (damage tier +1).

#strong[Stirge (Challenge 1/2):] HP 3, DR 0. Proboscis: 1/2/3 piercing + attach. On a hit, the stirge latches onto the target. While attached, it automatically deals 2 damage each round. A creature can use a Maneuver to make a Brawn check to detach the stirge. Tiny flyer, the stirge dies if it takes any damage while attached.

#strong[Dire Boar (Challenge 2):] HP 18, DR 2. Gore: 4/5/7. Charge: if it moves 20+ ft before attacking, damage tier +1. Relentless: when reduced to 0 HP, make Fortitude save; on Strong, stays at 1 HP.

#pagebreak()
== Humanoids (NPCs)
<humanoids-npcs>
#strong[Bandit (Challenge 1/2):] HP 4, DR 0. Shortsword: 2/3/4. Shortbow: 2/3/4. Pack Tactics.

#strong[Guard (Challenge 1/2):] HP 8, DR 1 (chain shirt). Spear: 2/3/4. Shield: +1 DR.

#strong[Cultist (Challenge 1/2):] HP 6, DR 0. Dagger: 1/2/3. Dark Bolt: 2/3/4 necrotic (range 60 ft). Fanatical: immune to Frightened.

#strong[Knight (Challenge 3):] HP 20, DR 4 (plate). Longsword: 2/3/5. Shield Block reaction. Leadership: allies within 10 ft gain +1 to attacks.

#strong[Archmage (Challenge 6):] HP 14, DR 2. Dagger: 1/2/3. Firebolt: 2/3/5 (at will). Fireball: 6/9/12 (3/day). Counterspell: reaction to negate a spell. Magical Ward: +2 DR vs spells.

#pagebreak()
== Goblinoids
<goblinoids>
#strong[Goblin (Challenge 1/2):] HP 4, DR 0. Scimitar: 2/3/4 slashing. Shortbow: 2/3/4 piercing (range 80/320). Nimble Escape: the goblin can use a Maneuver to Disengage. Darkvision: 60 ft. Cowardly: if outnumbered and below half HP, the goblin must make a Morale Check or flee.

#strong[Hobgoblin (Challenge 1/2):] HP 8, DR 1 (chain shirt). Longsword: 2/3/4 slashing. Longbow: 2/3/4 piercing (range 150/600). Martial Advantage: +1 damage tier when an ally is adjacent to the target. Iron Discipline: immune to Frightened while within sight of an allied hobgoblin.

#strong[Bugbear (Challenge 1):] HP 12, DR 1 (hide). Morningstar: 3/4/6 bludgeoning. Reach 10 ft. Brute: +1 damage tier against targets that haven't acted yet this combat. Natural Stealth: +1 to Guile (Stealth) checks. Surprise Attack: on the first round of combat, the bugbear's first attack that hits deals damage one tier higher.

#strong[Goblin Shaman (Challenge 1):] HP 8, DR 0. Staff: 1/2/3 bludgeoning. Hex Bolt: 2/4/6 necrotic (range 60 ft). Hex (Recharge): one target within 30 ft must make a Guile save or suffer disadvantage on its next attack roll. Goblin Cunning: can use a Maneuver to Disengage. Darkvision: 60 ft.

#pagebreak()
== Orcs
<orcs>
#strong[Orc (Challenge 1/2):] HP 10, DR 1 (hide). Greataxe: 3/4/5 slashing. Javelin: 2/3/4 piercing (range 30/120). Relentless Endurance: once per day, when reduced to 0 HP, the orc can make a Fortitude save. On a Strong result, it stays at 1 HP. Aggressive: can use a Maneuver to move up to its Speed toward a visible enemy.

#strong[Orc Warchief (Challenge 3):] HP 22, DR 3 (plate). Greataxe: 4/5/7 slashing. Javelin: 3/4/6 piercing (range 30/120). Multiattack: Greataxe twice. Battle Cry (Recharge): all orc allies within 30 ft gain +1 damage tier on their next attack. Relentless Endurance: as Orc. Commanding Presence: orc allies within 30 ft are immune to Frightened.

#pagebreak()
#figure([
#box(image("chapters/../assets/images/page108-img045.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 29: Bestiary Second Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 29 --- Bestiary chapter second art (Beast art). Placeholder; final art TBD. Dimensions: 654×654.]

#pagebreak()
== Undead
<undead>
#strong[Skeleton (Challenge 1/2):] HP 5, DR 0. Shortsword: 2/3/4. Shortbow: 2/3/4. Vulnerable (Bludgeoning): damage tier +1 vs bludgeoning. Undead Nature: immune to poison and charm.

#strong[Zombie (Challenge 1/2):] HP 12, DR 1. Slam: 2/3/4. Undead Fortitude: when reduced to 0 HP, roll Fortitude. On Strong, stays at 1 HP. Slow: always acts last in initiative.

#strong[Ghoul (Challenge 1):] HP 10, DR 0. Claw: 1d6/1d8/1d10. Bite: 3/4/6. Paralyzing Touch: on Strong claw hit, target must make Fortitude save or be Paralyzed for 1 round.

#strong[Wraith (Challenge 3):] HP 12, DR 3 (non-magical). Life Drain: 3/5/7 necrotic. Incorporeal: half damage from non-magical physical attacks. Create Specter: humanoid killed by Life Drain rises as a specter under the wraith's control at next sunset.

#strong[Lich (Challenge 10):] HP 30, DR 4. Paralyzing Touch: 4/6/9 cold + Paralyzed (Fortitude save). Disrupt Life: 5/8/11 necrotic (30 ft radius, 1/day). Spellcasting: as 10th-level Arcanist. Phylactery: reforms in 1d10 days if phylactery survives.

#pagebreak()
== Monstrosities
<monstrosities>
#strong[Owlbear (Challenge 2):] HP 16, DR 1. Claw: 3/4/6. Bite: 4/5/7. Blood Frenzy: when below half HP, all attacks at damage tier +1.

#strong[Basilisk (Challenge 3):] HP 14, DR 2. Bite: 3/4/6 + poison. Petrifying Gaze: creatures within 30 ft must make Fortitude save or be Restrained. Fail twice: Petrified.

#strong[Chimera (Challenge 5):] HP 25, DR 2. Bite: 4/6/9. Claw: 4/5/7. Fire Breath: 6/9/12 (15 ft cone, Recharge). Multiattack: Bite + Claw + breath if available. Three heads: cannot be surprised.

#strong[Harpy (Challenge 1):] HP 8, DR 0. Claw: 2/3/4 slashing. Club: 2/3/4 bludgeoning. Luring Song: creatures within 60 ft that can hear the harpy must make a Guile save or use their movement to move toward the harpy by the safest route. Creatures immune to Charmed are immune. Flyer: the harpy can fly at its full Speed.

#strong[Minotaur (Challenge 3):] HP 22, DR 2 (natural hide). Greataxe: 4/5/7 slashing. Gore: 3/4/6 piercing + push 10 ft on a Strong hit. Charge: if the minotaur moves 20+ ft before making a Gore attack, that attack deals damage one tier higher. Labyrinthine Recall: the minotaur cannot become lost and always knows the way back to the entrance of any maze or labyrinth it has explored.

#strong[Rust Monster (Challenge 2):] HP 12, DR 2 (chitin). Bite: 2/3/4 piercing. Rusting Antennae: as an action, the rust monster touches a metal weapon or suit of armor. Metal armor permanently loses 1 DR (to a minimum of 0). Metal weapons permanently deal damage one tier lower (to a minimum of Weak). If an item's DR or damage is reduced to its minimum, the item is destroyed. Non-metal items are unaffected. Scent Metal: the rust monster can detect the presence of metal within 60 ft.

#pagebreak()
== Fey
<fey>
#strong[Pixie (Challenge 1/2):] HP 2, DR 0. Tiny. Invisible: permanently invisible. Confusion Touch: on hit, target rolls Weak on its next action. Pixie Dust: once per day, grant one creature flight for 1 minute.

#strong[Dryad (Challenge 1):] HP 10, DR 0. Club: 1d6/1d8/1d10. Charm: one humanoid within 30 ft must make Guile save or be Charmed (1/day). Tree Stride: teleport between trees within 60 ft. Treebound: takes 1d6 damage per round when more than 300 ft from its bonded tree.

#strong[Green Hag (Challenge 3):] HP 16, DR 2. Claw: 3/4/6. Illusory Appearance: appears as any humanoid. Vicious Mockery: 2/4/6 psychic + disadvantage on next attack (at will). Coven Magic: when 3 hags are within 30 ft, they share spellcasting.

#pagebreak()
== Dragons
<dragons>
#strong[Wyrmling (Challenge 3):] HP 15, DR 3. Bite: 3/4/6. Breath Weapon: 5/8/11 (15 ft cone, Recharge). Choose color: Red (fire), Blue (lightning), Green (poison), Black (acid), White (cold).

#strong[Young Dragon (Challenge 6):] HP 30, DR 4. Bite: 5/7/10. Claw: 4/5/7. Breath Weapon: 8/11/15 (30 ft cone, Recharge). Multiattack: Bite + 2 Claws. Frightful Presence: creatures within 60 ft must save vs Frightened.

#strong[Ancient Dragon (Challenge 12):] HP 60, DR 6. Bite: 7/10/14. Claw: 5/7/10. Tail: 5/7/10 (15 ft reach). Breath Weapon: 15/21/28 (60 ft cone, Recharge). Multiattack: Bite + 2 Claws + Tail. Frightful Presence. Legendary Resistance (3/day): automatically succeed a failed save.

#pagebreak()
== Elementals
<elementals>
#strong[Fire Elemental (Challenge 4):] HP 20, DR 2. Slam: 4/5/7 fire. Touch: creatures touching or hitting the elemental take 2 fire. Water Vulnerability: takes 2 cold damage when splashed with water.

#strong[Water Elemental (Challenge 4):] HP 22, DR 2. Slam: 4/5/7 bludgeoning. Whelm: target must make Brawn save or be Grappled and take 2/4/6 bludgeoning each round. Freeze: when hit by cold damage, speed halved for 1 round.

#pagebreak()
== Giants
<giants>
#strong[Hill Giant (Challenge 5):] HP 30, DR 2. Greatclub: 5/7/10. Rock: 4/6/9 (range 60/240). Slow-Witted: disadvantage on Knowledge, Reason, and Guile saves.

#strong[Stone Giant (Challenge 7):] HP 35, DR 4. Greatclub: 2d10/3d10/4d10. Rock: 6/9/12 (range 60/240). Stone Camouflage: advantage on Stealth in rocky terrain.

#strong[Ogre (Challenge 2):] HP 20, DR 2 (thick hide). Greatclub: 4/5/7 bludgeoning. Rock: 3/4/6 bludgeoning (range 30/90). Reach 10 ft. Slow-Witted: disadvantage on Knowledge, Reason, and Guile saves. Hulking Brute: the ogre deals +1 damage tier to objects and structures.

#pagebreak()
== Extraplanar
<extraplanar>
#strong[Vrock (Demon, Challenge 6):] HP 25, DR 3. Claw: 4/5/7. Bite: 3/4/6. Spores (Recharge): all within 15 ft take 4/6/9 poison. Stunning Screech (1/day): all within 30 ft must make Fortitude save or be Stunned for 1 round. Magic Resistance: advantage on saves vs spells.

#strong[Barbed Devil (Challenge 5):] HP 22, DR 4. Claw: 3/4/6 + 2 fire. Tail: 4/5/7 piercing. Barbed Hide: creatures grappling or hitting with melee take 2 piercing. Magic Resistance: advantage on saves vs spells.

#pagebreak()
== Oozes
<oozes>
#strong[Gelatinous Cube (Challenge 3):] HP 20, DR 1. Pseudopod: 3/4/6 acid. Engulf: moves into target space, Restrained + 4/6/9 acid per round. Transparent: requires Standard Investigation check to notice when motionless.

#pagebreak()
== Shapechangers
<shapechangers>
#strong[Doppelganger (Challenge 3):] HP 14, DR 0. Slam: 2/3/4 bludgeoning. Shapechange: as an action, the doppelganger can assume the appearance of any Medium humanoid it has seen. Its attributes and attacks remain unchanged, but it gains the target's voice and mannerisms. Creatures can make a Guile (Investigation) check opposed by the doppelganger's Guile (Deception) to see through the disguise. Mind Reading (Recharge): the doppelganger learns the surface thoughts of one creature within 30 ft. The target may make a Guile save to resist. Ambusher: +1 damage tier against surprised targets. Deceptive: +1 to Guile (Deception) checks.

#pagebreak()
== Additional Monsters
<additional-monsters>
=== Cave Troll (Challenge 4)
<cave-troll-challenge-4>
HP 25, DR 3 (regenerates). Attributes: Brawn +2, Fortitude +2, Agility -1, Guile -2, Knowledge -1, Reason -1.

#strong[Claw:] 4/5/7 slashing. #strong[Bite:] 3/4/6 piercing. #strong[Multiattack:] Claw + Claw + Bite.

#strong[Regeneration:] At the start of its turn, the troll regains 5 HP. This regeneration stops for 1 round if the troll takes fire or acid damage. The troll cannot regenerate from 0 HP.

#strong[Rend:] If both claws hit the same target, the second claw deals damage one tier higher.

#strong[Mindless Fury:] When below half HP, the troll attacks the nearest creature, friend or foe. It cannot distinguish ally from enemy in its rage.

=== Shadow Stalker (Challenge 3)
<shadow-stalker-challenge-3>
HP 14, DR 1. Attributes: Agility +2, Guile +1, others +0.

#strong[Shadow Claw:] 3/4/6 necrotic. Target's shadow is torn, disadvantage on Stealth until the end of the encounter.

#strong[Merge with Shadow (Maneuver, at will):] If in dim light or darkness, the stalker becomes Invisible until it attacks or enters bright light.

#strong[Shadow Leap (Maneuver, Recharge):] Teleport up to 60 ft to any area of dim light or darkness.

#strong[Light Vulnerability:] While in bright light, all attacks against the stalker are at advantage, and its damage tier is reduced by one.

=== Treant (Challenge 5)
<treant-challenge-5>
HP 35, DR 4 (bark). Attributes: Brawn +2, Fortitude +2, Agility -2, Knowledge +1, others +0.

#strong[Slam:] 5/7/10 bludgeoning. Reach 15 ft. #strong[Rooted Grasp:] Creatures within 20 ft must make Agility save or be Restrained by erupting roots (Recharge).

#strong[Animate Trees:] As an action, the treant animates one nearby tree as a Lesser Treant (HP 10, Slam 2/3/4) that acts on the treant's initiative.

#strong[Fire Vulnerability:] Fire damage is always treated as one tier higher against the treant. The treant must make a Morale Check whenever it takes fire damage.

=== Phase Beast (Challenge 4)
<phase-beast-challenge-4>
HP 18, DR 2. Attributes: Agility +2, Reason +1, others +0.

#strong[Phase Bite:] 4/5/7 force. Ignores non-magical DR.

#strong[Blink (Reaction, Recharge):] When hit by an attack, the phase beast may teleport 20 ft. The attack still deals damage, but the beast is no longer adjacent.

#strong[Phasing (Maneuver):] Until the end of its turn, the phase beast can move through solid objects and creatures. It cannot end its turn inside a solid object.

#strong[Unstable:] When the phase beast is reduced to 0 HP, it explodes. All creatures within 10 ft take 4/6/9 force damage (Agility save for half).

=== Death Knight (Challenge 8)
<death-knight-challenge-8>
HP 40, DR 5 (plate + unholy). Attributes: Brawn +2, Fortitude +1, Guile +1, others +0.

#strong[Greatsword:] 5/8/11 slashing. #strong[Hellfire Orb:] 6/9/12 fire + necrotic (range 90 ft, Recharge). #strong[Multiattack:] Greatsword twice.

#strong[Marshal Undead:] Undead allies within 30 ft gain +1 to all attack rolls.

#strong[Unholy Resilience:] The Death Knight has advantage on all saves against spells and magical effects.

#strong[Soulbind:] When the Death Knight reaches 0 HP, its soul retreats into its armor. It reforms at full HP in 1d4 rounds unless the armor is destroyed (HP 15, DR 6) or a Shepherd uses Turn Undead on the armor.

#pagebreak()
== Encounter Building
<encounter-building-1>
#table(
  columns: (23.4%, 36.17%, 40.43%),
  align: (auto,auto,auto,),
  table.header([Difficulty], [Challenge Budget], [Example (4 players)],),
  table.hline(),
  [Easy], [1 - party level], [4 Wolves (Challenge 1/2 each)],
  [Standard], [2 - party level], [1 Knight (C3) + 2 Guards (C- each)],
  [Hard], [3 - party level], [1 Young Dragon (C6) + 4 Cultists (C-)],
  [Deadly], [4+ - party level], [1 Ancient Dragon (C12) or 1 Lich (C10) + minions],
)
#pagebreak()
== Creating Monsters
<creating-monsters>
Assign attributes (-2 to +2), give 1-3 attacks with W/S/S damage, add 1-2 abilities. HP = 5 - desired challenge. DR = 0-6 based on natural armor.

#strong[Quick Monster Template:]

+ Choose type (Beast, Undead, etc.)
+ Set Challenge (1-12)
+ HP = 5 - Challenge, DR = Challenge 1/2 2 (round down)
+ Choose 1-2 attacks with W/S/S damage (W = d6 x Challenge x 2, S = d8-Challenge-2, St = d10-Challenge-2)
+ Add 1 signature ability from its type

#block[
#callout(
body: 
[
The stat block is a starting point, not a contract. If a fight is too easy or too hard, change it. The players can't see the numbers.

#strong[Too easy?] The monster has a second phase. When it drops to 0 HP, it roars, gains 10 HP, and its damage tier increases by one. The cultist leader drinks a potion. The wolf pack's alpha arrives, drawn by the sounds of combat. You're not cheating, you're making the fight interesting.

#strong[Too hard?] The monster is wounded from a previous fight. Reduce its HP by 25%. Remove its Multiattack, it's favoring an injured limb. Its Recharge ability doesn't recharge, it used it earlier today on a different party of adventurers. The monster wants to survive too, it might flee at half HP instead of fighting to the death.

#strong[The golden rule:] Adjust in the fiction, not the math. Don't say "I'm reducing its HP by 10." Say "You notice a deep wound in its flank, someone fought this thing before you. It's already bleeding." The players feel smart for noticing. They don't need to know you just turned a Deadly encounter into a Hard one.

#strong[Morale is your best tool.] If the party is getting crushed and the fight was supposed to be Standard difficulty, the monsters get overconfident. One stops to gloat. Another starts looting a downed hero instead of finishing them. The monsters make mistakes, and mistakes give the party openings. This isn't pulling punches. It's playing the monsters like they're alive.

]
, 
title: 
[
Adjusting Monster Difficulty On the Fly
]
, 
background_color: 
brand-color-background.primary
, 
icon_color: 
brand-color.primary
, 
icon: 
fa-info()
, 
body_background_color: 
brand-color.background
)
]
#part[Appendices]
= Core Mechanic Terms
<core-mechanic-terms>
﻿\# Glossary {\#sec-chapter-glossary}

#figure([
#box(image("chapters/../assets/images/page111-img046.jpeg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 30: Glossary Art
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 30 --- Glossary / appendices chapter art (Final page art). Placeholder; final art TBD. Dimensions: 1024×1024.]

#pagebreak()
Every mechanical term used in this book, defined in one place. If you hit a word you don't recognize, start here.

#pagebreak()
#strong[3d6:] The core dice roll. Three six-sided dice, summed, plus modifiers.

#strong[Always Hit:] Attacks do not roll to hit, the 3d6 determines damage tier. Every attack connects. Every swing matters.

#strong[Attribute:] One of six core stats: Brawn, Fortitude, Agility, Guile, Knowledge, Reason. Ranges from -2 to +2.

#strong[Bell Curve:] The probability distribution of 3d6. Most rolls cluster around 9-12. Extreme results (3 and 18) are rare, about 0.5% each.

#strong[Boon:] An extra d6 added to a 3d6 roll. Roll 4d6 and keep the highest three. Halflings get a boon once per session from their Lucky trait.

#strong[Bane:] An extra d6 added to a 3d6 roll where you keep the #emph[lowest] three. The opposite of a boon. Applied by the DA for severe disadvantage.

#strong[Critical:] Three natural 6s on 3d6. Automatic Strong success plus a bonus effect from the Critical table. About a 1-in-200 chance.

#strong[Fumble:] Three natural 1s on 3d6. Automatic failure plus a complication. About a 1-in-200 chance. The table groans.

#strong[Success Tier:] The three bands of outcome: Weak (1-6), Standard (7-12), Strong (13-18+). Every roll lands in one of these.

#strong[Weak:] Partial success or success with complication. You get what you wanted, barely, or at a cost.

#strong[Standard:] Full, clean success. The thing you attempted works as intended.

#strong[Strong:] Exceptional success. Extra effect, bonus damage, additional information, or sheer style.

#pagebreak()
== Character Terms
<character-terms>
#strong[Ability:] An active power purchased with DP. Spells, combat techniques, and signature class powers are all abilities. Must be activated to use. Follows Novice/Adept/Master chain.

#strong[Ancestry:] Your species, Human, Elf, Dwarf, or Halfling. Grants one Discipline and one trait.

#strong[Background:] Level 0. Your hero's life before adventuring. Governed by Background DP (8 + Knowledge + Fortitude).

#strong[Class:] Your hero's calling, Protector, Blade, Arcanist, Shepherd, Intellect, Odd, Leader, or Unbalanced. Determines favored skills, favored Disciplines, and signature ability.

#strong[Culture:] Your upbringing within your ancestry. Grants a +1 skill bonus and either two specific Disciplines or one free Discipline.

#strong[Development Points (DP):] The currency of character creation and advancement. Spent to purchase skills, abilities, and Disciplines. Different classes pay different costs (X1, X2, X3) for different purchases.

#strong[Discipline:] A prerequisite resource representing mastery of a domain. Disciplines come in types: Elemental (Fire, Earth, Wind, Water), Weapon (Blades, Axes, Polearms, Heavy Weapon, Archery, Unarmed), Defense (Protection, Armor), Primal (Animal, Plants), Arcane (Energy), Divine (Life, Religion), and Esoteric (Mind, Summon).

#strong[General Discipline:] A wildcard Discipline that can substitute for any specific type at Novice tier. All characters begin with 3 General Disciplines.

#strong[HP (Health Points):] How much damage you can take before falling unconscious. Starting HP = 10 + Brawn. Gain Brawn modifier HP each level (minimum 1).

#strong[Level:] Your hero's experience tier, from 1 to 20. Higher levels unlock Adept (Level 3) and Master (Level 7) abilities and grant attribute increases every 4 levels.

#strong[Novice:] The first tier of any skill or ability. Grants +1 bonus. Costs 1 DP at X1.

#strong[Adept:] The second tier. Grants +2 bonus. Unlocks a maneuver for skills. Costs 2 DP at X1. Requires Novice. Unlocks at Level 3.

#strong[Master:] The third tier. Grants +3 bonus. Unlocks a powerful maneuver for skills. Costs 4 DP at X1. Requires Adept. Unlocks at Level 7.

#strong[Maneuver:] A special technique unlocked by Adept or Master skill rank. Spent as your Maneuver for the turn.

#strong[Signature Ability:] The unique power granted by your class at Level 1. Defines your class identity mechanically.

#strong[Skill:] A trained competency. Ranges from Novice (+1) to Master (+3). Includes combat skills (Blades Fighting), knowledge skills (Arcana), social skills (Persuasion), and physical skills (Athletics).

#strong[Talent:] A passive benefit purchased with DP. Always on. Does not require activation. Examples: Tough (+2 HP), Lucky (reroll one 1 per session).

#strong[Trait:] An ancestry-granted special ability. Human: Versatile. Elf: Elven Grace. Dwarf: Sturdy. Halfling: Lucky.

#pagebreak()
== Combat Terms
<combat-terms>
#strong[Action:] The main thing you do on your turn. Attack, cast a spell, activate an ability, Dash. One per turn.

#strong[Maneuver (combat resource):] A secondary resource spent on basic maneuvers (Defend, Shove) or skill-granted maneuvers (Riposte, Cleave). One per turn.

#strong[Movement:] How far you can move on your turn. Usually 30 ft. Can be broken up before and after your Action.

#strong[Reaction:] A response triggered by someone else's turn. Opportunity attacks, Shield Block, Counterspell. One per round (resets at the start of your turn).

#strong[Free Action:] Anything trivial, talking, dropping an item, drawing a weapon. Unlimited per turn.

#strong[Basic Maneuver:] A combat technique available to everyone. Defend, Disengage, Aid, Shove, Grapple, Command, Catch Breath, Search, Stand Up, Use Item. Costs your Maneuver for the turn.

#strong[Damage Reduction (DR):] Subtracted from incoming physical damage. Comes from armor, shields, and some abilities.

#strong[Damage Tier:] Weak, Standard, or Strong, determines how much damage an attack deals. Weapons and spells have fixed damage values for each tier.

#strong[Protection Value (PV):] A defensive bonus from shields, the Defend maneuver, and some abilities. Adds to DR or enables Shield Block.

#strong[Shield Block:] A reaction that reduces incoming damage by one tier. Requires a shield.

#strong[Opportunity Attack:] A free melee attack when an enemy leaves your reach without Disengaging.

#strong[Concentration:] Some spells require concentration to maintain. You can only concentrate on one spell at a time (two with the Spell Weaver talent). Taking damage may break concentration.

#strong[Condition:] A temporary status effect. Blinded, Charmed, Deafened, Frightened, Grappled, Incapacitated, Invisible, Paralyzed, Poisoned, Prone, Restrained, Stunned, Unconscious.

#strong[Morale Check:] A 3d6 roll (no modifiers) to determine whether an NPC or monster flees, wavers, or stands firm.

#strong[Initiative:] 1d6 + Agility modifier. Determines turn order in combat.

#strong[Surprise:] When one side catches the other unaware. Surprised creatures take -2 on their first roll. Determined by Stealth vs passive Insight.

#strong[Cover:] Terrain that provides protection. Half cover (-1 to attacker), three-quarters cover (-3), full cover (cannot be targeted).

#strong[Non-Lethal Attack:] A melee attack that reduces a creature to 0 HP but leaves them unconscious and stable instead of dying.

#strong[Dying:] At 0 HP, you fall Unconscious and roll 3d6 each turn to determine if you stabilize, worsen, or die.

#strong[Wounded:] Below half HP. Healing received is halved while Wounded.

#pagebreak()
== Magic Terms
<magic-terms>
#strong[Spell:] A magical ability. Follows Novice ? Adept ? Master chain. Always fires, no spell slots, no mana.

#strong[Spell Chain:] Three linked spells (Novice, Adept, Master) sharing a theme. Example: Spark ? Firebolt ? Inferno.

#strong[Concentration Spell:] A spell that requires ongoing focus. You can maintain one (or two with Spell Weaver) at a time.

#strong[Arcane Focus:] An item (wand, staff, orb) that channels arcane magic. Required for some spells.

#strong[Holy Symbol:] An item (amulet, reliquary, sacred text) that channels divine magic. Required for some spells.

#strong[Attunement:] The bond between a hero and a magic item. Maximum 3 attuned items at a time. Artifacts don't count against this limit.

#pagebreak()
== GM Terms
<gm-terms>
#strong[DA (Dungeon Architect):] The game master. Runs the world, plays the NPCs, adjudicates the rules.

#strong[Challenge Rating (Challenge):] A measure of monster difficulty. Roughly equivalent to the level of a party that would find the monster a Standard encounter.

#strong[Difficulty Modifier:] A bonus or penalty the DA applies to a roll based on how hard the task is. Ranges from +3 (Trivial) to -6 (Nearly Impossible).

#strong[Passive Insight:] A creature's baseline ability to detect lies and hidden threats. Calculated as Knowledge score + 7.

#strong[Session:] One gaming session, typically 3-4 hours. Some abilities refresh per session.

#strong[Encounter:] A single scene or combat. Some abilities refresh per encounter.

#strong[Campaign:] The entire ongoing story, spanning multiple sessions and potentially years of play.

= Core Resolution
<core-resolution>
﻿\# Quick Reference Sheets {\#sec-chapter-reference-sheets}

#figure([
#box(image("chapters/../assets/svg/placeholder-section.svg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 31: Reference Sheets
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 31 --- Reference sheets chapter placeholder. Placeholder for final art. Use placeholder-section.svg dimensions: 400×300.]

#pagebreak()
Tear these pages out. Photocopy them. Keep them behind your DA screen or next to your character sheet. When the dice are rolling and the table is loud, these are the numbers you need.

#pagebreak()
#strong[The One Rule:] 3d6 + Attribute + Skill + Modifiers

#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Tier], [Range], [Meaning],),
  table.hline(),
  [#strong[Weak]], [1-8], [Partial success or success with complication],
  [#strong[Standard]], [9-14], [Full, clean success],
  [#strong[Strong]], [15-18+], [Exceptional success. Bonus effect.],
  [#strong[Critical]], [3-6 (natural)], [Automatic Strong + special outcome],
  [#strong[Fumble]], [3-1 (natural)], [Automatic failure + complication],
)
#pagebreak()
== Difficulty Modifiers
<difficulty-modifiers-2>
#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Difficulty], [Modifier], [Example],),
  table.hline(),
  [Trivial], [+4], [Climbing a knotted rope],
  [Easy], [+2], [Picking a simple lock],
  [Standard], [+0], [Most tasks],
  [Hard], [-2], [Lying to a suspicious guard],
  [Very Hard], [-4], [Swimming in armor during a storm],
  [Nearly Impossible], [-6], [Convincing the king you're his heir],
)
#pagebreak()
== Combat Quick-Reference
<combat-quick-reference>
=== Your Turn
<your-turn>
#table(
  columns: (30.3%, 30.3%, 39.39%),
  align: (auto,auto,auto,),
  table.header([Resource], [Per Turn], [Common Uses],),
  table.hline(),
  [#strong[Action]], [1], [Attack, cast a spell, Dash (double move), activate ability],
  [#strong[Movement]], [1], [Move up to Speed (usually 30 ft). Break up: move ? act ? move.],
  [#strong[Maneuver]], [1], [Basic maneuvers or skill-granted maneuvers],
  [#strong[Reaction]], [1/round], [Shield Block, opportunity attack, Counterspell, Riposte],
  [#strong[Free]], [Unlimited], [Talk, draw weapon, drop item, gesture],
)
#strong[Trading:] Action ? Movement or Maneuver. Never Maneuver ? Action.

=== Basic Maneuvers (Everyone)
<basic-maneuvers-everyone>
#table(
  columns: (55.56%, 44.44%),
  align: (auto,auto,),
  table.header([Maneuver], [Effect],),
  table.hline(),
  [#strong[Defend]], [+2 Protection Value until your next turn],
  [#strong[Disengage]], [Move 5 ft without provoking opportunity attacks],
  [#strong[Aid]], [Ally within 30 ft gains +2 on their next roll],
  [#strong[Shove]], [Opposed Brawn check. Push 5 ft (10 ft on Strong)],
  [#strong[Grapple]], [Initiate a grapple (opposed Brawn check)],
  [#strong[Command]], [Companion/familiar/mount takes an extra move],
  [#strong[Catch Breath]], [Regain HP equal to Fortitude (min 1). Once per combat.],
  [#strong[Search]], [Active Investigation check to spot hidden things],
  [#strong[Stand Up]], [Rise from prone],
  [#strong[Use Item]], [Drink a potion, apply a salve, activate a device],
)
=== Conditions Quick-Reference
<conditions-quick-reference>
#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Condition], [Effect], [Ends],),
  table.hline(),
  [#strong[Blinded]], [Attacks reduced one tier], [Source duration],
  [#strong[Charmed]], [Cannot attack charmer], [Save ends],
  [#strong[Deafened]], [Perception disadvantage], [Source duration],
  [#strong[Frightened]], [Cannot approach source], [Save ends],
  [#strong[Grappled]], [Speed 0], [Escape action],
  [#strong[Incapacitated]], [No actions], [Source duration],
  [#strong[Invisible]], [Cannot be targeted directly], [Attack/action ends],
  [#strong[Paralyzed]], [Incapacitated + auto-crit if hit], [Save ends],
  [#strong[Poisoned]], [Disadvantage on attacks], [Save ends],
  [#strong[Prone]], [Melee adv vs you, ranged disadv], [Stand up (move)],
  [#strong[Restrained]], [Speed 0, attack disadv], [Escape action],
  [#strong[Stunned]], [Incapacitated + cannot move], [Save ends],
  [#strong[Unconscious]], [Incapacitated + prone + unaware], [Healing or save],
)
=== Morale Checks (3d6, no modifiers)
<morale-checks-3d6-no-modifiers>
#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Result], [Behavior],),
  table.hline(),
  [#strong[Strong (15+)]], [Stands firm. +1 on next attack.],
  [#strong[Standard (9-14)]], [Wavers. Disadvantage on next attack.],
  [#strong[Weak (1-8)]], [Flees or surrenders.],
)
#strong[Auto-triggers:] Below half HP, leader defeated, half group fallen, overwhelming force.

=== Dying (at 0 HP, roll 3d6 each turn)
<dying-at-0-hp-roll-3d6-each-turn>
#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Result], [Outcome],),
  table.hline(),
  [#strong[Strong (15+)]], [Stabilize at 1 HP],
  [#strong[Standard (9-14)]], [Unconscious, stable],
  [#strong[Weak (1-8)]], [Take 1 wound],
  [#strong[Fumble (3-1)]], [Death],
  [#strong[Critical (3-6)]], [Wake at half HP],
)
=== Cover
<cover-1>
#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Cover], [Attacker Penalty],),
  table.hline(),
  [Half cover], [-1],
  [Three-quarters], [-3],
  [Full cover], [Cannot target],
)
#pagebreak()
== Damage Types
<damage-types-1>
#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Category], [Types],),
  table.hline(),
  [#strong[Physical]], [Slashing, Piercing, Bludgeoning],
  [#strong[Elemental]], [Fire, Cold, Lightning, Acid, Poison],
  [#strong[Magical]], [Force, Radiant, Necrotic, Psychic],
)
#pagebreak()
== Skills Quick-Reference
<skills-quick-reference>
#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Skill], [Attr], [Key Use],),
  table.hline(),
  [#strong[Athletics]], [BR], [Climb, swim, jump],
  [#strong[Intimidation]], [BR], [Frighten, coerce],
  [#strong[Blades Fighting]], [BR], [Swords, daggers],
  [#strong[Axe Fighting]], [BR], [Axes, cleaving],
  [#strong[Polearms Fighting]], [BR], [Spears, reach],
  [#strong[Heavy Weapon Fighting]], [BR], [Greatswords, mauls],
  [#strong[Unarmed Fighting]], [BR], [Fists, grappling],
  [#strong[Endurance]], [FO], [Fatigue, breath-holding],
  [#strong[Survival]], [FO], [Track, forage, navigate],
  [#strong[Resilience]], [FO], [Poison, disease, extremes],
  [#strong[Acrobatics]], [AG], [Balance, tumble, escape],
  [#strong[Stealth]], [AG], [Sneak, hide],
  [#strong[Bow Fighting]], [AG], [Longbows, shortbows],
  [#strong[Thrown Weapon]], [AG], [Knives, axes, javelins],
  [#strong[Crossbow Fighting]], [AG], [Crossbows],
  [#strong[Sleight of Hand]], [AG], [Pickpocket, lockpick],
  [#strong[Deception]], [GU], [Lie, bluff, disguise],
  [#strong[Persuasion]], [GU], [Diplomacy, negotiate],
  [#strong[Streetwise]], [GU], [Gather info, contacts],
  [#strong[Arcana]], [KN], [Magic knowledge],
  [#strong[History]], [KN], [Lore, legends],
  [#strong[Investigation]], [KN], [Search, deduce],
  [#strong[Nature]], [KN], [Plants, animals],
  [#strong[Religion]], [KN], [Gods, rituals],
  [#strong[Alchemy]], [RE], [Potions, substances],
  [#strong[Crafting]], [RE], [Smith, build, create],
  [#strong[Medicine]], [RE], [Heal, diagnose],
  [#strong[Insight]], [RE], [Read people, detect lies],
)
#pagebreak()
== Discipline Catalog
<discipline-catalog>
#table(
  columns: 2,
  align: (auto,auto,),
  table.header([Category], [Disciplines],),
  table.hline(),
  [#strong[Elemental]], [Fire, Earth, Wind, Water],
  [#strong[Weapon]], [Blades, Axes, Polearms, Heavy Weapon, Archery, Unarmed],
  [#strong[Defense]], [Protection, Armor],
  [#strong[Primal]], [Animal, Plants],
  [#strong[Arcane]], [Energy],
  [#strong[Divine]], [Life, Religion],
  [#strong[Esoteric]], [Mind, Summon],
)
#pagebreak()
== Character Creation Checklist
<character-creation-checklist>
+ #strong[Concept:] One sentence. Who is your hero?
+ #strong[Attributes:] Assign -2 to +2. Total must be +3.
+ #strong[Ancestry:] Human, Elf, Dwarf, or Halfling. Record Discipline and trait.
+ #strong[Culture:] Choose upbringing. Record +1 skill bonus and Disciplines.
+ #strong[Background DP:] 8 + Knowledge + Fortitude. Spend all on Novice skills and abilities.
+ #strong[Class:] Choose class. Record Class Discipline and signature ability.
+ #strong[Class DP:] 8 DP. Spend all on Novice skills and abilities.
+ #strong[Equipment:] Take class starting kit. Record weapon damage values and armor DR.
+ #strong[Derived Stats:] HP, Initiative, Speed, Carry Slots.
+ #strong[Backstory:] Motivation, Trinket, Name.

#pagebreak()
== Level Progression Quick-Reference
<level-progression-quick-reference>
#table(
  columns: (23.33%, 36.67%, 40%),
  align: (auto,auto,auto,),
  table.header([Level], [DP Gained], [Milestones],),
  table.hline(),
  [1], [3 DP (class) + 8 DP (background)], [Class, signature ability],
  [2], [2 DP], [,],
  [3], [2 DP], [Adept abilities unlock. +1 Discipline rank.],
  [4], [2 DP], [+1 Attribute (max +2)],
  [5], [3 DP], [Class feature],
  [6], [2 DP], [+1 Discipline rank],
  [7], [2 DP], [Master abilities unlock],
  [8], [2 DP], [+1 Attribute (max +2)],
  [9], [2 DP], [+1 Discipline rank],
  [10], [2 DP], [Class feature],
  [11-20], [2 DP/level], [Discipline every 3 levels. Attribute every 4 levels.],
)
#pagebreak()
== DP Cost Reference
<dp-cost-reference>
#table(
  columns: 4,
  align: (auto,auto,auto,auto,),
  table.header([Purchase], [X1 (Favored)], [X2 (Neutral)], [X3 (Out of Class)],),
  table.hline(),
  [Skill (Novice)], [1 DP], [2 DP], [3 DP],
  [Skill (Adept)], [2 DP], [4 DP], [6 DP],
  [Skill (Master)], [3 DP], [6 DP], [9 DP],
  [Discipline (1st rank)], [1 DP], [2 DP], [3 DP],
  [Discipline (2nd rank)], [2 DP], [4 DP], [6 DP],
  [Discipline (3rd rank)], [4 DP], [8 DP], [12 DP],
  [Ability (Novice)], [1 DP], [1 DP], [1 DP],
  [Ability (Adept)], [2 DP], [2 DP], [2 DP],
  [Ability (Master)], [4 DP], [4 DP], [4 DP],
)
#strong[Abilities always cost 1/2/4 DP] regardless of class. Their real gate is Discipline prerequisites.

#pagebreak()
== Encounter Building Quick-Reference
<encounter-building-quick-reference>
#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Difficulty], [Challenge Budget], [Example (Level 4 party)],),
  table.hline(),
  [Easy], [1 - party level], [4 Wolves (C- each)],
  [Standard], [2 - party level], [1 Knight (C3) + 2 Guards (C-)],
  [Hard], [3 - party level], [1 Young Dragon (C6) + 4 Cultists (C-)],
  [Deadly], [4+ - party level], [1 Ancient Dragon (C12)],
)
#pagebreak()
== Common Item Reference
<common-item-reference>
#table(
  columns: 4,
  align: (auto,auto,auto,auto,),
  table.header([Armor], [DR], [Stealth], [Disc Req],),
  table.hline(),
  [Padded], [-1], [,], [,],
  [Leather], [-2], [,], [,],
  [Studded Leather], [-2], [,], [1 Armor],
  [Chain Shirt], [-3], [Disadv], [1 Armor],
  [Breastplate], [-4], [,], [2 Armor],
  [Half Plate], [-4], [Disadv], [2 Armor],
  [Chain Mail], [-5], [Disadv], [2 Armor],
  [Plate], [-6], [Disadv], [3 Armor],
)
#table(
  columns: 3,
  align: (auto,auto,auto,),
  table.header([Shield], [PV], [DR Bonus],),
  table.hline(),
  [Buckler], [1], [+1],
  [Shield], [1], [+2],
  [Tower Shield], [2], [+3],
)
= Open Game License Version 1.0a
<open-game-license-version-1.0a>
﻿\# License {\#sec-chapter-license}

#figure([
#box(image("chapters/../assets/svg/placeholder-section.svg", width: 60.0%))
], caption: figure.caption(
position: bottom, 
[
Illo 32: License
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


#emph[Illustration 32 --- License chapter placeholder. Placeholder for final art. Use placeholder-section.svg dimensions: 400×300.]

#pagebreak()
#pagebreak()
The following text is the property of Wizards of the Coast, Inc.~and is Copyright 2000 Wizards of the Coast, LLC ("Wizards"). All Rights Reserved.

#strong[\1. Definitions:] (a) "Contributors" means the copyright and/or trademark owners who have contributed Open Game Content; (b) "Derivative Material" means copyrighted material including derivative works and translations (including into other computer languages), potation, modification, correction, addition, extension, upgrade, improvement, compilation, abridgment or other form in which an existing work may be recast, transformed or adapted; (c) "Distribute" means to reproduce, license, rent, lease, sell, broadcast, publicly display, transmit or otherwise distribute; (d) "Open Game Content" means the game mechanic and includes the methods, procedures, processes and routines to the extent such content does not embody the Product Identity and is an enhancement over the prior art and any additional content clearly identified as Open Game Content by the Contributor, and means any work covered by this License, including translations and derivative works under copyright law, but specifically excludes Product Identity. (e) "Product Identity" means product and product line names, logos and identifying marks including trade dress; artifacts; creatures characters; stories, storylines, plots, thematic elements, dialogue, incidents, language, artwork, symbols, designs, depictions, likenesses, formats, poses, concepts, themes and graphic, photographic and other visual or audio representations; names and descriptions of characters, spells, enchantments, personalities, teams, personas, likenesses and special abilities; places, locations, environments, creatures, equipment, magical or supernatural abilities or effects, logos, symbols, or graphic designs; and any other trademark or registered trademark clearly identified as Product identity by the owner of the Product Identity, and which specifically excludes the Open Game Content; (f) "Trademark" means the logos, names, mark, sign, motto, designs that are used by a Contributor to identify itself or its products or the associated products contributed to the Open Game License by the Contributor (g) "Use", "Used" or "Using" means to use, Distribute, copy, edit, format, modify, translate and otherwise create Derivative Material of Open Game Content. (h) "You" or "Your" means the licensee in terms of this agreement.

#strong[\2. The License:] This License applies to any Open Game Content that contains a notice indicating that the Open Game Content may only be Used under and in terms of this License. You must affix such a notice to any Open Game Content that you Use. No terms may be added to or subtracted from this License except as described by the License itself. No other terms or conditions may be applied to any Open Game Content distributed using this License.

#strong[\3. Offer and Acceptance:] By Using the Open Game Content You indicate Your acceptance of the terms of this License.

#strong[\4. Grant and Consideration:] In consideration for agreeing to use this License, the Contributors grant You a perpetual, worldwide, royalty-free, non-exclusive license with the exact terms of this License to Use, the Open Game Content.

#strong[\5. Representation of Authority to Contribute:] If You are contributing original material as Open Game Content, You represent that Your Contributions are Your original creation and/or You have sufficient rights to grant the rights conveyed by this License.

#strong[\6. Notice of License Copyright:] You must update the COPYRIGHT NOTICE portion of this License to include the exact text of the COPYRIGHT NOTICE of any Open Game Content You are copying, modifying or distributing, and You must add the title, the copyright date, and the copyright holder's name to the COPYRIGHT NOTICE of any original Open Game Content you Distribute.

#strong[\7. Use of Product Identity:] You agree not to Use any Product Identity, including as an indication as to compatibility, except as expressly licensed in another, independent Agreement with the owner of each element of that Product Identity. You agree not to indicate compatibility or co-adaptability with any Trademark or Registered Trademark in conjunction with a work containing Open Game Content except as expressly licensed in another, independent Agreement with the owner of such Trademark or Registered Trademark. The use of any Product Identity in Open Game Content does not constitute a challenge to the ownership of that Product Identity. The owner of any Product Identity used in Open Game Content shall retain all rights, title and interest in and to that Product Identity.

#strong[\8. Identification:] If you distribute Open Game Content You must clearly indicate which portions of the work that you are distributing are Open Game Content.

#strong[\9. Updating the License:] Wizards or its designated Agents may publish updated versions of this License. You may use any authorized version of this License to copy, modify and distribute any Open Game Content originally distributed under any version of this License.

#strong[\10. Copy of this License:] You MUST include a copy of this License with every copy of the Open Game Content You Distribute.

#strong[\11. Use of Contributor Credits:] You may not market or advertise the Open Game Content using the name of any Contributor unless You have written permission from the Contributor to do so.

#strong[\12. Inability to Comply:] If it is impossible for You to comply with any of the terms of this License with respect to some or all of the Open Game Content due to statute, judicial order, or governmental regulation then You may not Use any Open Game Material so affected.

#strong[\13. Termination:] This License will terminate automatically if You fail to comply with all terms herein and fail to cure such breach within 30 days of becoming aware of the breach. All sublicenses shall survive the termination of this License.

#strong[\14. Reformation:] If any provision of this License is held to be unenforceable, such provision shall be reformed only to the extent necessary to make it enforceable.

#strong[\15. COPYRIGHT NOTICE:]

#strong[Open Game License v 1.0a] Copyright 2000, Wizards of the Coast, LLC.

#strong[System Reference Document 5.1] Copyright 2016, Wizards of the Coast, LLC.; Authors Mike Mearls, Jeremy Crawford, Chris Perkins, Rodney Thompson, Peter Lee, James Wyatt, Robert J. Schwalb, Bruce R. Cordell, Chris Sims, and Steve Townshend, based on original material by E. Gary Gygax and Dave Arneson.

#strong[Heroes of Legend Core Rulebook] Copyright 2024-2026, Bruce A. Moser.

#horizontalrule
#pagebreak()
== Product Identity Declaration
<product-identity-declaration>
The following items are hereby identified as Product Identity, as defined in the Open Game License Version 1.0a, Section 1(e), and are not Open Game Content:

- The name "Heroes of Legend" and all associated logos and identifying marks.
- All proper names of characters (Kael, Lyra, Roric, Zara, Makeva Quickfoot, Ser Aldric), creatures, locations, and organizations.
- All artwork, illustrations, graphic designs, maps, and cartographic representations.
- All storylines, plots, thematic elements, dialogue, and fictional narratives (including but not limited to the opening fiction "The Last Ember" and all chapter epigraphs and flavor text).
- The specific names and descriptions of all classes (Protector, Blade, Arcanist, Shepherd, Intellect, Odd, Leader, Unbalanced).
- The specific names and descriptions of all ancestries and cultures as presented in the world of Heroes of Legend.
- The trade dress, layout, and visual presentation of this book.
- The "Battle-Scarred Mentor" and "Veteran Adventurer" voice and writing style.

#pagebreak()
== Open Game Content Declaration
<open-game-content-declaration>
The following portions of this work are designated as Open Game Content:

- All game mechanics, rules systems, and procedures described in Chapters 1-22, including but not limited to: the 3d6 core resolution system, success tier mechanics (Weak/Standard/Strong), the always-hit attack rule, the Discipline system, Development Point (DP) economy, skill tiers (Novice/Adept/Master), attribute ranges (-2 to +2), combat action economy, condition effects, damage reduction, morale mechanics, dying and death rules, and all associated tables and numerical values.
- All spell mechanics (damage values, ranges, durations, effects) presented in Chapters 11 and 12, excluding spell names and flavor text.
- All monster stat blocks and encounter building guidelines presented in Chapter 20, excluding proper names and descriptions of specific creatures unique to the Heroes of Legend setting.
- All character creation and advancement procedures, including DP costs, level progression milestones, and derived stat formulas.

This designation follows the principle that game mechanics and rules are Open Game Content, while creative expression, setting elements, and proper names remain Product Identity.

#pagebreak()
== Third-Party Attributions
<third-party-attributions>
This product uses the following fonts, tools, and assets:

- #strong[Quarto:] Open-source scientific and technical publishing system. Copyright the Quarto contributors.
- #strong[Typst:] Open-source typesetting engine. Copyright the Typst contributors.

Full license texts for open-source components are available in the source repository.

#pagebreak()
== Contact & Rights Inquiries
<contact-rights-inquiries>
For licensing inquiries, permissions requests, or questions about using #emph[Heroes of Legend] Open Game Content in your own products, contact: \[TBD\]

#horizontalrule
#emph[Heroes of Legend] is a work of fiction and a game. Any resemblance to actual persons, living or dead, or actual events is purely coincidental. The game is intended for entertainment purposes only. Dice cannot actually summon fire. (We checked.)
