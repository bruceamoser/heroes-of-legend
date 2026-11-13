#let data = json("catalog.json")
#let ink = rgb("20352e")
#let gold = rgb("a58448")
#let shades = (rgb("e4eee2"), rgb("e0eaf1"), rgb("ece2f0"), rgb("f2e3c4"))
#set document(title: "Elements - Four Tomes of Magic", author: "Bruce A. Moser")
#set page(width: 612pt, height: 792pt, margin: (x: 35pt, y: 30pt), fill: rgb("faf7ef"))
#set text(font: "EB Garamond", size: 10pt, fill: ink)
#set par(leading: .25em, spacing: 4pt)
#let books = (
 ("flame", "Vexilar’s Tome of", "Fire & Catastrophe", ("Kindling", "Stoke the Furnace", "Command the Inferno", "Heart of the Furnace")),
 ("water", "Ysella’s Treatise on", "Tides & Winter", ("First Thaw", "Keeper of Currents", "Deepwater Secrets", "Winter’s Dominion")),
 ("earth", "Ormund’s Codex of", "Stone & Deep Places", ("Earthen Lore", "Fault & Fissure", "The Patient Stone", "Deep Foundations")),
 ("air", "Zephyra’s Almanac of", "Winds & Thunder", ("A Whisper of Air", "Gathering Winds", "Stormcalling", "Voice of the Tempest")),
)
#let tome(spec) = {
 let (id, author, name, unlocks) = spec
 let l = data.lists.find(l=>l.id==id)
 block(width: 100%, stroke: .6pt + gold, inset: 10pt)[
  #align(center)[
   #text(size: 9pt, style: "italic", author) \
   #text(font: "Cinzel", size: 14pt, weight: "bold", name) \
   #text(size: 8pt, tracking: .5pt)[ELEMENTS · #upper(l.name)]
  ]
  #v(5pt)
  #table(
   columns: (22pt, 1fr, 25pt, 23pt),
   inset: (x: 4pt, y: 2.5pt), stroke: none,
   fill: (x,y) => if y==0 {ink} else {let i = y - 1; shades.at(if i < 8 {calc.floor(i/2)} else {3})},
   table.header(..("Page", "Spell", "SP", "Sect.").map(t=>text(size: 8pt, fill: white, weight: "bold", t))),
   ..(l.spells + l.advanced).enumerate().map(((i,s))=>(
    text(size: 9pt, if i < 8 {str(s.page)} else {"A"+str(s.page)}),
    text(size: 10pt, s.name),
    text(size: 9pt, str(s.sp)),
    text(size: 8pt, ("I", "II", "III", "IV").at(if i < 8 {calc.floor(i/2)} else {3})),
   )).flatten()
  )
  #v(5pt)
  #text(size: 8pt, weight: "bold")[LEARNED SECTIONS  I → II → III → IV]
  #v(2pt)
  #for i in range(4) {
   grid(columns: (18pt, 1fr, 26pt), gutter: 3pt,
    block(fill: shades.at(i), width: 18pt, inset: 1pt, align(center,text(size: 8pt, ("I","II","III","IV").at(i)))),
    text(size: 9pt, unlocks.at(i) + if i==3 {" · L3"} else {""}),
    align(right,text(size: 9pt, str((1,2,2,3).at(i))+" DP")))
  }
  #v(3pt)
  #text(size: 8pt)[*IV teaches pages 7–8 and all three advanced pages (A1–A3).*]
 ]
}
#text(font: "Cinzel", size: 8pt, tracking: 1pt)[HEROES OF LEGEND #h(1fr) SPELLBOOKS]
#v(8pt)
#align(center)[#text(font: "Cinzel", size: 25pt)[The Elemental Library] \
#text(size: 10pt, style: "italic")[Four paths into the secrets of fire, water, earth and air.]]
#v(8pt)
#grid(columns: (1fr,1fr), gutter: 12pt, ..books.map(b=>tome(b)))
#v(7pt)
#line(length: 100%, stroke: .5pt + gold)
#text(size: 9pt)[*Begin with Elements (1 DP).* It opens all four lists; it teaches no spells. Learn each tome’s sections in order. Row colors and section numbers show which spells you learn together. *SP* is the casting cost; page 1 costs 0 SP. *L3* requires character level 3.]
