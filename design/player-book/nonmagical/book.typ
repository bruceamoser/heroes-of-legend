#let ink = rgb("20352e")
#let gold = rgb("a58448")
#let shades = (rgb("e4eee2"),rgb("e0eaf1"),rgb("ece2f0"),rgb("f2e3c4"))
#set document(title: "Heroes of Legend - Nonmagical Disciplines", author: "Bruce A. Moser")
#set page(width: 612pt,height: 792pt,margin: (left: 35pt,right: 35pt,top: 40pt,bottom: 32pt),fill: rgb("faf7ef"),
 header: [#text(font: "Cinzel",size: 8pt,tracking: .7pt,fill: ink)[HEROES OF LEGEND #h(1fr) DISCIPLINES]],
 footer: context [#line(length: 100%,stroke: .5pt + gold) #text(size: 8pt)[Development review #h(1fr) #counter(page).display()]] )
#set text(font: "EB Garamond",size: 10pt,fill: ink)
#set par(leading: .3em,spacing: 5pt)
#show heading: set text(font: "Cinzel")
#show heading.where(level: 1): set text(size: 24pt)
#for item in json("procedures.json") {
 if item.kind=="page" {pagebreak(weak: true); heading(level: 1,item.text)}
 else if item.kind=="heading" {heading(level: 2,item.text)}
 else {block(above: 6pt,below: 6pt,item.text)}
}
#let path(p) = block(width: 100%,inset: 9pt,stroke: .6pt + gold,breakable: false)[
 #text(font: "Cinzel",size: 16pt,weight: "bold",p.name)
 #v(5pt)
 #for (i,e) in p.entries.enumerate() {
  block(width: 100%,fill: shades.at(i),inset: (x: 6pt,y: 5pt),above: 0pt,below: 3pt)[
   #grid(columns: (1fr,28pt),gutter: 2pt,
    text(size: 10pt,weight: "bold",e.name),
    align(right,text(size: 9pt,str(e.dp)+" DP")))
   #if e.level==3 {text(size: 8pt,weight: "bold")[LEVEL 3]}
   #v(2pt)
   #text(size: 10pt,e.effect)
  ]
 }
]
#for d in json("generated.json") {
 pagebreak()
 heading(level: 1,d.name)
 text(size: 11pt,style: "italic",d.theme)
 v(5pt)
 text(size: 10pt,d.intro)
 v(7pt)
 grid(columns: (1fr,1fr),gutter: 12pt,..d.paths.map(path))
}
