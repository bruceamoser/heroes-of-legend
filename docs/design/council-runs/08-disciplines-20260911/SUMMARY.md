# Synod run 20260911-2001 - hol-rulebook, Chapter 08 Disciplines

**Verdict:** REJECTED 7-0 (seven refutes, zero supports; six un-rebutted, reject_quorum 4; terminal
reject-majority, no judge, no impasse).
**Chain:** verify -> ok (13 events). **Wall rejections:** 0. **Prescreen:** 7/7 clean on the first pass.

## Telemetry
- 7 voting members, quorum 4, 1 round (max_rounds 2 not needed). All 7 round-1 briefs rendered and
  all 7 dispatched (3 + 3 + 1); rendered-vs-dispatched reconciled 7/7.
- Pre-ingest wall lint ran over all 7 findings before any `finding` ingest: 0 leaks, 0 rewrites,
  0 schema rescues (every member ran its own `member-selfcheck.py` before replying DONE).
- Single model (config default) for every role: decorrelation is untested (Q4 caveat, machine
  readable in report.md).
- Stance split: 7 refute, 0 support. Positions: librarian f-001 (0.82), contrarian f-002 (0.72),
  researcher f-003 (0.60), game-architect f-004 (0.78), author f-005 (0.82), editor-in-chief
  f-006 (0.72), layout-expert f-007 (0.78). One rebuttal in the ledger: f-007 rebuts f-005.

## What the council cleared (no numeric or taxonomic defect)
The chapter's spine survived an evidence-first audit from four independent lenses: 23 Disciplines
in 9 categories, all nine class starting sets against ch05, the four per-class rank ladders
(Home 1/2/4, Adjacent 2/4/8, Foreign 3/6/12, Opposed 4/8/16), flat card costs 2/4/8, the Level 3
and Level 7 gates, the prereq shapes, the flat budget table with zero dice, and every arithmetic
line in the worked build except the one cost line below.

## Contested claim, adjudicated in-run
- **08:107 (f-001 vs f-004 vs f-007).** f-001 wanted the example magic item renamed; f-004 held
  that the item name is right and the *condition* is wrong; f-007's lens was presentation. ch17:27
  defines an item card's `Disciplines:` line as the Disciplines it **grants** while attuned, and
  ch17:46 gives the Blade of the Last Ember 1 Fire, so the name stands. ch17:512 keys the loss of a
  granted Discipline to ending attunement, so "while you wield it / set it down" was the defect.
  Fix: attunement wording plus a room cross-reference. The name was NOT changed.
- **f-007 rebuts f-005, correctly.** The author lens asserted the render carried no doubled
  cross-reference periods; the layout lens found two. `pdftotext` on the built PDF settles it:
  `(Chapter 9.).` printed at 08:15 and 08:113. The rebuttal was sound and the doubled period became
  the seed of a book-wide sweep.

## Disposition plan (librarian synthesis, confidence 0.85)
**MECHANICAL** - 08:23 class name used as a Discipline name; 08:103 a promised new Discipline where
08:99 and the level-3 pick at 08:261 deepen; 08:133 echoing the card-cost table's prerequisite
column; 08:99/155/174/177/192/199/200/208 lowercase game term; 08:246 restating the damage table's
own column; 08:228-230 spaced damage triads.
**SUBSTANTIVE** - 08:133 skills inside the Discipline-gated ladder; 08:107 item-grant condition;
08:263 bespoke condition phrasing; 08:248 weapons credited with their own damage values; 08:210
entry requirements limited to weapons; 08:181 Ember Lance's Arcanist line charging a rank already
held.
**DESIGN (default named)** - 08:248 the Novice attribute-scaled base: printed 1/2/3 cannot come
from "budget minus 3" (2/4/6 minus 3 is -1/1/3).
**ROUTED OUT** - 21-glossary:47 (mirror of the reworded rule), 02:161 (starting-Discipline count
range), the book-wide doubled-period sweep.

## Implementation (same session)
- **PR #479** - 08-disciplines.qmd + 10-magic-system.qmd + 21-glossary.qmd, 29 replacements, build
  exit 0. Mechanics: the Arcanist's Ember Lance total corrected to 2 DP (08:181); the attribute-scaled
  rule rescoped so the printed 1/2/3 is producible and the minus-3 rule keeps Adept and Master;
  melee damage re-keyed to the attack card; the ladder rule scoped to spells and abilities; the
  Master Ember Lance printed as `(Burning 2)`; the level 3/6/9 pick restated as a rank. Consistency:
  `Blades` not `Blade`; item grants on attunement; entry requirements extended to armor and shields;
  eight lowercase instances reconciled; the two doubled periods; the spaced triads; the table
  restatement. 21:47 carries the reworded glossary mirror.
- **PR #480** - doubled-period sweep, 10 sites across 06/07/13/16/18/19. Left chapter-local it would
  have made ch08 inconsistent with six other chapters. Render gate: `pdftotext` now returns 0
  `(Chapter N.).` instances book-wide, was 9.
- **PR #481** - 02:161 "4-6 Disciplines" -> "4-5": ancestry 1 + culture 2 (or 1) + class 2 caps the
  three grant sources at five, and six is unreachable.
- Verification on every PR: build exit 0, 0 em-dashes in added lines, 0 damage dice in added lines,
  `check-native-typst.py` exit 0, and the changed text confirmed by short-fragment `pdftotext` probes
  against the rebuilt PDF rather than by source diff alone.

## Deliberately not implemented (with reason)
- The author lens's wider prose trims at 08:240 and 08:265 were declined. 08:240's three examples
  map NAMED cards to budget rows, which the table cannot say; only the card-less "A Master card deals
  9/15/21" restatement was cut. 08:265's "No shortcuts" is the chapter's closing refrain, not a
  restatement of 08:214's rule. The style law targets prose that repeats a table's own columns; nine
  lines of voice were left intact rather than trimmed for a body count.
- The librarian's 08:133 expected value dropped "skill" from the parenthetical. Skills DO have three
  tiers (ch07), so the word was kept and the false clause (the Discipline count) was scoped to spells
  and abilities instead, plus an explicit skills carve-out. The defect is closed either way.

## Beyond the plan (found by orchestrator verification, then confirmed)
- **08:181** the cost-line error: every member praised the worked example's arithmetic and none
  checked its premise against the class grants. 08:86 and the same callout's own Brimstone line
  (08:185) and the worked build (08:259) all treat the Arcanist's Fire rank 1 as already paid.
- **08:210** the armor and shield entry-requirement gap, and the render-verified doubled period.
- **02:161** the unreachable "6".

## Known limitations
- Single-model homogeneity (Q4); no model decorrelation is claimed.
- No judge ran: the reject was terminal by reject-majority, so no blind-judge ruling exists for this
  chapter and `rulings_applied` is empty.
- The 08:248 fix is a rules-formula call implemented as the recommended default (see
  docs/design/decisions-pending.md, veto-able).
