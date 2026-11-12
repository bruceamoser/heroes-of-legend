#let data = json("catalog.json")
#let forest = rgb("15221c")
#let gold = rgb("b39253")
#let paper = rgb("f7f3e9")
#set document(title: "The Forge - Spellbook Layout", author: "Bruce A. Moser")
#set page(width: 612pt, height: 792pt, margin: (x: 40pt, y: 44pt), fill: paper,
 header: [#text(font: "Cinzel", size: 8pt, fill: forest)[HEROES OF LEGEND #h(1fr) THE FORGE] #line(length: 100%, stroke: .5pt + gold)],
 footer: context [#line(length: 100%, stroke: .5pt + gold) #text(size: 8pt)[Spellbook layout study #h(1fr) #counter(page).display()]] )
#set text(font: "EB Garamond", size: 11pt, fill: forest)
#set par(leading: .4em)
#show heading: set text(font: "Cinzel", fill: forest)
#let title(kicker, name) = [#text(size: 9pt, fill: gold, weight: "bold", kicker) #v(3pt) #text(font: "Cinzel", size: 25pt, name) #v(7pt) #line(length: 100%, stroke: 1pt + gold) #v(8pt)]
#let box(body) = block(width: 100%, inset: 12pt, fill: rgb("ece4d2"), stroke: (left: 2pt + gold), body)
#title("DEVELOPMENT", "Assembling your spellbook")
You learn magic a few pages at a time. Choose a discipline, open one of its four spellbooks, and follow that book’s connected purchase steps. Every spell you learn remains available as your collection grows.

= Follow the binding
#box[
*Discipline: 1 DP* → *Pages 1–2: 1 DP* → *Pages 3–4: 2 DP* → *Pages 5–6: 2 DP* → *Capstone: 3 DP, level 3*

The capstone teaches pages 7–8 and all three pages of its named advanced book immediately.
]

Buy the discipline once to open its four branches. This purchase teaches no spells. Each branch begins independently at its first purchase; later purchases require the preceding purchase in that same branch. You may spend DP in the Forge during both level-0 and level-1 development.

*DP buys learning. SP pays for casting.* Page 1 of each spellbook costs 0 SP to cast. A page number identifies a spell’s position in its book; it is neither a character level nor a spell slot.

= Four books, one discipline
#grid(columns: (1fr, 1fr), gutter: 12pt,
 box[*Flame* \ Heat, ignition and controlled fire. \ Spell list: page 2.],
 box[*Water* \ Currents, freezing and thawing. \ Spell list: page 2.],
 box[*Earth* \ Stone, excavation and reinforcement. \ Spell list: page 3.],
 box[*Air* \ Wind, sound and lightning. \ Spell list: page 3.])

= Where the branches meet
Completing a capstone may satisfy one prerequisite for a confluence. Buy every named endpoint connected to that confluence, reach level 7, and pay its DP cost. Having the disciplines alone is insufficient. Tier II, III and IV describe the number of disciplines meeting there; all three tiers require level 7.

#box[*Example:* Opening Elements and learning Flame pages 1–6 costs 6 DP in total. At level 3, another 3 DP teaches Flame pages 7–8 and all three Heart of the Furnace spells. Meteor Swarm also requires the Telekinesis capstone, level 7 and a separate 3 DP purchase.]
#v(1fr)
#text(size: 9pt)[Reading this study: the following lists retain the Magic Forge’s spell selections and SP costs. They are learning references; complete casting profiles belong in the spell descriptions.]
#let row(s, advanced: false) = block(above: 4pt, below: 4pt)[
 #grid(columns: (20pt, 1fr, 29pt), gutter: 4pt,
 text(size: 10pt, fill: gold, weight: "bold", if advanced {"A" + str(s.page)} else {str(s.page)}),
 text(size: 11pt, weight: "bold", s.name),
 align(right, text(size: 9pt, str(s.sp) + " SP")))
]
#let book(id) = {
 let l = data.lists.find(l => l.id == id)
 [#text(font: "Cinzel", size: 21pt, l.name) #v(2pt) #text(size: 10pt, l.theme) #v(9pt)]
 for i in range(4) {
  let n = data.nodes.find(n => n.id == id + ":" + str(i))
  block(width: 100%, inset: (left: 10pt, right: 8pt, top: 7pt, bottom: 7pt), stroke: (left: 1.5pt + gold), fill: if i == 3 {rgb("ece4d2")} else {none})[
   #grid(columns: (1fr, auto),
    text(size: 10pt, weight: "bold", "○  " + if i == 3 {"CAPSTONE · LEVEL 3"} else {"PURCHASE " + str(i + 1)}),
    text(size: 10pt, weight: "bold", str(n.cost) + " DP"))
   #text(size: 9pt)[Requires #if i == 0 {[Elements]} else {[purchase #i in this book]}]
   #v(3pt)
   #for s in l.spells.slice(i*2, i*2+2) {row(s)}
   #if i == 3 {
    line(length: 100%, stroke: .5pt + gold)
    v(5pt)
    text(size: 11pt, weight: "bold", l.advancedName)
    [\ #text(size: 9pt)[All three advanced pages learned with this purchase.]]
    for s in l.advanced {row(s, advanced: true)}
   }
  ]
  if i < 3 {align(left, [#h(7pt)#text(fill: gold)[↓]])}
 }
 v(9pt)
 let cs = data.confluences.filter(c => c.contacts.contains(id))
 text(size: 10pt, weight: "bold", "CONNECTED CONFLUENCES")
 [\ #text(size: 10pt, if cs.len() == 0 {"No outgoing confluence in this atlas."} else {cs.map(c=>c.name).join("; ") + ". See page 4."})]
}
#pagebreak()
#title("ELEMENTS · FOUR CONNECTED BRANCHES", "Fire & water")
#text(size: 10pt)[Enter either list from Elements. Read downward; each arrow is a required purchase.]
#v(12pt)
#grid(columns: (1fr, 1fr), gutter: 24pt, [#book("flame")], [#book("water")])
#pagebreak()
#title("ELEMENTS · FOUR CONNECTED BRANCHES", "Stone & sky")
#text(size: 10pt)[The shaded capstone includes the final two pages and the complete advanced book.]
#v(12pt)
#grid(columns: (1fr, 1fr), gutter: 24pt, [#book("earth")], [#book("air")])
#pagebreak()
#title("BEYOND THE BRANCHES", "Confluences")
Every endpoint below is required. These are connections from the Elements branches shown on pages 2–3. Each confluence is a separate purchase at level 7.
#for c in data.confluences.filter(c=>c.contacts.any(id=>("flame","water","earth","air").contains(id))) {
 block(above: 12pt, below: 8pt, width: 100%, inset: 12pt, stroke: .6pt + gold)[
  #text(font: "Cinzel", size: 14pt, c.name)
  \ #text(size: 10pt, weight: "bold")[TIER #("II", "III", "IV").at(c.contacts.len()-2) · LEVEL 7 · #c.cost DP]
  #v(6pt)
  #text(size: 10pt, weight: "bold")[REQUIRES ALL OF THESE CAPSTONES]
  #for id in c.contacts {
   let l = data.lists.find(l=>l.id==id)
   let d = data.disciplines.find(d=>d.id==l.discipline)
   [\ #d.name / #l.name / #l.advancedName]
  }
 ]
}
#v(1fr)
#text(size: 9pt)[The full catalog will place spell casting profiles after the learning lists, with page references from each spell entry. This study demonstrates list grouping and prerequisite connections; it does not change spell effects.]
