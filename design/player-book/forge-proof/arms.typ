#let ink = rgb("20352e")
#let gold = rgb("a58448")
#let shades = (rgb("e4eee2"),rgb("e0eaf1"),rgb("ece2f0"),rgb("f2e3c4"))
#set document(title: "Arms - Learned Abilities Layout", author: "Bruce A. Moser")
#set page(width: 612pt,height: 792pt,margin: (x: 35pt,y: 30pt),fill: rgb("faf7ef"))
#set text(font: "EB Garamond",size: 10pt,fill: ink)
#set par(leading: .3em,spacing: 4pt)
#let paths = (
 ("Bladework", "Make each opening count.", (
  ("Measured Cut", "Learn an attack that rewards a carefully placed strike."),
  ("Keen Edge", "Measured Cut deals additional damage."),
  ("Open the Wound", "Measured Cut also applies Bleeding on a Strong result."),
  ("Sweeping Blade", "Learn a new attack that strikes up to three nearby enemies.")),
  "Measured Cut retains its extra damage and gains Bleeding on Strong. Sweeping Blade is a separate learned attack."),
 ("Impact", "Drive your enemy out of position.", (
  ("Driving Blow", "Learn an attack that pushes its target on a Strong result."),
  ("Unyielding Force", "Driving Blow pushes its target farther."),
  ("Rattling Impact", "Driving Blow also applies Dazed on a Strong result."),
  ("Battering Stroke", "Learn a new attack that drives an enemy into another foe.")),
  "On Strong, Driving Blow applies its increased push and Dazed together. Battering Stroke is a separate learned attack."),
 ("Disruption", "Deny your opponent an easy escape.", (
  ("Hamstring", "Learn an attack that applies Slowed on a Strong result."),
  ("Hobbling Cut", "Hamstring applies additional Slowed."),
  ("Cruel Precision", "Hamstring also deals additional damage."),
  ("Pinning Strike", "Learn a new attack that holds an enemy in place.")),
  "Hamstring retains its increased Slowed and gains extra damage. Pinning Strike is a separate learned attack."),
 ("Dueling", "Turn a guarded exchange in your favor.", (
  ("Blade Ward", "Learn a reaction that reduces damage from a melee attack."),
  ("Sure Guard", "Blade Ward prevents additional damage."),
  ("Give Ground", "Blade Ward also lets you step away after defending."),
  ("Riposte", "Learn a new reaction that answers a melee attack with a strike.")),
  "Blade Ward combines its greater protection with the step away. Riposte is a separate reaction; it does not grant an extra reaction."),
)
#let path(p) = {
 let (name,theme,rows,summary) = p
 block(width: 100%,inset: 10pt,stroke: .6pt + gold)[
  #text(font: "Cinzel",size: 17pt,weight: "bold",name) \
  #text(size: 10pt,style: "italic",theme)
  #v(6pt)
  #text(size: 8pt,weight: "bold")[LEARNED ABILITIES  I → II → III → IV]
  #v(4pt)
  #for (i,row) in rows.enumerate() {
   block(width: 100%,fill: shades.at(i),inset: (x: 6pt,y: 6pt))[
    #grid(columns: (16pt,1fr,28pt),gutter: 2pt,
     text(size: 9pt,("I","II","III","IV").at(i)),
     text(size: 10pt,weight: "bold",row.at(0)),
     align(right,text(size: 9pt,str((1,2,2,3).at(i))+" DP")))
    #if i==3 {text(size: 8pt,weight: "bold")[NEW ABILITY · LEVEL 3]} else if i>0 {text(size: 8pt)[IMPROVES #upper(rows.at(0).at(0))]} else {text(size: 8pt)[LEARN A TECHNIQUE]}
    \ #text(size: 10pt,row.at(1))
   ]
  }
  #v(6pt)
  #text(size: 9pt,weight: "bold")[AFTER LEARNING ALL FOUR]
  \ #text(size: 9pt,summary)
 ]
}
#text(font: "Cinzel",size: 8pt,tracking: 1pt)[HEROES OF LEGEND #h(1fr) DISCIPLINES]
#v(7pt)
#text(font: "Cinzel",size: 27pt)[Arms]
#text(size: 11pt,style: "italic")[Distance, timing and the practiced turn of a weapon.]
#v(5pt)
*Begin with Arms (1 DP).* It opens these four paths; it teaches no ability. Your basic melee attack is already available. Learn each path’s abilities in order. Improvements remain in effect together; they do not require a choice each time you attack.
#v(8pt)
#grid(columns: (1fr,1fr),gutter: 12pt,..paths.map(path))
#v(7pt)
#line(length: 100%,stroke: .5pt + gold)
#text(size: 8pt)[Layout study · Proposed Arms examples. These summaries demonstrate learning and improvement; complete ability rules supply actions, ranges, result effects and limits.]
