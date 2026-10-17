#import "template.typ": *
#show: setup
#let release = json("../../release/version.json")
#{
 set page(width:612pt,height:792pt,margin:0pt,fill:black,header:none,footer:none)
 include "cover.typ"
 pagebreak()
}
#set document(title:"Heroes of Legend — Dungeon Architect’s Guide & Bestiary",author:"Bruce A. Moser")
#align(center)[
 #v(35pt)
 #text(font:"Almendra",size:34pt,weight:"bold")[Heroes of Legend]
 #v(18pt)
 #text(font:"Cinzel",size:23pt)[Dungeon Architect’s Guide]
 #v(8pt)
 #text(font:"Cinzel",size:23pt)[& Bestiary]
 #v(16pt)
 #text(size:13pt)[A world-agnostic companion for levels 1–10]
 #v(20pt)
 #text(font:"Cinzel",size:14pt)[Game design by Bruce A. Moser]
]
#v(30pt)
#note[
 Prepare adventures, make confident rulings, and bring the world to life. This book
 contains guidance for the Dungeon Architect, an introductory rescue adventure,
 hazards, campaign tools, and the complete core bestiary.

 Use it alongside the Player’s Book. Creature and encounter CV values remain
 playtest estimates; the budgets do not guarantee a particular difficulty or duration.
]
#v(16pt)
#text(size:9pt)[Starter Kit v#release.version · #release.date

 Based on the approved Heroes of Legend design workspace. Manuscript and layout
 prepared with Codex under Bruce’s direction. AI-assisted illustrations combine
 the approved visual library with new creature portraits; maps and rules diagrams are original
 editable vector artwork. This digital playtest edition is not a print-production release.]
#pagebreak()
#outline(title:[Contents],depth:1)
#pagebreak()
#include "generated/body.typ"
