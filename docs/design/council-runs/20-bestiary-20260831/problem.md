Chapter under review: ch20 (quarto-book/chapters/20-bestiary.qmd), "Bestiary", 322 lines.

Task: audit the chapter as a publishable unit and produce a disposition plan.
Each member audits through their own lens (see role card) and files a finding:
  stance support = the chapter holds on this lens as written
  stance refute  = the chapter must change; name the fix and its scope
Findings cite [file:line] in the chapter (20-bestiary.qmd). Mechanics
findings state the broken value and the expected value. Cross-chapter checks
use the authoritative chapters as the reference, not this chapter (core
rules = ch06: Boon/Bane, difficulty ladder +2/+0/-2/-4; combat = ch13:
conditions and their leveled forms (Burning X, Slowed X, Poisoned X, Dazed
X, Frozen X), Surprised, resistance half/double, "no surprise rounds"
phraseology; classes = ch05: the nine classes and their names; skills =
ch07: the 23-skill roster (Deception IS on it, keyed Guile); magic = ch11/
ch12: spell names (Turn Unholy is the spell; the Shepherd's class signature
is Turn Undead and still exists in ch05); advancement = ch18: follower
counts/1d3 precedent, stronghold HP; GM guidance = ch19: encounter
multiplier semantics (a creature's Challenge is its share of the budget),
faction actions; glossary = ch21; reference tables = ch22).

Disposition classes (for the librarian's synthesis):
  mechanical    - safe to implement as a micro-PR (headings, tables, wording,
                  em-dashes, single-cell refs, budget rows, band values,
                  vocabulary swaps, stat-block arithmetic)
  substantive   - needs a dispatched implementation pass (multi-file, new
                  content, worked-example rewrite requiring new narrative)
  design-decision - needs Bruce's ruling; implement the recommended default,
                  flagged veto-revertible in decisions-pending.md

Standing book conventions are in force: zero em-dashes in book text; damage
budgets flat at Novice 2/4/6, Adept 6/9/12, Master 9/15/21; monster stat
blocks CONFORM to challenge bands (C1-2 -> 2/4/6, C3-6 -> 6/9/12, C7+ ->
9/15/21), secondary attacks at most one tier lower than the primary; card
costs 2/4/8 DP; no flat +N damage riders anywhere in the book (a damage
bonus must be a budget row, a Basic-card floor of 1/2/3 + attribute, or a
"+1 damage tier" bump); one-roll principle; damage dice are dead outside the
allowed random-table exceptions (1d4/1d6 random behavior, 1d4+1 duration
dice); ZERO "save" vocabulary (resistance = attribute CHECKS: "Fortitude
check", "Guile check"); leveled conditions carry a number (Slowed X, Poisoned
X), bespoke phrasings like "speed halved" or "dazed for 1 round" are stale
vocabulary; attribute ceiling -2 to +2; class names are exactly the nine
from ch05; monster HP is a GUIDELINE ("HP ~= 5 x Challenge, adjust to
taste") and printed HP values are NOT findings. Violations of these
conventions are findings, not questions.

Scope note: this chapter is the canonical home for stat blocks, monster
creation, and encounter building. Where another chapter contradicts it, the
finding should name BOTH files and identify which is canonical. The council's
output is a disposition plan; it does not itself edit the book.
