Chapter under review: ch17 (quarto-book/chapters/17-magic-items.qmd), "Magic Items", 413 lines.

Task: audit the chapter as a publishable unit and produce a disposition plan.
Each member audits through their own lens (see role card) and files a finding:
  stance support = the chapter holds on this lens as written
  stance refute  = the chapter must change; name the fix and its scope

Findings cite [file:line] in the chapter (17-magic-items.qmd). Mechanics
findings state the broken value and the expected value. Cross-chapter checks
use the authoritative chapters as the reference, not this chapter (core
rules = ch06: DR math, minimum-1 damage, one-roll principle; combat = ch13:
Damage Types, Conditions table (Table 13.3), Shared Effects, Defense Roll,
Morale Check; social = ch14: the attitude ladder (Hostile, Neutral, Friendly,
Allied) and how attitude shifts work; disciplines = ch08: the Discipline
Taxonomy (23 disciplines, 9 categories) and tier/prereq shapes; equipment =
ch15: pricing and kit lines; bestiary = ch20: monster stat blocks; glossary =
ch21; reference sheets = ch22).

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
or casting roll IS the outcome, no second damage roll); leveled conditions
(Burning X, Frozen X, Slowed X) carry their number in the condition name and
card text; Boon/Bane and the -2/-1 modifier ladder are the only numeric
roll modifiers (a flat "-1 to attack rolls" in an effect is NOT a canonical
modifier form); attributes run -2 to +2 and no rule may require a +3
attribute score or modifier. Violations of these conventions are findings,
not questions.

Known context for the council (verify, don't trust the summary): the chapter
is 413 lines with 25 item entries (lines 41-372), an Attunement section
(373-388), a Discipline Items table (389-403), and Finding Magic Items
(404-413). Two items repeat the same granted effect: Cloak of Elvenkind
(lines 57-63) and Veilwalker's Shroud (lines 65-79) both grant Boon on
Stealth checks. The chapter cites [file:line] references to other chapters
(@sec-chapter-damage-budget, @sec-chapter-equipment) whose anchors must
resolve. Item damage rows must land flat on a budget row (e.g. an item keyed
to the Novice row uses 2/4/6; a potion's Greater tier uses 6/9/12, Superior
9/15/21). Consumable "spend an action" healing and "once per day/encounter"
limits are canonical item design. The chapter also contains a Discipline
Items table granting disciplines to non-magic users; verify each discipline
name appears in the ch08 taxonomy exactly as spelled.

Scope note: the chapter is the canonical home for magic item rules. Where
another chapter contradicts it, the finding should name BOTH files and
identify which is canonical (ch17 for item rules; ch13/ch14/ch08 for the
mechanics it references). Figure-caption doubling (the "Illo 24: Magic Items
Art" image alt text + the italic caption line) is a BOOK-WIDE convention
already routed to decisions-pending as #36 — do NOT raise it as a per-chapter
finding; a chapter-local fix would make this chapter inconsistent with the
book. The council's output is a disposition plan; it does not itself edit
the book.
