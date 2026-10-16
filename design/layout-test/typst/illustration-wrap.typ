#import "@preview/wrap-it:0.1.1": wrap-content
#let sample = json("sample.json")
#let forest = rgb("#0e1714")
#let gold = rgb("#c9a766")
#let ivory = rgb("#f1e6ce")
#set document(title: "HOL — Illustration wrapping trial", author: "Bruce A. Moser")
#set page(width: 612pt, height: 792pt, margin: (x: 42pt, top: 65pt, bottom: 48pt), fill: ivory,
  header: text(font: "Cinzel", size: 8pt, fill: forest)[HEROES OF LEGEND / ILLUSTRATION TEST],
  footer: context align(right, text(font: "Cinzel", size: 8pt, counter(page).display("01"))))
#set text(font: "EB Garamond", size: 11pt, fill: forest, hyphenate: false)
#set par(leading: .35em, spacing: 8pt)
#let title(t) = block(below: 20pt)[#text(font: "Cinzel", size: 23pt, t)]
#let note(t) = block(fill: forest, inset: 12pt, width: 100%)[#text(fill: ivory, size: 10pt, t)]
#let art = block(width: 170pt, stroke: .6pt + gold, inset: 4pt)[
  #image("library-art.png", width: 160pt, height: 160pt, fit: "cover")
]
#let paras = sample.flow.text.split("\n").filter(p => p != "")
#let prose(ps) = { for p in ps { text(p); parbreak() } }
#let baseline = paras.slice(0, 7)
#title[An illustration beside the story]
#wrap-content(art, prose(baseline), align: top + left, column-gutter: 16pt)
#v(12pt)
#note[LEFT WRAP — The illustration occupies the left edge. Text flows beside it, then returns to the full measure below. This is actual package-driven wrapping; the paragraph was not split by hand.]

#pagebreak()
#title[The story grows]
#wrap-content(art, prose(paras.slice(0, 11)), align: top + right, column-gutter: 16pt)
#v(8pt)
#note[RIGHT WRAP / REVISION — The same opening text now has four additional paragraphs. The illustration is on the right. The text is reflowed by the same reusable layout.]

#pagebreak()
#title[A square, precisely placed]
#note[POSITION TEST — A square illustration begins 330 points from the left page edge and 245 points from the top. The neighboring text occupies an explicitly reserved column; arbitrary placement alone does not create automatic wrapping.]
#v(18pt)
#prose(paras.slice(0, 2))
#place(top + left, dx: 288pt, dy: 180pt, art)
#block(width: 265pt, height: 210pt)[
  #prose(paras.slice(2, 5))
]
#prose(paras.slice(5, 7))
