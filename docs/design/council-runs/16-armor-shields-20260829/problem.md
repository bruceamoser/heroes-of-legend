Chapter under review: ch16 (quarto-book/chapters/16-armor-shields.qmd), "Armor & Shields", 130 lines.

Task: audit the chapter as a publishable unit and produce a disposition plan.
Each member audits through their own lens (see role card) and files a finding:
  stance support = the chapter holds on this lens as written
  stance refute  = the chapter must change; name the fix and its scope

Findings cite [file:line] in the chapter (16-armor-shields.qmd). Mechanics
findings state the broken value and the expected value. Cross-chapter checks
use the authoritative chapters as the reference, not this chapter (core
rules = ch06: DR math, minimum-1 damage, critical hit table, one-roll
principle; combat = ch13: Defense Roll tiers, cover, Defend maneuver,
actions/reactions; abilities = ch09: the printed Shield Block card;
disciplines = ch08: ladder and prereq table; bestiary = ch20: monster stat
blocks with DR; equipment = ch15: shield/armor pricing; skills roster =
ch07; starting kits and worked templates = ch02/ch05; glossary = ch21;
reference tables = ch22).

Disposition classes (for the librarian's synthesis):
  mechanical    - safe to implement as a micro-PR (headings, tables, wording,
                  em-dashes, single-cell refs, budget rows, worked-example
                  arithmetic that is canon-determined by another chapter)
  substantive   - needs a dispatched implementation pass (multi-file, new
                  content, worked-example rewrite requiring new narrative)
  design-decision - needs Bruce's ruling; implement the recommended default,
                  flagged veto-revertible in decisions-pending.md

Standing book conventions are in force: zero em-dashes in book text; damage
budgets flat at Novice 2/4/6, Adept 6/9/12, Master 9/15/21; card costs 2/4/8;
Adept prereqs exactly 2, Master exactly 3; no flat +N damage riders anywhere
in the book (a damage bonus must be a budget row, a Basic-card floor of
1/2/3 + attribute, or a "+1 damage tier" bump); one-roll principle (the hit
or defense roll IS the outcome, no second damage roll); damage never drops
below 1 from any hit. Violations of these conventions are findings, not
questions.

Scope note: this chapter is the canonical home for armor and shield rules.
Where another chapter contradicts it, the finding should name BOTH files and
identify which is canonical (ch16 for armor/shield rules; ch06/ch13/ch20 for
core resolution, defense, and monster stat blocks). The council's output is
a disposition plan; it does not itself edit the book.
