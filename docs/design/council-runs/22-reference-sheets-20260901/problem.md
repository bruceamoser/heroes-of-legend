# HOL Council — ch22 Reference Sheets

Chapter under review: ch22 (quarto-book/chapters/22-reference-sheets.qmd), "Quick Reference Sheets", 303 lines.

Task: audit the chapter as a publishable unit and produce a disposition plan.
Each member audits through their own lens (see role card) and files a finding:
  stance support = the chapter holds on this lens as written
  stance refute  = the chapter must change; name the fix and its scope
Findings cite [file:line] in the chapter (22-reference-sheets.qmd). Mechanics
findings state the broken value and the expected value. Cross-chapter checks
use the authoritative chapters as the reference, not this chapter (core
rules = ch06: Boon/Bane, success tiers 1-8/9-14/15-18+, Critical/Fumble;
skills = ch07: the 23-skill roster and attribute keys (Athletics Brawn,
Parry Brawn, Acrobatics Agility, Dodge Agility, Endurance Fortitude,
Survival Fortitude, Lore Knowledge, History Knowledge, Arcana Knowledge,
Nature Knowledge, Religion Knowledge, Medicine Reason, Persuasion Guile,
Insight Reason, Deception Guile, Intimidation Brawn, Performance Guile,
Stealth Agility, Sleight of Hand Agility, Thievery Agility, Perception
Reason, Craft Reason, Alchemy Reason); disciplines = ch08: 23 disciplines /
9 categories; combat = ch13: the 21-condition table (incl. Dazzled,
Petrified; Asleep X is "Unaware for X minutes"), Basic Maneuvers (Disengage
5 ft, Aid "+2 on their next roll before your next turn", Shove "Brawn vs
Brawn/Agility", Catch Breath, Command extra move, Stand Up is a MANEUVER),
morale (Strong "Gains +1 on its next attack", auto-triggers: below half HP,
leader defeated, half group fallen, overwhelming force), dying (Critical
wake at half HP, Strong stabilize at 1 HP, Standard stable, Weak still
dying, Fumble death), cover (attacker -1/-3 / full cannot target), action
economy (Action 1 / Movement 1 / Maneuver 1 / Reaction 1 per round / Free
unlimited; trading Action -> Movement or Maneuver, never up); armor/shields
= ch16: DR values + Discipline requirements (Buckler 1 Protection +1 DR,
Shield 1 Protection +2 DR, Tower Shield 2 Protection +3 DR HALF COVER),
Half Plate/Chain Mail/Plate reduce speed 5 ft; advancement = ch18: level
table (L1 4 DP "Class signature, Starting Disciplines", L3 Progression
Discipline + Adept unlock, L5 4 DP "DP windfall" — NO class features exist,
L7 Master unlock, L8 attribute +1, L10 3 DP — no milestone; "Classes do not
have feature upgrades"); GM guidance = ch19: rest rules, encounter
multiplier semantics (a creature's Challenge is its share of the budget —
Easy x1, Standard x2, Hard x3, Deadly x4+ party level, so a level-3 Easy
encounter has budget 3: 6 Wolves C1/2; Standard budget 6: 1 Knight C3 + 6
Guards C1/2; Hard budget 9: 1 Young Dragon C6 + 6 Cultists C1/2; Deadly 12:
1 Ancient Dragon C12); bestiary = ch20: Ancient Dragon (C12) exists,
encounter examples there still need re-totalling to the multiplier budgets;
glossary = ch21: Rest/Recharge/Finesse definitions, PV as defense-roll
bonus, Condition list).

Disposition classes (for the librarian's synthesis):
  mechanical    - safe to implement as a micro-PR (headings, tables, wording,
                  em-dashes, single-cell refs, budget rows, band values,
                  vocabulary swaps, arithmetic)
  substantive   - needs a dispatched implementation pass (multi-file, new
                  content, worked-example rewrite requiring new narrative)
  design-decision - needs Bruce's ruling; implement the recommended default,
                  flagged veto-revertible in decisions-pending.md

Standing book conventions are in force: zero em-dashes in book text; damage
budgets flat 2/4/6 6/9/12 9/15/21 (Novice/Adept/Master, keyed to C1-2/C3-6/
C7+); card costs 2/4/8; Adept prereqs EXACTLY 2, Master EXACTLY 3; L3/L7
gates; no "chain" vocabulary (growing-card model); no "save" vocabulary
(checks); no flat +N damage riders; leveled conditions (Burning X, Slowed X,
Poisoned X, Dazed X, Frozen X, Asleep X); en-dash for prose ranges (50-52 ->
50–52); art-tracker residue ("Placeholder for final art...") is stripped
from captions (ch20 #387 precedent); quick-reference tables abbreviate
legitimately but must never contradict the authoritative chapter or the
sheet's own tables.
