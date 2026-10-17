#import "template.typ": *
#let strip(title) = block(width:100%,fill:forest,inset:(x:6pt,y:4pt),above:6pt,below:4pt)[#text(font:"Cinzel",size:9pt,fill:ivory,weight:"bold",title)]
#let field(title,height:26pt) = block(width:100%,height:height,inset:5pt,stroke:.5pt+gold,radius:3pt,breakable:false)[#text(size:7.5pt,weight:"bold",title)]
#let ruled(title,n:3) = [#strip(title)#for i in range(n){v(13pt);line(length:100%,stroke:.3pt+rgb("#b9b2a2"))}]
#let score(title) = block(width:100%,height:58pt,stroke:.8pt+forest,radius:5pt,inset:4pt)[
  #align(center)[#text(font:"Cinzel",size:8pt,weight:"bold",title)#v(5pt)#circle(width:32pt,stroke:.6pt+gold)]
]
#let rows(head,widths,count,height:18pt) = {
  set text(size:8pt)
  table(columns:widths,rows:(auto,)+(height,)*count,inset:4pt,stroke:.35pt+rgb("#aaa28f"),
    table.header(..head.map(h=>table.cell(fill:ivory,strong(h)))),
    ..range(count*head.len()).map(i=>[]))
}
#let sheet-title(subtitle) = grid(columns:(45pt,1fr,110pt),gutter:10pt,
 image("art/hol-crest-v2.png",height:50pt),
 [#text(font:"Almendra",size:25pt,weight:"bold")[Heroes of Legend]#linebreak()#text(font:"Cinzel",size:10pt,subtitle)],
 [#field("LEVEL",height:25pt)#v(3pt)#field("PLAYER",height:25pt)])
#let page-sheet(body) = {
 pagebreak(weak:true)
 set page(fill:white,header:none,footer:context align(right,text(size:8pt,counter(page).display())),margin:(left:36pt,right:36pt,top:30pt,bottom:35pt))
 set text(size:9pt)
 set par(leading:.25em,spacing:3pt)
 body
 pagebreak()
}
#page-sheet([
 #sheet-title("Hero & encounter")
 #v(8pt)
 #grid(columns:(2fr,1fr,1fr),gutter:6pt,field("CHARACTER NAME / PRONOUNS",height:32pt),field("ANCESTRY",height:32pt),field("CLASS",height:32pt))
 #v(6pt)#grid(columns:(1fr,1fr),gutter:6pt,field("CULTURE"),field("BACKGROUND"))
 #v(10pt)#grid(columns:(1fr,)*6,gutter:7pt,..("Brawn","Fortitude","Agility","Guile","Knowledge","Reason").map(score))
 #strip("Keep fighting")
 #grid(columns:(2fr,1fr,1fr),gutter:7pt,
  field("HP: CURRENT                         MAXIMUM",height:42pt),
  field("GRIT: CURRENT / TOTAL GRANTED",height:42pt),
  field("SCARS / DEATH MARKS",height:42pt))
 #v(6pt)#grid(columns:(1fr,1fr,1fr),gutter:7pt,field("SPEED (SQUARES)"),field("STABILITY"),field("BULK / CAPACITY"))
 #strip("Protection & preparation")
 #grid(columns:(1fr,1fr),gutter:7pt,field("RESISTANCES (HIGHEST OF EACH TYPE; CAP 3)",height:38pt),field("LEFT HAND / RIGHT HAND",height:38pt))
 #strip("Your turn")
 #text(size:9pt)[Main Action → Maneuver → movement. Reaction refreshes at turn start.]
 #rows(([ABILITY / ACTION],[COST],[ROLL],[OUTCOMES / RANGE / PAGE]),(1.3fr,50pt,55pt,2fr),6,height:20pt)
 #strip("Conditions in play")
 #rows(([CONDITION],[RATING],[EXPIRY / REMOVAL / SOURCE]),(1fr,50pt,2fr),3,height:20pt)
 #v(6pt)#field("ACCESSIBLE POTION / SUPPLY DICE / OTHER TURN NOTES",height:35pt)
 #v(8pt)#block(inset:7pt,stroke:.5pt+gold)[
  #strong[3d6 + attribute] · Weak ≤8 · Standard 9–14 · Strong ≥15. Cancel Boons/Banes, then keep best/worst three of up to six dice.
  End turn: resolve temporary conditions, then decay 1. Minimum damage: 1 total per damaging event.
 ]
])
#page-sheet([
 #sheet-title("Training & abilities")
 #v(8pt)#grid(columns:(2fr,1fr),gutter:7pt,field("CHARACTER NAME"),field("SAVED DP"))
 #strip("Disciplines")
 #rows(([DISCIPLINE],[RANK],[AFFINITY],[DP PAID / GRANT]),(2fr,40pt,1fr,1.5fr),10,height:17pt)
 #strip("Learned abilities & class signatures")
 #rows(([ABILITY],[TIER],[ACTION],[REQUIREMENTS / PAGE]),(2fr,35pt,70pt,1.5fr),14,height:16pt)
 #strip("Ancestry traits & other lasting benefits")
 #rows(([TRAIT / SOURCE],[BENEFIT / LIMIT]),(1fr,2fr),3,height:19pt)
 #v(5pt)#field("LANGUAGES / SPOKEN-ONLY OR OTHER LIMITS",height:30pt)
 #v(8pt)#text(size:8.5pt)[All learned cards are available. Keep frequently used cards beside the encounter sheet. Rank requirements must be owned before purchase; buy ranks in order.]
])
#page-sheet([
 #sheet-title("Belongings & scars")
 #v(8pt)#grid(columns:(2fr,1fr,1fr),gutter:7pt,field("CHARACTER NAME"),field("COINS"),field("BULK / CAPACITY"))
 #strip("Carried equipment")
 #rows(([ITEM / SUPPLY],[BULK],[DIE],[LOCATION / SPECIAL EFFECT]),(1.7fr,35pt,35pt,1.8fr),14,height:18pt)
 #v(5pt)#text(size:8.5pt)[Capacity = 10 + 3 × Brawn. Speed loses 1 per excess Bulk. Inventory: d20 → d12 → d10 → d8 → d6 → d4 → out. After use, a 1 steps down.]
 #strip("Recipes, tools & materials")
 #rows(([RECIPE / PERMISSION],[TOOLS / MATERIALS / PROJECT PROGRESS]),(1fr,1.6fr),5,height:18pt)
 #strip("Wounds & permanent scars")
 #rows(([WOUND / SCAR],[LASTING EFFECT],[TREATMENT / RV],[PROGRESS / LAST DAY]),(1.2fr,1.4fr,1.2fr,1fr),5,height:22pt)
 #v(7pt)#text(size:8.5pt)[One treatment attempt per wound per day. Weak/Standard/Strong gives 1/2/3 recovery progress. Treatment removes the stated penalty; the scar still counts on future wound rolls.]
])
#page-sheet([
 #sheet-title("Creation ledger")
 #v(8pt)#field("CHARACTER NAME / CONCEPT",height:36pt)
 #strip("Level 0 — before your class")
 #text(size:9pt)[10 + Knowledge + Reason + Guile + duplicate-grant DP. No discipline purchases.]
 #v(6pt)#grid(columns:(1fr,1fr,1fr),gutter:6pt,field("BASE + MENTAL ATTRIBUTES"),field("DUPLICATE DP"),field("TOTAL POOL"))
 #v(6pt)#rows(([GRANT / PURCHASE],[REQUIREMENTS MET],[DP ±],[LEFT]),(2fr,1.5fr,55pt,45pt),10,height:17pt)
 #v(6pt)#grid(columns:(1fr,1fr),gutter:6pt,field("SPENT"),field("UNSPENT DP EXPIRES — CLOSE AT 0"))
 #strip("Level 1 — choose your class")
 #text(size:9pt)[New 10 + Knowledge + Reason + Guile + duplicate-grant DP. Apply class discipline prices.]
 #v(6pt)#grid(columns:(1fr,1fr,1fr),gutter:6pt,field("BASE + MENTAL ATTRIBUTES"),field("DUPLICATE DP"),field("TOTAL POOL"))
 #v(6pt)#rows(([GRANT / PURCHASE],[REQUIREMENTS MET],[DP ±],[LEFT]),(2fr,1.5fr,55pt,45pt),10,height:17pt)
 #v(6pt)#grid(columns:(1fr,1fr),gutter:6pt,field("SPENT"),field("UNSPENT DP EXPIRES — CLOSE AT 0"))
 #v(9pt)#text(size:9pt)[Finish: record HP, Grit, Speed and capacity; resolve equipment grants once; add starting coins and shop. Levels 2–10 grant 8 + new level DP, which may be saved and spent in a safe place.]
])
