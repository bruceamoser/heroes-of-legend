#let forest = rgb("#15221c")
#let gold = rgb("#b39253")
#let ivory = rgb("#f1e6ce")
#let paper = rgb("#f7f3e9")
#let ink = rgb("#28251c")
#let chapter-name = state("chapter-name", "Player’s Book")
#let setup(body) = {
  set document(title: "Heroes of Legend — Player’s Book", author: "Bruce A. Moser")
  set text(font: "EB Garamond", size: 10.5pt, fill: ink, lang: "en", hyphenate: true)
  set par(leading: 0.42em, spacing: 0.65em, justify: false)
  set page(width: 612pt, height: 792pt, margin: (left: 42pt, right: 42pt, top: 52pt, bottom: 46pt), fill: paper,
    background: context {
      for item in json("generated/space-art.json").filter(it => it.page == here().page()) {
        place(top+left, dx:item.x*1pt, dy:item.y*1pt,
          image("art/interior/"+item.asset+".png",width:item.width*1pt,height:item.height*1pt,fit:"contain"))
      }
    },
    header: context {
      grid(columns: (1fr, 1fr), text(font: "Cinzel", size: 8pt, fill: forest)[Heroes of Legend],
        align(right, text(size: 8pt, fill: forest, {
          let hs = query(heading.where(level: 1)).filter(h => h.location().page() <= here().page())
          if hs.len() > 0 { hs.last().body } else { [Player’s Book] }
        })))
      v(4pt); line(length: 100%, stroke: 0.5pt + gold)
    },
    footer: context {
      line(length: 100%, stroke: .5pt + gold)
      v(4pt)
      grid(columns: (1fr, 1fr), text(size: 8pt)[Player’s Book · Playtest Edition],
        align(right, text(font: "Cinzel", size: 9pt, counter(page).display())))
    })
  set heading(numbering: none)
  show heading.where(level: 1): it => block(above: 0pt, below: 13pt)[
    #text(font: "Cinzel", size: 26pt, fill: forest, weight: "bold", it.body)
    #v(7pt)#line(length: 100%, stroke: 1pt + gold)
  ]
  show heading.where(level: 2): it => block(above: 12pt, below: 6pt)[
    #text(font: "Cinzel", size: 14pt, fill: forest, weight: "bold", it.body)
  ]
  show heading.where(level: 3): it => block(above: 9pt, below: 4pt)[
    #text(size: 11.5pt, fill: forest, weight: "bold", it.body)
  ]
  show link: set text(fill: rgb("#3b5d46"))
  set list(indent: 10pt, body-indent: 5pt, spacing: 4pt)
  set enum(indent: 11pt, body-indent: 5pt, spacing: 4pt)
  body
}
#let chapter(n, title) = {
  pagebreak(weak: true)
  chapter-name.update(title)
  block(below: 8pt)[#text(font: "Cinzel", size: 9pt, fill: gold)[CHAPTER #n]]
  heading(level: 1, title)
}
#let entry(title, key) = {
  [#heading(level: 2, title)#label(key)]
}
#let xref(key, body) = link(label(key), body)
#let pageref(key) = context link(label(key), str(counter(page).at(label(key)).first()))
#let twocol(body) = columns(2, gutter: 18pt, body)
#let note(body) = block(width: 100%, inset: 9pt, fill: ivory, stroke: (left: 2pt + gold), radius: 2pt, above: 6pt, below: 8pt, breakable: true)[
  #set text(size: 10pt)
  #body
]
#let art-files = json("generated/art-files.json")
#let illustration(asset, width: 100%, height: 160pt, fit: "contain") = block(width: width, height: height, above: 8pt, below: 8pt)[
  #layout(size => context { let pos=here().position(); [#metadata((asset:asset,page:pos.page,x:pos.x/1pt,y:pos.y/1pt,width:size.width/1pt,height:height/1pt)) <art-placement>] })
  #if asset in art-files {
    image("art/interior/" + asset + ".png", width: 100%, height: height, fit: fit, alt: asset.replace("-", " "))
  } else {
    rect(width: 100%, height: height, fill: ivory, stroke: gold)[#align(center+horizon)[Artwork in production]]
  }
]
// A fractional block gives the remaining page height without making a new page.
#let tail-art(asset) = block(height: 1fr, layout(size => {
  if size.height >= 110pt { align(center+horizon, illustration(asset, height: calc.min(size.height - 12pt, 340pt))) }
}))
#let rule-table(cols, head, rows, widths: auto, pad: 5pt, font-size: 9.3pt) = {
  set text(size: font-size)
  set par(leading: 0.28em, spacing: 3pt)
  table(columns: if widths == auto { cols } else { widths }, inset: (x: 5pt, y: pad),
    stroke: .3pt + rgb("#cfc7b3"),
    fill: (x,y) => if y == 0 { forest } else if calc.odd(y) { rgb("#ede6d4") } else { paper },
    table.header(repeat: true, ..head.map(c => text(fill: ivory, weight: "bold", c))),
    ..rows.flatten())
}
#let diamond(tier) = box(width: 23pt, height: 23pt)[
  #place(center + horizon, rotate(45deg, square(size: 17pt, fill: forest, stroke: .7pt + gold)))
  #place(center + horizon, text(size: 9pt, fill: ivory, weight: "bold", tier))
]
#let discipline-mark(name, rank, size: 25pt) = box(width: size, height: size)[
  #if "badge-"+name in art-files {
    place(center+horizon, image("art/interior/badge-"+name+".png",width:size,height:size,fit:"contain"))
  } else {
    place(center+horizon, circle(width:size,fill:forest,stroke:gold))
  }
  #if rank != "" {
    place(center+horizon, circle(width: 12pt,fill:forest.transparentize(10%),stroke:.4pt+gold))
    place(center+horizon, text(size:10pt,weight:"bold",fill:white,rank))
  }
]
#let card-heading(title, key, tier: none, icons: [], title-size: 11pt) = block(width:100%,fill:forest,inset:7pt)[
  #set text(fill:ivory)
  #show heading.where(level:3): it => block(above:0pt,below:0pt,text(size:title-size,weight:"bold",fill:ivory,it.body))
  #grid(columns: if tier == none {(1fr,auto)} else {(24pt,1fr,auto)},gutter:6pt,
    ..if tier == none {()} else {(diamond(tier),)},
    [#heading(level:3,outlined:true,title)#label(key)],
    box(icons))
]
#let card(title, tier, req, action, attr, tags, price, key, body, icons: []) = {
  let whole = block(width:100%,stroke:.7pt+gold,radius:3pt,clip:true,fill:rgb("#fbf8ef"),above:7pt,below:5pt)[
    #card-heading(title,key,tier:tier,icons:icons)
    #block(inset:(x:7pt,y:5pt))[
      #set text(size:9.4pt)
      #set par(leading:.27em,spacing:.45em)
      #set list(indent:9pt,body-indent:3pt,spacing:1.5pt)
      #text(size:8.6pt,weight:"bold")[#action · #attr]
      #h(1fr)#text(size:8pt,price)
      #linebreak()#text(size:8pt)[#tags · #req]
      #v(4pt)#line(length:100%,stroke:.4pt+gold)#v(3pt)
      #body
    ]
  ]
  layout(size => {
    let height = measure(block(width: size.width, whole)).height
    [#metadata((key: key, height: height / 1pt)) <card-size>]
    block(breakable: height > 675pt, whole)
  })
}
#let catalog-card(title,key,body) = block(width:100%,stroke:.7pt+gold,radius:3pt,clip:true,fill:rgb("#fbf8ef"),above:7pt,below:5pt,breakable:false)[
  #card-heading(title,key)
  #block(inset:7pt)[
    #set text(size:9.4pt)
    #set par(leading:.27em,spacing:.45em)
    #set list(indent:9pt,body-indent:3pt,spacing:1.5pt)
    #body
  ]
]
#let companion-card(title,key,asset,intro,body) = block(width:100%,stroke:.8pt+gold,radius:4pt,clip:true,fill:rgb("#fbf8ef"),breakable:false,above:6pt,below:8pt)[
  #card-heading(title,key,title-size:16pt)
  #block(inset:9pt)[
    #set text(size:9.5pt)
    #set par(leading:.3em,spacing:.45em)
    #grid(columns:(1.5fr,1fr),gutter:12pt,[#intro],[#illustration(asset,height:165pt)])
    #v(5pt)#line(length:100%,stroke:.5pt+gold)#v(3pt)
    #body
  ]
]
#let form-field(title, height: 30pt) = block(width: 100%, height: height, stroke: .5pt + gold, inset: 5pt)[#text(size: 8pt, weight: "bold", title)]
#let sheet-page(title, body) = {
  pagebreak(weak: true)
  set page(fill: white)
  heading(level: 2, title)
  body
  pagebreak()
}

#let form-table(cols, head, rows) = {
  set text(size: 8pt)
  table(columns: (1fr,) * cols, rows: (auto,) + (17pt,) * rows.len(), inset: 4pt,
    stroke: .4pt + rgb("#a69c83"), fill: (x,y) => if y == 0 { ivory } else { white },
    table.header(..head.map(c => strong(c))), ..rows.flatten())
}
