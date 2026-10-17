#let forest = rgb("#15221c")
#let gold = rgb("#b39253")
#let ivory = rgb("#f1e6ce")
#let paper = rgb("#f7f3e9")
#let ink = rgb("#28251c")
#let setup(body) = {
 set document(title:"Heroes of Legend — Dungeon Architect’s Guide & Bestiary",author:"Bruce A. Moser")
 set text(font:"EB Garamond",size:10.5pt,fill:ink,lang:"en",hyphenate:true)
 set par(leading:.4em,spacing:.6em,justify:false)
 set page(width:612pt,height:792pt,margin:(left:42pt,right:42pt,top:52pt,bottom:46pt),fill:paper,
 header:context {
  grid(columns:(1fr,1fr),text(font:"Cinzel",size:8pt)[Heroes of Legend],align(right,text(size:8pt,{
   let hs=query(heading.where(level:1)).filter(h=>h.location().page() <= here().page())
   if hs.len()>0 {hs.last().body} else {[Dungeon Architect’s Guide]}
  })))
  v(4pt);line(length:100%,stroke:.5pt+gold)
 },footer:context {
  line(length:100%,stroke:.5pt+gold);v(4pt)
  grid(columns:(1fr,auto),text(size:8pt)[Dungeon Architect’s Guide & Bestiary · Review Edition],text(font:"Cinzel",size:9pt,counter(page).display()))
 })
 set heading(numbering:none)
 show heading.where(level:1): it=>block(above:0pt,below:12pt)[#text(font:"Cinzel",size:25pt,weight:"bold",fill:forest,it.body)#v(6pt)#line(length:100%,stroke:1pt+gold)]
 show heading.where(level:2): it=>block(above:11pt,below:5pt,text(font:"Cinzel",size:13pt,weight:"bold",fill:forest,it.body))
 show heading.where(level:3): it=>block(above:7pt,below:4pt,text(size:11pt,weight:"bold",fill:forest,it.body))
 show link:set text(fill:rgb("#3b5d46"))
 set list(indent:9pt,body-indent:4pt,spacing:3pt)
 set enum(indent:12pt,body-indent:4pt,spacing:3pt)
 body
}
#let chapter(number,title,key) = {
 pagebreak(weak:true)
 text(font:"Cinzel",size:9pt,fill:gold,number)
 v(7pt)
 [#heading(level:1,title)#label(key)]
}
#let xref(key,body)=link(label(key),body)
#let pageref(key)=context link(label(key),str(counter(page).at(label(key)).first()))
#let note(body)=block(width:100%,inset:8pt,fill:ivory,stroke:(left:2pt+gold),above:5pt,below:7pt,breakable:false)[#set text(size:10pt)
#body]
#let rule-table(cols,head,rows,widths:auto,font-size:9.3pt,pad:4pt,blank:false,compact:false)={
 set text(size:font-size)
 set par(leading:.23em,spacing:2pt)
 let t=table(columns:if widths==auto {cols} else {widths},inset:(x:5pt,y:pad),stroke:.3pt+rgb("#cfc7b3"),
 fill:(x,y)=>if y==0 {forest} else if calc.odd(y) {rgb("#ede6d4")} else {paper},
 table.header(repeat:true,..head.map(c=>text(fill:ivory,weight:"bold",c))),
 ..rows.flatten().map(c=>if blank {block(above:3pt,below:3pt,c)} else {c}))
 layout(size=>{let h=measure(block(width:size.width,t)).height;block(breakable:h>650pt,above:if compact {2pt} else {4pt},below:if compact {3pt} else {6pt},t)})
}
#let picture(path,height:150pt,fit:"contain",caption:[]) = block(above:8pt,below:14pt,breakable:false)[
 #context [#metadata((path:path,page:here().page())) <art-placement>]
 #image(path,width:100%,height:height,fit:fit)
 #if caption!=[] {v(3pt);text(size:8.5pt,fill:forest,caption)}
]
#let balanced(items,width:255pt) = context {
 let hs=items.map(it=>measure(block(width:width,it)).height+2pt)
 let best=0;let gap=100000pt
 for i in range(0,items.len()+1) {let a=hs.slice(0,i).sum(default:0pt);let b=hs.slice(i).sum(default:0pt);if calc.abs(a - b) <= gap {best=i;gap=calc.abs(a - b)}}
 grid(columns:(1fr,1fr),gutter:16pt,[#for it in items.slice(0,best) {block(below:2pt,it)}],[#for it in items.slice(best) {block(below:2pt,it)}])
}
#let reading-columns(items)=context {
 let w=255pt
 let blocks=items.map(it=>block(above:0pt,below:5pt,it))
 let heights=blocks.map(it=>measure(block(width:w,it)).height+5pt)
 let available=742pt-here().position().y
 let cursor=0
 while cursor < blocks.len() {
  let end=cursor;let left=0pt;let right=0pt;let on-right=false
  while end < blocks.len() {
   let h=heights.at(end)
   if not on-right and left+h <= available {left+=h}
   else {on-right=true;if right+h>available {break};right+=h}
   end+=1
  }
  if end==cursor {
   if available < 680pt {pagebreak();available=690pt}
   else {columns(2,gutter:18pt,blocks.at(cursor));cursor+=1;if cursor < blocks.len(){pagebreak()}}
  } else {
   let best=cursor;let gap=100000pt
   for cut in range(cursor,end+1) {
    let a=heights.slice(cursor,cut).sum(default:0pt);let b=heights.slice(cut,end).sum(default:0pt)
    if a <= available and b <= available and calc.abs(a - b) <= gap {best=cut;gap=calc.abs(a - b)}
   }
   grid(columns:(1fr,1fr),gutter:18pt,[#for it in blocks.slice(cursor,best){it}],[#for it in blocks.slice(best,end){it}])
   cursor=end
   if cursor < blocks.len(){pagebreak();available=690pt}
  }
 }
}
#let card-title(title,key,small:false) = block(width:100%,fill:forest,inset:(x:9pt,y:7pt))[
 #show heading.where(level:2): it=>block(above:0pt,below:0pt,text(font:"Cinzel",size:if small {11pt} else {16pt},fill:ivory,weight:"bold",it.body))
 #heading(level:2,title)#label(key)
]
#let creature(title,key,top,actions,details,art:none)= {
 set text(size:10pt)
 set par(leading:.2em,spacing:.4em)
 show heading.where(level:2):set text(size:12pt)
 show heading.where(level:3):it=>block(above:4pt,below:3pt,text(size:10pt,weight:"bold",fill:forest,it.body))
 let head=[#context [#metadata((key:key,page:here().page(),edge:"start")) <card-edge>]#card-title(title,key)#block(inset:8pt)[#top#actions]]
 let body=block(inset:(x:8pt,y:5pt),balanced(details,width:248pt))
 let whole=block(width:100%,stroke:.7pt+gold,radius:3pt,fill:rgb("#fbf8ef"),breakable:false,below:8pt)[#head#body#context [#metadata((key:key,page:here().page(),edge:"end")) <card-edge>]]
 layout(size=>{
  let h=measure(block(width:size.width,whole)).height
  [#metadata((key:key,height:h/1pt,kind:"creature"))  <card-size>]
  if h <= 686pt {
   if art!=none {
    block(breakable:false)[
     #whole
     #v(8pt)
     #context [#metadata((path:art,page:here().page())) <art-placement>]
     #align(center,image(art,height:calc.min(190pt,630pt - h),width:100%,fit:"contain"))
    ]
   } else {whole}
  } else {
   block(width:100%,stroke:.7pt+gold,breakable:false,head)
   text(size:8pt,fill:forest)[Details continue on the following page.]
   pagebreak()
   card-title(title+" — Details",key+"-details")
   body
  }
 })
}
#let reference-card(title,key,body)=block(width:100%,stroke:.6pt+gold,fill:rgb("#fbf8ef"),radius:2pt,breakable:false,above:5pt,below:6pt)[
 #context [#metadata((key:key,page:here().page(),edge:"start")) <card-edge>]
 #card-title(title,key,small:true)
 #block(inset:7pt)[
 #set text(size:9.2pt)
 #set par(leading:.23em,spacing:.4em)
 #show heading.where(level:3):it=>block(above:4pt,below:3pt,text(size:10pt,weight:"bold",it.body))
 #body]
 #context [#metadata((key:key,page:here().page(),edge:"end")) <card-edge>]
]
