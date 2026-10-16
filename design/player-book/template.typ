#let forest = rgb("#15221c")
#let gold = rgb("#b39253")
#let ivory = rgb("#f1e6ce")
#let paper = rgb("#f7f3e9")
#let ink = rgb("#28251c")
#let chapter-name = state("chapter-name", "Player’s Book")
#let setup(body) = {
  set document(title: "Heroes of Legend — Player’s Book", author: "Bruce A. Moser")
  set text(font: "EB Garamond", size: 10.5pt, fill: ink, lang: "en", hyphenate: true)
  set par(leading: 0.42em, spacing: 0.65em, justify: false)
  set page(width: 612pt, height: 792pt, margin: (left: 42pt, right: 42pt, top: 52pt, bottom: 46pt), fill: paper,
    header: context {
      grid(columns: (1fr, 1fr), text(font: "Cinzel", size: 8pt, fill: forest)[Heroes of Legend],
        align(right, text(size: 8pt, fill: forest, {
          let hs = query(heading.where(level: 1)).filter(h => h.location().page() <= here().page())
          if hs.len() > 0 { hs.last().body } else { [Player’s Book] }
        })))
      v(4pt); line(length: 100%, stroke: 0.5pt + gold)
    },
    footer: context {
      line(length: 100%, stroke: .5pt + gold)
      v(4pt)
      grid(columns: (1fr, 1fr), text(size: 8pt)[Player’s Book · Playtest Edition],
        align(right, text(font: "Cinzel", size: 9pt, counter(page).display())))
    })
  set heading(numbering: none)
  show heading.where(level: 1): it => block(above: 0pt, below: 13pt)[
    #text(font: "Cinzel", size: 26pt, fill: forest, weight: "bold", it.body)
    #v(7pt)#line(length: 100%, stroke: 1pt + gold)
  ]
  show heading.where(level: 2): it => block(above: 12pt, below: 6pt)[
    #text(font: "Cinzel", size: 14pt, fill: forest, weight: "bold", it.body)
  ]
  show heading.where(level: 3): it => block(above: 9pt, below: 4pt)[
    #text(size: 11.5pt, fill: forest, weight: "bold", it.body)
  ]
  show link: set text(fill: rgb("#3b5d46"))
  set list(indent: 10pt, body-indent: 5pt, spacing: 4pt)
  set enum(indent: 11pt, body-indent: 5pt, spacing: 4pt)
  body
}
#let chapter(n, title) = {
  pagebreak(weak: true)
  chapter-name.update(title)
  block(below: 8pt)[#text(font: "Cinzel", size: 9pt, fill: gold)[CHAPTER #n]]
  heading(level: 1, title)
}
#let entry(title, key) = {
  [#heading(level: 2, title)#label(key)]
}
#let xref(key, body) = link(label(key), body)
#let pageref(key) = context link(label(key), str(counter(page).at(label(key)).first()))
#let twocol(body) = columns(2, gutter: 18pt, body)
#let note(body) = block(width: 100%, inset: 9pt, fill: ivory, stroke: (left: 2pt + gold), radius: 2pt, above: 6pt, below: 8pt, breakable: true)[
  #set text(size: 10pt)
  #body
]
#let art(width: 100%, height: 108pt, brief: "") = block(width: width, height: height, stroke: .7pt + gold, fill: ivory, inset: 10pt, above: 8pt, below: 10pt)[
  #align(center + horizon)[
    #text(font: "Cinzel", size: 9pt, fill: forest)[ILLUSTRATION PLACEHOLDER]
    #v(5pt)
    #layout(size => text(size: 8pt)[#calc.round(size.width / 1pt + 20) × #calc.round(height / 1pt) pt · #(calc.round((size.width / 1pt + 20) / 72 * 100) / 100) × #(calc.round(height / 72pt * 100) / 100) in])
    #v(5pt)
    #text(size: 10pt, brief)
  ]
]
#let rule-table(cols, head, rows, widths: auto, pad: 5pt) = {
  set text(size: 9.3pt)
  set par(leading: 0.28em, spacing: 3pt)
  table(columns: if widths == auto { cols } else { widths }, inset: (x: 5pt, y: pad),
    stroke: .3pt + rgb("#cfc7b3"),
    fill: (x,y) => if y == 0 { forest } else if calc.odd(y) { rgb("#ede6d4") } else { paper },
    table.header(repeat: true, ..head.map(c => text(fill: ivory, weight: "bold", c))),
    ..rows.flatten())
}
#let diamond(tier) = box(width: 23pt, height: 23pt)[
  #place(center + horizon, rotate(45deg, square(size: 17pt, fill: forest, stroke: .7pt + gold)))
  #place(center + horizon, text(size: 9pt, fill: ivory, weight: "bold", tier))
]
#let discipline-mark(name, rank) = box(inset: 1pt)[#image("icons/" + name + ".svg", width: 12pt) #text(size: 8pt, rank)]
#let card(title, tier, req, action, attr, tags, price, key, body, icons: []) = {
  let whole = [#block(above: 12pt, below: 4pt, sticky: true)[
    #line(length: 100%, stroke: .8pt + gold)
    #v(5pt)
    #grid(columns: (24pt, 1fr, auto), gutter: 6pt,
      diamond(tier),
      block[#heading(level: 3, outlined: true, title)#label(key)],
      align(right, icons))
    #text(size: 8pt, fill: forest, req)
    #v(4pt)
    #text(size: 8.7pt, weight: "bold")[#action · #attr]
    #linebreak()
    #text(size: 8pt)[#tags #h(3pt)·#h(3pt) #price]
  ]
  #body]
  layout(size => {
    let height = measure(block(width: size.width, whole)).height
    [#metadata((key: key, height: height / 1pt)) <card-size>]
    block(breakable: height > 675pt, whole)
  })
}
#let form-field(title, height: 30pt) = block(width: 100%, height: height, stroke: .5pt + gold, inset: 5pt)[#text(size: 8pt, weight: "bold", title)]
#let sheet-page(title, body) = {
  pagebreak(weak: true)
  set page(fill: white)
  heading(level: 2, title)
  body
  pagebreak()
}

#let form-table(cols, head, rows) = {
  set text(size: 8pt)
  table(columns: (1fr,) * cols, rows: (auto,) + (17pt,) * rows.len(), inset: 4pt,
    stroke: .4pt + rgb("#a69c83"), fill: (x,y) => if y == 0 { ivory } else { white },
    table.header(..head.map(c => strong(c))), ..rows.flatten())
}
