#import "template.typ": *
#show: setup
// Preserve the approved native cover composition without rasterizing its title.
#{
  set page(width: 612pt, height: 792pt, margin: 0pt, fill: black, header: none, footer: none)
  include "cover.typ"
  pagebreak()
}
#set document(title: "Heroes of Legend — Player’s Book", author: "Bruce A. Moser")
#align(center)[
  #v(35pt)
  #text(font: "Almendra", size: 34pt, weight: "bold")[Heroes of Legend]
  #v(12pt)
  #text(font: "Cinzel", size: 18pt)[Player’s Book]
  #v(10pt)
  #text(size: 13pt)[Levels 1–10 · Playtest Edition]
  #v(22pt)
  #image("art/hol-crest-v2.png", width: 130pt)
  #v(20pt)
  #text(font: "Cinzel", size: 13pt)[Game design by Bruce A. Moser]
]
#v(25pt)
#block(width: 100%, inset: 12pt, fill: ivory)[
  This book contains the player rules and choices for Heroes of Legend: character
  creation, advancement, abilities, equipment, summoned companions and recovery.
  The Dungeon Architect’s bestiary and encounter guidance are separate.

  Cover artwork was created with AI assistance and approved by Bruce. Interior
  illustrations and discipline symbols were generated to match the book’s visual style. The title and
  rules remain editable type. This is a digital playtest proof; final print artwork,
  production specifications and publication notices will be prepared for release.
]
#v(14pt)
#text(size: 9pt)[Manuscript and layout prepared with Codex under Bruce’s direction.
Rules snapshot: approved design workspace, October 15, 2026.
Construction edition: October 16, 2026.]
#pagebreak()
#outline(title: [Contents], depth: 1)
#tail-art("journey")
#pagebreak()
#include "generated/body.typ"
