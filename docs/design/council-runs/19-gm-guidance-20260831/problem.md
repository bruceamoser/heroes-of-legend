Chapter under review: ch19 (quarto-book/chapters/19-gm-guidance.qmd), "Dungeon Architect's Guide", 566 lines.

Task: audit the chapter as a publishable unit and produce a disposition plan.
Each member audits through their own lens (see role card) and files a finding:
  stance support = the chapter holds on this lens as written
  stance refute  = the chapter must change; name the fix and its scope
Findings cite [file:line] in the chapter (19-gm-guidance.qmd). Mechanics
findings state the broken value and the expected value. Cross-chapter checks
use the authoritative chapters as the reference, not this chapter (core
rules = ch06: success tiers, difficulty ladder +2 Easy / +0 Standard / -2
Hard / -4 Very Hard, Boon/Bane; combat = ch13: conditions incl. Prone,
one-roll principle, modifiers, W/S/S damage; disciplines/economy = ch08: DP,
ladder, progression; classes = ch05: the nine classes and their names;
attributes = ch03: the -2 to +2 ceiling; skills = ch07: the 23-skill roster
and costs, Skill (Attribute) check format; advancement = ch18: leveling,
milestones, strongholds @sec-strongholds (base 50 HP, Fortify action),
faction reputation ladder; magic items = ch17: named unique cards, rarity
ladder, no flat-bonus generics; bestiary = ch20: stat block format and the
monster challenge bands; spell chains = ch11/ch12: card format and specific
cantrips; glossary = ch21; reference tables = ch22).

Disposition classes (for the librarian's synthesis):
  mechanical    - safe to implement as a micro-PR (headings, tables, wording,
                  em-dashes, single-cell refs, budget rows, worked-example
                  arithmetic that is canon-determined by another chapter)
  substantive   - needs a dispatched implementation pass (multi-file, new
                  content, worked-example rewrite requiring new narrative)
  design-decision - needs Bruce's ruling; implement the recommended default,
                  flagged veto-revertible in decisions-pending.md

Standing book conventions are in force: zero em-dashes in book text; damage
and healing budgets flat at Novice 2/4/6, Adept 6/9/12, Master 9/15/21;
monster stat blocks conform to challenge bands (C1-2 -> 2/4/6, C3-6 ->
6/9/12, C7+ -> 9/15/21; secondary attacks at most one tier lower than the
primary; monster HP is a guideline, never a deviation); card costs 2/4/8 DP;
Adept prereqs exactly 2, Master exactly 3; no flat +N damage riders anywhere
in the book (a damage bonus must be a budget row, a Basic-card floor of
1/2/3 + attribute, or a "+1 damage tier" bump); no flat "+N to a check"
riders where the book convention is Boon/Bane; one-roll principle (the hit
or casting roll IS the outcome, no second damage roll); damage dice are dead
outside the allowed random-table exceptions (1d4/1d6 random behavior, 1d4+1
duration dice); attribute ceiling -2 to +2; class names are exactly the nine
from ch05 (Protector, Blade, Arcanist, Shepherd, Intellect, Odd, Leader,
Unbalanced, Shadow - "cleric", "wizard", "fighter", "warlock" as class nouns
are stale vocabulary); level-gated conditions use the leveled vocabulary
(Burning X, Frozen X, Poisoned X, Slowed X, Dazed X - no bespoke phrasing);
checks are written as Skill (Attribute) or plain skill names, never mixed
skill-and-attribute lists. Violations of these conventions are findings, not
questions.

Scope note: this chapter is the canonical home for DA guidance, encounter
building, treasure pacing, resting, exploration, crafting, resource
management, corruption, the faction system (@sec-faction-system), the
sample adventure "The Sunken Vault", and the card templates
(@sec-card-templates). Where another chapter contradicts it, the finding
should name BOTH files and identify which is canonical. The council's
output is a disposition plan; it does not itself edit the book.
