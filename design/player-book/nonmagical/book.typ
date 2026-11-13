#import "../template.typ": setup, forest, gold, ivory, ink, catalog-card, discipline-mark, reading-columns
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
