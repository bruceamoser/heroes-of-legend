#import "template.typ": *
#let sections = ("I","II","III","IV","V","VI","VII")
#let section-colors = (rgb("e4eee2"),rgb("e0eaf1"),rgb("ece2f0"),rgb("f2e3c4"),rgb("ead8c4"),rgb("dedbd0"),rgb("ead38e"))
#let spellbook(b) = catalog-card("Spell list",b.key,icons:discipline-mark(lower(b.Discipline),"",size:22pt))[
 #text(size:8.5pt,weight:"bold")[#b.Discipline / #b.List]
 #v(5pt)
 #table(columns:(23pt,1fr,23pt,22pt),inset:(x:3pt,y:2pt),stroke:none,
  fill:(x,y)=>if y==0 {forest} else {section-colors.at(sections.position(s=>s==b.rows.at(y - 1).at(3)))},
  table.header(..("No.","Spell","SP","Sect.").map(t=>text(size:8pt,fill:ivory,weight:"bold",t))),
  ..b.rows.map(r=>(text(size:9pt,r.at(0)),text(size:9pt)[#xref(b.spells.find(e=>e.page==r.at(0)).id,r.at(1))],text(size:9pt,r.at(2)),text(size:9pt,r.at(3)))).flatten())
 #v(5pt)
 #text(size:8.5pt,style:"italic")[IV · #b.Endpoint]
 #linebreak()
 #text(size:8.5pt,weight:"bold")[VII · #b.spells.last().name]
]
#let spell-entry(b,e) = catalog-card(e.name,e.id,icons:discipline-mark(lower(b.Discipline),"",size:22pt))[
 #let action-parts = e.action.split(" · ")
 #grid(columns:(1fr,auto),gutter:6pt,text(weight:"bold",action-parts.first()),text(weight:"bold",e.sp+" SP"))
 #if action-parts.len() > 1 { v(3pt); text(size:8.8pt, action-parts.slice(1).join(" · ")) }
 #v(3pt)
 #text(size:8.8pt)[*Section #e.section* · #if e.section == "VII" {[Level 7]} else if ("IV","V","VI").contains(e.section) {[Level 3]} else {[Level 1]} · #if e.attribute == "None" { [Automatic] } else {e.attribute}]
 #linebreak()
 #text(size:8.8pt)[*Target / range:* #e.target]
 #linebreak()
 #text(size:8.8pt)[*Duration:* #e.duration]
 #for (field,label) in (("defense","Defense"),("hold","Hold"),("escape","Escape")) {
  let value = e.at(field,default:none)
  if value != none {linebreak();text(size:8.8pt)[*#label:* #value]}
 }
 #v(3pt)
 #text(e.effect)
]

#let spread-art = json("spellbook-art.json")
#let spell-spread(b) = context {
  pagebreak(to:"even",weak:true)
  let w = 255pt
  let usable = 610pt
  let items = (spellbook(b),) + b.spells.map(e=>spell-entry(b,e))
  let cards = items.map(it=>block(above:0pt,below:3pt,it))
  let heights = cards.map(it=>measure(block(width:w,it)).height+3pt)
  let art = spread-art.at(b.ID)
  let art-column = art.at("column",default:3)
  let best = none
  let best-score = 100000pt
  for a in range(1,items.len()-2) {
    for c in range(a+1,items.len()-1) {
      for d in range(c+1,items.len()) {
        let hs = (heights.slice(0,a).sum(),heights.slice(a,c).sum(),heights.slice(c,d).sum(),heights.slice(d).sum())
        let score = calc.max(..hs.enumerate().map(((i,h))=>h+if i==art-column {160pt} else {0pt}))
        if hs.all(h=>h<=usable) and hs.at(art-column)<=usable - 85pt and score < best-score {
          best = (a,c,d);best-score=score
        }
      }
    }
  }
  assert(best != none,message:"Spellbook exceeds its spread: "+b.ID)
  let bounds = (0,) + best + (items.len(),)
  for side in range(2) {
    if side==1 {pagebreak()}
    block(height:64pt)[
      #heading(level:2,b.title)
      #text(size:9pt,fill:forest)[#b.Discipline / #b.List #h(1fr) #if side==0 {[SPELLBOOK]} else {[SPELLS · CONTINUED]}]
    ]
    [#metadata((book:b.ID,side:side)) <spell-spread-page>]
    grid(columns:(1fr,1fr),gutter:18pt,
      ..range(side*2,side*2+2).map(col=>block(height:usable)[
        #for it in cards.slice(bounds.at(col),bounds.at(col+1)) {it}
        #if col==art.at("column",default:3) {
          let gap = usable - heights.slice(bounds.at(col),bounds.at(col+1)).sum() - 8pt
          v(1fr)
          block(height:calc.min(gap,290pt))[
            #layout(size=>context {
              let pos=here().position()
              [#metadata((asset:art.asset,page:pos.page,x:pos.x/1pt,y:pos.y/1pt,width:size.width/1pt,height:size.height/1pt)) <art-placement>]
              image(art.path,width:100%,height:size.height,fit:"contain",alt:b.List+" magical study")
            })
          ]
        }
      ])
    )
  }
}
