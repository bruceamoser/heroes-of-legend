#let gold = rgb("#c9a766")
#let ivory = rgb("#f1e6ce")
#set document(title: "Heroes of Legend — Player's Book cover proof", author: "Bruce A. Moser")
#set page(width: 612pt, height: 792pt, margin: 0pt, fill: black)
#place(top + left, image("art/cover-ruins-v2.png", width: 612pt, height: 792pt, fit: "cover"))
// Native type remains editable and sharp in the PDF.
#let title = text(font: "Almendra", weight: "bold", size: 48pt, tracking: .005em, fill: ivory)[Heroes of Legend]
#place(top + left, dx: 25pt, dy: 42pt, align(center, block(width: 562pt)[#title]))
#place(top + left, dx: 226pt, dy: 136pt, image("art/hol-crest-v2.png", width: 218pt))
#place(top + left, dx: 190pt, dy: 396pt, block(width: 292pt)[
  #set align(center)
  #text(font: "Cinzel", size: 15pt, fill: gold, tracking: .12em)[PLAYER’S BOOK]
])
#place(top + left, dx: 280pt, dy: 430pt, line(length: 112pt, stroke: .6pt + gold))
#place(top + left, dx: 190pt, dy: 445pt, block(width: 292pt)[
  #set align(center)
  #text(font: "EB Garamond", size: 11pt, fill: ivory)[Levels 1–10 • Playtest Edition]
])
#place(bottom + center, dy: -14pt, block(fill: black.transparentize(25%), inset: (x: 12pt, y: 5pt))[
  #text(font: "Cinzel", size: 9pt, fill: ivory, tracking: .12em)[BRUCE A. MOSER]
])
