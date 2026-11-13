#let ink = rgb("20352e")
#let gold = rgb("a58448")
#let shades = (rgb("e4eee2"),rgb("e0eaf1"),rgb("ece2f0"),rgb("f2e3c4"))
#set document(title: "Arms - Learned Abilities Layout", author: "Bruce A. Moser")
#set page(width: 612pt,height: 792pt,margin: (x: 35pt,y: 30pt),fill: rgb("faf7ef"))
#set text(font: "EB Garamond",size: 10pt,fill: ink)
#set par(leading: .3em,spacing: 4pt)
#let paths = (
 ("Bladework", "Make each opening count.", (
  ("Measured Cut I", "Main Action · Brawn. Attack one adjacent creature for 2/3/5 physical damage. On Strong, you may move 1 square after the attack."),
  ("Measured Cut II", "Measured Cut deals +1 damage on every result: 3/4/6 physical damage."),
  ("Measured Cut III", "Measured Cut also applies Bleeding 1 on Strong."),
  ("Sweeping Blade", "Main Action · Brawn. Attack up to three adjacent enemies. Roll once; each takes 1/2/4 physical damage. Measured Cut improvements do not apply.")),
  "Measured Cut retains its extra damage and gains Bleeding on Strong. Sweeping Blade is a separate learned attack."),
 ("Impact", "Drive your enemy out of position.", (
  ("Driving Blow I", "Main Action · Brawn. Attack one adjacent creature for 2/3/5 physical damage. On Strong, push it 1 square directly away from you."),
  ("Driving Blow II", "Driving Blow pushes 2 squares instead of 1 on Strong."),
  ("Driving Blow III", "Driving Blow also applies Dazed 1 on Strong, whether or not the target can be pushed."),
  ("Battering Stroke", "Main Action · Brawn. Deal 2/3/5 physical damage to one adjacent creature; push it up to 2 squares. If another creature blocks that push, both take 1 physical damage and the push ends.")),
  "On Strong, Driving Blow applies its increased push and Dazed together. Battering Stroke is a separate learned attack."),
 ("Disruption", "Deny your opponent an easy escape.", (
  ("Hamstring I", "Main Action · Brawn. Attack one adjacent creature for 2/3/5 physical damage. On Strong, apply Slowed 1."),
  ("Hamstring II", "Hamstring applies Slowed 2 instead of Slowed 1 on Strong."),
  ("Hamstring III", "Hamstring deals +1 damage on every result: 3/4/6 physical damage."),
  ("Pinning Strike", "Main Action · Brawn. Attack one adjacent creature for 2/3/5 physical damage. On Strong, its movement is 0 until the end of its next turn. Forced movement still affects it.")),
  "Hamstring retains its increased Slowed and gains extra damage. Pinning Strike is a separate learned attack."),
 ("Dueling", "Turn a guarded exchange in your favor.", (
  ("Blade Ward I", "Reaction · After resolving your melee defense roll, before taking damage: reduce that attack’s damage by 2, minimum 0. No additional roll."),
  ("Blade Ward II", "Blade Ward reduces damage by 3 instead of 2."),
  ("Blade Ward III", "After Blade Ward resolves, you may move 1 square. This movement does not trigger reactions."),
  ("Riposte", "Reaction · After resolving a melee attack against you, attack its source if adjacent. Roll Brawn for 2/3/5 physical damage. You must still have your reaction available.")),
  "Blade Ward combines its greater protection with the step away. Riposte is a separate reaction; it does not grant an extra reaction."),
)
#let path(p) = {
 let (name,theme,rows,summary) = p
 block(width: 100%,inset: 10pt,stroke: .6pt + gold)[
  #text(font: "Cinzel",size: 17pt,weight: "bold",name) \
  #text(size: 10pt,style: "italic",theme)
  #v(6pt)
  #for (i,row) in rows.enumerate() {
   block(width: 100%,fill: shades.at(i),inset: (x: 6pt,y: 6pt))[
    #grid(columns: (1fr,28pt),gutter: 2pt,
     text(size: 10pt,weight: "bold",row.at(0)),
     align(right,text(size: 9pt,str((1,2,2,3).at(i))+" DP")))
    #if i==3 {text(size: 8pt,weight: "bold")[LEVEL 3]}
    \ #text(size: 10pt,row.at(1))
   ]
  }
 ]
}
#text(font: "Cinzel",size: 8pt,tracking: 1pt)[HEROES OF LEGEND #h(1fr) DISCIPLINES]
#v(7pt)
#text(font: "Cinzel",size: 27pt)[Arms]
#text(size: 11pt,style: "italic")[Distance, timing and the practiced turn of a weapon.]
#v(5pt)
*Begin with Arms (1 DP).* It opens these four paths; it teaches no ability. Your basic melee attack is already available. Learn each path in order; improvements add together. Damage is listed Weak/Standard/Strong. All attacks require a melee weapon and deal instant damage. Conditions use normal decay. Forced movement stops at blocked squares. An improvement applies only to its named ability.
#v(8pt)
#grid(columns: (1fr,1fr),gutter: 12pt,..paths.map(path))
#v(7pt)
#line(length: 100%,stroke: .5pt + gold)
#text(size: 8pt)[Layout study · Arms mechanics shown for design review.]
