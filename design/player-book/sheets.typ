#import "template.typ": *
#sheet-page("Character sheet — hero and turn", [
  #grid(columns: (1fr,1fr), gutter: 8pt,
    form-field("NAME / PRONOUNS", height: 38pt), form-field("ANCESTRY / CLASS / LEVEL", height: 38pt),
    form-field("CULTURE / BACKGROUND"),form-field("CONNECTION / PURPOSE"))
  #v(10pt)
  #grid(columns: (1fr,1fr,1fr), gutter: 8pt,
    ..("BRAWN","FORTITUDE","AGILITY","GUILE","KNOWLEDGE","REASON").map(x=>form-field(x,height:44pt)))
  #v(10pt)
  #grid(columns: (1fr,1fr,1fr), gutter: 8pt,
    ..("HP CURRENT / MAX","GRIT CURRENT / TOTAL GRANTED","WOUNDS / DEATH MARKS","SPEED","BULK / CAPACITY","STABILITY").map(x=>form-field(x,height:42pt)))
  #v(10pt)
  #form-field("RESISTANCE BY TYPE — HIGHEST SOURCE, CAP 3",height:42pt)
  #v(10pt)
  #form-table(4,([MY GO-TO ACTION],[ATTRIBUTE],[OUTCOMES / EFFECTS],[RANGE / LIMIT]),
    (([Main],[ ],[ ],[ ]),([Main],[ ],[ ],[ ]),([Maneuver],[ ],[ ],[ ]),([Reaction],[ ],[ ],[ ]),([Passive],[ ],[ ],[ ])))
  #v(10pt)
  #form-field("CURRENT CONDITIONS / RATING / EXPIRY / SOURCE",height:62pt)
  #v(8pt)
  #form-field("LEFT HAND / RIGHT HAND / ACCESSIBLE SUPPLIES",height:40pt)
  #v(9pt)
  #text(size:9pt)[3d6 + attribute. Weak ≤8 · Standard 9–14 · Strong ≥15.
  Boons/Banes cancel; keep best/worst 3 of up to 6 dice.
  Main → Maneuver → movement. End turn: resolve temporary condition, then decay 1.]
])
#sheet-page("Character sheet — development and belongings", [
  #grid(columns: (1fr,1fr), gutter: 8pt,form-field("NAME / LEVEL"),form-field("SAVED DP / COINS"))
  #v(8pt)
  #form-table(5,([DISCIPLINE],[RANK],[AFFINITY],[DP PAID],[GRANT / NOTES]),
    range(8).map(i=>([ ],[ ],[ ],[ ],[ ])))
  #v(10pt)
  #form-table(4,([LEARNED ABILITY / SIGNATURE],[TIER],[ACTION],[PAGE / NOTES]),
    range(8).map(i=>([ ],[ ],[ ],[ ])))
  #v(10pt)
  #form-table(4,([EQUIPMENT / SUPPLY],[BULK],[INVENTORY DIE],[HELD / LOCATION]),
    range(8).map(i=>([ ],[ ],[ ],[ ])))
  #v(10pt)
  #form-field("RECIPES / TOOLS / MATERIALS",height:55pt)
  #v(10pt)
  #form-field("TRAITS / LASTING BENEFITS",height:45pt)
])
#sheet-page("Creation ledger and wound record", [
  #text(size:11pt)[Level 0: 10 + Knowledge + Reason + Guile + duplicate DP.
  No discipline purchases. Close this pool before level 1.]
  #v(7pt)
  #form-table(4,([LEVEL 0 GRANT / PURCHASE],[REQUIREMENTS],[DP CHANGE],[BALANCE]),range(8).map(i=>([ ],[ ],[ ],[ ])))
  #v(8pt)
  #form-field("LEVEL 0 SPENT / EXPIRED — FINAL BALANCE 0")
  #v(10pt)
  #text(size:11pt)[Level 1: new 10 + Knowledge + Reason + Guile + duplicate DP.
  Apply class prices; buy ranks in order before abilities.]
  #v(7pt)
  #form-table(4,([LEVEL 1 GRANT / PURCHASE],[REQUIREMENTS],[DP CHANGE],[BALANCE]),range(8).map(i=>([ ],[ ],[ ],[ ])))
  #v(8pt)
  #form-field("LEVEL 1 SPENT / EXPIRED — FINAL BALANCE 0")
  #v(10pt)
  #form-table(4,([WOUND / SCAR],[LASTING EFFECT],[TREATMENT / RV],[PROGRESS / LAST DAY]),range(4).map(i=>([ ],[ ],[ ],[ ])))
  #v(8pt)
  #text(size:9pt)[One attempt per wound per day. Weak/Standard/Strong = 1/2/3 progress.
  Recovery removes the listed penalty; the scar still counts toward future wound rolls.]
])
