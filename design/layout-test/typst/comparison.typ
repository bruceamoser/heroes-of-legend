// Same content, geometry and fonts as the DesignCraft sample.
// The final two pages use native Typst document flow.
#let data = json("sample.json")
#let palette = (
  Forest: rgb("#0e1714"), Panel: rgb("#15221c"), Gold: rgb("#c9a766"),
  Ivory: rgb("#f1e6ce"), Ink: rgb("#28251c"), Parchment: rgb("#e2d6b8"),
  "[Black]": black, "[Paper]": white, "[None]": none,
)
#let color(name) = palette.at(name)
#let styled(value, name) = {
  let s = data.styles.at(name)
  set text(font: s.chars.fontFamily, size: s.chars.size * 1pt,
    fill: color(s.chars.fill), top-edge: "ascender", bottom-edge: "descender")
  set par(leading: 0.28em, spacing: 3pt, justify: false)
  set text(hyphenate: false)
  for (i, p) in value.split("\n").enumerate() {
    if i > 0 { parbreak() }
    if p == "" { v(0.6em) } else { text(p) }
  }
}
#let draw(items, check: true) = {
  for it in items {
    if it.kind == "text" {
      place(top + left, dx: it.x * 1pt, dy: it.y * 1pt,
        block(width: it.w * 1pt)[#styled(it.text, it.style)])
      if check {
        context {
          let m = measure(block(width: it.w * 1pt)[#styled(it.text, it.style)])
          [#metadata((text: it.text.slice(0, calc.min(40,it.text.len())), height: m.height / 1pt, limit: it.h, overflow: m.height > it.h * 1pt)) <frame-check>]
        }
      }
    } else if it.kind == "graphic" {
      place(top + left, dx: it.x * 1pt, dy: it.y * 1pt,
        image("library-art.png", width: it.w * 1pt, height: it.h * 1pt, fit: "cover"))
    } else {
      place(top + left, dx: it.x * 1pt, dy: it.y * 1pt,
        rect(width: it.w * 1pt, height: it.h * 1pt, fill: color(it.fill),
          stroke: if color(it.stroke) == none { none } else { it.weight * 1pt + color(it.stroke) }))
    }
  }
}
#set document(title: "Heroes of Legend — Great Library Typst comparison", author: "Bruce A. Moser")
#set page(width: 612pt, height: 792pt, margin: 0pt)
#for i in range(4) {
  if i > 0 { pagebreak() }
  draw(data.pages.at(i))
}
#pagebreak()
#set page(margin: (top: 122pt, bottom: 70pt, left: 42pt, right: 42pt),
  background: context {
    let n = counter(page).get().first()
    draw(data.pages.at(if n == 5 { 4 } else { 5 }), check: false)
  })
#styled(data.flow.text, data.flow.style)
