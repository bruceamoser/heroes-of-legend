#import "../template.typ": setup, forest, gold, ivory, ink, catalog-card, discipline-mark, reading-columns, pageref, xref
#show: setup
// The standalone review uses the real book style, without its full-book art map.
#set page(background: none)
#set document(title: "Heroes of Legend - Nonmagical Disciplines", author: "Bruce A. Moser")
#let prose = json("procedures.json")
#let starts = prose.enumerate().filter(((i,item)) => item.kind == "page").map(((i,item)) => i)
#for (j,start) in starts.enumerate() {
 pagebreak(weak: true)
 heading(level: 1,prose.at(start).text)
 let end = if j+1 < starts.len() {starts.at(j+1)} else {prose.len()}
 let items = prose.slice(start+1,end).map(item => if item.kind == "heading" {heading(level:2,item.text)} else {item.text})
 reading-columns(items)
}
#let path(p, discipline) = catalog-card(p.name,p.id,icons: discipline-mark(discipline,"",size:22pt))[
 #for (i,e) in p.entries.enumerate() {
  if i > 0 {v(5pt); line(length:100%,stroke:.4pt+gold); v(5pt)}
  grid(columns: (1fr,auto),gutter:5pt,
   text(size:10.5pt,weight:"bold",fill:forest,e.name),
   text(size:8.5pt,str(e.dp)+" DP"))
  if e.level == 3 {text(size:8.5pt,weight:"bold")[Requires level 3]}
  v(3pt)
  text(e.effect)
 }

]
#for d in json("generated.json") {
 pagebreak()
 heading(level:1,d.name)
 text(size:11pt,style:"italic",d.theme)
 v(6pt)
 text(size:10pt,d.intro)
 v(5pt)
 reading-columns(d.paths.map(p=>path(p,d.id)))
}

#let combinations = json("combined.json")
#pagebreak()
#heading(level:1)[Combined disciplines]
#reading-columns(combinations.intro + (2,3,4).map(n=>block(breakable:false)[
 #heading(level:2)[#n disciplines · #(n+1) DP]
 #for c in combinations.abilities.filter(c=>c.count==n) {
  block(above:3pt,below:3pt)[#xref(c.id,c.name) #h(1fr) #pageref(c.id)]
 }
]))
#let combined-card(c) = catalog-card(c.name,c.id)[
 #text(size:9pt,weight:"bold")[Level 7 · #c.count disciplines · #c.dp DP]
 #if c.mixed {linebreak(); text(size:8.5pt,style:"italic")[Magic and nonmagical training]}
 #v(5pt)
 #text(weight:"bold")[Learn all of these first]
 #for p in c.parents {
  v(4pt)
  text(size:8.5pt)[#p.discipline / #p.branch]
  linebreak()
  xref(p.anchor,p.name); [ (p. #pageref(p.anchor))]
 }
 #v(5pt)#line(length:100%,stroke:.4pt+gold)#v(4pt)
 #text(c.effect)
]
#for count in (2,3,4) {
 pagebreak()
 heading(level:1, ("Two disciplines","Three disciplines","Four disciplines").at(count - 2))
 text(size:10pt,weight:"bold")[Level 7 · #(count+1) DP per ability]
 v(6pt)
 reading-columns(combinations.abilities.filter(c=>c.count==count).map(combined-card))
}

#pagebreak()
#heading(level:1)[From one path to many]
#text(size:10pt)[After learning the last ability in a path, use this index to find combinations that build on it. Follow each title to see the other abilities you’ll need at level 7.]
#v(8pt)
#let connections = ()
#for d in json("generated.json") {
 for p in d.paths.filter(p=>p.unlocks.len()>0) {
  connections.push(block(breakable:false,above:4pt,below:6pt)[
   #text(size:8.5pt)[#d.name / #p.name]
   \ #text(weight:"bold",p.entries.last().name) (p. #pageref(p.id))
   #for c in p.unlocks {linebreak(); xref(c.id,c.name); [ · p. #pageref(c.id)]}
  ])
 }
}
#reading-columns(connections)

#pagebreak()
#heading(level:1)[Final spellbook sections]
#text(size:10pt)[At level 3, learn a book’s final section after its first three. Each final section costs 3 DP and teaches pages 7–8 and A1–A3 together. Use this index to find combinations that build on those sections.]
#v(8pt)
#reading-columns(combinations.magic.map(m=>catalog-card(m.name,m.anchor)[
 #text(weight:"bold")[#m.discipline / #m.branch]
 \ #text(size:8.5pt)[Section IV]
 #v(5pt)
 *Pages 7–8:* #m.pages
 #v(4pt)
 *Advanced pages:* #m.advanced
 #v(5pt)
 #if combinations.abilities.any(c=>c.requires.contains(m.id)) {text(weight:"bold")[Further study at level 7:]}
 #for c in combinations.abilities.filter(c=>c.requires.contains(m.id)) {linebreak();xref(c.id,c.name);[ (p. #pageref(c.id))]}
]))
