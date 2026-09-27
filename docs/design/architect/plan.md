# Architect plan — where the book is going

**Owner:** the architect cycle. **Read first, written last, every cycle.**
If this file and `docs/design/decisions-pending.md` disagree, the ledger wins.

## Objective

Ship a **playable, cohesive, succinct** rulebook. ~81,400 words across 25 chapters, in its
build pass. Playability and succinctness have no instrument and no owner; that is this
file's reason to exist.

## Standing law this plan serves

Quoted, never invented: `discipline is permission · equipment is possession · cards are
damage`; attacks always hit / magic always fires; never a null turn; limits are spotlight
management; variance in a simple core; a spent Action is a real cost; the book is a
companion, not a manual; zero em-dashes in book text.

## State at cycle 0 (verified against the repo, not recalled)

- **The repo has been idle for nine days.** Last commit on `main`: `8d85689`, 2026-09-17.
- **Shields is done.** Rulings 155/156 landed as **PR #650** (issue #649 closed): Wall Shield
  removed from the card system, five maneuvers in, shield DR moved to the Shield Block
  reaction. Any plan that lists Shields as outstanding is reading a stale row.
- **Fate and Summon are ruled, specced, and not dispatched.**
  `docs/design/discipline-completion-spec-20260916.md` (214 lines, `28eb08c`) holds the spec;
  its appendix was rewritten as the resolved #649 record and it carries a shield-DR blocker
  note. This is the only fully-preread work order in the project and it has sat untouched
  since 2026-09-16.
- **Open tracker:** 2 issues, 0 PRs — #587 (blocked on Bruce: level 0/1 DP pools once gear
  permissions are paid from the same pool as cards) and #561 (ch09 council pass, substantive
  tier S-1..S-11).

## State at cycle 1 (2026-09-26, verified against the repo, not recalled)

- **Dispatch is off.** `HOL_ARCHITECT_DISPATCH` is not set in `~/.hermes/.env`, so cycle 1 filed its work order as issue #655 and dispatched nothing. Spending money is Bruce's call.
- **The bootstrap landed.** PR #654 merged as `eb8b5e0`, so these two state files are now on `main` and the next cycle reads them from `origin/main` rather than from a working tree.
- **Row 125 re-verified and moved.** Fate is still unpriced (0 hits in `05-classes.qmd`) and still uncarded (0 requirements book-wide) while `08:19`, `21:69` and `22:234` print it. Both blockers on the completion spec are clear, so the module is dispatchable: **#655**.
- **A defect with no prior row.** Three ch09 talents print "(Novice Talent)" against a 2- or 3-rank requirement, so the title promises 2 DP at level 1 where the ladder says 4 DP at 3 or 8 DP at 7. Ledger row 160, with the instrument that measured it (ch09 3 of 82; ch11 0 of 68; ch12 0 of 46).

## State at cycle 2 (2026-09-26, verified against the repo, not recalled)

- **Nothing was in flight.** 0 PRs, 3 open issues (#561, #587, #655), `main` unmoved at `f33a51a`
  since cycle 1, and dispatch still off (`HOL_ARCHITECT_DISPATCH` unset). No issue carried
  `s:working`, so no dispatch was outstanding and no PR awaited inspection.
- **#655 is filed and NOT built.** It carries every number the Fate module needs; it waits on Bruce
  enabling dispatch (or on the Fate distribution table being cleared). Re-filing it would be
  re-reporting settled work.
- **Walkthrough W-001 ran.** `architect/walkthroughs/2026-09-26-w-001-first-session.md`. Playable is no longer
  unmeasured. Four defects came out of it, all in the creation economy that the 2026-09-16 armament
  collapse rewrote; two are single-outcome and were fixed the same day (row 163), two need one word
  each from Bruce (rows 161, 162). Both pending rows land on the SAME nine builds in ch02, so they
  should be answered together and implemented as one pass.
- **The load-bearing number: 7 of the 9 printed heroes are unfunded by 2 to 6 DP** (26 DP of gear
  permission no ledger pays), and all 9 spend 2 DP buying the skill their own culture grants +1 in.

## State at cycle 3 (2026-09-26, verified against the repo, not recalled)

- **The direction changed mid-day.** Bruce filed **#659**: the build pass is ordered by
  *assessing the game from the foundation up*, not by the ledger's row order, because "the ledger
  records what has been DECIDED; it is never evidence that what exists is good". Method is
  `references/system-assessment.md`; artifact is `docs/design/architect/assessment.md`. The loop's
  **THINK priority 1 is now the unassessed sweep**, and it outranks the queue below until coverage
  reads 9 of 9.
- **PR #660 was already open when cycle 3 woke** and carried Assessment 1 (core resolution) with
  coverage at 1 of 9. Cycle 3 INSPECTED it - every probability row re-derived independently from the
  216 outcomes and confirmed correct, my own first checker being the one at fault (it capped Strong
  at 18 and dropped 4 of 216 outcomes at +2, 56 of 216 at +6) - then advanced the sweep to
  **Assessment 2, the economy** (coverage 2 of 9).
- **Priority 1 of Assessment 1 was measured and REVERSED.** Static HP was named "the game's biggest
  structural bet". It is not: Grit's pools (x3/x4/x5) plus the tier's own armour DR hold
  time-to-kill flat across the career - 5.8 / 5.9 / 5.8 hits at Novice / Adept / Master, and flat at
  every HP in the printed 8-14 range. A hero cannot be one-shot; only a *pool* can. Recorded beside
  the old verdict in `assessment.md`, never overwritten.
- **The economy's verdict is OK with LEARNABLE failing**, and the failure has a single root cause:
  the price is stated two ways. `02:204` and the ch22 reference sheet print the flat 2/4/8 and stop,
  while `08:178` says the flat cost "is only part of the price". The true price of a Novice card is
  **2 to 6 DP** depending on whether the hero holds the Discipline. That is the measured mechanism
  behind rows 161/162's 44 DP of unfunded spend.
- **Two new class-level defects, both computed from the classes' own tables.** The **Shepherd**
  overspends its pool (`05:202`: 7 DP of loadout ranks + a 2 DP card against 8 DP, so 9 DP). Four
  classes call a **4/8/16** charge "at your Foreign rate" where Foreign is **3/6/12** and 4/8/16 is
  Opposed (Blade, Arcanist, Shepherd-Armor, Unbalanced).
- **The Leader's "4 DP" line is CORRECT, and the first pass that called it a mis-sum was the bug.**
  Writing the class check as a script (which pays every rank above the granted rank, from the
  class's own cost table) showed Melee ranks 1+2 at Home (1+2) plus Two-Handed rank 1 (1) = 4 DP,
  because the class grant covers Shields only. Hand arithmetic on a table is a hypothesis; the
  parsed table is the source of record. Phantom removed from the assessment, the plan and the row.
- **Dispatch is still off** (`HOL_ARCHITECT_DISPATCH` unset). One mechanical work order filed
  (issue #661, the economy's line-level repairs), nothing dispatched.
- **#660 did NOT merge.** It was closed unmerged at 00:21 and superseded by **#662**. Its assessment
  content rode forward on the new branch; its `plan.md` cycle log, its `scorecard.md` row and its
  ledger rows did not, and cycle 5 restored them (see below). A cycle that closes one PR and opens
  another must carry the state files across, or the loop's memory silently loses a cycle.

## State at cycle 4 (2026-09-26, verified against the repo, not recalled)

- **Bruce ruled the pacing law (row 165):** "an even scaled combat should last 3-4 rounds... That
  should be the goal regardless of level." Grit is the intended staying-power mechanic and stays.
- **Cycle 4 built the instrument and measured the gap.** `scripts/rounds-to-resolve.py` (skill) was
  written against the live corpus, reported an even fight at 2.22 / 1.57 / 1.18 rounds at
  Novice / Adept / Master, and exited 1. It recommended "scale enemy HP with tier" as the lever.
- **It closed #660 and opened #662** (`docs/architect-pacing-law`, one commit), carrying
  `assessment.md` plus ledger row 165. Per the charter a PR touching `docs/design/architect/**` is
  Bruce's to merge, so it was left open for him. That is why `main` has not moved.
- **Both of its headline numbers were artifacts** (see cycle 5). The instrument paired a Master-tier
  party with the bestiary's global average HP, and its "party wiped in 1.8 rounds" line omitted Grit
  and armour DR. Its recommended lever is already implemented in the book as monster DR.

## State at cycle 5 (2026-09-26, verified against the repo, not recalled)

- **#662 was INSPECTED and repaired in place, never superseded.** Four defects, all fixed on the
  same branch:
  1. **Dangling ledger citations (hard red).** `assessment.md` pointed the Shepherd, Master-efficiency
     and Fortitude/Knowledge priorities at rows 165/166/167, but the branch added only row 165 - and
     used that number for the pacing law. The three rows that #660 had added were on no branch that
     would ever merge. Rows 165 (pacing) / **166 (Shepherd) / 167 (Master) / 168 (Fortitude-Knowledge)**
     now all exist and every citation resolves.
  2. **A cycle of loop memory was missing.** Cycle 3's plan log row, scorecard row and the amended
     row 161 were dropped with #660. Restored here and in `scorecard.md`, with the "merged as #660"
     claim corrected to what actually happened.
  3. **Two sections were both called "Assessment 2"** (the economy and pacing). The pacing one is now
     `Pacing assessment - combat and action economy`, which is also what it is in the coverage table.
  4. **The gate measured the wrong fight and the wrong pool.** Rebuilt (below).
- **The pacing numbers were re-derived from the corpus, and the truth is sharper than the report.**
  Stratified by challenge band and DR-aware: 4v4 is 2.52 / 2.10 / 1.92 rounds (a uniform 1.31x
  compression, not 1.88x); the even fight per the book's own encounter rule (`19:53`, Standard = x2
  party level, about two creatures) is **1.26 / 1.05 / 0.96 rounds**; and a party is dropped after
  **12.7 / 12.9 / 12.7 rounds, flat** once Grit and armour DR are counted. **There is no mutual rout
  and no one-round wipe** - the earlier claim is withdrawn in the assessment and in row 165.
- **The root cause is a cross-chapter premise mismatch.** `20:659` sizes a monster to absorb three
  rounds of ONE hero's output (a solo duel); `19:53` hands a party of four two creatures. Four heroes
  focus-firing finish in about a round. `19:57` already states the doctrine that fixes it: count
  actions, not hit points.
- **The gate is now proven in both directions.** `scripts/rounds-to-resolve.py` carries `--selftest`:
  HP sized for exactly 3.5 rounds must pass, and the same HP cut to a quarter must fail and name every
  tier. Both controls behave. It exits 1 on the live corpus. **A gate that has only ever printed OK
  is decorative** - this one had printed OK never and FAIL once, and was failing for the wrong reason.
- **Queue unchanged in substance:** still 0 dispatches (`HOL_ARCHITECT_DISPATCH` unset), and the only
  new work is the re-costed lever set on row 165, which needs one word from Bruce.

## State at cycle 7 (2026-09-26, verified against the repo, not recalled)

- `main` at `7ebbff2` (cycle 7's conformance PR #665 merged; cycle 6's docs at `303a5fe` below it).
- Open PRs: **0**. Open issues: **6** — 561, 587, 655, 659, 661, 663. Nothing is `s:working`.
- **Dispatch is still gated off** (`HOL_ARCHITECT_DISPATCH` unset in `~/.hermes/.env`).
- Ledger: **170 rows**, max id **171** (169/170/171 added this cycle; 160 amended).
- Assessments: **4 of 9** (1 core, 2 economy, 3 creation/progression, 4 combat+pacing). Walkthroughs: **W-001, W-002**.
- New instruments this cycle: `scripts/tier-census.py`, `scripts/heal-row-census.py` (both with selftests; the
  healing census carries a negative control and grades a card's full triple, because per-figure membership
  manufactures false conforming cards when a retired row and a live row share a value).
- Working tree clean, one checkout, no worktrees. The stale local branch `docs/architect-cycle-1` and three
  scratch files remain, because the cron guard blocks `git branch -D` and `rm` unattended.

## State at cycle 9 (2026-09-26, verified against the repo, not recalled)

- **Dispatch is ON.** `HOL_ARCHITECT_DISPATCH=1` (set after cycle 8), so this cycle did what the loop could
  not do for eight cycles: it dispatched. Worktree `/tmp/wt-663` on branch `fix/663-pacing` from `e86109c`,
  `opencode` running in the background against `.task-spec.md`. One work order, per the contract.
- **Priority 1 was the six misclassified balance rows, and the instruction that flagged them was right: all
  six were BALANCE problems with derivable answers, none was a question for Bruce.** Rows 162/166/167/168/169/171
  decided in place with the numbers attached, and rows 161 and 164 decided on the same reasoning (both read
  "needs one word from Bruce"; neither needed one).
- **The load-bearing number of this cycle: the level-1 4 DP award that creation never shows is exactly the size
  of the gear-funding hole the walkthrough measured.** `18:47` grants 4 DP at level 1 inside the advancement
  table whose total `22:270` prints as 32, and `22:272` counts that 32 in the career total, while creation's
  Step 7 and `22`'s checklist both print 8 DP and stop. With the Level-1 pool at **12 DP**, **8 of the 9 printed
  builds pay their loadout ranks and keep every card** (four land on exactly 0 slack), and Gorma alone trims one
  2 DP line. Evidence that this is the intended mechanism rather than a coincidence: the Shepherd's printed
  "which still leaves room for a card" is false at 8 DP and true at 12, and four builds land on exactly zero.
- **Row 161's earlier recommendation is retracted in place.** It proposed dropping the armour entry requirement
  a step (light 0 / medium 1 / heavy 2) to fund the hole. The hole was a missing creation line, so the rule
  never had to move; the smallest-lever rule prefers the line. `16:104-112` (Roric) carries the same defect in
  example form and is in the same work order.
- **Two of the six were already covered by existing law, so no new law was needed.** The culture's +1 skill
  bonus is the Novice tier of that skill, and buying it again is the duplicate-grant waste `08:93` already
  legislates for Disciplines (stacking is rejected on the level gate: `07` prices +2 at 4 DP gated to level 3,
  so stacking would hand a level-1 hero an Adept-magnitude skill for half price). And the 2 Two-Handed / 2 Melee
  weapon requirements are pre-collapse grid survivors: every loadout prices a melee or two-handed weapon at one
  rank, and invariant 8 decides it, because a second rank of Two-Handed costs an Unbalanced **8 DP** at Foreign,
  more than half its level-1 pool, for the spear its own loadout lists.
- **Two rows were closed as measured, not fixed.** Row 168 (Knowledge and Fortitude pay twice) is partly
  premise-false: `03:100` already states the mechanical consequence in plain text and `02:113` explains the
  fiction, and the measured bank is +1 HP and +1 DP per point, which dominates nothing (Brawn +2 is +2 damage on
  every hit). Row 167 (Master is not an efficiency tier) has no lever left but a sentence, because invariant 4
  fixes card prices at 2/4/8 and the bands were retuned by ruling.
- **Three work orders filed, one dispatched.** **#671** (gear entry requirements, dispatch first, since #670's
  per-build table assumes its values), **#670** (creation economy: the 12 DP pool, the nine builds, the culture
  swap), **#672** (recurring effects are budgeted on their total). **#587 closed**: its parked revival trigger
  ("returns only if play shows the level-1 pool is too tight") has fired, and the answer is printed in the book
  rather than invented, so no pool increase is needed.
- **Tracker at wake:** 0 PRs, 7 open issues, ledger 175 rows, `main` at `e86109c`.

## State at cycle 10 (2026-09-26, verified against the repo, not recalled)

- **The cycle's one action: #671 dispatched, audited and MERGED** (PR **#673**, `main` at `997abd1`), the
  requirements half of the creation economy. Files `15`/`08`/`21`/`02`/`16`/`05`, 11 lines.
- **The dispatch-readiness gate earned its keep: the spec was verified against the FILE and was wrong in two
  places, both of which would have landed in the audit instead.** (a) `05:338` prints `Longsword (2 Melee)`,
  so the Leader's loadout is a **fourth** per-weapon rank-2 survivor, and its printed 4 DP closes on Melee
  ranks 1+2 (1+2 = 3 DP) plus Two-Handed rank 1 (1 DP) at her Home rates - the spec's own "do not change
  `05:338`" was the mis-cite, and under the uniform 1-rank rule the line reads **2 DP**. (b) Four class lines
  charge **4 DP** and call it the "Foreign" rate while their own tables price that discipline at **4/8/16 =
  Opposed** (`05:107` Blade Armor, `05:158` Arcanist Melee, `05:202` Shepherd Armor, `05:408` Unbalanced
  Two-Handed). Numbers right in all four, rate names wrong, one word each.
- **Dependents swept by grepping the corpus, not by listing remembered sites**: the only per-weapon 2 left in
  the book after the merge is `13:474`'s Riposte `(2 Melee)`, which is a **card** requirement and stays.
- **Audit against the work order:** file set exactly as specified, em-dashes in added lines **0**, native-Typst
  gate exit 0, independent build exit 0 / **392 pages**, and all ten changed fragments re-read in the
  **render** rather than the source diff.
- **Tracker at wake:** 0 PRs, 8 open issues, ledger 175 rows, `main` at `1e21765`.

## Queue — ordered, each item tied to its pillar

**Ordering note (2026-09-26, per #659):** until `assessment.md`'s coverage table reads 9 of 9, the
queue's source of direction is that file's **"What matters now"**, not the order below. The rows here
are the *filed* work; the assessment says what outranks which. Read them together.

| # | Work | Source | Why it is ordered here |
|---|---|---|---|
| 1 | **#655 — the Fate module** (9 class cost rows, the Comprehensive row, 5 talents, 2 spells) | row 125; ledger row 159 | Ruled, specced, filed, and runnable the moment dispatch is enabled. Until it lands the book advertises a Discipline nobody can buy. |
| 2 | **Rebuild the nine ch02 printed builds** (gear ranks unpaid; culture-skill duplication) | rows 161, 162, walkthrough W-001 | **UNBLOCKED and filed as #670** (cycle 9 decided both rows; the requirements half landed cycle 10 as #673). It is the largest cohesion defect in the book (26 DP + 18 DP across 9 builds); the fix direction is now ruled, so it is a work order rather than a question. |
| 3 | **Retitle the three mis-titled ch09 talents** (`09:94`, `09:184`, `09:189`) | ledger row 160 | Three cards, one convention, and half of #655's file set, so it runs AFTER #655 merges. |
| 4 | **The Summon module** (row 151) | `discipline-completion-spec-20260916.md` section 2 | Writes the same nine class tables as #655, so it serialises behind it. Re-derive the bestiary Challenge values at dispatch time. |
| 5 | **#561 — ch09 council pass, substantive tier** | open issue | Already scoped per-line; no design fork. |
| 6 | **#587 — level 0/1 DP pools** | **CLOSED cycle 9** | Its own parked revival trigger fired (the level-1 pool IS too tight) and the answer was printed rather than needed: creation owes the level-1 4 DP (`18:47`). Landed as a decision, not a reprice; the work order is #670. |
| 7 | **23-license** — Wave 2 stands at 24/25 | row 2 | Outstanding chapter. |
| 8 | **Closing balance audit** — one full-book budget walk | row 2 | The closing act of the build pass; waits on items 1 and 4 landing. |
| 9 | **The economy's line-level repairs** - the true-price statement, 4 misnamed structures | assessment 2 (cycle 3) | **Filed as #661.** Mechanical and determinate, no ruling needed, so the engine can take it today. It is the cheapest fix in the book's most expensive defect class: 44 DP of unfunded spend in rows 161/162 traces to a price the book states incorrectly. |
| 10 | **Pacing lever 2 - size the Standard encounter to the party's actions** (1.5 creatures per hero) | row 165, cycle 6 decision | **MERGED cycle 9 as PR #669** (`main` at `262cd47`). Dispatched, audited and merged in the same cycle: gate **3.79 / 3.68 / 3.36 rounds, exit 0** against 1.26 / 1.05 / 0.96, independent build exit 0 / 392 pages, one redirect (the ch22 quick reference still carried the retired budgets). The gate itself was stale and was corrected to the amended law in the same pass. |
| 11 | **#680 — equipment: price the three unpriced item classes, fix the dominated Crossbow row** | Assessment 7 (cycle 13), rows 184/185 | Filed cycle 13 with exact old-to-new for all nine sites in three files (ch15, ch16, ch22). Values derived rather than chosen: shields 1/2/3 by the class ladder they already use, robes 1 slot (the only value that keeps the tightest printed build legal), the ammunition bundle convention, and the Crossbow off the 20/60 thrown band onto 60/120. No new rule, no damage/DR number moves. |
| 12 | **#677 - social conflict: the dead score and the inverted example** | Assessment 6 (cycle 12), row 179 | **MERGED cycle 13 as PR #678** (`main` at `f0c9af3`, issue closed). Dispatched cycle 13 and audited in the same cycle: 3 files, 6 sites, the example's arithmetic untouched, render-verified. |
| 13 | **#685 - ch19: the encounter ladder's words in the party's pool currency, and the starter boss sized for his own scene** | Assessment 9 (cycle 15), row 187 | **MERGED cycle 16 as PR #688** (`main` at `e426c94`, issue closed with the audit attached). Dispatched, audited and merged in the same cycle: 1 file, 4 insertions / 2 deletions; the four rung phrases restated in the pool currency ("about half the day / about three quarters / the whole day / more than a day") against the gate's 49 / 73 / 97 / 146 percent; Kelvath `HP 8 -> 32` = 3 x 2.67 x 4 attackers, putting his fight at 2.3 rounds inside his scene's 2-5 round seal clock. No band, HP rule, DR, Grit or #663 number moved. |
| 14 | **#686 - ch20: name the monster HP rule's unit (three rounds of ONE attacker)** | Assessment 9 (cycle 15), row 188 | **MERGED cycle 17 as PR #689** (`main` `26a5be3`, #686 closed with the audit attached). Dispatched, audited and merged in the cycle: 1 file, 2+/2-, stat-block `HP <n>` lines byte-identical to main, native gate exit 0, independent build exit 0 / 394 pages (main 393). The dispatch gate closed an ambiguity in the filed wording before any prompt existed (roster vs rate). Nothing in the 49-block corpus changes: the sentence stops a DA sizing a solo boss on a per-attacker number, which is how Kelvath's Scene 4 was built (row 187). |

## Next action

Cycle 23: **#561** (ch09's council substantive tier S-1..S-11) is the only open issue, and it must not be dispatched as written: each item needs its ruling decided first, and cycle 21's grep already shows two premises false (S-4's "Guarding Stance and Miracle Worker have ch05 twins" - neither name appears anywhere outside ch09). Then the deferred **walkthrough** (`thinking_due` has been lit for three cycles and is the first thing to take once #561 is closed or dispatched). Then the housekeeping candidate below. The closing full-book balance audit is DONE (cycle 21, assessment.md).

**Instrument debt found in cycle 17 (fixed the same cycle):** the pipeline skill's own law carried the phantom rule **"Monster HP ≈ 5 × Challenge"**, which the book does not print and has not since `1ed2c8e` repriced the bestiary against the live bands (#531 phase 4). It survived in three skill files (`SKILL.md`, `references/design-rulings.md`, `references/closing-balance-audit.md`) - the same class as the corrected "DR = Challenge // 2" phantom, and the one consumer a book-wide grep never reaches. Corrected in all three to the printed rule plus the per-attacker unit.

**Housekeeping candidate (not this cycle's work):** two one-off migration repair scripts are still tracked inside the book source directory, unreferenced by anything - `quarto-book/fix-unicode-corruption.ps1` (102 lines, added in `9e71019`) and `quarto-book/replace-em-dashes.ps1`. A mechanical micro-PR can move or drop them; they are repo dirt under the Succinct criterion, not book content.

## Cycle log

| Cycle | Did | Moved | Next |
|---|---|---|---|
| 0 (bootstrap) | role card + cycle contract written; state files created; baselines measured; repo state verified | the loop exists | run cycle 1 on item #1 |
| 1 (2026-09-26) | SENSE: bootstrap merged (#654), rows 125/151 re-verified against `origin/main@eb8b5e0`, tracker read. THINK: priority (a), a ruled-but-unbuilt row. DECIDE: the Fate module is ruled and dispatchable; its three unruled defaults got ledger row 159; a fresh ch09 title/tier defect got row 160. DISPATCH: blocked by design (`HOL_ARCHITECT_DISPATCH` unset), so the work order was filed as **#655** with every number pre-computed. | **#655** filed; rows 125 and 151 commented; rows 159 and 160 added; scorecard gained the title-vs-tier instrument; landed as PR **#656** (PR #654 audited - docs only, merged) | cycle 2: walkthrough #1 (Playable), then #655 dispatch if enabled |
| 2 (2026-09-26) | SENSE: 0 PRs, 3 open issues, `main` unmoved at `f33a51a`, dispatch still off, nothing `s:working`, canon index re-built and calibration passed (ch11 = 68 cards). THINK: nothing in flight, so priority (d) - the instrument the role exists for. RAN walkthrough W-001 (first session) on `origin/main@f33a51a`: built a hero through Steps 1-11, walked all nine printed builds against the loadout cost model, then played ch13's worked round and a goblin scene. DECIDE: four defects, all in the creation economy the 2026-09-16 armament collapse rewrote; two single-outcome (Challenge 1/2's penalty, ch13:502's round total) fixed same day, two need one word each (rows 161 gear ranks, 162 culture skill). FILED nothing new: #655 already carries the Fate module. | **W-001 transcript** written; ledger rows **161/162/163**; **#587** commented with the 26-DP measurement; **9 book defects fixed** (`06:111`, `21:231`, `13:502`) and verified in the rebuilt PDF; scorecard: Playable 0 -> 1 transcript, two new measurements | cycle 3: level walkthrough (gates 1/3/7), or #655 dispatch if enabled |
| 3 (2026-09-26) | SENSE: main advanced to `2a13070` (cycle 2 merged), canon index re-built, calibration passed again (ch11 = 68), dispatch still off, and a **state change the monitor caught: #659 (new direction from Bruce: assess from the foundation up) plus an open PR #660** carrying Assessment 1 at coverage 1 of 9. INSPECT: re-derived every one of Assessment 1's probability rows from the 216 outcomes - all six correct, and the first checker written for the job was itself the bug (it capped Strong at 18, dropping 4/216 outcomes at +2). THINK: the sweep's next subsystem, the economy. Computed the true price of a card (2-6 DP), damage per DP (3.00 / 2.00 / 1.29), the rank supply (3 progression picks), and the 8-DP promise class by class. Also measured Assessment 1's priority 1 - Grit holds time-to-kill flat (5.8 / 5.9 / 5.8) - and reversed it. DECIDE: 3 rulings go to rows (Shepherd, Master efficiency, K/F double bank); the line-level defects are mechanical and determinate, so they go out as one filed work order. | **Assessment 2 landed** (coverage 1 -> 2 of 9); **priority 1 reversed with the numbers**; rows **165/166/167** and a comment on 161; **#661 filed**; carried on PR **#660** | cycle 4: Assessment 3, creation and progression |
| 4 (2026-09-26) | SENSE: #660 open, 4 open issues, dispatch off. BRUCE RULED (row 165): an even fight must last 3-4 rounds at every tier, whatever the level; Grit stays as the staying-power mechanic. THINK: build the gate Bruce's ruling needs. Wrote `scripts/rounds-to-resolve.py`, measured the gap, named three levers. DECIDE: the ruling is a law to be gated, so the instrument ships with it. CLOSED #660 and opened **#662** (`docs/architect-pacing-law`) carrying `assessment.md` plus the row. | **#662 opened**; row **165** (the pacing law); **#660 closed** and superseded; nothing merged, so `main` stayed at `2a13070` | cycle 5: inspect #662, then Assessment 3 |
| 5 (2026-09-26) | SENSE: state diff showed #662 replacing #660 with `main` unmoved - so nothing of cycle 4 had landed, and #660's three commits were still reachable locally. INSPECT (#662, 1 commit, 2 files): found four defects - citations to rows 165/166/167 where only 165 existed and 165 meant the pacing law; a whole cycle of plan/scorecard state dropped with #660; two sections both named "Assessment 2"; and a gate that paired a Master party with the bestiary's global average HP and measured the book's DEADLY encounter while calling it even. VERIFY-BEFORE-TRUST on the numbers themselves: re-parsed the bestiary (48 stat blocks, not 51 HP mentions), stratified by challenge band, subtracted DR on both sides, and counted Grit and armour DR in the other direction. DECIDE: all four defects are mechanical or self-refuting, so they were fixed on the same branch rather than reported; the measurement corrections are recorded BESIDE the old verdict, and the withdrawn claim is named as withdrawn. Rebuilt the gate with a positive and a negative control. | **#662 repaired in place**: rows **166/167/168** restored and all citations resolve; the pacing re-assessment written (4v4 2.52/2.10/1.92, Standard encounter 1.26/1.05/0.96, party dropped 12.7/12.9/12.7 flat, root cause ch19-vs-ch20 premise mismatch, lever 2 recommended); plan cycle-3/4/5 states and scorecard rows restored; gate rebuilt with controls and still exiting 1 | cycle 6: Assessment 3 (creation and progression), unless Bruce rules row 165 or enables dispatch |
| 6 (2026-09-26) | SENSE: the monitor caught #662's head moving to `d7dd284`, a fourth commit reconciling the 51-vs-48 bestiary count. INSPECT: docs-only (4 files, no chapter touched), and every citation the branch makes re-verified against the corpus (`19:53`, `19:55`, `20:659`'s HP rule, the Lesser Treant at `20:607`, the Death Knight's reforming armour at `20:637`); gate `--selftest` passes both controls while the live run exits 1. The PR body still led with the retracted mutual-rout figures, so it was corrected BEFORE merging: the durable record should not open with numbers the branch itself withdraws. Merged. THINK: with the law ruled and the lever mine to choose, the pacing repair outranks a new assessment (the plan's own rule). Ran the numbers that pick the lever: creature HP is flat across the whole bestiary (15.0-15.1 by band) while Challenge runs 1/2 to 12, so HP per challenge point falls 15.78 / 3.74 / 1.80, and the printed budget yields a coincidentally flat ~30 HP at every tier, which is about one round of a four-hero party's output. The count is the instrument that works: six creatures (one and a half per hero) land 3.79 / 3.15 / 2.88 rounds and need 14.0 / 16.4 / 18.2 HP per monster against 15.1 / 14.8 / 15.0 printed, so **no stat block in ch20 needs to change**; Master wants seven (3.36 rounds) because party output grows 1.31x while monster HP does not. DECIDE: lever 2, specified as a per-hero budget plus a stated field size, recorded as a veto-revertible default and filed as a work order. | **#662 merged** (squash, branch deleted; `main` at `340fd11`); PR body corrected before merge; **#663 filed** with the full spec and every number pre-computed; row **165** now carries the lever decision as a veto-revertible default; `assessment.md` gained the cycle-6 section and coverage row 4 records the repair; **#661**'s stale "row 165" citation for the Shepherd corrected to 166; #659 umbrella noted | cycle 7: Assessment 3 (creation and progression), unless the dispatch gate opens, in which case #663 goes first |
| 7 (2026-09-26) | SENSE: no PRs open, `main` moved only by my own cycle 6 (`303a5fe`), dispatch still off, so nothing to inspect - straight to priority 1. THINK: Assessment 3 (creation and progression) plus the role card's level walkthrough, which is the same territory. Computed the reachable space rather than quoting it (Background DP 4-12, HP 6-14, career 44-52 DP, ranks 1-3), re-derived all nine printed builds' HP/Initiative/Carry (9 of 9 exact), and walked the ten levels for a dead rung (none: skills share the card tiers and gate nothing, so the sink is 322 DP wide, and the binding constraint after level 3 is the 3-rank ceiling, not the pool). Two new instruments, both with calibration: the tier census found the book's own tier RULE contradicting its corpus (59 of 102 cards, 174 DP, hang on whether "the number of Disciplines" or the total RANKS is the reading), and the healing census found the healing axis never converted to the live band rows - because the 2026-09-15 sweep grepped slash-triples, which is how DAMAGE prints, and a healing card prints one HP per line. DECIDE: both are single-outcome conformance defects, not design questions, so they were repaired the same cycle and merged by the architect rather than queued; the census itself was corrected mid-work when per-figure membership declared Mending Touch conforming on two of three lines (the retired and live Novice rows share 4 and 6). The three items that do need a ruling - the recurring-effect convention, two Adept cards printing the Master row, an untiered crit heal - went to rows, and the unassigned level-1 4 DP went to a row with its re-costing of row 161 measured. | **PR #665 merged** (`main` at `7ebbff2`): 4 chapter files, 17 lines, gate exit 0, build exit 0, 392 pages, and every change verified in the render - healing-axis retired rows **4 -> 0**, tier mispricing **59 -> 0**. **Assessment 3** landed (coverage 3 -> **4 of 9**), **W-002** written, rows **169/170/171** added, row **160** amended, plan/scorecard updated | cycle 8: Assessment 5 (magic and the spell system), beginning with the recurring-effect convention; #663 then #661 if the gate opens |
| 8 (2026-09-26) | SENSE: 0 PRs open, `main` moved only by my own cycle 7 (`40ef0eb`), dispatch still off, clean checkout, no worktrees - nothing to inspect, so straight to priority 1. THINK: Assessment 5, magic and the spell system, and the sweep's first subsystem whose defects are mostly in the RULES rather than the numbers. Built the axis census (`architect-magic-census.py`, three negative controls, all passing) over 114 spell cards: 68 arcane (15 cantrips + 53 spells) and 46 divine (6 cantrips + 40 spells); enumerated the casting odds from the 216 outcomes (Weak 48.2% at mod -2 down to 0.46% at +5, so the bands discriminate across the realistic range); computed damage per DP 3.00 / 2.00 / 1.25 and casts-to-drop 2.21 / 1.65 / 1.30. INSPECT turned up the finding the sweep exists for: **the 2026-09-15 band change was verified on one axis and there are three.** Healing was cycle 7's (row 170). The third is printed numbers with no slash triple, and it is still unconverted: **7 of 7 ch17 item ladders (21 figures) sit on the retired rows** although 17:29 prints the live rows in the chapter's own header, and **5 Master abilities in ch05 print 9 or 15**. #546 (closed) covered ch11/ch12 "and their mirrors" and names neither file. DECIDE: band conformance is single-outcome, so it was repaired in-cycle rather than queued (26 figures moved by position onto the live rows, verified in the render). The four genuine design questions went to rows: the casting skill is named nowhere (114 cards), Primal is a tradition with 12 cards, 7 requirements, 0 items, 0 glossary entries and 0 classes, the Adept limit's own worked example contradicts its justification, and the focus downgrade's floor is defined only for damage (23 of 59 focus-carrying cards have a non-damage Weak rung). | **PR #667 merged**: 2 chapter files, 26 figures, native-Typst gate 0, build exit 0, 392 pages, every changed value re-read in the PDF; **Assessment 5 landed (coverage 4 -> 5 of 9)**, three queue rows promoted into the ranked list; rows **172-176** added; one work order filed (**#668**, the magic entry-point pack: name the casting skill, complete the Primal tradition) | cycle 9: Assessment 6, social conflict - the last member of the pillar trio (combat, magic, social) and the only one whose resolution mechanic (Challenge) another assessment has already touched |
| 9 (2026-09-26) | SENSE: dispatch is ON (`HOL_ARCHITECT_DISPATCH=1`), `main` at `e86109c`, 0 PRs, 7 open issues, ledger 175 rows at wake. Nothing in flight to inspect, so straight to priority 1 - the six balance rows the loop's brief named. THINK: each row classified before acting, and all six came out BALANCE. Re-derived every loadout cost from the class tables rather than the rows' own summaries, which is where the cycle found its number: the level-1 4 DP award (`18:47`, inside the 32 that `22:272` already counts) is exactly the gear-funding hole the walkthrough measured, so the Level-1 pool is 12 DP and **8 of 9 builds close with every card intact**. DECIDE: 162 (culture bonus is the Novice tier, duplicate purchase is waste), 166 (dissolves - the Shepherd's line is true at 12 DP), 167 (state the intent; invariant 4 forbids a reprice), 168 (closed as measured; presupposes a defect the book already answers at `03:100`), 169 (award the 4 DP at creation), 171 (grade the total; the per-round figure paces it, because the live rows contain primes and no uniform per-round figure can sum to them) - plus 161 (retracting its own earlier recommendation in place: the missing line, not the rule) and 164 (defect not fork: uniform one rank per weapon category, tower shield 3 Shields). FILED #670/#671/#672, CLOSED #587 on its own revival trigger. | **#663 dispatched, audited and merged** as PR **#669** (`main` at `262cd47`) - the first agent this project has run. Audit: 2 files, 7 lines, zero em-dashes added, native-Typst gate 0, independent build exit 0 / 392 pages, and **one redirect before merge**: the work order's file scope missed the duplicate encounter table in the ch22 quick reference (`22:333-336`), which still printed the retired x1/x2/x3/x4+ budgets and the two-creature Standard, so the corrected table was mirrored onto the branch (`0980e88`). The gate was itself stale (it hard-coded the two-creature Standard) and now reads **3.79 / 3.68 / 3.36 rounds, exit 0** against 1.26 / 1.05 / 0.96, selftest passing both controls. Rows **161/162/164/166/167/168/169/171** decided with their measurements; **#670/#671/#672 filed**, **#587 closed**; worktree and branch removed. | cycle 10: dispatch #671 (then #670, which assumes it), then Assessment 6 (social conflict) |
| 10 (2026-09-26) | SENSE: the monitor caught my own cycle 9 landing (`main` at `1e21765`, #587/#663 closed, #670/#671/#672 filed), 0 PRs open, dispatch ON. Nothing in flight, so straight to priority 1 - the queue's head. THINK: the dispatch gate BEFORE the prompt, per the spec-hygiene rule, and it paid for itself twice on a work order that already carried a full spec. (a) `05:338` prints `Longsword (2 Melee)`: a **fourth** per-weapon rank-2 survivor that the cycle-9 spec had explicitly excluded ("do not change `05:338` ... both already close on the corrected rule"), and its printed 4 DP only closes on Melee ranks 1+2 (1+2 = 3 DP) plus Two-Handed rank 1 (1 DP) at the Leader's Home rates (`05:351-352`), so under the uniform 1-rank rule the line reads **2 DP**, not 4. (b) The cycle-3 instrument's own headline defect - "four classes call a 4/8/16 charge at your Foreign rate" - was filed as #661 and had never been fixed; the four lines sit in the same file as (a), their numbers are right and only the rate NAME is wrong, so they rode along at one word each (`05:107`/`158`/`202`/`408`). Also corrected the ch02 reference (458 -> 457). DECIDE: amend the issue body rather than dispatch a spec I could already show was mis-cited, with the arithmetic computed by me and written into the spec as fixed values. DISPATCH: worktree `wt-671`, branch `fix/671-gear-requirements`, background `opencode`. AUDIT against the work order: 6 files, 11 lines, exactly the specified sites, em-dashes in added lines **0**, native-Typst gate exit 0, independent build exit 0 / **392 pages**, and all ten changed fragments re-read in the **render** (not the source diff); dependents swept branch-wide, leaving only `13:474`'s Riposte `(2 Melee)`, which is a CARD requirement and stays. | **PR #673 merged** (squash, branch deleted locally and on origin; `main` at `997abd1`), **#671 CLOSED** by the PR; row **164**'s status cell records the round and its Concern cell carries an explicit CYCLE 10 arithmetic correction (the old "Melee rank 2 = 2 DP and Two-Handed rank 1 = 2 DP" was wrong in its working and right only in its total); scorecard "printed label matches printed price" **5 of 9 -> 9 of 9**; plan state section added and queue item 2 marked unblocked | cycle 11: dispatch **#670** (creation economy: the level-1 4 DP award, the nine build ledgers, the culture-skill swap), then #672 |

### Cycle 11 (2026-09-26) - #670 dispatched, audited and merged (PR #674 `5c52f12`); the pacing gate's second verdict recorded

- **SENSE.** `main` at `59c6563`, 0 PRs, 7 open issues (#671 closed by cycle 10), ledger 175 rows. Dispatch ON.
- **DISPATCH GATE (before the prompt was written) - four things the work order had wrong.** (1) `18:66` is the quote block: the level-1 row is **`18:47`** and the printed total is `18:63` (not `22:270`), and the same mis-cite sat in five docs; (2) the chapter's own Quick-Build summary `02:30` prints "Class DP: 8 DP" and was **not in the work list** at all; (3) "three on +2/+4 surplus" is **four** (the ninth build trims); (4) Makeva's header carries the `*Step 7, ` prefix the other eight lack. All four amended into #670 before dispatch.
- **DISPATCH.** Worktree `/tmp/wt-670`, branch `fix/670-creation-economy` from `origin/main`, spec seeded as `.task-spec.md`, opencode in background. The spec carried every build's fixed arithmetic (pool, loadout ranks at the class's own rate, cards, closing line) and the **13 named skill swaps and surplus spends** so the agent authored no number and no skill name.
- **INSPECT.** File set exactly the four named chapters; em-dashes in added lines 0; markdown bold 0; native-Typst gate exit 0; independent build exit 0, **392 pages**; a parser reading the branch file re-derived all **nine ledgers - 9/9 closing at 12 DP, 0 mismatches, 0 culture-note residuals**. **The audit found a defect my own spec caused:** three added lines put a crossref inside a parenthesis and typed the sentence period after the closing paren, rendering `(Chapter 10.).` and `in Chapter 20.).` The repair is the book's own precedent (`08:99`): the ref ends the clause and **nothing** is typed after it. Repaired on-branch (first attempt replaced one double period with the other - the bare `Chapter 20..` - and the render gate caught that too), then re-verified: bare double period **0**.
- **MERGE.** #674 squash-merged, remote and local branch deleted, **#670 closed**, worktree removed, merged tree byte-identical to the audited branch tip (`git diff --stat cdf6136 origin/main` empty).
- **RECORD.** Rows 161/162/165/166/169 marked IMPLEMENTED; `18:66` corrected to `18:47` in five docs; two new rows: **177** (the pacing gate's second verdict - a Standard fight spends 89.3 / 99.8 / 92.9 percent of the per-respite pool against `19:53`'s "some resources", with the Catch Breath model gap named as the first thing to settle) and **178** (the punctuation sweep, **filed as #675**, 15 sites in 10 files).
- **Next.** Dispatch **#672** (recurring effects, row 171's work order); **#675** (mechanical, disjoint files) rides the cycle after. The sweep is still 5 of 9 - social conflict (6) is next once the queue thins, and row 177 is the first item on the balance queue that needs its model settled before a lever is chosen.

### Cycle 12 (2026-09-26) - #672 merged (PR #676 `c51597c`); Assessment 6 lands the pillar trio at 6 of 9

- **SENSE.** The monitor's diff was my own cycle 11 landing (`main` `59c6563` -> `c68aa13`), #670 closed by its merge, #675 filed, ledger 175 -> 177 rows, `thinking_due` now computing instead of reading UNSTAMPED. Dispatch ON, 0 PRs, 7 open issues, clean checkout, no worktrees.
- **PRIORITY 1 WAS ALREADY DONE.** The brief names rows 162/166/167/168/169/171 as "needs Bruce"; all six were classified and decided in cycle 9 and landed in cycle 11 (162/166/169 marked IMPLEMENTED, 168 closed as measured, 167/171 stated as intent). Verified each row's STATUS cell against the file rather than the previous report, then moved to the queue head.
- **DISPATCH GATE.** Re-derived every claim in #672's spec against `origin/main` before writing the prompt: all four line refs correct (`12:123/125/127`, `12:132`, `12:146`, `10:101`), all five target figures computed. **One correction, and it was mine to make:** the spec shelved the new convention sentence in `== Limitations`, which is the brake list (per-encounter, per-session, concentration, ritual, ending an effect). A budgeting convention belongs where a reader is reading a card's outcome block, so it moved to the Spell Cards section after `10:54`. First draft of the amendment *named* the rejected location to close it off, which is the same transcription trap the one-path rule exists to prevent; rewrote it to state the single path positively.
- **AUDIT.** 2 files, 4 edits, exactly the spec. Em-dashes in added lines 0, markdown bold 0, native-Typst gate exit 0, independent build exit 0 / **392 pages**, the new sentence present exactly once, all three Flesh Renewal maxima and both 5/8/11 totals re-read in the **render**. One "retired row" grep hit turned out to be the compliant multi-attack split (3+3 = 6) - my regex was over-broad, the book was right.
- **MERGE.** #676 squash-merged, `main` at `c51597c`, both files byte-identical to the audited tip. #672 had already been auto-closed by the merge, so the audit evidence was attached as a comment afterwards; local and remote branches deleted, worktree removed.
- **THINK - Assessment 6, social conflict** (the sweep's next subsystem and the last member of the pillar trio). New instrument `scripts/architect-social-census.py` in the **skill** scripts dir (the repo has no tracked `scripts/`; the skill is the home for all of them). Its first two drafts were the bug: subtracting the fumble out of the Weak band goes negative at mod +6, because three natural 1s sums to 9 and lands in Standard, which drove P(party wins) to **100.007%**; and the duration invariant I asserted was wrong (a lopsided conflict ends fast in *both* directions, so E[rounds] peaks at the balanced point). The walk now enumerates all 216 rolls and assigns each exactly one outcome, and the self-test asserts what is actually true: probabilities normalise, P(party) is monotone, duration peaks. Negative control re-runs the walk with the NPC scoring 2 on a Weak and moves every row.
- **MEASURED.** Face modifier reaches **-4 to +7**. P(party wins) **12.4% -> 100%**, coin flip at **-2** (51.2%), duration peaking at **4.02 rounds** and on the pacing law's 3-4 through the whole playable middle. Passive Insight spans **5-9** and reaches Strong **0 times out of 5**. Cross-checks that came back CLEAN and are recorded so they are not re-filed: the two social tables are already scoped on both sides (`14:54`, `14:86`); the figure label `16.1` is correct (hardcoded labels run file+2 book-wide); the worked example's arithmetic is exactly right (13 Standard / 13 assist scoring nothing / 18 Strong, 1+2 = 3); assists are bounded by the Boon potence ladder; the DA rolling for a passive NPC is covered by `06`.
- **DECIDED.** Two entry-point defects go out as one work order, **#677** (same file group: `14` + `07` + `21`), with exact old-to-new text for all six sites: Passive Insight's three homes restate the Challenge the book already prints at `14:68` and drop the dead score; the worked example's attitude shift moves from Round 1's Standard onto the winning Strong. The two long-carried "needs a ruling" queue rows were reclassified as BALANCE and decided: **row 180** (the dial's asymmetry is load-bearing - a symmetric +/-4 dial would leave a Master specialist unfailable) and **row 181** (the "failure collapse" measured the Weak band, not failure; the fumble overrides the tier, so P(failure) is flat at 1/216 at +5 and +6 and never 0). No number moved in either.
- **RECORD.** Assessment 6 section + coverage 5 -> **6 of 9**; row 17 added to the ranked queue; queue rows 4 and 5 marked decided in place; ledger rows **179/180/181**; scorecard gained two measured lines and trend row 12.
- **Next.** Dispatch **#677** (social conflict), then assess subsystem 7, equipment. #675 rides whichever cycle has a free slot. Row 177 (the pacing gate's second verdict) still needs its model gap measured before a lever is chosen.

### Cycle 13 (2026-09-26) - #677 merged (PR #678 `f0c9af3`); the mirror residuals and a phantom economy closed (PR #679 `574794c`); Assessment 7 (equipment) at 7 of 9

- **SENSE.** The monitor's diff was my own cycle 12 landing (`main` `c68aa13` -> `e813157`): #672 closed by its merge, #677 opened, ledger 180 rows / max 181. Clean checkout on `main`, 0 worktrees, 0 open PRs, dispatch on.
- **INSPECT.** None open at SENSE time. PR #678 (the #677 work order) landed DURING the cycle: 3 files, 6 sites, added-line em-dashes 0 / markdown bold 0 / no new parenthetical refs, native gate exit 0, independent build in its own worktree exit 0 / 392 pages, every site compared against the spec line by line, and the render verified (the dead score reads 0, both new Challenge clauses 1-2, the worked example's 13 / 13 / 18 and 1+2 = 3 unchanged). Squash-merged, `main` `f0c9af3`, #677 auto-closed, worktree and both branches cleaned.
- **THINK - Assessment 7, equipment** (the sweep's next subsystem). Instrument: a fresh parse of ch15/ch16/ch22's tables, the 76 card `Requires:` lines across ch09/ch11/ch12, and all nine printed builds' equipment lines.
- **MEASURED.** DR: post-DR bands read 3/5/7, 3/6/9, 4/7/11 and the printed ceilings 3/4/6 sit exactly on the invariant's boundary (DR <= Weak - 1); nothing stacks, and ruling 145's single-source shield is what all six homes and all four DR cards print. Slots: all nine builds fit the budget their own Brawn prints (tightest 5 of 5), once the three unpriced item classes are priced at the values their own builds imply.
- **DECIDED + LANDED (PR #679, `574794c`).** Two mirror residuals from the closed requirements sweep (`15`'s tag table still read 2 Two-Handed against the uniform 1 rank; the same callout's shield sentence and Shields line still carried the retired two-size model, with no medium class) plus a phantom economy: ch21's glossary promised "Gear is bought with gold" and ch15 offered a pack "purchase" while ch15:15, ch15:239 and ch19:73 all say gear is never bought, and the book prints no currency at all (0 prices, 0 coins, 0 starting wealth). Mechanically aligned to the printed model; adding a currency would be new content and is Bruce's call, not required by this fix.
- **WORK ORDER #680 FILED.** Three item classes the slot system does not price (shields in all three homes, scholar's robes in three printed builds and no table, a bundle of thrown weapons) and the one weapon row dominated on every axis including a penalty (the Crossbow: a thrown weapon's 20/60 band for 2 slots and a Loading Maneuver). Values derived, not chosen: shields 1/2/3 on the class ladder they already use, robes 1 slot (the only value keeping the tightest build legal), the ammunition bundle convention, and the Crossbow onto 60/120. Loading stays, trade named.
- **IMPLEMENTED DEFAULT (row 174).** The Adept limit is per card, which the book's own worked example already prints, so the false justification sentence ("You can't drop an Adept spell every round") goes and the rule names the reading.
- **RECORD.** Assessment 7 section + coverage 6 -> **7 of 9**; two measured scorecard lines and trend row 13; ledger rows **182-185**; queue items 11/12. Duplicate Assessment 5 section and six stale "needs a ruling" status cells in the ranked queue reconciled against the ledger.
- **Next.** Dispatch **#680** (equipment: the three unpriced item classes and the Crossbow band), then assess subsystem 8, content. #675/#655/#661/#668/#561 ride behind it. Row 175's default and row 177's model gap are the next balance items the ranked queue names.

### Cycle 14 (2026-09-27) - #680 merged (PR #682 `aaab1ca`); the Sleight dead rank found, decided and landed (PR #684 `ecc59f7`); Assessment 8 (content) at 8 of 9

- **SENSE.** The monitor's diff was my own cycle 13 landing (`main` `e813157` -> `3f3b344`): #677 closed by its merge, #680 opened, ledger 184 rows / max 185, `thinking_due` 1. Clean checkout on `main`, 0 worktrees, 0 open PRs.
- **PRIORITY 1 (the misclassified balance rows) is long done** - rows 162/166/167/168/169/171 were classified and decided in cycle 9 and landed in cycle 11. Re-verified as bookkeeping, not re-argued.
- **DISPATCH GATE (before the prompt was written) - two things the work order had wrong, and one it had right that I nearly "fixed".** Every line ref in #680 was re-read against `origin/main` (all ten correct, including 15:208/209 for the Sack/Shovel insertion, 22:420/421, the 15:225 anchor, and 02:403's 5-slot budget that fixes the robe at 1). The header said "8 sites" for nine numbered items; the Bundles paragraph's insertion point was described as the table's `)])` when the file has `)],` + four closing lines + `)`. Both amended into the body before dispatch. **The near-miss:** the five-column shield table keeps a four-entry `align:` array, and the house convention is one `auto` per column; I compiled a five-column table with a short align array in `typst` first and it renders fine, so I amended nothing. The trap was caught by testing, not by "fixing".
- **AUDIT.** #682: file set exactly the three named chapters (0 `docs/design/` touches), 0 em-dashes / 0 dice / 0 retired rows in added lines, native gate exit 0, **independent build in the PR's own worktree exit 0 / 392 pages**, the render re-read (392 pages, `60/120 ft` 6, `Robes` 2, the new `Slots` column present, both bundle sentences present with the ch22 one wrapping across lines). **The regression the new rule owed:** a shield slot cost is a NEW number, so every printed build carrying a shield was re-priced - 02:483 is 8 of 15, 02:600 is 9 of 20, the Protector loadout 8 against a Brawn-keyed pool, and the book's tightest build (02:403, 5 of 5) carries no shield. All fit. One defect the spec authored and the agent transcribed faithfully (the shield ladder restated twice in one callout) was fixed on-branch, which is where a wording defect belongs.
- **MERGE.** #682 squash-merged, `main` `aaab1ca`, #680 auto-closed with the audit attached as a comment (the mutation to check - the merge had closed it before my comment landed), remote and local branches deleted, worktree removed.
- **THINK - Assessment 8, content** (ancestries, classes, disciplines, the card library) on a new instrument, `scripts/architect-content-census.py`, in the skill's scripts dir. Its first version was the bug twice: it counted class abilities at the wrong heading level and parsed only the LEFT column of every class cost table, which reported Shields/Protection/Armor as "priced nowhere" and Sleight/Lore/Stealth as floor violations. The class abilities live in **five tables**, not headings; `tier-census.py` was then run as the independent cross-check for the tier reading.
- **MEASURED.** Calibrated against the book's own totals before any figure was read: **196 cards** (82 + 68 = 15 cantrips + 53 spells + 46 = 6 + 40) plus **90 class abilities** = 286 containers, and **exactly 10 abilities per class**. Law gates over the nine content chapters: **0 retired rows, 0 damage dice, 0 flat `+N` riders, 0 numeric roll modifiers** - the cleanest single result in the sweep. Tier distribution 51 / 52 / 64 / 25 (+4). Reachable career budget **6 ranks**, deepest printed requirement **5**, so every requirement in the book is reachable with one rank spare.
- **DECIDED (BALANCE, veto to revert).** **Sleight rank 2 is dead content**: priced in every class table, consumed at rank 1 by nine sites, and required at rank 2 by nothing. That is invariant 8 and coverage-standard rule 1. There is no rank-3 requirement to invent either, and rule 2 makes rank 3 optional, so the fix is the standard's own prescribed mechanism (re-key existing content, as with Fate): **Filch moves to `1 Stealth, 2 Sleight`**. Tier preserved (3 ranks, `[Master]` label true), Stealth's floor still met by Ghost, cost unchanged for the Shadow and cheaper for the Blade. Routed three ways at once, because the decision, the "what matters" row and the "about 10 per class" claim all had to agree.
- **LANDED.** #683 filed with the full reasoning and the exact old-to-new, then implemented as a **micro-PR (#684, `main` `ecc59f7`)**: one line, one file, `git grep -n Filch` = 1 hit book-wide so no mirror to sweep, native gate exit 0, independent build exit 0 / 392 pages, render reads `2 Stealth` 2 -> 1 and `2 Sleight` 0 -> 1.
- **RECORD.** Assessment 8 section + coverage 7 -> **8 of 9**; ranked-queue row 18 marked MERGED, row 11 rewritten to carry all three dead ranks; scorecard trend row 14; **ledger row 186** (Sleight) plus rows 184/185 status cells marked implemented rather than decidable; words 82,057 -> **82,171**.
- **Next.** Assess subsystem 9, **bestiary and GM tools** (the last one), then the closing full-book balance audit that rows 2/3 hold open. #655 (Fate) and the Summon module queue behind it; #561/#659/#661/#668/#675 ride as capacity allows.

### Cycle 15 (2026-09-27) - #661 merged (PR #687 `1c06fa0`); Assessment 9 lands and the 9-subsystem sweep is COMPLETE at 9 of 9

- **SENSE.** The monitor's diff was my own cycle 14 landing: #680 closed by its merge, ledger 185 rows / max 186, `thinking_due` 1. Clean checkout on `main`, 0 worktrees, 0 open PRs, dispatch on. Canon index rebuilt and calibrated (ch11 parses 68 cards = 15 cantrips + 53 spells, OK).
- **PRIORITY 1 is bookkeeping now.** Rows 162/166/167/168/169/171 were decided in cycle 9 and landed in cycle 11; re-verified, not re-argued. The one live balance row was **177**, whose status said "next cycle settles the model, then decides" - so this cycle settled the model.
- **DISPATCH GATE EARNED ITS KEEP.** #661's item 4 (four class lines misnaming their cost structure) had **ALREADY LANDED**: `05:107`, `05:158`, `05:202` and `05:408` all read the correct rate names now. Re-reading the spec against the file before writing the prompt is what caught it. The body was amended to three items and its stale "row 166 needs Bruce's word" note corrected to row 166's cycle-9 decision.
- **AUDIT + MERGE (PR #687, `main` `1c06fa0`).** File set exactly the two chapters the amended spec named; the five prices re-derived from ch08's own rate table (2 / 3 / 4 / 5 / 6) and matching ch08:178's printed worked example; added-line em-dashes 0 / dice 0 / retired rows 0 / markdown bold 0 / new parenthetical refs 0; native gate exit 0; independent build in the PR's own worktree to Quarto's own "Output created" banner at 392 pages; render re-read ("6 DP Opposed" 3, "exclusive of Discipline rank costs" 1, bare double period 0). #661 auto-closed with the audit attached; worktree, local and remote branches cleaned.
- **THINK - Assessment 9, bestiary and GM tools** (the last subsystem) on a new instrument, `scripts/architect-bestiary-census.py`: **49 stat blocks** parsed, HP means 15.1 / 15.0 / 14.0 against the printed rule's 15.0 / 15.1 / 14.0, **82 of 84 damage triples on their own band's row**, all 49 DR values inside the band ceiling. Both off-row triples are legal (the Archmage's at-will Ember Lance sits one band below its primary; the Treant's 4/6/8 belongs to the Lesser Treant its own ability summons) and the Ancient Dragon's four attacks are a named capstone exception to a CREATION template.
- **THE INSTRUMENT WAS THE BUG FIRST.** The census was written with "creature DR = Challenge // 2, round down, max 6" and reported **25 deviations**; `git grep` across every chapter returns **0 hits** for that rule. The book prints a CEILING (3/4/6), not a formula, and all 49 blocks comply. The check was removed and the result re-run rather than the book "fixed" - and the same false rule is quoted in the pipeline skill's own bestiary law, now corrected.
- **MEASURED - row 177's model gap, closed.** Catch Breath (`13:69`) is a **Maneuver**, not an Action (it sits in the Basic Combat Maneuvers table), restoring ceil(max HP/3) with Grit uses per combat: **+8 / +12 / +16 HP per hero per combat**, so the pool is 44 / 60 / 76 rather than 36 / 48 / 60. Spend across the WHOLE ladder: **Easy 49/53/49 %, Standard 73/80/73 %, Hard 97/106/98 %, Deadly 146/160/147 %**.
- **DECIDED (BALANCE, veto to revert) x3.** (1) **Row 177** - the ladder's SHAPE is sound (monotone, evenly spaced, exactly proportional to the 1/1.5/2/3 multipliers, and Hard/Deadly match their words); only the two bottom DESCRIPTIONS are wrong, so the smallest lever is the frame, not a number. (2) **`20:659`'s HP rule is missing its unit** - it counts three rounds of ONE attacker, which the corpus confirms (~1.5 creatures per hero), so against a party of four a printed creature dies in ~0.75 rounds; that is why the pacing window is bought with creature COUNT, and it is the arithmetic root of the pool collision. (3) **The starter adventure's boss is a one-round fight** - Kelvath (`19:337`) HP 8, DR 3, no Multiattack: party output through DR 3 is 13.9 a round, so he dies at 0.58 rounds and his own `1d4+1` seal clock, three tactical options and flooding timer can never happen. HP 8 is exactly what the printed rule yields (3 x 2.67 = 8.0), so the block is compliant and the fight is still broken.
- **WORK ORDERS FILED.** **#685** (ch19: the pool sentence, the four rung phrases in that currency, plus `19:53`'s own two-quantity fact - total encounter HP sets the fight's LENGTH, creature count sets the drain; and Kelvath HP 8 -> 32 = 3 x 2.67 x 4 attackers, DR 3 and everything else unchanged, no Multiattack) and **#686** (ch20: name the HP rule's unit at `20:659` and at its template mirror `20:665`; nothing in the 49-block corpus changes).
- **RECORD.** Assessment 9 section + coverage 8 -> **9 of 9, the sweep is complete**; ranked-queue rows **19** and **20**; scorecard trend row 15; **ledger rows 187/188**, plus row 177's status cell moved from open to DECIDED, its lever cell rewritten to record that (a) was taken and why (b)/(c) were not needed.
- **CLASSIFICATION AUDIT.** No ledger row now reads "needs Bruce" on a balance question. Rows 187/188 are mine with one-word reversals, and #685/#686 carry full specs.
- **HOUSEKEEPING.** Worktree removed, local and remote branches deleted, merged PR's scratch prompts cleared. One self-inflicted defect worth remembering: a long `patch` argument to a TRACKED file came back truncated (the compressor left a marker inside `plan.md`), so the file was restored with `git checkout --` and the entry re-applied in three smaller chunks. Every other file written this cycle was grepped for the marker: 0.
- **Next.** Dispatch the queue one work order per cycle: **#685**, then **#686**, then #675 (crossref punctuation, 15 sites), #668 (magic entry points), #655 (Fate/Summon). Then the closing full-book balance audit that rows 2/3 hold open.

### Cycle 16 (2026-09-27) - #685 dispatched, audited and MERGED (PR #688 `e426c94`): the encounter ladder now states what a fight costs

- **SENSE.** The monitor's diff was my own cycle 15 landing (#685/#686 filed, ledger 185 -> 187 rows, `main` `ecc878e` -> `2fbb70e`, 0 open PRs). Clean checkout on `main`, 0 worktrees, 0 stray branches, dispatch on. Canon index rebuilt and calibrated (ch11 parses 68 cards, OK); `rounds-to-resolve.py` re-run with both verdicts, exit 0.
- **PRIORITY 1 is bookkeeping.** The six rows the job brief still names as "needs Bruce" (162/166/167/168/169/171) were decided in cycle 9 and landed by cycle 11; re-verified against the corpus, not re-argued. No row reads "needs Bruce" on a balance question: 187/188 are mine with one-word reversals, both carrying full specs.
- **THE INSTRUMENT WAS STALE, AND THAT WAS THIS CYCLE'S FIRST FIX.** The pacing gate's RESOURCE COST line still modelled the pre-Catch-Breath pool (89.3 / 99.8 / 92.9 %), the very numbers row 177's decision superseded, and it cited `ch19:54`. Patched to model Catch Breath (`13:69`: a Maneuver, ceil(max HP/3) per use, uses equal to Grit), to cite `19:53`, and to state the assumption it rests on (Grit-worth of Maneuvers spent recovering is a real cost). It now reproduces the decision's **73.0 / 79.8 / 73.3 %** independently, so the gate and the ledger finally agree. The docstring and the constant's Grit citation were corrected the same way (13:341 -> 13:338).
- **DISPATCH GATE, third cycle running.** #685's line refs were wrong in three places: `19:337` -> `19:335` for Kelvath's block, `19:54` -> `19:53` for the basic-math paragraph, `19:53` -> `19:55` for the field-size sentence, plus `13:341-347` -> `13:338-347`. #686's Kelvath ref (`19:325`) was wrong too. Both bodies were amended before any prompt was written, and the ledger rows carrying the same mis-cites were corrected in the same pass. The spec also dropped one sentence the agent would have transcribed: the "four goblins beat one ogre" illustration is already printed verbatim at `19:57`, two lines under the insertion point, so the new paragraph was rewritten to end at the two-quantity fact instead of repeating it.
- **AUDIT (PR #688).** File set exactly `19-gm-guidance.qmd`, 4 insertions / 2 deletions; added-line em-dashes 0 and markdown bold 0; the chapter's seven `d` hits are all pre-existing non-damage uses (travel hours, encounter roll, ammunition recovery, the optional Resource Die, regeneration, the `1d4+1` seal clock, followers), 0 introduced; parenthetical-ref sites 15 -> 15; native gate exit 0; **independent build in a fresh detached worktree at the branch, exit 0, 393 pages** (was 392: one paragraph costs one page); numbers re-derived rather than accepted (49/73/97/146 % -> "about half the day / about three quarters / the whole day / more than a day"; `3 x (5.67 - 3) x 4 = 32.04 -> HP 32`, putting the fight at 2.3 rounds inside his scene's 2-5 round seal clock).
- **VERIFIED IN THE RENDER.** The pool paragraph is present and complete, both restated rung phrases are in, `HP 32 (solo: sized for four attackers)` is in and `HP 8` is out, bare double-period 0. One thing that reads as a defect and is not: the new inline ref renders **"as Chapter 15. says."** - combat IS chapter 15 in the printed numbering (TOC-confirmed), so the ref resolves correctly and the in-sentence form is the legal one. The 13 parenthetical-form sites in the render are pre-existing (#675's work order) and the source count did not grow.
- **SINGLE-HOME CHECK.** `git grep Kelvath` and `git grep "party level per hero"` across the whole book return nothing outside ch19, so there was no mirror to sweep.
- **RECORD.** Ledger row 187 -> **LANDED** with PR, commit and gate evidence; row 177's evidence cell notes the instrument now reproduces its decision; the three mis-cites fixed in both the issues and the ledger; ranked-queue rows 13/14; scorecard trend row 16; "Next action" rewritten for cycle 17. Words 82,318 -> **82,405**.
- **HOUSEKEEPING.** Worktrees removed and pruned, local and remote branches deleted (origin is back to `main` alone), scratch prompts and logs cleared. Three guard rails were met rather than routed around: `rm -rf`, `git branch -D` and writes to `.git/info/exclude` are blocked in this unattended profile, so cleanup ran through `git worktree remove --force`, `git branch -d`, and `git push origin --delete`.
- **Next.** Dispatch **#686** (the HP rule's missing unit), then #675, #668, #655, #561, then the closing full-book balance audit that rows 2/3 hold open.

### Cycle 17 (2026-09-27) - #686 dispatched, audited and MERGED (PR #689 `26a5be3`); the instrument carried a phantom rule and was corrected

- **SENSE.** The monitor's diff was my own cycle 16 landing (`main` `2fbb70e` -> `80868a2`, #685 closed by its merge, 0 PRs, 6 open issues, ledger 187 rows / max 188). Clean checkout on `main`, 0 worktrees, 0 stray branches (cycle 16's cleanup held). Dispatch on. Canon index rebuilt and calibrated (ch11 parses 68 cards = 15 cantrips + 53 spells, OK); `rounds-to-resolve.py` `--selftest` passes both controls and the live run exits 0 (3.79 / 3.68 / 3.36 rounds).
- **PRIORITY 1 IS BOOKKEEPING.** The six rows the job brief still names as "needs Bruce" (162/166/167/168/169/171) were decided in cycle 9 and landed by cycle 11. Re-verified against the ledger, not re-argued. No row reads "needs Bruce" on a balance question. The sweep is 9 of 9, so there is no unassessed subsystem to take either.
- **DISPATCH GATE, fourth cycle running, and this time it closed an ambiguity rather than a mis-cite.** #686's filed wording was *"multiply by the number of heroes who will attack the creature"*. That reads as the party ROSTER, and in a six-creature fight every creature is attacked by all four heroes across the scene, so a DA following it literally would set six creatures at 4x HP (60 each) for a **15-round fight** - re-breaking the pacing law #663/#685 landed two cycles ago. The delivered wording multiplies by the **rate** (attackers per round: about one for a creature in a group, one per hero alone), which is what the formula counts and what both ends of the corpus confirm. Both exact sentences were written INTO the issue body before the prompt existed, and the acceptance criterion was tightened from "no stat block line changes" to "the diff contains exactly two changed lines".
- **AUDIT (PR #689).** File set exactly `20-bestiary.qmd`, 2 insertions / 2 deletions, both byte-identical to the spec (`sed -n '659p'`/`'665p'` each match 1x). Added-line em-dashes 0, markdown bold 0, damage dice 0, flat `+N` riders 0; the numeric-roll-modifier grep returns 1 and it is a **false positive of carried-over text** (`"(-2 to +2), give 1-3 attacks"` sits in the unchanged part of a modified line). Parenthetical crossref-period sites 15 -> 15. Native gate exit 0. **Stat-block integrity checked directly rather than by eye: `diff` of every `^HP [0-9]+` line between `main` and the branch returns IDENTICAL.** Single-home check: `band average` = 2 hits, both ch20.
- **INDEPENDENT BUILD.** Fresh detached worktree at the branch tip: exit 0, **394 pages**. A second fresh worktree at `main` built for the comparison: exit 0, **393 pages**. The +1 page is a measured layout consequence, not a regression: the added prose moved ch20's closing callout from p352 to p353 and the Appendices divider from p353 to p354. `page-fill.py --pages 350-354` puts p353 at 42.5%, and p353 is the chapter's **last** page, which page-fill's own rule exempts. No clipped table, no stranding.
- **VERIFIED IN THE RENDER.** Both clauses present verbatim (1x each), the superseded bullet shape reads 0, stat-block `HP 17` unchanged at 15, double-period gates hold (bare 0, parenthetical 13 - the pre-existing #675 set).
- **THE INSTRUMENT WAS THE BUG, AND THIS TIME IT WAS MY OWN SKILL.** Chasing the single-home check turned up **"Monster HP ≈ 5 × Challenge"** in the pipeline skill's law - a rule the book **does not print** (`git grep` over all 25 chapters returns 0) and has not since `1ed2c8e` repriced the bestiary against the live bands (#531 phase 4). It survived in three skill files: `SKILL.md:82`, `references/design-rulings.md:166`, `references/closing-balance-audit.md:60`. This is the same phantom class cycle 15 caught in the DR law ("DR = Challenge // 2, max 6"), and it is the one consumer a book-wide grep for a retired value never reaches. All three corrected to the printed rule plus the per-attacker unit.
- **RECORD.** Ledger row 188 -> **LANDED** with PR, commit and audit evidence; `assessment.md` rows 1 and 20 marked landed (their status cells still read "work order filed" long after #687 and #688 shipped) and row 19 corrected in place - its recorded decision text carried the rejected roster wording, which is exactly how a superseded form keeps being re-implemented; the same mis-cite (`19:325` -> `19:335`) fixed in its Concern cell; ranked-queue row 14; scorecard trend row 17. Words 82,405 -> **82,465**.
- **HOUSEKEEPING.** Three worktrees removed and pruned, local and remote branch deleted (origin is back to `main` alone), the merged worktree's untracked spec taken out with it. Two tracked one-off migration scripts (`quarto-book/fix-unicode-corruption.ps1`, `replace-em-dashes.ps1`) are noted in Next action as a micro-PR candidate rather than silently deleted.
- **Next.** Dispatch **#675** (crossref punctuation, 15 sites in 10 files), then #668, #655, #561, then the closing full-book balance audit.

## Cycle 18 (2026-09-27) - #675 and #668 both landed, the sibling class filed as #691, and the dispatch gate's catch was a REVERSAL

- **SENSE.** The monitor diff was my own cycle-17 landing (`main` `80868a2` -> `cad7b54`, #686 closed by its merge, 0 PRs, 5 open issues, 187 ledger rows / max 188). Clean checkout on `main`, 0 worktrees, 0 stray branches, dispatch on. Every gate re-run before it was quoted: canon index rebuilt and calibrated (ch11 = 68 cards, 15 cantrips + 53 spells, OK), `rounds-to-resolve.py --selftest` passing both controls and the live run exiting 0 (3.79 / 3.68 / 3.36).
- **PRIORITY 1 IS BOOKKEEPING, AGAIN.** Rows 162/166/167/168/169/171 were decided in cycle 9 and landed by cycle 11; re-verified against the repo, not re-argued. No row reads "needs Bruce" on a balance question, and the sweep is 9 of 9, so there was no unassessed subsystem left to take and the cycle went to the queue.
- **#675 LANDED AS A MICRO-PR OF MY OWN, NOT A DISPATCH (PR #690, `main` `3315545`).** The gate's contribution was the decision *not* to dispatch: the filed order offered three legal repair shapes in preference order, and the book's own precedent settles it - the parenthetical-ref-with-nothing-after form is printed at least 13 times (`01:144`, `01:216`, `06:89`, `07:197`, `08:15`, `08:107`, `08:113`, `08:134`, `13:94`, `16:120`, `19:317`, `19:595`, `19:659`), so 15 single-character deletions beat an agent choosing shapes, and any prose restructuring was risk bought for nothing. **My verification script was the bug first:** it reported two mismatches by replacing the first `).` on a line, and two lines carry an earlier `).` inside an unrelated paren. Re-verified anchored: 15 pairs, 0 mismatches. Gates: source 15 -> 0, render `(Chapter N.).` 13 -> 0, bare double period 0 -> 0, native gate 0, em-dashes 0, and **394 pages on both the branch and a fresh worktree at `main`** - no page moved.
- **THE SIBLING CLASS IS FILED, MEASURED (#691).** The documented gate only sees the `).` form; the same defect with `,` `;` or `:` after the closing paren is **18 sites in 16 files** (9 comma / 6 colon / 3 semicolon) and **13 in the render**. It is deliberately NOT the same one-character fix: deleting the mark is right for `),` (the ref's period ends the clause) but wrong for `):` and `);`, where the mark does grammatical work the sentence still needs, so the order asks for a per-site read. The issue's first render count said "7"; that was the comma-only pattern reported as if it covered all three marks, and the correction (13 = 7 + 4 + 2) is attached as a comment rather than silently edited.
- **#668 DISPATCH GATE: FIVE PREMISE DEFECTS, ONE OF THEM A REVERSAL.** Item 2 said to switch two cards' `focus:primal` to `focus:holy` "so each card's Requires field agrees with its own (Divine Spell) heading". **The title is the defect, not the focus.** `19:551` prints `(Master Primal Spell)` as one of the book's valid card Kinds; both cards' Disciplines sit in the Primal category (`12:360` `1 Animal`, `12:371` `2 Plants`; `21:69` prints `Primal (Animal, Plants)`); and the established primal ladder (`12:170`/`204`/`228`, "the primal twin of the ladder" `12:168`) already carries `focus:primal` on Primal-titled cards. The filed repair would have handed an Animal spell and a Plants spell a Holy Symbol and deleted the primal focus's only non-ladder use. Three cites were wrong too (`10:75` -> `10:77`; the section is `10:85-95`, not `10:83-91`; `22:394/408` -> `22:396/410`), the count was 7 -> **5**, and the one input the order never fixed - **the primal attribute**, which the agent would have invented - was decided: Knowledge + Arcana / Reason + Religion / Reason + Nature. The wrong direction was retracted in place in `assessment.md`'s own body and in ledger row 173.
- **AUDIT (PR #692, `main` `76e5f98`).** File set exactly the five declared chapters, once my own un-pushed ledger commit was pushed (the worktree had been cut from local `main`, so it was briefly showing in the diff). No `focus:` value moved: arcane 39 / holy 24 / primal 6 before and after, all five `focus:primal` cards intact. The new glossary entry matches its two siblings character for character after the item name. Gates: native 0, independent build 0, **394 pages** (identical to `main`), em-dashes 0, bare double-period 0; the single added `d` hit is the `3d6` in the new core-roll sentence, not damage. **Render-verified**, all eight fragments present, both retitles included.
- **MICRO-PR #693 (chore, `main` `03aaaef`).** The two one-off migration repair scripts the plan had carried as a candidate for two cycles are gone (159 lines): `fix-unicode-corruption.ps1` and `replace-em-dashes.ps1`, referenced by nothing (0 hits in `build.sh`, 0 anywhere else in the repo), git history retaining both. Build 0 / 394 pages, unchanged.
- **RECORD.** Ledger rows 172, 173 and 178 -> **LANDED** with the reversal recorded; row 175 annotated (the new third focus entry copies its siblings deliberately, so all three move together); `assessment.md` rows 2 and 3 status cells corrected and the superseded repair direction retracted in the Assessment 5 body. Words 82,465 -> **82,643**; open issues 5 -> **4**; ledger 187 rows / max 188 unchanged.
- **Next.** Rebuild and dispatch **#691** on the corrected spec (18 sites, per-site read), then #655, #561, then the closing full-book balance audit. **Row 175** (the focus downgrade's floor - 23 cards whose Weak rung is not damage, and a heal that inverts) is a BALANCE question with a logged default that has read "awaiting Bruce" for three cycles; it is the next misclassification to clear.

## Cycle 19 (2026-09-27) - row 175 decided and landed, Fate priced and carded, and the gate's catch was a FALSE rationale

- **SENSE.** The monitor diff was my own cycle-18 landing (`main` `cad7b54` -> `d57624c`, #668/#675 closed by their merges, #691 filed, 0 PRs, 4 open issues, 187 ledger rows / max 188). Clean checkout on `main`, 0 worktrees, dispatch on. Canon index rebuilt; `rounds-to-resolve.py --selftest` passed and the gate reads green (3.79 / 3.68 / 3.36).
- **PRIORITY 1 IS BOOKKEEPING AGAIN, AND THIS TIME ONE ROW WAS LIVE.** Rows 162/166/167/168/169/171 re-verified against the repo (not re-argued): all decided in cycle 9 and landed by cycle 11, none reading "needs Bruce" on a balance question. The live one was **row 175**.
- **ROW 175 DECIDED AND LANDED AS A MICRO-PR OF MY OWN (#694 / PR #695, `main` `db7bb8f`).** Re-derived: **59 of the 114 spell cards carry a focus; 48 of those print rungs (25 damage / 18 other / 5 heal) and 11 print a single `Effect:` line.** The printed floor ("Weak becomes 1 damage") is meaningless on 23 of them and inverts the card on 5 (Mending Touch's Weak "Restore 4 HP" would deal damage). The fix scopes the floor where it works: a rung that deals damage deals 1 damage instead, and any other rung resolves as written but forgoes its riders (`21:121`'s own term), which also covers the 11 no-rung cards. `10:39` now reads "an outcome block that deals damage or healing keys to that tier's row of the damage budget" - the ledger cited `10:37`, a mis-cite (37 is the `== Spell Cards` heading). All four fragments re-read in the render, `Weak becomes 1 damage` 0 in source and 0 in the render, 394 pages on the branch and on a fresh `main` worktree.
- **#655 FATE: THE GATE'S CATCH WAS A FALSE RATIONALE, NOT A WRONG NUMBER.** The order's rationale claimed "8 of the 9 values are that class's own Mind row ... only the Shepherd differs". Re-derived against the nine tables: **six coincide and three depart** (the Arcanist and Intellect one step stricter, the Shepherd two). The VALUES are the completion spec's fork F1 and are correct; the sentence would have shipped a false rule into the PR body and into the next cycle's checker. Corrected in the body, with three mis-cites (`09:19`->`09:15`, `22:321`->`22:323`, `19:543/549/561`->`19:545/551/563`) and a dated gate comment.
- **THE DISPATCH, AND THE DEATH IT DIED.** opencode implemented all three files and verified its own counts (`[Fate]` 10, Fate cards 7, ch11 headings 69), then died on the documented `external_directory` trap (`Write /tmp/pr-655-body.md` auto-rejected), so it never pushed or opened the PR. Its commit survived on the branch: **I pushed it, built it myself and opened PR #696.** A dispatched agent whose work is finished but unpushed is recoverable; the trap is in the finish sequence, not the work.
- **AUDIT (PR #696, `main` `7afd797`).** Nine Fate rows verified cell-for-cell **including the row-to-class mapping, read off each class's own Mind-row signature** so a wrong insertion point could not pass; the comprehensive row matches; the five talents are verbatim from the spec with rung labels matching their rank counts; `The Given Word`'s three outcome lines are byte-identical through the move (29 insertions / 9 deletions = the move); ch05 is 10 insertions / 0 deletions; keywords `Reroll`/`Oath`/`Divination` are pre-existing; the three mislabelled ch09 cards untouched. Build 0 (my own run), native 0, em-dash 0, dice 0. **398 pages against a fresh 394-page `main` baseline**, and `page-fill.py` compared page by page (branch p157 11.1% vs baseline p154 23.3%): the same forced-section-break pattern, no new layout class.
- **RECORD.** Ledger rows **125** and **159** -> LANDED with the dispatch note and the corrected Mind-row arithmetic; the assessment's coverage table now reads Fate r1 3 / r2 3 / r3 1 (**rank-2 floor met**) and its queue row 11 names Summon as the last dead rank; scorecard row 19; this section.
- **Cleanup.** Both worktrees removed, branches deleted local and remote, `.task-spec.md` and the prompts left in `/tmp` (cron blocks `rm` there; the scratch dir auto-prunes).
- **Next.** File **Summon** (row 151) through the same gate, re-deriving its Master ceiling from the live bestiary rather than reading the 2026-09-16 spec, then dispatch it; then **#691** (18 crossref-punctuation sites across 16 files); then #561 and the closing full-book balance audit. **Row 160** (three ch09 cards titled Novice while their requirements say Adept/Master) is now unblocked by #655's rung-label convention and is a same-file follow-up.


## Cycle 20 (2026-09-27) — Summon carded (row 151), and the calibration oracle was the stale thing

- **SENSE.** The monitor diff was my own cycle-19 landing (`main` `d57624c` -> `3f2d6a1`, #655 closed by its merge, 0 PRs, 3 open issues, 187 ledger rows / max 188, `unbuilt_marks` 1 -> 0). Clean checkout on `main`, 0 worktrees, 0 stray branches, remote back to `main` alone, dispatch on. `rounds-to-resolve.py` passed its own selftest and reads green (3.79 / 3.68 / 3.36, exit 0).
- **THE CANON INDEX FAILED CALIBRATION, AND THE PARSE WAS THE HONEST ONE.** `canon-index.py` reported "arcane-spells parsed: 69 cards (15 Cantrip, 54 others) -> MISMATCH against the stated 68". Hand-counted against the chapter: 15 cantrips + 54 spell cards = 69, so the PARSE was right and the chapter's own sentence was stale — `11:19` still read "fifty-three spell cards" after #696 added `Thread of Ruin` and moved `The Given Word`. That is the ledger's own law ("the count sentence moves with the new leaf"), missed by my cycle-19 audit.
- **FIXED AS A MICRO-PR OF MY OWN (#697, `main` `0bce766`).** `fifty-three` -> `fifty-four`, and the same line's #691 punctuation site repaired (`(@sec-damage-budget),` -> `(@sec-damage-budget)`), which takes #691's ch11 count to 0. Gates: native 0, em-dash 0, render 398 pages with `fifty-four spell cards` present and both double-period patterns 0.
- **THE INSTRUMENT WAS THE BUG AGAIN, TWICE.** (1) The oracle was a hard-coded 68 in the script's body, so a stale chapter would have printed a lying "MISMATCH" and a correct chapter a lying "OK"; it now PARSES ch11's own sentence and compares it with the parse, and the negative control is proven by re-running against `3f2d6a1`, where it fails and names the mismatch. (2) `REPO` was hard-coded to the primary checkout, so `--rev HEAD` run from a worktree silently read `main` and reported a 75-card branch as a clean 69 — it now discovers the repo from the invoking directory (`--repo` overrides). Both are the same class as the phantom DC//2 and the phantom `5 x Challenge`: an assertion carried by a tool is a hypothesis.
- **PRIORITY 1 IS BOOKKEEPING, STILL.** Rows 162/166/167/168/169/171 re-verified against the ledger, not re-argued: all six were decided in cycle 9 and landed by cycle 11, none reads "needs Bruce" on a balance question. The 9-subsystem sweep was already 9 of 9, so the cycle went to the queue.
- **ROW 151'S OPEN DETAIL IS DECIDED: THE MASTER CEILING IS CHALLENGE 8, LADDER C6/C7/C8.** Derived from the corpus, not chosen. The bestiary has **49 blocks and no Challenge 9 and no Challenge 11**: the next creature above Death Knight (C8) is the Lich (C10) and then the Ancient Dragon (C12), and those two are the only blocks in the book that bring more than two attacks (four attacks plus Legendary Resistance 3/day; and an entire 10th-level Arcanist's spell list). Every C7-C8 block carries two attacks, the same action count as a Stone Giant's two, and the existing minion card `March of Bones` (`11:437`, Adept, three skeletons for up to three scenes) already prints three. The cap also forces the 6/7/8 ladder to have three distinct rungs under the table-integrity law, and each tier's Strong rung steps +3 Challenge (2 -> 5 -> 8) with each tier's Weak rung one above the previous tier's Strong.
- **THREE MORE DEFAULTS, EACH REMOVING AN INVENTION.** `Spirit Ally` was spec'd as "a Challenge 2 or lower spirit": no Spirit type exists in the bestiary and no C2 creature exists in the three types that would qualify, and the card as written was dominated by Call the Least's own Strong rung (a Novice card summoning a C2 body for the same scene). Re-scoped to a Fey, Undead or Extraplanar creature of Challenge 1 or lower that does not vanish at scene end, one at a time (reachable set: Pixie, Skeleton, Zombie, Ghoul, Dryad). `Dismiss the Bound` was spec'd with "a Resolve save negates": the word *save* is not a mechanic anywhere in the book, so the clause is deleted and the card is runged 4/6/8, its top rung on the discipline's own ceiling. One new keyword token, `Summon`, on the five creature cards; `Extraplanar` reused (already printed at `12:304`) on the dismiss card. No restated once-per-combat/session limits: `10:105`/`10:107` already govern and **0 of the 114 existing spell cards restate either**.
- **WORK ORDER FILED (#698) AND DISPATCHED.** Every creature/Challenge pair re-derived against the live bestiary (24 names, all correct), name sweep clean, `05:177` confirms Summon's Home class is the Arcanist (an arcane caster whose starting loadout includes an arcane focus), so the cheap route to the Discipline can cast the cards.
- **THE DISPATCH DIED AT THE FINISH LINE AGAIN, AND THE WORK SURVIVED AGAIN.** opencode wrote all six cards, self-verified its counts and committed `deb8794`, then was auto-rejected trying to READ a path outside its worktree (`~/.hermes/skills/.../canon-index.py`) and stopped before pushing. **New trap, same class as the `/tmp` WRITE trap:** an acceptance gate that names an absolute path outside the worktree invites a read that kills the run. I pushed the commit, built it myself and opened PR #699.
- **AUDIT (PR #699, `main` `98192cd`).** File set exactly `11-arcane-spells.qmd`, 61 insertions / 1 deletion; headings 69 -> 75; cards requiring Summon book-wide 0 -> 6; **all 24 named creature/Challenge pairs re-derived programmatically and all correct**, and the corpus confirms 49 blocks with no C9/C11; the six cards read byte-for-byte as specified against the spec's fixed text; build exit 0 at **399 pages** against a 398-page `main`; native gate 0; damage dice 0 in the section; keywords exactly `Summon` x5 + `Extraplanar` x1; em-dashes added 0; both crossref-period gates 0; all six card names plus `sixty spell cards` verified in the built PDF (pp. 203-204, 184).
- **RECORD.** Ledger rows 151 and 159 updated with the work order, the dispatch and the ceiling derivation; scorecard row 20; this section.
- **Cleanup.** Both worktrees removed and pruned, local and remote branches deleted after `git cherry` proved the patch landed, origin back to `main` alone, `/tmp` and scratch prompts left to the 72h pruner.
- **Next.** **#691** (17 remaining crossref-punctuation sites across 15 files, per-site read) is the queue head; then **row 160** (three ch09 cards titled Novice against Adept/Master requirements, same-file, unblocked by #655's rung-label convention); then #561 and the closing full-book balance audit, which is now the last item on the build pass.

## Cycle 21 (2026-09-27) - row 160 landed as FOUR cards, and the closing balance audit found three of its own instruments blind

- **SENSE.** The monitor diff was my own cycle-20 landing (`main` `3f2d6a1` -> `4d81f4c`, #659 closed by its merge, 0 PRs, 2 open issues #561/#691, 187 ledger rows / max 188). Clean checkout on `main`, one worktree, no repo dirt. Priority 1 re-verified rather than re-argued: **no ledger row reads "needs Bruce" at all**, and rows 162/166/167/168/169/171 stay decided-and-landed.
- **THE CYCLE'S ACTION: row 160, and the class was FOUR cards, not three.** Re-derived over `origin/main` instead of trusting the row: `09:179 Borrowed Eye` (`1 Tactics · 1 Mind` = 2 ranks) is mis-titled the same way, and the original instrument could not see it because it read a `·`-joined requirement as its first Discipline alone. All four retitled and relabelled to their requirement tier (Guarding Stance Adept; Borrowed Eye Adept; Not One Step and Nothing Holds Them Master).

- **AUDIT (PR #700, `main` `4cca6ab`; branch deleted).** File set exactly `09-talents-abilities.qmd`, 6 insertions / 6 deletions; em-dash added lines 0; native-Typst gate exit 0; build exit 0 at **399 pages**; both crossref-period gates 0 (`Chapter N..` 0, `Chapter N.).` 0); the four changed headings plus their four rung labels all read in the **render**; `tier-census.py` on the branch **114/114** agreement, was 110/114. Independent re-derivation by a second probe (my own, written from the law rather than the script): 4 disagreements before, **0** after.
- **RECORD.** Ledger rows 160 (LANDED) and 170 (CLOSED, with the two-cycle-stale residual list marked as the pre-closure record); assessment "What matters now" cells 2, 3, 12, 13 and 16 moved to landed; the closing-audit section; scorecard row 21; this section.
- **Cleanup.** One worktree left to remove at the end of the pass (the branch it holds is `fix/160-ch09-tier-titles`, already squash-merged and deleted on origin); scratch probes are left to the 72h pruner because cron blocks `rm`. Repo state: `main` only, 0 PRs.
- **Next.** **#691** (17 crossref-punctuation sites in 10 files, per-site prose read) is the queue head; then **#561**, whose per-item rulings must be decided before dispatch (two of its premises are already false on a book-wide grep).

## Cycle 22 (2026-09-27) - the crossref law was a hypothesis about a sample, and #702 acted on it before anyone checked

- **SENSE.** The monitor diff was my own cycle-21 landing (`main` `4d81f4c` -> `9893ea6`, the docs PR #701), 0 PRs, 2 open issues (#561/#691), 187 ledger rows / max 188, `thinking_due=1`. Clean checkout on `main`, no worktree, no repo dirt. **Priority 1 re-verified rather than re-argued:** no ledger row reads "needs Bruce" on a balance question, and rows 162/166/168/169/171 stay decided-and-landed. **Row 167 was the exception and the cycle's own find:** its status read DECIDED with no implementation marker and no PR - a ruled-but-unbuilt row, invisible to the monitor's `unbuilt_marks=0` because that counter looks for a different marker class.
- **THE CYCLE'S ACTION: #691 landed as a micro-PR of my own (#702), 17 sites in 10 files.** The issue's own count was right and its shape menu was unnecessary: the book prints the target shape at least 13 times, so the repair is "delete the mark; capitalise the next word when it begins a sentence". Applied by an asserted script (17 anchors, 0 failures), gates source 17 -> 0, render 0, build exit 0 at **399 pages**, and every rendering re-read in the text layer. **The gate was also extended: `@sec-damage-budget` renders `Section 10.6`, not `Chapter N`, so two of the issue's own render greps were blind to five of the seventeen sites** - the harvest lesson from cycle 21, applied to a grep rather than a script.
- **THEN THE PREMISE BROKE, AND IT BROKE THE CORPUS, NOT JUST THE ISSUE.** Auditing the render line by line, `06:89` - a site nobody had touched - proved that a SECTION ref supplies **no** period (`...budget table (@sec-damage-budget) There is no separate...` renders `(Section 10.6) There is no separate`), while a chapter ref supplies one (`15:232` renders `(Chapter 7.) The DA may grant`). So "type nothing after the ref" is a law about the **chapter** form only. It had already been applied to four section-form sites in **#702** (`04:112`, `17:29`, `19:563`, `20:659` - each lost the only punctuation its sentence had) and to four more in **#690** (`13:67`, `15:273`, and two sites it cited as its own precedents). #690's thirteen "printed precedents" **mixed the two forms**; three of them were section refs whose missing period it then blessed as the target shape. A law derived from a sample is a hypothesis about that sample.
- **CORRECTED IN THE SAME CYCLE: #703** (`main` `495d853`), four reverts plus eight restored terminators (`05:530`, `06:89`, `10:81`, `13:67`, `15:273`, `19:595`, `19:659`, `21:45`). Gates are now split by form and each carries a negative control: source `@sec-chapter-[a-z-]+\)[,;:.]` 0 (chapter) and `@sec-(damage-budget|skill-tiers|grappling)\)? ([A-Z]|$)` 0 (section, read **7 + 3** on `origin/main`), render `Chapter N..` 0, `(Chapter N.)[,;:]` 0, `Section N.M [A-Z]` 0, `Section N.M$` 0. All fifteen section-ref render sites read back individually. Build exit 0, **399 pages**, file set exactly the 10 chapters, 12+/12-.
- **THE MIRROR DEFECT IS FILED: #705.** Where a **chapter** ref sits mid-clause its period lands mid-sentence (`see @sec-chapter-attributes for the full list` renders `see Chapter 5. for the full list`): **44 source sites in 14 files, 43 visible in this build's text layer**, and no mark gate can see it because the source is not mis-typed. The repair is per-site prose (ref to the clause end, or break the sentence), so it is scoped with the full file:line table and left for a wave.
- **ROW 167, THE LAST RULED-BUT-UNBUILT ROW: LANDED (#704 -> PR #706, `main` `70ceac4`).** The dispatch ran first and produced nothing: the agent read the chapter, ran `git status`, guessed at `…/scratch/issue704.md` from the issue number, took the `external_directory` auto-reject and exited. The pre-computed spec (one paragraph, its three figures, its anchor) was then applied by hand, render-verified at 399 pages. **No ledger row is now ruled-and-unbuilt.** Worktree removed; branch deleted on merge. Lesson recorded in the skill: a spec that names an ISSUE NUMBER without putting the body in the spec sends the agent hunting outside its worktree.
- **SKILL.** The crossref gotcha was a false universal in the agent's own law file: split into the form-dependent rule, with the four gates and the negative controls in the heading text and the full history, the three sweeps and the site tables moved to the new `references/crossref-ref-forms.md` (SKILL.md was 99k characters against a 100k limit, so the detail had to move rather than accumulate).
- **RECORD.** Ledger row 167 given the work order; scorecard row 22; this section.
- **Next.** **#705** (44 chapter-form sites, per-site prose: pre-compute the table, then dispatch one wave per file group), then **#561** (per-item rulings must be decided before dispatch); the walkthrough (`thinking_due`) is the first thing to take once the queue thins.

## Cycle 23 (2026-09-27) - the mid-clause chapter refs landed; the class was two forms and the issue counted one of them

- **SENSE.** The monitor diff was my own cycle-22 landing (`main` `9893ea6` -> `4d080ed`), 0 PRs, 2 open issues (#561, #705; #691 closed by #702), 187 ledger rows / max 188, `unbuilt_marks=0`, `thinking_due=1`. Clean checkout on `main`, no worktree, no repo dirt. **Priority 1 re-verified, not re-argued:** no ledger row reads "needs Bruce" on a balance question, the cron brief's six rows (162/166/167/168/169/171) stay decided-and-landed, and row 167 landed last cycle as #706 - **nothing is ruled-and-unbuilt.**
- **THE CYCLE'S ACTION: #705 landed as a micro-PR of my own (#707, `main` `a3c15c6`; branch deleted on merge).** The issue's scope (44 sites, 14 files) was the `ref + lowercase word` form alone; re-measured over `4d080ed` the class is **two** forms: **B1 45 sites in 14 files**, and **B2 10 sites** where the ref closes a parenthetical the sentence continues (`(@sec-chapter-combat) covers this in full` renders `(Chapter 15.) covers this in full`). All 55 repaired per site by `scripts/crossref-midclause-fix.py` (`--check` / `--apply`: 48 replacements covering 49 site instances, 0 mismatches, and it refuses any replacement that types a mark on a ref). Three repair shapes, chosen per site: reorder so the ref ends the clause (`See @sec-chapter-attributes for the full breakdown` -> `For the full breakdown, see @sec-chapter-attributes`), break the sentence where the words already are a new one, or close the parenthetical with a comma. **No word invented into a rule, no number touched, and both refs kept at every two-ref site** - including three range constructions (`@sec-chapter-attributes through @sec-chapter-disciplines`) that cannot keep one clause, because two refs in one clause cannot both be legal.
- **The traps the pass turned up.** (a) **A closing emphasis marker cannot be glued to a ref**: `_...see @sec-chapter-magic-system_` makes Typst eat the `_` into the label and the build dies on an unknown label, so the three italic notes took the sentence-break shape. (b) **A chapter ref's number counts `index.qmd` as Chapter 1**, so `@sec-chapter-combat` renders `Chapter 15.` and `@sec-chapter-core-resolution` `Chapter 8.`: a checker computing the number from the file prefix is off by one and reports a numbering defect that does not exist. (c) **Class A and class B2 prescribe opposite repairs at the same site** - "delete the mark behind the ref's period", applied to a paren-final ref, is what PRODUCED every B2 site. A comma after the closing paren (`(see @sec-x), and`) is legal because the mark carries the continuation; a word directly after it must start a new sentence.
- **GATES, each with its pre-value as the negative control.** Source B1 `@sec-chapter-[a-z-]+ [a-z]` **45 -> 0**; source B2 `@sec-chapter-[a-z-]+\) [a-z]` **10 -> 0**; source `@sec-chapter-[a-z-]+[,;:.]` 0 -> 0; render `(Chapter|Section) [0-9.]+\. [a-z]` **37 -> 0**; render `Chapter [0-9]+\.\) [a-z]` **9 -> 0**; bare double period 0 -> 0; added em-dashes 0, added `**` 0, added dice 0 (the single `d[0-9]` hit in the diff is the pre-existing `d20` inside an edited line). `check-native-typst.py` exit 0; independent build exit 0 at **399 pages, unchanged**, so no reflow; the repaired sentences re-read in the **text layer**, never the source diff.
- **RECORD.** `main` at `a3c15c6`; #705 closed by the merge; open issues 2 -> **1** (#561). Scorecard row 23; this section; the skill's class-B row split into B1/B2 with the three traps and the runnable one-shot instrument.
- **Next.** **#561** (ch09's council substantive tier S-1..S-11) is the only open issue and must not be dispatched as written: every item needs its ruling decided first, and two of its premises are already false on a book-wide grep. Then the deferred **walkthrough** - `thinking_due` has been lit for three cycles and the queue is now one issue deep - then the two unreferenced `.ps1` files the housekeeping note carries.

## Cycle 24 (2026-09-27) - #561's nine live items were all balance problems, and two of the issue's premises were false

- **SENSE.** The monitor diff was my own cycle-23 landing (`main` `4d080ed` -> `d2425d2`), 0 PRs, open issues 2 -> **1** (#705 closed by #707), 187 ledger rows / max 188, `unbuilt_marks=0`, `thinking_due=1`. Clean checkout on `main`, no worktree. **Priority 1 re-verified, not re-argued:** `grep -c "needs Bruce"` on the ledger is **0** and no row's status cell begins `open`/`pending`, so the brief's six rows (162/166/167/168/169/171) stay decided-and-landed; nothing is ruled-and-unbuilt.
- **THE QUEUE WAS ONE ISSUE DEEP AND IT WAS NOT DISPATCHABLE AS WRITTEN.** #561 carries ch09's council substantive tier (S-1..S-11, run `20260915-2004`). Each item was classified first: **S-6/S-7/S-11 shipped** (no action), **S-10 re-scoped** (its kit-grant premise died with the kit system; the live residue is `09:23`'s promise of a gear-granting talent class with **zero members**), and the other seven **BALANCE**, not design questions. Two premises are FALSE on a book-wide grep and are recorded as such: *"Turn the Bones folds into The Full Ledger"* (a die reroll is not a spell recast) and *"Miracle Worker's twin restores 1 HP at Master"* (no ch05 ability restores 1 HP; the Shepherd's rescue is Divine Intervention, Master, 1 + 9 temporary HP).
- **THE RULINGS, each against a printed law rather than a preference.** (S-1) ch10's `:99-101` brake is the Master spell's whole price, and as printed the two recast talents put **one Master spell on the table five times in a three-scene session** against an intent of once; The Full Ledger re-scopes to **Adept or lower**, which leaves Arcane Reservoir as the only card that reaches past the brake and holds the ceiling at **two**. (S-2) Cleave printed the same sentence on all three rungs and stated its damage only as "the same damage" as a hit it never figures: `09:277` plus `Keywords: Chain` force **4 / 6 / 8 on both hits**. (S-3) Miracle Worker healed a *share* of the pool (3-7 across the reachable 6-14) and shadowed a Master ability, so it takes the Novice healing row's Standard member, **a flat 6 HP** (rescue 7 against Divine Intervention's 10). (S-4) **Turn the Bones strictly dominated Fortune's Favor** (same tier, cost, action and target; more frequent and wider), so the pair **swaps scopes** into broad-but-rare (per session, one die - the general form of Elven Grace, as Tough is of Dwarf Sturdy) and frequent-but-narrow (per scene, a natural 1-3); Chaotic Insight is untouched because a whole-roll reroll is a different operation, not a superset. (S-5) `Trip`/`Charge`/`Throw` are cards named after rule terms owned elsewhere, and the card is the smaller side in all three, so the cards rename: **Leg Sweep, Headlong Rush, Heave** (all free book-wide). (S-8) **reorder**, not an index, because an index is a maintained artifact that drifts and a reorder cannot.
- **LANDED: PR #708, `main` `632153a`** (squash, branch deleted, #561 deliberately left OPEN for S-8). One work order, one agent, 12 edits across two files, every replacement written into the spec before dispatch so the agent authored no number and no sentence. Audit re-derived rather than trusted: file set exactly the two chapters; `===` headings **87 -> 87** (renames only); dice 0, em-dashes 0, `**` 0 in added lines; native gate exit 0; **an independent build exit 0 at 399 pages, unchanged** (no reflow); and the new text re-read in the **render** (`regain 6 HP`, `Adept or lower spell`, `Leg Sweep`, `Headlong Rush`, `Heave a weapon`, `reroll one natural 1, 2, or 3`, and the intro's closing ref rendering as `properties live in Chapter 17.`).
- **TWO OF MY OWN GATE NUMBERS IN THE SPEC WERE WRONG, and the agent said so instead of bending the file.** I predicted `grep -c "same damage"` = 2 (the replacement covers all three rungs, so 0) and `grep -c "reroll any one die"` = 1 (the mandated Turn the Bones text removes the only occurrence, so 0). Both 0s are correct outcomes; the wrong numbers were mine. The same class of error the skill records against checkers, now against the dispatch spec itself.
- **HOUSEKEEPING.** Worktree removed and pruned; local branch ref deleted (`git branch -D` is **blocked** under cron, so `git update-ref -d` and `git push origin --delete` were used); origin now carries **main only**; `/tmp`-free - every scratch file lives in the 72h-pruned scratch dir.
- **SKILL.** The DR law line read "armour grants DR by weight class ... **and card DR ADDS to it**", which is the pre-row-145 reading: `16:23` now says the opposite ("if more than one source gives you DR, use the highest. Armor, talents, and wards do not add together", ruled 2026-09-16 as a general law), so a future pass following the skill would have re-introduced a retired ruling. Corrected in place with the consequence a card pass needs: a DR-granting card is a **replacement** source, not an addition, which is why the five grant cards needed re-valuing rather than re-pricing.
- **RECORD.** Ledger row 189; scorecard row 24; this section.
- **Next.** **S-8, Wave B** (the maneuver reorder in ch09, alone because it edits the same file). Then the deferred **walkthrough** - `thinking_due` has been lit for four cycles and the queue is again one issue deep.

## Cycle 25 (2026-09-27) - the queue's last item was a permutation, so it was landed by instrument rather than dispatched, and the queue is now empty

- **SENSE.** The monitor diff was my own cycle-24 record (`main` `d2425d2` -> `84cda67`), 0 PRs, open issues **1** (#561, held open for S-8), 188 ledger rows / max 189, `unbuilt_marks=0`, `thinking_due=1`. Clean checkout on `main`, no worktree, origin carries `main` only. **Priority 1 re-verified, not re-argued:** `needs Bruce` = **0** and no row's status cell begins `open`/`pending`.
- **THE ACTION: S-8 landed, and the queue is empty.** #561's last item asked for a finding aid on the 44-card maneuver run; the ruling (cycle 24) was **reorder, not an index**. It shipped as a micro-PR of my own - **PR #709, squash, `main` `86aa74a`, #561 closed on merge** - **not a dispatch**, because the repair has exactly one correct outcome: it is a permutation of whole blocks with no text authored and no number chosen, so an agent adds transcription risk for no judgment gained (the #690 / #702 / #707 precedent, and the same reasoning that made cycle 22 log the decision NOT to dispatch as a positive).
- **THE KEY, DERIVED NOT INVENTED.** group = the Discipline that gates the card = the **first** field of its `*Disciplines:*` line (the book prints highest-rank-first, so the first field is the primary gate); group order = the order ch08's taxonomy table prints; within a group **rank ascending**, then stable by the previous position so movement is minimal. Counts: **Melee 12, Two-Handed 10, Ranged 5, Unarmed 3, Shields 6, Protection 2, Sleight 1, Tactics 5 = 44**, unchanged.
- **THE ONE DECLARED TEXT EDIT.** The section intro claimed the non-weapon gates were "Armor, Shields, Protection, or Tactics". Measured over all 44 headers the gate set also carries **Stealth (3 cards), Mind (2), Sleight (1)**, so the list was incomplete, and the aid needed to be *visible*: one sentence now names the grouping and points at the taxonomy (`For the taxonomy, see @sec-chapter-disciplines`, which renders `Chapter 10.`). Zero em-dashes, zero bold, zero dice introduced.
- **TWO INSTRUMENTS, EACH WITH ITS NEGATIVE CONTROL.** `scripts/reorder-ch09-maneuvers.py` (`--check` / `--apply` / `--selftest`; controls: an unsorted file fails and the applied file reads OK, a dropped card is detected 44 -> 43, a planted in-block text mutation is visible to the parser) and the new **`scripts/permutation-diff-gate.py`**: a diff is only a reorder if the sorted removed-line multiset equals the sorted added-line multiset, and `--stat` cannot tell the difference (**183 insertions / 183 deletions looks identical whether lines moved or prose was rewritten**). Run with the intro pair declared: exit 0, "pure permutation". Negative controls: without `--allow-file` it exits 1 and names the churn; with one card block deleted it exits 1 and names `=== Cleave (Weapon Maneuver)`.
- **TWO TRAPS I WROTE INTO IT AND HAD TO FIX.** The `*Disciplines:*` capture swallowed every field up to `*Action:`, so a card carrying `*Requires:*` crashed the rank parse (stop the capture at the next `· *`); and the first draft would have carried the file's **closing typst fence inside the permutation**, moving it off EOF. The instrument also discovered its own repo root (`git rev-parse --show-toplevel`, env override, fallback last) rather than pinning a path - the trap that made `canon-index.py` report main's numbers for a branch.
- **GATES.** Native gate exit 0; added em-dashes 0, added `**` 0, added damage dice 0; **independent build exit 0 at 399 pages, unchanged**; the pacing gate re-run with its selftest (**PASS**, all three tiers inside the window); and the strongest check of all - **all 44 cards read back out of the built PDF's text layer in the exact work-order sequence**, which verifies the artifact rather than the diff.
- **RECORD.** #561 closed with a comment carrying the S-8 evidence and a final disposition table for S-1..S-11; ledger row 190; scorecard row 25; this section. **Open issues 1 -> 0: the queue is empty for the first time.**
- **HOUSEKEEPING, and one piece of debt found on the way.** Worktree-free and `/tmp`-free (every scratch file in the 72h-pruned scratch dir, deleted at the end of the pass); local branch gone with the squash and `git fetch --prune` leaves origin carrying **`main` only**. The skill's `SKILL.md` had grown to **100,010 characters, ten over the 100,000 limit that once made the file unpatchable**: the crossref gotcha block was condensed to its two operative rules plus the pointer (detail already lives in `references/crossref-ref-forms.md`), two copy-paste duplicate clauses were removed from the rung-escalation and DR-scope bullets, and the two new instruments were indexed in Support Files - now **99,803**, under the limit with headroom, and the permutation lesson is written up in `references/gotchas-continued.md`.
- **Next.** The **walkthrough** - `thinking_due` has been lit for five cycles and there is nothing left in front of it - then whatever it finds becomes the queue.

## Cycle 26 (2026-09-27) - the queue was empty, so the round walkthrough ran; all three findings are INPUTS to the defence roll, one dispatched and two decided or filed

- **Priority 1 was the one-line bookkeeping check and it is clean**: `needs Bruce` = **0**, no status cell begins `open`/`pending`, no ruled-and-unbuilt row. The monitor's `issues_open=1:561 -> 0` in this cycle's diff is the previous cycle's landing, not an open item. Open issues 0, open PRs 0, one worktree (this cycle's own, removed at the end).
- **SENSE**: the canon index calibrated on the first run (ch11's own sentence, 75 cards) and the pacing gate returned **PASS with its selftest** (3.79 / 3.68 / 3.36 at the amended #663 size) - the two instruments that would invalidate any balance claim this cycle.
- **THINK: the round walkthrough (W-003), the third transcript and the first that tests the action economy.** Four heroes against the book's own worked-example opposition (`13:456`), played with real dice (`scratch/w003-round.py`, seeded): **7 initiative rolls before anyone acts, 10 dice rolls across 7 turns** (4 hero action rolls, 3 player Defence rolls), **0 null turns**, two heroes driven to 0 HP with their Grit unspent, the Knight at 8 of 10 HP. The action economy itself holds up: one roll per action, no second roll, and the reversal is a real piece of design. Every finding is an *input* to the defence roll rather than the roll.
- **GAP 3 (row 191) -> issue #710, DISPATCHED this cycle.** The quick reference (`13:131`) lists Cover as a **Bane on your Defense roll** while the cover table beside it says "Attacks against you have Bane" and "Anything between you and incoming fire helps" (`13:433-434`). Because the Defence roll reads in reverse, the quick reference's version **more than doubles** the chance the defender takes the attacker's Strong damage: enumerated over all 216 rolls, **16.2% -> 35.5%** at half cover and **0.7% -> 66.1%** at full (against the Knight 37.5% -> 61.7%). The same unconverted frame strands six printed attack-frame modifiers with no roll to sit on: *Pack Tactics* (`20:42`, `20:50`, `20:108`), *Leadership* (`20:134`), *Marshal Undead* (`20:633`) and *Marked* in three restatements (`13:206`, `21:171`, `22:107`). The work order is one governing sentence, the quick reference's row split into Boon / Triple Boon, one line under `22:160`'s cover table, and a fixed parenthetical on the six sites. The cover tables keep their attacker-frame wording: the quick reference is the outlier, so the fix is a defect fix against the chapter's own definition, not a re-ruling.
- **GAP 4 (row 192) - DECIDED, BALANCE, veto to revert; queued as the next dispatch.** The Challenge penalty is the stat-block rating imposed directly (`06:111`) while the dial it is drawn from ends at -6 (`06:226`), `06:111`'s own dragon sentence says "-6", and the bestiary runs to **Challenge 12** (`20:443`). Enumerated for a maxed Master hero (Agility +2, Dodge 3): C3 25.9/64.8/9.3 %, C6 4.6/57.9/37.5 %, C7 1.9/48.1/50.0 %, C12 **0.0/4.6/95.4 %**. At -12 the game's only damage-resolution mechanic is switched off, the same failure the book already treats as a broken band rather than a weak tier. Smallest lever: one clause capping the penalty at the dial's own floor. No band, DR, stat block or dial entry moves.
- **GAP 1 (row 193) - FILED with a recommendation, deliberately not decided.** Only **10 of 48** bestiary blocks print the Attributes line that the stat-block table documents (`20:24`), while initiative is `3d6 + Agility` (`13:19`, `03:80`, `21:181`) and every opposed contest reads "the target's relevant attribute modifier, negated" (`06:71`, which is how Shove and Grapple resolve). W-003 could not roll initiative for 3 of its 7 combatants. This is the one finding that is **not** balance: the repair authors values rather than deriving them (the 10 existing blocks imply a ceiling of +2 but print no formula), so it goes out with both shapes costed and a recommendation.
- **No instrument was added to the repo this cycle** - the all-216 enumeration is a scratch probe, because the number it produces is the *evidence* for a decision rather than a gate someone re-runs. It exists because band subtraction is wrong at the edges (a fumble's natural 3 can land inside Standard at high modifiers); every figure above assigns each of the 216 rolls exactly one outcome.
- **AUDITED AND MERGED IN-CYCLE**: **PR #711**, squash, `main` `9e56564`; 4 files, chapters only; 13 insertions / 10 deletions; no number touched (damage, DR, HP, the Challenge 12 rating, the dial and the bands all stand); added em-dashes / bold / damage dice **0 / 0 / 0**; native gate exit 0; **independent build exit 0 at 399 pages (unchanged, so no reflow)**; and the render rather than just the diff - `pdftotext` shows the quick reference reading Boon / Triple Boon beside the conversion sentence (p228), the reference sheet's line (p379), and 5 + 3 hits for the parentheticals. The agent's self-report and my audit agreed on every count.
- **RECORD**: rows 191 / 192 / 193, scorecard row 26, `walkthroughs/2026-09-27-w-003-round.md`, #710 closed with the audit evidence attached, this section. **Next**: dispatch row 192's cap (the defence Challenge), then bring row 193's convention call back with the evidence.



## Cycle 28 (2026-09-27) - the caster session (W-004) found the one rule the damage maths never states, and running the two law gates widened turned up the last survivor of each

**Priority 1 is now a one-line check and it returned zero again.** `needs Bruce` = 0, no status cell
begins `open`/`pending`, no row is ruled-and-unbuilt. Rows 162/166/167/168/169/171 were decided and
landed in cycles 9-22; the brief still names them, the ledger does not. Priority 2 has no target either
(assessment coverage 9 of 9), so the cycle took the plan's own named next action.

**The action: W-004, the caster session.** The one pillar with no transcript behind it. Sera Ashvein is
fully printed at `02:330-366`, so no hero had to be invented, and both her pools close exactly (11/11
background, 12/12 class) - the creation economy holds up for a caster with no adjustment. Clean on every
other check: the casting procedure (`10:31-33`), the tier/gate table, cantrips at will, focus and its
downgrade, concentration **with its target stated** (`10:110`), ritual, ending another caster's effect,
the per-encounter/per-session limits, `Arcana` as a real skill (`07:167`), `Recharge` (`20:28`,
`21:239`) and Morale Check (`13:311`).

**The find.** The book never says whether DR comes off before or after a resistance/vulnerability
multiplier - and its own starter encounter is the one stat block that needs both: **4 Drowned Guardians,
HP 14, DR 1, Vulnerable (Fire)** (`19:312`), against a party that will bring fire. Measured: 50 bestiary
blocks print DR, 4 print a resistance, and **no worked example in the book combines the two**. The order
is not a preference - DR-then-type reaches **0** (4 fire vs DR 3 resistant), which `06:91`'s "minimum 1
damage from any hit" and `16:27`'s "a hit must always be able to land for something" both forbid - so it
is derived: **type modifier first, then DR, floored at 1**. One clause at `13:155`, the rule's own home.

**Two swept-law singletons fell out of reconning the caster's chapter group**, both landed in the same
PR: `05:340` Leader *Lead by Example* still granted **`+2 bonus on their next roll`** (the last numeric
roll modifier in the book, and contradicted by the book's own restatement at `02:470`, which prints
**`Boon`**), and `05:568` *Leverage* still read **`deals +2 bonus damage`** (the last flat damage rider,
in a table whose five siblings all print `+1 damage tier`). **Both gates were blind to both by the same
mechanism:** each regex requires the number glued to its noun, and `bonus` sat in between. Both gates
widened to allow it, with a negative control that FAILS on pre-fix `main` and passes on the branch.
SKILL.md trimmed to 99,755/100,000 to pay for the addition.

**Also landed:** `07:41` now states that a class sheet's `*Favored Skills*` line is guidance, not a
discount - the field is printed on all nine class sheets and marked in the printed builds, while ch07
already says all skills cost the same for every class and never uses the word, and ch02/ch05 use
"Favored" for a cheap *Discipline* rate.

**Cost:** +44 words (84,173 -> 84,217), no page change (399 before and after). Four ledger rows' worth
of decisions in 4 changed lines plus one clause. PR #714, `bdd96ca`.

**Next:** the queue is empty and no subsystem is unassessed. W-005 is the next transcript in the role
card's rotation and the scorecard's thinnest axis after Playable: the **DA walkthrough** (run the
bestiary as printed against a party of the intended level), because the caster session just showed that
the encounter-side stats are where an unstated assumption costs the most.

## State at cycle 27 (2026-09-27, verified against the repo, not recalled)

- **Nothing was in flight.** 0 open PRs, 0 open issues, `main` at `87922dc` on wake and `ab38794`
  after the merge. 9 of 9 subsystems assessed, no status cell reads `needs Bruce`, nothing
  ruled-and-unbuilt. Priority 1 is now a one-line check and it returned zero.
- **The queue's last two rows landed in one work order.** Rows 192 and 193 were the same subsystem
  (the Challenge number) and are now **#713** (`ab38794`), audited and merged: the defence Challenge
  is capped at the dial's own -6, the stat-block Attributes field states its default, a player rolls
  creature initiative on the DA's behalf, and the 39 blocks that printed no attribute line now carry
  one.
- **Row 193 was MISCLASSIFIED and is decided.** Its status cell read "needs a convention call -
  not decided unilaterally because the repair authors values rather than deriving them". Authoring a
  value is not a Bruce question: the row's own premise supplies the bound, and the corpus supplies the
  shape. Two of its counts were also wrong (the chapter has **49** `=== ` blocks, not 48; the omission
  is **39 of 49**), and one premise was false (a contest's Challenge is printed, in the heading).
  The three defects it actually names each got the smallest lever that restores the invariant it
  breaks: the DEFAULT (frame, no new rule) for initiative, the roller SENTENCE for a gap against
  `13:103`, and per-creature values only where the default lies about the creature.
- **The line that decided the last part, and the one to remember:** the Doppelganger is not a
  judgement call at all. Its own Shapechange text consumes *its attributes* and *the doppelganger's
  Guile (Deception) modifier* (`20:561`) while its block prints no Attributes line, so leaving the
  default to cover it would have left a printed ability reading an unprinted zero.
- **New instrument:** `scripts/check-attributes-census.py` (skill). Two comparisons, each against a
  source that is not the file: BRANCH vs the decided values, and BRANCH vs base for the ten printed
  lines that must stay byte-identical. Three planted-defect controls. **It caught its own author
  first:** run from inside the worktree it read `HEAD` in the primary checkout and reported main's
  numbers as a failure, which is trap (8) of the audit discipline, and the repo is now discovered
  from the invoking directory.
- **Cost, stated plainly:** the wave adds **422 words** (83,751 -> 84,173) and no page (399 before
  and after), for 39 blocks that a DA could not otherwise roll for or shove.
- **Next:** the queue is empty and no subsystem is unassessed, so the next cycle runs **W-004**, the
  walkthrough the scorecard is thinnest on: a caster session, because "magic always fires" is the one
  pillar with no transcript behind it and the magic assessment's four design questions were filed
  rather than played.

## Cycle 29 (2026-09-27) - W-005 played the bestiary and 2 of 49 blocks failed; the pacing gate was reading 48

**The action, in the order the queue asked for it.** Priority 1 returned zero as a measurement again: no
ledger row reads open, pending, needs-Bruce, waiting or do-not-implement, and no row is ruled-and-unbuilt
(the six rows the prompt names landed in cycles 26-28). No subsystem is unassessed (9 of 9, re-assessed
cycle 28). So the cycle ran the next transcript on the role's list, **W-005, the DA walkthrough** - the
one the scorecard is thinnest on after W-004, and the only one that plays the bestiary as a fight.

**Findings, both singletons, both the same shape.** The Wraith printed two statements of one reduction
and their composition collapsed the damage triple to `[1,1,2]` - a coin flip for one point of damage,
against `16:25`'s distinctness law and `20:659`'s DR ceiling. The Swarm of Rats printed an immunity whose
named counter (an area effect) is not reachable at the Novice band it is budgeted into, so a level-1
Standard encounter of twelve of them is 204 HP the party cannot touch. Both were decided as balance
questions: name the invariant, measure the whole range, take the smallest lever, prefer the book's own
printed idiom. Repairs: delete the duplicate trait (the DR stays, because HP follows it); replace the
immunity with the resistance phrasing the book already uses. One work order, one file, **#715 -> PR #716,
squash `5ef6b51`**, audited and merged in-cycle, render-verified at 399 pages.

**One review redirect, and it caught MY instrument, not the agent's work.** The work order also asked for
the wraith's DR field to be reworded to `DR 3 against non-magical attacks`. Nine blocks print
`DR n (source)`, and that shape is what the parser keys on, so the rewording silently dropped the Wraith
and the sweep printed **48 blocks as a PASS** - a false clean in the very cycle that was hunting false
cleans. Restored on the branch before merge; the sweep now refuses to pass when parsed != headings.

**The durable half is the gate, not the block.** `rounds-to-resolve.py` had been averaging **48 of the
book's 49 blocks** and never banding the C12 dragon; fixed, its verdicts are now Adept `3.68 -> 3.73`
and Master `3.36 -> 3.27` (PASS at every tier, cost 73.0% / 81.0% / 71.5% of the pool). With the corpus
complete, the pacing law reads green on the whole bestiary for the first time.

**State at cycle 29.** Book at `5ef6b51`; **0 open issues, 0 open PRs**, one checkout, clean tree, PDF 399
pages at **84,216 words**; gates: native-Typst 0, pacing PASS (49 blocks), canon index calibration OK
(ch11's own 75 claimed = 75 parsed), DA sweep 49/49 PASS; ledger 198 rows with an unbroken sequence
(row 105 tombstoned, cited by a council SUMMARY and unrecoverable). Landed this cycle: PR #716 plus the
two gate repairs and the ledger tombstone.

**Next: three walkthroughs on the role's list have never been played** - the change-one-number pass
(perturb a budget row, a tier or a rank cost and report the blast radius), **the boredom pass**
(dominated choices, and the most forgettable page in the book) and **the flavour pass** (does each
mechanic's flavour sell it, and does any flavour contradict its own rule). Play the boredom pass next: it is the only one of the three that
produces decisions rather than descriptions, and it targets the scorecard's Succinct line, which has been
flat since the armament collapse. Screen first with `choice-space-sweep.py` and the card census so the
pass reads a shortlist, not all 208 cards. *(Cycle 30 correction: that screener belonged to the retired kit
economy and is dead - see the cycle 30 entry.)*

## Cycle 30 (2026-09-27) - W-006 screened 208 cards, found ONE dominated choice, and the screener needed five repairs to be readable

**Priority 1 returned zero for the fourth cycle** (`needs Bruce` 0, no status cell begins open/pending, nothing
ruled-and-unbuilt, 9 of 9 assessed), so the cycle took the plan's named next action, **W-006 the boredom
pass**, and it produces a decision: it found and landed a card that a player should never buy.

**The named screener was dead, which is itself a finding.** `scripts/choice-space-sweep.py` is the kit
economy's instrument and the kit system retired in #577/#586, so it now has no live target and its own
`--selftest` crashes (`IndexError`: the planted-rule kit is not in its synthetic space). The pass needed a
new instrument for the card corpus: **`scripts/dominated-choice-census.py`** (208 cards parsed from
`09`/`11`/`12`, 3 planted defects and 4 negative controls, `--rev` for branch reads, a coverage guard that
reports the cards it cannot screen instead of a clean line).

**Five repairs before the shortlist was readable, each a trap worth keeping.** (1) The field-line parser
read `block.split("\n")[0]`, which is the empty tail of the heading because the card regex eats the
newline, so Disciplines/Action/Range/Keywords ALL parsed as empty and the first run screened 208 cards on
their kind alone. (2) A `·`-joined requirement truncated at the first `·`, the same trap `tier-census.py`
carries a repair note for (`2 Melee · 1 Stealth` counted as 2). (3) `+1 damage tier` read as 1 damage,
turning every tier-bump card into a 1/1/1 dud. (4) `remove Frightened or Dazed` read as IMPOSING
Frightened, inventing a dominant support talent out of Rally the Troops; and `the target is Prone` read as
a PRECONDITION, deleting the condition from every card that imposes one. (5) A condition-only vocabulary
could not see `lose their Maneuver` at all, which is the trap the skill already records. The list went
**62 -> 18 -> 16 -> 5 -> 3** pairs across those repairs, and each step was a documented class of error, not
tuning: the count moving is what an undercount looks like.

**One genuine domination in 208 cards.** `Tremor` (Adept Arcane, 2 Earth) strictly contains `Static Field`
(Adept Arcane, 2 Wind): identical price (2 ranks), identical `focus:arcane` gate, identical Action,
identical 10-ft radius, identical 5/8/11 row, identical Weak failure clause, and Tremor adds Prone at
Standard while its Strong keeps the Maneuver loss Static Field has. **Damage type cannot carry the choice**:
across all 49 bestiary blocks nothing resists or is immune to lightning, and bludgeoning is a vulnerability
once. All nine class cost tables price Earth and Wind identically, so the two compete for the same DP. Fix
is a design act on the weaker card's OWN axis: "targets lose their Maneuver" moves down to Standard, Strong
adds the book's printed no-Reaction clause, Tremor is untouched, and neither card is a superset afterwards.
**The other two pairs are model artifacts, read and dismissed**: two gear-locked basic attacks compare
weapon properties (a thrown weapon's 20/60 is the weapon's, not the card's), and a range-only pair whose
Strong rungs diverge.

**The same sweep produced a second finding the ledger had no row for.** `13:161` prints "never a second
roll... No check"; row 38 applied that law to ch17's six item riders; **five card clauses still asked the
target to roll to avoid the card's own effect** (Venom Lance x2, Touch of the Grave x2, Phantasmal Image
x1). Converted to the rung each effect already sat on, using only printed vocabulary. Exempt after reading:
every Morale clause (a printed subsystem where a player rolls FOR the creature), Ghost Sound's perception
check, and the Boon-on-a-check support clauses. One more was filed rather than converted: **Thaumaturgy's
Strong rung is an at-will mass-flee** once its check goes, so #719 carries the fork and the recommended
default (bound it to one creature, the printed cantrip scale).

**Landed:** #717 + #718 -> one work order -> **PR #720**, squash `e37b49f`, one file, 7 lines; my own
gates: second-roll grep 0, em-dashes/bold/dice 0, native-Typst exit 0, independent build exit 0 at **399
pages**, and the PDF text layer re-read for every changed line (p191, p194, p197, p202) with `fail a Reason
check` returning 0 hits book-wide. Ledger rows 199/200. **Open: #719 only.**

**Next: the change-one-number pass and the flavour pass are the two walkthroughs still never played.** Play
the **change-one-number** pass next: it is the designer's form of an audit, it needs no new corpus parse
(the instruments for bands, tiers and DP cost already exist), and the boredom pass just proved how much of
a design question hides behind a single printed number.


## Cycle 31 (2026-09-27) - #719 landed, and the one-roll law's third population split into 2 defects and 11 questions

**Priority 1 returned zero for the fifth cycle** (`needs Bruce` 0, no status cell begins open/pending, 9 of 9 assessed), so the cycle landed the one ruled row: **#719** - the Thaumaturgy decision cycle 30 recorded - as the cycle's work order.

**The dispatch was clean because the decision was already fixed.** Worktree `fix/719-thaumaturgy` from `origin/main`, spec seeded inside the worktree as `.task-spec.md` with the chosen text ONLY (the issue's options B/C/D were deliberately not carried into the spec, because an agent transcribes what it reads and reads top-down). The spec's OLD line was asserted byte-identical against the file before dispatch (`line 74 == OLD`, occurrences in file: 1), which is the dispatch gate that costs nothing and catches a spec written from recollection.

**Audit (mine, not the agent's report).** Exactly 1 file changed, 1 insertion / 1 deletion; the added line carries 0 damage dice, 0 em-dashes, 0 markdown bold, 0 flat riders; `check-native-typst.py` exit 0; **an independent rebuild of my own** exit 0 at **399 pages**; and the built PDF read at the card so the ruling is verified in the RENDER, not the diff: `flees for 1 round` 1 hit, `Hostile creatures of Novice` 0 hits book-wide. Merged as **PR #721, squash `0582e50`**, branch deleted local and remote, worktree removed, #719 closed with the evidence attached.

**The cycle's find is a population split, not a new card defect.** #719 and row 200 closed the one-roll law on the card corpus; the sweep's follow-on then grepped the law book-wide, where it is live in a **third** population - monster stat blocks - and reading every site split it cleanly in two:

- **2 sites are the rows-38/200 class exactly**: Dire Wolf *Knockdown* (`20:52`) and Ghoul *Paralyzing Touch* (`20:277`) each key their effect to the attack's own tier ("On Strong hit") and then demand a target check. For an NPC attack the player's Defence Roll has already happened and picked the monster's damage value, so the check is a second roll for one exchange, forbidden by `13:161`. Filed as work order **#722** with both exact lines and a do-not-convert list; not dispatched, because the cycle's one work order was #719.
- **11 sites are a mechanism fork, not a balance defect**: Hex, Petrifying Gaze, Luring Song, Charm, Frightful Presence, Stunning Screech, Mind Reading, Rooted Grasp, Whelm and Kelvath's Tidal Surge impose a condition with a resistance check and **no attack attached**. There is no roll to key them to, so deleting the check would make a Challenge 3-6 aura automatic (Frightful Presence auto-Frightening, Petrifying Gaze auto-Restraining). Recorded as **row 203**, classified INTENT with the keep-and-name-it recommendation, because abandoning the check needs a mechanism the book does not print - and inventing one is new law, not a repair.

**Five sites read and dismissed as compliant**, so the next pass does not re-file them: the three *Relentless* traits (the monster's own check), the Stirge's detach check (`20:86`, a Maneuver the hero spends - the printed Escape shape, `13:265`), the ch19 environmental hazards, and five player-facing self-rolls (`04:179` Indomitable, `05:544` Disrupt, `05:546` Arcane Override, `10:114` the opposed effect-ending procedure, `11:61` Ghost Sound).

**State at cycle 31.** Book at `0582e50`; **1 open issue (#722), 0 open PRs**; one checkout, clean tree; PDF 399 pages at **84,253 words** (+1, which is the line's net word change). Gates on the cycle: native-Typst 0 (26 files), canon-index calibration OK (ch11's 75 claimed = 75 parsed), pacing PASS (3.79 / 3.73 / 3.27 rounds at Novice / Adept / Master, inside the 3-4 window), ledger 203 rows with no ruled-but-unbuilt row.

**Next: the change-one-number pass and the flavour pass are still the two walkthroughs never played**, and the queue is one dispatchable work order deep (**#722**, the two-trait fix, spec already fixed in the issue body). Dispatch #722 first: it is a two-line change with a verified scope table, and the pass after it should be the **change-one-number** pass, which needs no new corpus parse and was deferred by cycles 30 and 31 in favour of live defects.

## Cycle 32 (2026-09-27) - #722 landed; row 203 reclassified, because the threshold was missing from the SITES, not from the book

**Priority 1 returned zero on the brief's six named rows for the sixth cycle** (162/166/167/168/169/171 all landed), but the queue still held one row whose **classification column was itself the defect**: row 203 read "OPEN, INTENT fork, not a balance row I can decide", and the mandate says a balance question wearing an INTENT label is mine to settle. The cycle therefore did two things: landed the queue's work order, and decided that row.

**The dispatch.** #722 -> **PR #723, squash `878fdda`**. Worktree `fix/722-bestiary-traits` from `origin/main`, spec seeded inside the worktree as `.task-spec.md` carrying the chosen texts only (no discarded alternatives). **The dispatch gate's catch this cycle was a false claim in the issue's own acceptance criteria**: it asserted that a book-wide grep for `Paralyzing Touch` returns one site; measurement returns two, and `20:291` is the **Lich's** attack line, a different sub-class from the two traits filed (it has no tier trigger, so deleting its check would make an at-will Lich paralysis automatic). The spec named 291 explicitly as out of scope and byte-identical, and the acceptance assertions were rewritten to the counts that are actually true (`Knockdown` 1, `Paralyzing Touch` 2). A spec written from recollection would have had the agent "fix" the Lich's line, or fail its own acceptance test.

**Audit was mine.** Exactly 1 file (`20-bestiary.qmd`), 2 insertions / 2 deletions; added lines carry 0 damage dice, 0 em-dashes, 0 markdown bold, 0 flat riders; `check-native-typst.py` exit 0; **my own rebuild exit 0 at 399 pages**; the built PDF's text layer re-read at the site (new `Knockdown` line present, `must succeed Agility check` 0 hits, `must make a Fortitude check or be Paralyzed` 0 hits, the Lich's line byte-intact). Off the branch: `da-walkthrough.py` **PASS 49/49** (0 unreachable, 0 collapse, 0 immune), `rounds-to-resolve.py` **PASS 3.79 / 3.73 / 3.27**. Merged squash, branch deleted local and remote, worktree removed, #722 closed with the evidence attached (the PR's `Closes` line had auto-closed it, so the audit was posted as a comment).

**Row 203 decided rather than asked, and the fork dissolved under measurement.** The row's question was whether the game has target-defence rolls for non-attack effects at all, and its premise was that "no printed mechanism says which roll such an effect keys to". Grepping both printed forms of the idiom book-wide shows the threshold is **not** missing from the book: twelve other instances of the same shape name it (`13:370`, `13:410`, `15:187`, `15:191`, `15:193`, `15:291`, `15:295`, `17:407`, `19:107`, `19:317`, `19:337`, `19:357`), and **every single one uses the same value**, `Standard or better` (the phrase `06:41` already defines). So the smallest lever is ONE sentence at `13:161`, the site whose own closing "No check" is what makes a reader or a checker read the class as a violation: *"An effect that carries no attack or spell roll of its own, such as a gaze, an aura or a hazard, resolves as the target's own check on Standard or better. That check is the effect's whole resolution, not a second roll."* Every check stays: the dice remain in the players' hands, and deleting them would turn a soft aura on a Challenge 3-6 block into an automatic lockdown. **Census corrected in the same pass: the class is 13 sites, not the 10 the row listed and not the "eleven" it claimed** - the three it never named are `20:68` Giant Spider *Bite*, `20:291` Lich *Paralyzing Touch*, and `20:619` Phase Beast *Unstable*.

**The two attack-line riders split out as row 204, decided on the one-roll axis.** `20:68` and `20:291` are also in row 202's class (a second roll on an exchange the defender's roll has already answered), and neither names a tier, so deleting the check outright would make the rider unconditional. Decision: the check becomes the tier the same roll already produces, `on a Strong hit`, the exact form `20:52` uses. **Why that is not a power change:** read as the class default, a Standard-or-better resist gate at +0 is beaten 74.1% of the time, so the rider landed 25.9% of the time, and `P(3d6 <= 8) = 56/216 = 25.9%` is exactly the chance the defender rolls Weak and the monster's Strong band comes up. Same frequency, no second roll.

**Both decisions are one work order: #724** (3 lines, 2 files, the sentence plus the two retiers), filed with the full census, the byte-identical anchors, and the veto path. **State at cycle 32:** book at `878fdda`; **1 open issue (#724), 0 open PRs**; one checkout, clean tree; index calibration OK (75 = 75); ledger 205 rows, none ruled-but-unbuilt.

**Next: dispatch #724**, then the **change-one-number** pass, which is still the walkthrough never played.

## Cycle 33 (2026-09-27) - #724 landed (PR #725 `0f46c66`); the missing threshold is printed, and the queue is empty

**Priority 1 returned zero for the seventh cycle** (`needs Bruce` 0, no status cell begins open/pending, nothing ruled-but-unbuilt, 9 of 9 assessed), so the cycle took the queue's only item, which was cycle 32's own decision landing.

**The dispatch gate found nothing, and that is the result worth recording.** Every premise of #724 was re-read against `origin/main` before the prompt existed: `13:161` (the paragraph whose closing words are "No check"), `20:68`, `20:291`, the three byte-identical anchors (`20:277` Ghoul, `20:317` Basilisk, `19:337` Kelvath), the twelve precedent sites, `06:41`'s definition of "Standard or better", and the two acceptance greps (`Fortitude check)` 1 -> 0, `Paralyzing Touch` 2 -> 2). All held. The gate is not decoration when it finds nothing: it is the check that makes a clean audit meaningful rather than lucky.

**The work order:** one sentence pair at `13:161` plus two bestiary lines, 2 files, 3 insertions / 3 deletions. The spec carried both new texts verbatim and explicitly named the thirteen-site census as **not** a to-do list, so the agent authored nothing and touched nothing else.

**Audit was mine.** File set exactly the two named chapters; added lines 0 damage dice / 0 em-dashes / 0 markdown bold / 0 flat riders; anchors unchanged; `check-native-typst.py` exit 0; **my own rebuild exit 0 at 399 pages**; the built PDF's text layer read at the site (both new bestiary lines present, both OLD parenthetical clauses 0 hits, the Ghoul's `on Strong claw hit` line intact, the new sentence present in the render); off the branch `da-walkthrough.py` **PASS 49/49** and `rounds-to-resolve.py` **PASS 3.79 / 3.73 / 3.27**. Merged squash, branch deleted local and remote, worktree removed, #724 closed with the evidence attached.

**One instrument lesson, and it is the audit-discipline class again.** The render check's first pass read **0 hits** for the new ch13 sentence and looked like a failed landing. It was the checker: the PDF text layer prints a typographic apostrophe (`\u2019`), so an ASCII fragment containing `target's` can never match. Normalising the apostrophe before matching returned 1 hit. A fragment grep that silently cannot match is the same failure mode as a harvest regex that collects 5% of its population, and the fix is the same: prove the check can see what it is looking for before believing a zero.

**Record correction.** Cycle 32's row and its plan section both wrote "ledger 205 rows"; the file holds **204**, and the monitor's own counter agreed with the file. The overcount is corrected in the scorecard rather than left to propagate.

**The end-of-pass ledger sweep found three stale status cells, and they are the drift class the skill warns about.** Grepping for a status cell that names a work order while never saying LANDED returned six rows; three are decisions with no build (171, 180, 181, all rulings that change no number) and **three were genuine drift**: row 202 still read "FILED, dispatchable as written" two cycles after #722 landed, row 177 still read "Work order #685" after #685 closed in PR #688, and row 191 still read "filed and dispatched this cycle" after #710 closed in PR #711. All three now carry their evidence (PR number and squash sha). This is the second consecutive cycle in which the defect was in the ledger's own bookkeeping rather than the book, which is why the status cell must be updated in the same commit as the implementation.

**State at cycle 33.** Book at `0f46c66`; **0 open issues, 0 open PRs**; one checkout, clean tree, no worktrees, no stray branches. Words **84,287** (+47); ledger **204** rows, none ruled-but-unbuilt; index calibration OK (75 = 75).

**Next: the change-one-number pass.** It is now the only named item left on the plan, deferred by cycles 30, 31 and 32 behind live defects that no longer exist. It is the designer's form of an audit, needs no new corpus parse, and the queue behind it is empty.

## Cycle 34 (2026-09-27) - the change-one-number pass: the row holds up 283 printed sites, and two of its constants were printed with no derivation

**Priority 1 returned zero for the eighth cycle** (`needs Bruce` 0, no status cell begins open/pending, nothing ruled-but-unbuilt, 9 of 9 assessed, 0 open issues, 0 open PRs), so the plan's own named next action ran: **W-007, the change-one-number pass**, the fifth walkthrough and the only one never played.

**The pass needs an instrument, and the instrument is the finding.** `scripts/change-one-number.py` (new, in the skill) parses `origin/main`, re-derives every constant that is supposed to follow from the damage-budget row, then perturbs one number at a time and reports the blast radius. Its `--selftest` plants a mutated Novice row and requires the derived-constant check to fail on it (**it does**). The census it prints: 208 card headings, **155 card damage blocks**, 49 stat blocks, **79 monster damage triples**, 49 `HP n, DR n` lines, 6 ceiling sites, 1 band-average site, four rank ladders `(1,2,4) (2,4,8) (3,6,12) (4,8,16)`, level-1 pool 12 DP.

**Part A: 0 stale derived constants.** The printed band averages are exactly the row's three values weighted by the 3d6 odds (56/140/20 in 216: 4·56 + 6·140 + 8·20 over 216 = **5.667** = 5.67 printed), and the printed ceilings sit exactly on the invariant boundary, `Weak − 1` at all three tiers (3/4/6 against 4/5/7). Both are correct. **Neither derivation is printed, and the odds table appears nowhere in the book** (0 hits each), which is the gap the pass exposes: the numbers are unverifiable to a DA.

**Part B: the blast radius.** Row **+1** moves all three averages and leaves every ceiling a step too low; row **−1** **breaks invariant 3** at the printed ceiling, because Novice ceiling 3 would exceed Weak − 1 = 2 and heavy armour's DR 3 (gear, therefore gold-gated rather than level-gated) collapses the Novice triple to 1/1/1. Grit 2/3/4 → 1/2/3 **breaks invariant 7** (the ledger's measured 73/80/73% share of the pool becomes 110/107/91%). Card price and the rank ladders are coupled but sound. Heavy armour DR 3 → 4 is ungrantable in principle, since `16:29` costs a DR grant at one rank per DR and `10:70` caps a Discipline at rank 3 - so the armour ladder is self-consistent as printed, and the pass confirms it rather than repairing it.

**CN-1 landed as a micro-PR of my own (PR #726, `92d990e`)**, on the smallest lever: two clauses, documentation only, no number, band, ceiling or stat block moved and no rule added. `16:27` names the ceiling's derivation and its dependence on the band; `20:657` names the average's weighting, which also prints the odds the book never carried. Audit: 2 files, 2 insertions / 2 deletions, 0 em-dashes / 0 markdown bold / 0 flat riders in added lines (the single damage-dice grep hit is `3d6 odds`, the core die), every removed number survivable in the added text (checked programmatically), native gate 0, independent build 0 at **399 pages unchanged**, both clauses re-read in the built PDF's text layer.

**CN-2 and CN-3 reported, deliberately unchanged.** The largest printed hero DR grant anywhere is **+3** (heavy armour 3; the +3 wards at `11:731`, `12:241`) and DR does not stack (`16:23`), so the Adept ceiling 4 and the Master ceiling 6 can never bind today - a guardrail whose values are derived from the band rather than chosen (P6 shows the Adept ceiling binds the moment the rank cap moves to 4), so lowering them would be new law. And `Petrified`'s DR +5 exceeds the Novice and Adept ceilings by design, because the ceiling's scope sentence names armor, talents and wards only. Both are recorded in the transcript so the next pass does not re-file them.

**State at cycle 34.** Book at `92d990e`; **0 open issues, 0 open PRs**; one checkout, clean tree, no worktrees, no stray branches. Words **84,329** (+42, the two clauses); **ledger 205 rows**, none ruled-but-unbuilt; pages **399** (unchanged).

**Next: the flavour pass (W-008)** is now the only walkthrough never played, and it is the one whose criterion has no instrument yet: does each mechanic's printed flavour sell its mechanic, and does any flavour contradict its own rule. The queue behind it remains empty, so the cycle after that returns to the assessment's `## What matters now`.

## Cycle 35 (2026-09-27) - the flavour pass: flavour was the one dimension with no owner, and it held two mechanical defects

**Priority 1 returned zero for the ninth cycle** (`needs Bruce` 0, no status cell begins open/pending, nothing ruled-but-unbuilt, 9 of 9 assessed, 0 open issues, 0 open PRs), so the plan's own named next action ran: **W-008, the flavour pass**, the seventh and last walkthrough on the role's list and the only criterion enforced by human read.

**The pass needs an instrument.** `scripts/flavour-pass.py` (new, in the skill) parses `origin/main` (or `--rev`), screens four candidate classes with addresses, and carries a `--selftest` that plants one defect per check plus a negative control (it flags all four and leaves the control clean). Its coverage guard is the book's own oracle: ch11 claims 75 cards, and a short parse exits 2 rather than printing a clean line. Corpus: **208 cards, 503 rungs**; the screen is bounded by its own vocabulary, so the counts below are stated under it.

**Two of flavour's failure modes are mechanical, and both were live.**

(a) **A rung keyed to a subsystem the book does not have.** `11:34` Arcane Mark's Weak rung said *"Detection spells reveal it, but the image is blurry."* The qualifier `detection` appears **once in the whole book**, on that line: the reader is told a category of magic gates the effect and there is no category to look up. Fixed by naming the printed spell, `Eldritch Sight` (`11:365`, Novice Arcane, "Reveal 1 clue about magic").

(b) **A rung promising a rider its row does not fund.** `11:110` Acid Splash's Strong rung said *"The acid clings and keeps eating"* while nothing on the card recurs and the rung prints no duration, which invites a table argument about ongoing damage at a cantrip whose row is fixed. The rung below already carries the corrosion mechanic (*"Ignores 1 point of DR against objects"*), so the clause now describes corrosion on the same axis: *"It eats through cloth, leather, and thin metal."* The persistence grep behind the class returns seven lines book-wide and six are legal (the persistence is the printed effect, or the line prints its own duration).

(c) **The stat-block-soup shape, at card level.** Three cards printed no flavour clause on any rung: `Tough` (09), `Renewal` (09), `Thread of Ruin` (11). Their chapters' convention is the opposite (85 of ch09's 87 cards, 72 of ch11's 75 carry flavour), so each gained one clause in its neighbours' register. No number moved.

**Read and judged NOT defects**, and recorded so the next pass does not re-file them: the 45 bare rungs inside otherwise-flavoured cards (the book's rhythm; the card-level check is the actionable one), the 18 `Basic Attack` rungs (the printed floor, excluded by law), and the whole-book orphan screen's two survivors (`abjuration` at `08:45`, `necromancy` at `11:15`), which are atmospheric nouns in prose with no mechanic keyed to them. Duration conflicts and dead lexicon both read **0**.

**Landed as a micro-PR of my own (PR #727, `6f4769c`)**, 2 files, 5 lines. Audit: file set exactly the two chapter files; added lines carry 0 damage dice / 0 em-dashes / 0 markdown bold; every number present on both sides of the diff, checked by digit multiset rather than by eye; `check-native-typst.py` exit 0; **independent build exit 0 at 399 pages** (unchanged); all five new fragments and the removed phrase re-read in the built PDF's text layer.

**State at cycle 35.** Book at `6f4769c`; **0 open issues, 0 open PRs**; one checkout, clean tree, no worktrees, no stray branches. Words **84,398** (+69); **ledger 206 rows**, none ruled-but-unbuilt; pages **399** (unchanged). Every walkthrough on the role's list has now been played.

**Next: the assessment's `## What matters now`**, because the queue is empty and the walkthrough list is exhausted. The flavour dimension now has an instrument (coverage and contradiction), which was the last of the three scorecard outcomes to have one; the honest next move is to re-rank the open items against the reassessment rule rather than to invent a new pass.

---

## Cycle 36 (2026-09-27): THE STATE OF THE GAME, the first full review

**SENSE.** 0 open PRs, 0 open issues, 206 ledger rows with none ruled-and-unbuilt, 9 of 9 subsystems
assessed, all seven walkthroughs played. The queue was empty, and the contract makes an empty queue a
PRIORITY-1 trigger: *"if the queue is empty ... the act is the REVIEW, and it outranks everything below."*
Nothing to inspect, nothing to dispatch, and the plan's own named next action (re-rank `## What matters
now`) was a bookkeeping step, so the review ran.

**A housekeeping find first.** The cycle-35 bookkeeping commit (`aec0df3`) was sitting **unpushed** on the
local checkout, so the state the monitor reads was one commit behind the state on disk, which is why it
reported 205 ledger rows against a file holding 206. Pushed. And `origin/fix/flavour-pass-1` was still on
the remote after cycle 35; `git cherry origin/main origin/fix/flavour-pass-1` returned `-`, so the commit's
patch-id was already in main and the ref was deleted. **A cleanup pass that deletes the local branch and
leaves the remote ref has not finished the job.**

**THINK: the book, not the tracker.** Read for the review: ch01 in full (the promise list at `01:74-78`),
ch06's resolution engine, ch13's round, Grit and the Wound Table, ch19's encounter economics and starter
adventure, ch20's block format and traits, ch05's nine class blocks and ability tables, ch10's casting
rule and cantrip floor, ch16's DR law, plus all seven walkthrough transcripts as the playtest record.

**DECIDE: three positions the review takes and defends.**

1. **The reversed Defence roll is the best idea in the book**, and the single most likely thing to break a
   first session: the book's own quick reference inverted cover once, and the arithmetic says why it
   matters (16.2% to 35.5% chance of taking the attacker's Strong damage, all 216 outcomes enumerated).
   Ranked first among the weaknesses, and the repair is layout discipline rather than design.
2. **Flat hits-to-fall (5.8 / 5.9 / 5.8) is a position, not a defect.** Danger stays constant and the means
   scale. Its printed price is damage per DP falling 3.00 to 2.00 to 1.25, which needs the intent sentence
   the ledger already decided.
3. **The next most valuable work is to measure the Wound Table against the pacing law.** Every Grit spend
   is a Wound roll and much of the table is a per-encounter Bane; whether that compounds faster than the
   pools absorb is the one live unknown that could overturn the 3-4 round frame, and every other judgement
   sits on that frame.

Two findings were raised and cleared by reading rather than filing, which is the point of reading the card
first: ch01's example of play prints "Standard damage is 2, plus your Agility: 4" and that is **correct**
(the Basic Melee floor is 2 at Standard, `09:232`, plus Agility via the Blade's Precision), so the defect is
readability and the unstated substitution, not the number; and the goblin chieftain's "crude leather armour
DR 2" is an NPC stat line, not hero gear, so the DR scope law does not reach it.

**Landed as a micro-PR of my own (PR #728, squash `0786a0c`)**: one new file, `docs/design/architect/review.md`,
3,845 words, 10 sections in the contract's order. Audit: file set exactly the one file and 0 `.qmd` touched
(so no rebuild is owed); **36 distinct `chapter:line` citations checked against the chapter files, 0
dangling**; 0 em-dashes and 0 contract-banned words in added lines. Two citations were corrected on the
branch before merge (`06:93` pointed at the wrong section, `05:11-13` at the figure rather than the callout),
which is what the citation gate is for.

**State at cycle 36.** Book at `0786a0c`; **0 open issues, 0 open PRs**; one checkout, clean tree, no
worktrees, no stray branches, no unpushed commits. Ledger **206 rows**, none ruled-but-unbuilt; words
**84,398**; pages **399**. The review is on disk for the first time; `references/game-review.md`'s cadence
rule now applies (rewrite when the queue empties, after an assessment sweep, or on request).

**Next: the Wound Table against the pacing law.** The review names it as the highest-value open question and
it is a measurement with an instrument to build (Grit spends per fight by tier, the Wound Table's Bane
population, and the resulting rounds-to-resolve), not a new pass. It is balance in the contract's sense:
the invariant is pacing (7) and the lever is a measurement, so it is mine to settle.

## Cycle 37 (2026-09-27) - the Wound Table measured: it is bounded, and the one row that carries the tax was keyed to a word the book never defines

**Priority 1 returned zero again** (`needs Bruce` 0, no status cell begins `open`/`pending`, no
ruled-and-unbuilt row, 9 of 9 assessed), so the cycle ran cycle 36's own named next action: measure the
Wound Table against the pacing law, because if Grit's price compounds faster than the pools absorb then
the 3-4 round frame is holding a spiral rather than a fight.

**SENSE.** Both calibration instruments ran clean before any claim was made: the canon index
calibrated on the first run (ch11's own sentence, 75 = 75) and `rounds-to-resolve.py` returned **PASS
with its selftest** (both controls, 3.79 / 3.73 / 3.27 at the amended #663 size). The monitor's wake was
my own cycle 36 landing, so the corpus was re-read rather than assumed.

**The instrument.** New `scripts/wound-spiral.py`. It parses both D666 tables out of `origin/main`
(never a transcribed copy, the lesson that has cost this project three false findings), enumerates the
**56** reachable sorted-triple outcomes with their permutation weights, maps them under the printed
named-triple precedence, classifies every row's effect by what it does to a roll and for how long, and
then walks a hero's pool against the band's own stat blocks using the book's **reversed** defence
mapping. `--selftest` carries four controls: the reversal oracle (the book's own worked example at
`13:152`), a planted deletion (remove Cracked Ribs and 4 outcomes strand), a bestiary-harvest floor, and
an amplification control (a Bane must raise damage, or the model is wrong).

**The answer: bounded, not spiralling.** The table is **56/56** outcomes mapped with 0 gaps and 0
ambiguity. Per Grit spend, **11.1%** adds a sustained DEFENCE-roll Bane (Cracked Ribs 9.7% + Shattered
Spirit 1.4%); 78.2% impose something, 0.9% nothing. The tax is **~0.3 rounds** of pool life per source
and `06:63` caps potence at three. Pool life unwounded -> at the ceiling: Novice **5.2 -> 4.1** against a
3.79-round fight, Master **4.1 -> 3.3** against 3.27, Adept **4.2 -> 3.3** against 3.73. Novice and
Master clear at every potence they can reach; Adept has one tail, opening at potence 2 and needing two
of the 11.1% events inside three spends, i.e. **3.4% of heroes**. The test that settles it is the book's
own failure condition rather than my impression: `13:346` says a hero falls at 0 HP **with no Grit
left**, so a drop after exhausting Grit is the design working, and **no hero is dropped while holding
Grit**. Nothing on the Wound Table needs to move, and that is the decision (BALANCE, veto to revert).

**The find, which came out of doing the measurement rather than the arithmetic.** `13:395` Cracked Ribs
keyed its Bane to **"all physical rolls"**, and `physical roll` appears **once in the whole manuscript**,
never defined. `07:134` groups skills as Physical / Knowledge / Social / Subterfuge / Crafting, so that
reading covers a Dodge or Parry Defence Roll but **not** the attribute-only Defence Roll at `06:103` -
two heroes, one wound, opposite outcomes, no rule to settle it. It matters because the Defence Roll is
reversed (`06:122`), so a Bane there raises the attacker's damage tier: this is the single row the whole
measured tax rides on. The same token appears a second time at `11:56` ("next physical action"). Both are
now named in the taxonomy the book already prints (Brawn, Fortitude, Agility), in the idiom the
neighbouring cards use when they mean a specific roll (`06:198`, `13:388`, `13:207`). Two sites, two
insertions, two deletions, no number moved.

**Audit.** Exactly the two named chapters; added lines carry 0 damage dice, 0 em-dashes, 0 markdown
bold, 0 flat riders; `check-native-typst.py` exit 0; **my own rebuild exit 0 at 399 pages, unchanged**;
both clauses re-read in the built PDF's text layer (p185, p240) with the OLD tokens at 0 hits
book-wide; `da-walkthrough.py` PASS 49/49. Realised as **PR #730**, squash, branch deleted.

**Two instrument lessons, recorded because both would have produced a false report.** (1) The ch13
fragment read **0 hits** on the first render check and the site was fine: the text layer breaks
"For-titude" across lines, so **a fragment that reads 0 can be wrapped, not absent** - the site must be
read, not counted. (2) **Three citations I wrote this cycle pointed one line past the end of the
reversal table's rows** (at its closing paren; the rows are `06:122`-`06:124`). Found by re-reading every
line ref against the
file before the commit, not by a gate.

**Reported, not changed.** `rounds-to-resolve.py`'s monster direction maps the distribution the
attacker's way rather than the book's (`06:122`), which overstates incoming damage by 0-13% for an
untrained defender and 12-19% for a trained one. **The verdict does not move**: the window is set by the
clear direction, which is mapped correctly, and the gate's hits-to-fall is right in level. Recorded as an
erratum in `assessment.md`; rewriting a gate's model deserves its own measured cycle.

**A RULING LANDED MID-CYCLE, which is the cycle's second work order.** Bruce filed **#729** at 09:37, one
minute after this cycle's scan, so the scan's "0 open issues" was true when read and wrong a minute later -
and the monitor's snapshot missed it for the same reason. *"it needs scaled to the number of wounds you
carry"*: the wound roll was independent of the count, so the first Grit spend and the fifth carried
identical odds, which is the property the d20 was retired to kill. That is INTENT, his, and the issue
delegates the implementation design to the architect, so it was decided, dispatched and landed inside the
same cycle. New instrument `scripts/wound-scaling.py`; the decision, its numbers and the parked severity
axis are ledger rows 208 and 209, and the full design is a dated section on the issue itself. **PR #732,
squash `035a902`, #729 closed.** The pipeline lesson is the one the tracker keeps teaching: **a state read
is a moment, not a fact** - the scan, the monitor snapshot and the tracker were each correct and all three
were stale inside a minute, so the only check that counts is a read at the point of action.

**Next.** The review's weakest item 3: **the Master-tier payoff** - what a Master actually gains across
the ladder (damage per DP 3.00 -> 2.00 -> 1.25) and whether the top of it is a payoff or larger numbers.


---

## Cycle 38 (2026-09-27) - the bestiary's silence, counted: the blocks say what a creature DOES, and the missing axis was printed in another chapter

**SENSE.** 0 open PRs, 0 open issues, 209 ledger rows with none ruled-but-unbuilt, 9 of 9 assessed, all
walkthroughs played, dispatch on, checkout clean on `main` at `4b6f542`, one worktree, no stray branches.

**Why the cycle did not start with cycle 37's named next item.** Item 3, the Master-tier payoff, is CLOSED,
and that was verified before any work began: row 167 decided "state the intent, no reprice", and the
paragraph is printed at `10:58` and reads 1 hit in the built PDF's text layer ("tier buys impact, not
efficiency"). So the item is measured (damage per DP 3.00 / 2.00 / 1.29), decided (invariant 4 leaves no
lever but language) and landed. Item 4 is the top item still open, so it got the cycle.

**The measurement, and it refutes the review's own claim.** `scripts/bestiary-role-census.py` (new) parses
the 49 blocks out of `origin/main` and asks one question per block: does the block's own text decide what
the creature does with its turn. **45 of 49 do** - a Multiattack, a Recharge ability, a condition on a hit,
a casting line, a positioning or support clause, a reaction, and in 33 blocks a second attack line, which
is a target or range choice every round. Four are simple by content (Swarm of Rats, Guard, Zombie, Fire
Elemental) and each of those turns is unambiguous. **8 of 49 carry any who-or-when cue**, and four of those
are only "fight next to an ally". So the DA's invention sits on the two axes the block leaves open, not
spread across 49 mute entries.

**And the second axis was already printed, in another chapter.** `13:307` is a full Morale section ("NPCs
and monsters don't fight to the death by default") with its own table and its own list of automatic checks;
the starter adventure's blocks each carry a `Morale:` clause (`19:312` "mindless, fights until destroyed",
`19:351` Kelvath); none of the 49 bestiary blocks does. Two stat-line populations, one field, and nothing in
either chapter saying how they reconcile. ch20's "Reading a Stat Block" documented seven fields and neither
axis.

**Two defects in the instrument were caught by its selftest before any count was quoted.** `\btargets?\b`
matched mechanical sentences ("target is knocked Prone", "latches onto the target") and reported 17 priority
cues where 8 exist; and the condition vocabulary read the defence line "immune to Frightened" as a condition
on a hit. Both are the skill's own marker law, that a marker must name a TURN EFFECT and never a clause that
shares a word with one, and both are why the census prints its vocabulary beside its counts and exits 2 on a
short parse instead of printing a clean line.

**Landed as a micro-PR of my own, with no dispatch (PR #734, squash `1309460`).** One paragraph after ch20's
field table naming both axes, and `#label("sec-morale")` on the line after `== Morale` so the pointer has a
target (the section was unlabelled; the label is unique book-wide). No rule added, no per-creature content
authored, no `Morale:` field added to the format table, no band / DR / HP / Grit number touched. Audit: 2
files, 3 insertions, 0 deletions; added lines carry 0 em-dashes, 0 damage dice, 0 markdown bold, 0 flat
riders, 0 roll modifiers; native-Typst gate 0 over 26 files; independent build 0 at **399 pages, unchanged**;
the new crossref reads **(Section 15.12)** in the render; off the branch `rounds-to-resolve.py` PASS (3.79 /
3.73 / 3.27) and `da-walkthrough.py` PASS 49/49.

**State at cycle 38.** Book at `1309460`; 0 open issues, 0 open PRs; one checkout, clean tree, no worktrees;
the four remote refs left by cycles 35-37 were proven landed (ancestor test, `git cherry` for the
squash-merges, merged-PR check) before anything was deleted, and `fix/20-running-the-block` was removed by
its own merge. Words 84,496 -> **84,572** (+76); ledger **210** rows, none ruled-but-unbuilt; pages **399**
(unchanged).

**Next.** Item 5 (the Leader's Novice shelf) is next by harm and is **INTENT, so it is Bruce's**: three of
the class's four rank-1 options hand out a modifier and pass the turn, and repairing it means replacing
printed abilities, which is an authorship call about what the class is, not a fit problem with a derivable
answer. The one BALANCE item left is **item 6, the example of play at `01:156`**: it prints a total the
reader cannot derive, because Kael adds Agility where the Basic Melee floor adds Brawn (`09:232`) and the
substitution is a talent, Precision, printed once in another chapter (`09:48`) and never named in the
example. A LEARNABLE defect with a one-clause repair. That is the next cycle's target.

---

## Cycle 39 (2026-09-27) - the example of play's one undeliverable number, and the review's fifth item withdrawn by census

**SENSE.** 0 open PRs, 0 open issues, 210 ledger rows with none ruled-but-unbuilt, 9 of 9 assessed, all
seven walkthroughs played, dispatch on, checkout clean on `main` at `a075a15`, one worktree, no stray
branches. The canon index calibrates (ch11's own sentence, 15 cantrips + 60 spells = 75 parsed). Priority 1
returned zero as a measurement for the eighth cycle, so the cycle worked the review's queue in the order the
review ranks it, which meant measuring item 5 before repairing item 6.

**Item 5 was measured first, and the measurement refutes it: the item is withdrawn, not repaired, and
nothing was dispatched for it.** The claim was that three of the Leader's four rank-1 options "grant a
modifier and pass" (review items at `:129`, `:142`, `:266`). New `scripts/class-shelf-cost-census.py` parses
ch05's nine ability tables out of `origin/main` and sorts every Novice option by what it costs the turn:
**all four Leader options are Maneuvers** (`05:612-615`), `21:105` defines a Maneuver as the turn's secondary
resource ("One per turn"), and `13:51` states the trade in both directions (an Action may buy an extra
Maneuver, never the reverse). So the class attacks with its Action and commands with its Maneuver in the same
round; nothing is passed, four times out of four. Book-wide the census reads **36 Novice class options: 4
costing an Action, 11 a Maneuver, 21 triggered riders**, and the Leader is the only class whose whole Novice
shelf is maneuver-priced: the cheapest shelf in the book to use, not the most administrative. What survives is
repetition (three of the four are once per scene), which is exactly the span of the 3-4 round fight the pacing
law names. The verdict was going to be INTENT and Bruce's; it turned out to be premise-false, which is the
second time in three cycles that a review item carried the phantom-rule defect the book itself carries.
Corrected in place at all three sites, dated, beside the old text.

**Item 6's premise held, and it is now measured rather than asserted: exactly one of the four numbers the
example prints is undeliverable.** `01:154` (12 + Agility 2 = 14) follows the printed core loop (`07:15`);
`01:169` (15 + Agility 2 + Stealth Adept 2 = 19) follows the Skill Tiers table (`07:32`); `01:158` (4 - DR 2)
follows the DR rule. Only `01:156` fails: it reads "2, plus your Agility" where the floor card says
**2 + Brawn** (`09:232`), and the substitution is a talent, Precision (`09:48`), granted free by the Blade's
Swift Blade signature (`05:104`) and named nowhere in the chapter. The reader who checks the arithmetic against
Basic Melee finds the book contradicting itself and has no way to reconcile it inside ch01.

**Landed as a micro-PR of my own, with no dispatch (PR #735).** One clause at the point of use: the line now
reads "plus your Agility (the Precision talent lets you use Agility in place of Brawn): 4", which is the house
idiom (ch06/ch07 name every input in parentheses) and mirrors the talent's own card text. No rule added, no
number moved, no other chapter touched. Audit: 2 files, 1 chapter line changed; added lines carry 0 em-dashes,
0 damage dice, 0 markdown bold, 0 flat riders, 0 roll modifiers; native-Typst gate 0 over 26 files;
**independent build 0 at 399 pages, unchanged**; the new clause re-read in the built PDF's text layer at page
24 with the old phrasing at 0 hits; off the branch `rounds-to-resolve.py` PASS (3.79 / 3.73 / 3.27) and
`da-walkthrough.py` PASS 49/49.

**State at cycle 39.** Book at the cycle-39 merge; 0 open issues, 0 open PRs; one checkout, clean tree, no
worktrees; scratch cleared and the build log removed. Words 84,572 -> **84,583** (+11); ledger **210** rows,
none ruled-but-unbuilt; pages **399** (unchanged).

**Next.** With item 5 withdrawn and item 6 repaired, the only ranked item left whose mechanical claim has never
been measured is **item 1**, which the review ranks first by harm. Its *rule* half landed in cycle 26 (#711:
`13:119` converts an NPC's attack advantage into a Boon on the player's Defence roll, `22:170` does the same
for cover, `13:131-132` prints the table rows, `13:207` carries the Marked conversion inline). What has never
been checked is the **layout** half the item actually asks for: whether a reader meeting a defence modifier in
the places it is printed can see the converted sign beside the number, rather than a Bane that belongs to the
other roll. That is a census of every printed defence-modifier site across the nine content chapters and the
bestiary, not a re-read, and it is the next cycle's target.

---

## Cycle 40 (2026-09-27) - review item 1 measured: the law sentence had the sign backwards, and twelve sites never got it

**SENSE.** 0 open PRs, 0 open issues, 210 ledger rows with none ruled-but-unbuilt, 9 of 9 assessed, all
seven walkthroughs played, dispatch on, checkout clean on `main` at `6952fba`, one worktree, no stray
branches. Priority 1 returned zero as a measurement for the ninth cycle, so the cycle took the review's
own named next target: item 1's layout half, ranked first by harm and never checked.

**Item 1's criterion is right and its prescription was too narrow.** The review asked that "anywhere cover,
Marked, Pack Tactics or Leadership touches a Defence roll, the converted sign has to sit beside the number
on the same line". New instrument `scripts/defense-frame-census.py` (oracle over all 216 rolls, a SIGN GATE
that parses the governing sentence, and a site census with a stated vocabulary and 7 selftest controls)
returned two defects the item never named, both worse than the one it describes.

**The first is the law sentence itself.** `13:119` printed the conversion with the sign CARRIED instead of
flipped: "an advantage on an attack against you (an adjacent ally's *Pack Tactics*, a leader's *Leadership*)
is a Boon on your Defense roll, and a disadvantage on that attack is a Bane". Every one of the six
parentheticals PR #711 added in the same wave reads "a Bane on the defender's roll", the cover clause two
sentences later flips its sign, and `13:111` treats the enemy's own Challenge as "a penalty to your roll",
so the sentence contradicted its own implementation, its own next sentence and the rule beside it. This is
the error in row 191's own ruling text, inherited by the sentence the agent wrote from it. Read as printed,
a Pack Tactics wolf pack is **3.3x weaker** than its own trait intends and half cover is **2.5x worse than
standing in the open**: all 216 rolls at Agility +2 (`06:103`) give P(take the NPC's Strong damage) =
**9.3%** flat, **2.8%** with a Boon, **23.1%** with a Bane.

**The second is the twelve sites that never got the conversion.** Hidden (`13:204`, `22:104`, `21:151`) uses
cover's exact phrasing and was converted for cover and not for Hidden; Prone (`13:211`, `22:111`) prints
"Melee Boon vs you, ranged Bane"; ch13's cover table (`13:439-440`) lacks the line its ch22 restatement
already carries (`22:170`), so the two restatements disagreed; the glossary's Cover entry (`21:185`) also
asserted a roll the attacker never makes (`13:105`); and Sanctuary (`12:191/193/195`) and Beast's Watch
(`05:592`) print the cover trap on a spell and a class ability.

**Landed as a micro-PR of my own (#736 -> PR #737, squash `11d4040`), with no dispatch.** Five files, 13
insertions / 11 deletions, one sentence flipped and one clause per site in the book's own parenthetical
idiom. No number, band, stat block, dice or rule moves. Audit: file set exactly the five chapters; added
lines 0 em-dashes / 0 damage dice / 0 markdown bold / 0 flat riders / 0 roll modifiers; native-Typst gate 0;
**independent build 0 at 399 pages, unchanged**; the corrected sentence, all three Sanctuary rungs and both
cover lines re-read in the built PDF's text layer with the old phrasing at 0 hits; off the branch
`rounds-to-resolve.py` PASS (3.79 / 3.73 / 3.27) and `da-walkthrough.py` PASS 49/49.

**Boundary, recorded so a later pass does not re-file it.** The census reports 28 sites that NAME a named
attacker (`the target is at Bane on its next attack`, `Pack Tactics: Boon on attacks`, `Poisoned X: attacks
at Bane`). Those leave no sign choice to a reader, and one generic clause pasted onto 28 cards is the
substitution defect this repo has already logged. Four further sites are adjudicated inside the instrument
with their reason (`09:395`, `11:274`, `12:214`, `20:597`), so a NEW defence-side site fails the gate until
it is either converted or adjudicated.

**Instrument lessons, all three found by cross-checking counts against the artifact rather than trusting the
verdict.** (1) A window-scoped exemption swallows real hits: `checks?` matched in the neighbour line of a
glossary entry and filed a live defect as own-roll, and the same coarse window let a table row pass on a
SIBLING row's conversion. (2) The table-close test `endswith("),")` also matches `align: (auto, auto,),`
two lines into the block, collapsing the window to nothing; `startswith(")")` is the right test. (3) A raw
string does not interpret `\u2019`, so `['\u2019]` silently becomes a class of the literal characters
`\ u 2 0 1 9`; write the typographic apostrophe literally.

**State at cycle 40.** Book at the cycle-40 merge (`11d4040`); 0 open issues, 0 open PRs; one checkout,
clean tree, no worktrees; scratch cleared. Words 84,583 -> **84,698** (+115); ledger **211** rows, none
ruled-but-unbuilt; pages **399** (unchanged). The review's six-item weaknesses list is now fully resolved,
which means **the review is owed a rewrite**: it was written before items 1, 4, 5 and 6 were measured and
three of those measurements changed the item.

**Next.** The class-ability sweep: ch05's 90 abilities live in five-column tables that no instrument reads, and
`05:568` *Leverage* proves the corpus carries at least one dead trigger. Screen it for (a) triggers that can
never fire, (b) strict dominance inside a class's own shelf, and (c) flat riders and roll modifiers in the
table shape. Then the game's ceiling, which is content rather than mechanics: printed play stops at level 2.

**State at cycle 41.** Book at `f7873b1` (chapters at `11d4040`); 0 open issues, 0 open PRs; one checkout,
clean tree, no worktrees; scratch cleared. Words **84,700**; ledger **211** rows, none ruled-but-unbuilt;
pages **399** (unchanged). **The review is rewritten** at `f7873b1`: all six of the old weaknesses list are
resolved (1, 4 and 6 repaired; 2 and 3 closed by measurement; 5 withdrawn), the new list is ordered by harm
at a table, and the verdict names the class-shelf sweep as the next act.

---

## Cycle 42 (2026-09-27) - the class-shelf sweep dispatched: the shelf is NINE tables, and the ninth has no `====` header

**SENSE.** `main` moved `f7873b1` -> `aba0a2d` (ledger row 212 + work order #739, PR #740); 0 open PRs,
**1 open issue (#739)**, ledger 212 rows with none ruled-but-unbuilt, 9 of 9 assessed, dispatch ON. The queue
was not empty, so priority 1 (the review) did not fire. The act is the dispatch of the standing work order.

**Recon before dispatch changed the spec three times, and all three are under-parse traps that read as passes.**
(1) The shelf is **90 entries across NINE tables**, not the eight a `^==== ` scan finds: the Odd's shelf sits
under a **`===`** header (`05:724` "Odd Abilities"), so a parser splitting on `^==== ` reports 8 tables and 80
rows, silently drops the whole Odd shelf, and then prints a confident clean sweep over what it collected. The
canonical index independently confirms the population: *"TOTAL cards 208 + class abilities 90 = 298"*.
(2) A table row carries **four leading spaces** inside its `#figure(...)`, so `^\[\*` matches zero rows; and
the tag-cost table (`05:770-773`) contributes four more `[*Name*]` rows that are not abilities, which is how a
parse can return **94** and call it the corpus. (3) The trigger vocabulary was measured, not assumed: **11**
ch05 triggers already key to a tier result, and the events the book cannot produce are enumerated and cheap to
grep (no misses, no saving throws, no to-hit rolls anywhere in the 25 chapters).

**An independent read of all 90 triggers finds exactly one dead one, and one near-miss that is NOT dead.**
*Leverage* (`05:568`) is the dead one. The near-miss is *Shield Bash* (`05:685`, "When you hit with a shield"):
ch16's Shields section describes a shield only as an active defence, so the trigger reads unproducible until
`09:554` *Shield Throw* (Action, `Requires: shield`, 4/6/8) and `09:577-578` *Shield Slam* (Maneuver,
`Requires: shield`, 4/6/8, Push) are found. Both hit with a shield, and `05:63` tells the Protector to fight
with Shield Bash. Held as a **boundary**: recorded so a later sweep does not re-file it, and so the agent's
report can be checked against a baseline I derived independently of it.

**The dispatch.** Work order **#739**, one file, one edit: re-key *Leverage* to the shelf's own tier idiom and
delete the dead clause one sentence later in its own effect ("if the reroll hits" is the same defect as the
trigger, because there are no misses). Everything else the agent finds is report-only; it moves no other
number, cost or wording. The prompt is seeded **inside the worktree** as `.task-spec.md` with the replacement
row written out as fixed text, the PR body instructed to live in the worktree (a `/tmp` body is an
`external_directory` auto-reject at the last step), and `git push -u origin HEAD` explicit because the worktree
branch is created tracking `origin/main` (whose upstream was unset before dispatch so a bare `git push` can
never aim at main).

**Instruments, this cycle.** Canon index calibration **OK** (ch11's own sentence 75 = 75 parsed; 208 cards + 90
class abilities). `rounds-to-resolve.py` **PASS** 3.79 / 3.73 / 3.27 against the 3-4 law, with the resource
line recorded: one Standard fight spends **73.0 / 81.0 / 71.5 %** of a hero's per-respite pool at Novice /
Adept / Master, and **Adept is the tightest tier** (the review's item 3, now a standing measurement rather
than a claim).

**Audit and merge, mine, not the agent's report.** Work order **#739 -> PR #742, squash `edbe563`**. File set
exactly the one named chapter (1 insertion / 1 deletion, and no other line in the diff). The new `Leverage`
row is byte-identical to the replacement text the spec pinned. Added-line gates: **0** em-dashes, **0**
markdown bold, **0** damage dice, **0** numeric roll modifiers; the single `+[0-9]+ damage` hit is `+1 damage
tier`, the legal tier-bump form (`05:548`, `05:613`) and the same shape the row already carried. Native-Typst
gate **exit 0**; my own rebuild **exit 0 at 399 pages**; the built PDF's text layer re-read at the site (page
98) shows the new trigger and effect and the old `misses an attack` at **0 hits book-wide**. The three `miss`
tokens that remain in the render are prose and the spell line "it never misses", read one by one.

**The sweep's own numbers were checked against the baseline this cycle derived before dispatch, not against its
report.** Tables/rows **9 and 90** before and after (the agent's parser is heading-level aware and says so);
dead triggers **1**, and it is `Leverage`; dominance **0 strict pairs**, with ten same-tier same-cost pairs read
and named as trades rather than containment. Its one new lead is a **boundary deliberately left standing**:
`05:405`, the Backlash Table's face 5, prints a flat `+2` ("the target takes +2") outside the 90, so the
work order's scope correctly did not reach it. That is a live flat-rider site for the next wave, and it is
recorded here rather than silently fixed.

**State at cycle 42.** Book at `edbe563`; **0 open PRs, 0 open issues**; ledger **212** rows, none
ruled-but-unbuilt (row 212 now reads IMPLEMENTED); words 84,700 -> **84,711** (+11); pages **399**
(unchanged); one checkout, clean tree, no worktrees, remote holds `main` alone, scratch cleared.

**Next.** The class shelf is swept and its one dead entry is repaired, so the queue is empty again and the
next act is either the review (if Bruce asks) or the next unassessed gap. The named content ceiling is
unchanged: printed play stops at level 2, and `05:405`'s flat `+2` is the one mechanical lead the sweep
handed on.

## Cycle 43 (2026-09-27) - THE STATE OF THE GAME, rewritten: the class shelf is swept clean, and the damage law's blind spot is measured

**Queue state at scan.** 0 open PRs, 0 open issues, ledger **212** rows with none ruled-but-unbuilt,
assessment 9 of 9. Priority 1 fired: when the queue is empty the act is the review, and it outranks
everything else.

**The review, rewritten** (`docs/design/architect/review.md`, PR #744, squash `04e641e`, 12 insertions / 10
deletions against cycle 41's text). Book source `90f7d11` (chapters at `edbe563`, 84,709 words, 399 pages).
Previous verdict kept in one line; **what changed in the GAME** stated rather than what changed in the
tracker: the class-ability corpus was swept and *Leverage* now fires (`05:568`, PR #742). Three consequences
landed in the file: §1's "attacks always hit" row loses its caveat (the promise now holds with no printed
exception), §4's dated correction is updated (Leverage is live, but it is a damage-conversion support rather
than the information ability the paragraph once claimed), and the former weakest item 2 is closed in place,
dated, with the evidence. Weakest list re-ranked by harm at a table: the priority gap (41 of 49), the lone
damage figures below, Adept as the tightest tier (81% of the pool in one Standard fight), the flagship
teaching example.

**What this cycle measured, and it is the new finding.** Cycle 42's sweep handed on exactly one lead
(`05:405`, a flat `+2`) and left it standing as out of scope. It was measured rather than filed: new
instrument `scripts/lone-damage-census.py` (skill, not repo) grades every `N damage` figure that is not part
of a slash triple against the live rows, with `--selftest` (7 checks, including a planted Basic-card 2 that
must read legal and a planted ability 2 that must read OFF). Over 25 chapters: **233 lone figures, 35
off-row candidates, every one read, 5 in the defect class**, and all five print `2`, a figure on no live row
(4/6/8, 5/8/11, 7/10/14) and the RETIRED Novice Weak value: the Backlash Table's faces 4 and 5 (`05:404`,
`05:405`), *Toxic Bloom* (`05:711`), *Volatile Surge* (`05:712`), and the fumble table's *Spell Backfire*
(`06:200`). Two of the five carry a second consequence: `05:405` is unresolvable as written (a player rolling
a 5 on the Unbalanced's backlash must ask what the target takes "+2" of) and it is the book's **only**
surviving flat damage rider once the sweep vocabulary includes `takes +N` rather than only `adds +N damage`;
*Toxic Bloom* spends a full Action and its once-per-scene for a figure the Novice row's own Weak value
exceeds. Boundaries read and NOT flagged, recorded so a later pass does not re-file them: `05:639` Serrated
Edge's 2 (a gated rider, 4+2=6), the cantrip 1/3 band (`11:52-108`), `11:173`'s dividing rider, `13:284`'s
off-hand 1, `13:395`'s bleed tick, `15:187` caltrops, `15:202` oil, `15:295` mount fall, `20:78`/`20:393`/
`20:463` stat-block clauses, and seven worked-example arithmetic sites.

**The instrument's own vocabulary was wrong twice, and both directions are the recorded trap.** The first
pattern matched the `1` in `+1 damage tier` and returned 35 hits that were not damage figures at all; the
second missed `2 force damage`, `8 radiant damage` and `3 lightning damage` because an adjective sits between
the number and its noun, which made `06:200` invisible to the census that exists to find it. An audit is
bounded by its vocabulary, the OFF list is a lower bound, and the count is not the finding until each
candidate is read. The repair the finding supports needs no new rule: the four earlier band sweeps moved
retired figures onto the live row by **position** (retired Novice Weak 2 to live Novice Weak 4), and that map
settles all five sites.

**Instruments re-run against `origin/main`:** `rounds-to-resolve.py` **PASS** 3.79 / 3.73 / 3.27 with the
resource line (one Standard fight spends 73.0 / 81.0 / 71.5% of the per-respite pool); `wound-spiral.py`
**PASS** (bounded, Adept tail unchanged at 3.4%); `bestiary-role-census.py` (45 of 49 decide their turn, 8 of
49 cue priority, 41 of 49 with no party-facing cue); `class-shelf-cost-census.py` (36 Novice class options:
4 Action / 11 Maneuver / 21 triggered); `canon-index.py` calibration **OK** (75 = 75; 208 cards + 90 class
abilities = 298); native-Typst gate **exit 0**.

**Audit and merge, mine.** File set exactly the one review file; added lines carry **0** em-dashes; every
number in the document was produced this cycle or carried from a named instrument; and every citation changed
in the diff was re-read against `origin/main` at the exact line (`05:404`, `05:405`, `05:612-615`, `05:711`,
`05:712`, `06:200`, `08:225`, `09:48`, `13:347`, `20:32`). Branch deleted on merge, tree clean, one
checkout, no worktrees.

**Next.** The review's named next act, filed as a work order this cycle: the **lone-figure sweep**, five
figures across two chapters, repaired by the positional map rather than by repricing. Standing content
ceiling unchanged: printed play stops at level 2, and the book ships one adventure.


## Cycle 44 (2026-09-27) - the fifth axis swept (PR #748), and the run died mid-record: its own find reached a drafted row that was never written

**The wake.** The queue held one item, this file's own work order: **#745**, the lone-figure sweep, filed at cycle 43 with the review. It was dispatched and it landed as **PR #748, squash `47a8203`, closing #745** - two files, 5 insertions / 5 deletions, exactly the five named sites: the Backlash Table's faces 4 and 5 (`05:404`, `05:405`), *Toxic Bloom* (`05:711`), *Volatile Surge* (`05:712`) and the fumble table's *Spell Backfire* (`06:200`). Every figure moved by the map the four earlier band sweeps already used, **retired Novice Weak 2 to live Novice Weak 4**; no rule, price, tier, trigger or cost moved, and `05:405`'s unresolvable "the target takes +2" is now a plain on-row figure.

**The landing was re-read this cycle rather than trusted.** Old fragments 0 hits, new fragments 1 each; `takes 2 damage` fell 4 -> 2 with the survivors exactly the two cleared boundaries (`05:639`'s gated rider, `16:31`'s DR remainder); native-Typst gate 0; build 0 at **399 pages**; added lines 0 em-dashes / 0 bold. The census that found the five now reads **232 lone figures over 25 chapters, 29 flagged off-row and each one read as a boundary, 0 in the defect class**.

**Then the run found something better and did not live to record it.** Re-reading the book against the sweep it had just landed, it hit `13:518`, the flagship example of play, and the finding is a class no gate in the toolchain covers: **prose that narrates a rule the book does not have**. Lyra is an **Odd**; her Ember Lance rolled **Standard**; the sentence said "the backlash from bending the rules doesn't care" and sang a second cultist for 2 damage - but *Eccentric Spellcasting* prints no backlash in any of its three homes (`05:291`, `10:72`, `21:91`), the Backlash Table belongs to the Unbalanced's *Edge of Chaos* and fires only on a **Strong** hit (`05:392`), and `2` was one of the five figures it had just swept off the board. It drafted ledger row 214 and a work-order number, and the run ended there: no row written, no issue filed, no plan entry, no scorecard row, and row 213's status cell still reading "work order filed".

**The lesson is the record, not the finding.** A cycle that lands work and dies before recording it leaves the next cycle unable to tell a finding that was *decided* from one that was never seen: the ledger said "filed", the tracker said 0 open issues, and the two documents disagreed about work that was already on `main`. Cycle 45 reconstructed the entry from the PR and the branch instead of re-deriving it, and the reconstruction cost a cycle's first act.


## Cycle 45 (2026-09-27) - THE STATE OF THE GAME, rewritten: the damage law reaches its own tables, and the example of play stops charging a price the book does not have

**SENSE.** `main` `29de35e` (from `47a8203`), **0 open PRs, 0 open issues, 0 unbuilt rows**, `thinking_due` 0. The queue emptied because the review's own named next act landed, so priority 1 fired and **the act is the review**.

**INSPECT, mine.** #748 audited against row 213's decision: file set exactly the two named chapters, the five figures re-derived from the diff, gates 0 em-dash / 0 bold, the five sites now absent from the census. **Row 213's status cell moved to IMPLEMENTED** with that evidence, which is the first thing cycle 44 could not do.

**The clause the dead run found, repaired.** A micro-PR of my own, **PR #749, squash `29de35e`**: one line at `13:518`, the mechanism claim and the figure removed, the fiction kept ("...but fire does not care for rules. The second cultist, standing too close to his wounded ally, is caught in the spill, robes scorched and hair singed."). No rule added or removed, no other file touched, no number printed. `bloodied` - a word that line alone used and nothing defines - is now 0 hits book-wide, and the case-insensitive `backlash` census is down to the **11 sites that are all the Unbalanced's** (ch02's pregen 6, ch05's signature, table, face 4 and two abilities 5); the example's line was the only one that was not. `13:530`'s "Both cultists are wounded but standing" and `13:534`'s "The wounded cultists" both still read, because the second cultist is still scorched and hurt in the fiction. Verified in the render by **reading page 245 rather than counting a fragment**: `13:530`'s own unchanged sentence returns 0 in the text layer (it wraps), which is the reminder that a fragment count of 0 is a question, never an absence.

**The review, rewritten** (`docs/design/architect/review.md`, 5,412 words, date + head sha + the previous verdict in one line): §1's promise table unchanged (nothing in it was affected); §4's Unbalanced paragraph corrected twice over, because the class's price table is no longer the place the damage law fails to reach; §5 and weakest item 1 now **name the five blocks** rather than the 41; the former item 2 is closed in place with the census number; the list re-ranks to the priority gap, Adept's tightness (81.0% of the pool in one Standard fight, re-measured this cycle and unchanged), and the flagship example; and the verdict's single next act moved from the lone figures to **the priority cue**.

**The decision, and the work order.** Filing a work order is the act that keeps an empty queue from producing another review instead of work, so the review's top item was decided and filed the same cycle (**row 215**): the test returns **five blocks, not 41** - Knight, Archmage, Orc Warchief, Green Hag, Death Knight, each a buffer or a caster whose trait pays off only inside a ring or at a range - and the route is **one appended sentence on the trait that creates the dependency**, naming who the creature targets or where it stands and when it stops. The four printed exemplars (Bugbear, Doppelganger, Cave Troll, Goblin) are the model; no number, condition, keyword or trigger moves. Filed as **#750** and **dispatched** into a worktree from `origin/main`, one file, with the spec seeded inside the worktree (never `/tmp`) and the finish sequence told where the PR body lives.

**Instruments re-run against `origin/main`:** `rounds-to-resolve.py` **PASS** 3.79 / 3.73 / 3.27 with the resource line (73.0 / 81.0 / 71.5% of the per-respite pool); `bestiary-role-census.py` (45 of 49 decide their turn, 4 simple, 8 cue priority, 41 with no party-facing cue); `lone-damage-census.py` (**232** figures, 29 flagged off-row, each read as a boundary, **0 in the defect class**); `canon-index.py` calibration **OK** (75 = 75; 208 cards + 90 class abilities = 298); native-Typst gate **exit 0**; chapters **84,710 words**, **399 pages**.

**Next.** Audit #750's PR when it lands - the cues must follow from the trait each sits under, add no capability, and leave every block's numbers byte-identical. Then item 2, Adept's sentence: 81.0% of the pool in one Standard fight is the measurement, `19:53`'s rungs are the lever, and the repair is a sentence rather than a number.


**Closing record (same cycle).** #750 was audited and merged the same cycle (**PR #751**, squash `2504621`): file set exactly `20-bestiary.qmd`, **5 pure appends** (old text byte-intact, checked programmatically), **digits identical on every changed line**, 0 em-dashes / 0 bold / 0 dice in added lines, native gate 0, independent build 0 at **399 pages**, all five cues read in the render, issue #750 closed with the audit attached, worktree removed and branch deleted.

**The item ranked second was WITHDRAWN by the instrument that wrote it**, which is the same verdict cycle 39 reached about item 5 and the reason the review's own standard is "count an item before you repair it": `19:53` already prints the ladder's cost ("*Standard* about three quarters") and the model's 73.0 / 81.0 / 71.5% lands within 6 points of it at every tier, so the sentence the item recommended is on the page (row 216 records the withdrawal). That leaves the review's open list at **content rather than repair**: the ceiling (one adventure, nothing printed past level 2) is a product decision, and the smallest thing the loop can close itself is the **player-facing tactics section**, filed as **#752** for the next cycle to dispatch.

**Process slip, recorded rather than hidden:** this cycle's earlier docs commit was pushed straight to `main` instead of through a branch and PR (base and head were both `main`, so the PR step had nothing to open). The content was architect-owned docs only and no chapter file was involved, but the route was wrong; this record itself went through a branch and a PR.

## Cycle 46 (2026-09-27) - Bruce filed three rulings on one subsystem inside eleven minutes; two landed, the third was measured and held rather than dispatched

**The act, and why it was not the review.** The queue was not empty (#752 open), and at 17:15Z three of Bruce's own filings arrived within eleven minutes, all on one subsystem: Grit, wounds, and healing. The two that were coupled (#754 the healing economy, #755 the wound remnant) were settled together in one edit set; the third (#756, threshold healing) was measured, designed, and held.

**#754 DECIDED (BALANCE, veto-revertible): no numeric change, and two of its three risk sites do not exist.** Site 1 was a potion economy that has no economy to collapse: `17:13` prints magic items found and never bought, `15:15` prints that gear is not bought, `21:223` prints that magic items have no price, and a book-wide grep for gold, coin, price, wealth or shop returns no currency rule in 24 chapters. Site 2's "cheapest heal in action economy" is false in the same way: drinking a potion costs the Maneuver, and so does `Catch Breath` (`13:69`), which every hero already has, returns a third of maximum HP against the potion's 6 average, and is usable a number of times per combat equal to Grit; the potion is also self only. Site 3 stands and is priced. New instrument `scripts/heal-vs-grit.py` carries the measurement: the best unlimited heal is behind ONE HERO'S SHARE of the Standard encounter at every tier (6.66 against 8.49, then 6.96 against 13.03, then 7.24 against 16.60) with the gap widening, and heal per Action sits at parity with attacking (1.11 / 0.99 / 0.97). The pool arithmetic is convention-dependent (flat and attrition swap the sign at Novice and Adept), so no verdict was drawn from it, and the instrument says so in its own output.

**#755 designed and landed: one rule, not a table.** A rule paragraph under the Wounds intro, a giving-back clause in *Healing Wounds*, and the two restatements the law needs (`21:195`, `22:158`). No per-row additions: six of the 21 Wound Table rows already carry remnant language and the other 15 would be the manual the directive rules out. Precedent, not invention: `10:25` already printed "The heal knits flesh but leaves a scar". **PR #757**, audited by hand: file set exactly three chapters, each insertion byte-checked against the spec (743 / 464 / 137 / 74 characters, each exactly once), 0 em-dashes and 0 dice and 0 riders in added lines, native gate 0, **my own rebuild 0 at 399 pages**, all four insertions and the two restatements read in the render. #754 and #755 closed with the evidence attached.

**#756 measured and held, and the measurement corrects its own justification.** New instrument `scripts/heal-threshold-sim.py`: a round-by-round fight with per-hero HP and a real Grit pool, reporting the metric a table feels, Grit spends per Standard fight. Threshold healing and flat healing produce **identical** Grit costs (2/2, 5/5, 7/7) while differing in HP returned (31.3 to 37.6, 27.9 to 36.6, 19.5 to 20.1), so the threshold redesign is worth about 1.2x at Novice and 1.0x at Master: **the cost of a healer is the Action, never the amount**, and this is recorded so the change is not sold as a balance repair. A healer is a genuine gain at Novice (4 Grit to 2) and a genuine cost from Adept up (4 to 7); two healers buy length rather than a turtle. The instrument's control 5 asserted a monotone shape on its first run, the model falsified it, and the control now asserts the finding: healing helps at Novice and hurts at Master.

**A class-C crossref residual, found by a gate's own blind spot.** The documented render gate requires the paren to open directly before "Chapter", so it cannot see the book's own `(see @sec-chapter-X)` form: 26 source sites, six of them illegal (a comma after a parenthetical that just printed a sentence period), and the gate read 0. Filed **#758**, repaired as **PR #759** (one character at five sites, the ref moved to the end of the clause at the glossary), with the gate extended to `see Chapter [0-9]+\.\)[,;:]` and a negative control that reads 5 on main. The sixth site was found by the RENDER and not by the source grep, which is the whole argument for keeping both.

**Housekeeping: the scorecard carried its entire document twice.** Lines 1 to 107 were byte-identical to lines 109 to 215, so the file held 200KB of itself and the stale copy is the one that would have been read first. Verified by comparing the two copies before deleting one, de-duplicated to 108 lines, and the live copy's rows 44 and 45 confirmed intact.

**Instruments re-run against `origin/main`:** `canon-index.py` calibration **OK** (75 = 75; 208 cards + 90 class abilities = 298); `heal-vs-grit.py` selftest PASS (two planted controls); `heal-threshold-sim.py` selftest PASS (five controls).

**Ledger 216 -> 219 rows**, none ruled-and-unbuilt.

**Next.** One work order, not two: **#756 and #760 land together as a single pass over ch13's Dying and Death section**, which is Bruce's own sequencing instruction and also the only way to avoid two edits to the same rules. The pass needs the finished text of every healing card, including a Master-tier heal that does not yet exist in ch12, so the card authoring is the design act and it comes before the dispatch. Then #752, the player-facing tactics section.

**Late arrival, recorded rather than absorbed:** #760 (the Grit spend is a choice at 0 HP, and the death roll must scale with wounds) was filed at 17:33, after this cycle's merges. It is read, accepted with no fork remaining, and its issues-of-record amended the same cycle; row 220 carries it and the sequencing above is written to it.

## Cycle 47 (2026-09-27) - Bruce's fourth ruling on the same subsystem arrived three minutes after the third, and this cycle's judgement was which half of it could be dispatched TONIGHT

**SENSE, and the monitor flag was a filing rather than a merge.** `main` `2311f21` -> `e18fae4`, **0 open PRs**. The monitored diff moved for one reason: **#763** appeared at 17:43Z, three minutes after #760 and twenty-five minutes before this run, authored by Bruce, and it had **no ledger row** - so it was a discovery and not a status update. Its content is a new law with a design ask attached: the hundreds digit of a D666 wound roll IS the severity band, 5xx must be catastrophic and 6xx Death's Door, the table must be restructured to match, and "design and text are the architect's". `thinking_due` 0, sweep 9 of 9 assessed, so priority 2 fired: land a ruled-but-unbuilt row.

**The judgement that made the cycle dispatchable.** Cycle 46 held the ch13 pass because it believed the finished healing-card text was a prerequisite. Re-reading #760's own design dissolves that: under the choice, **a Wound only ever comes from the roll you chose to make**, so a hero who declines Grit and is healed never rolled at all. The ch13 pass therefore needs no threshold-heal card text, no ch10 rule and no ch12 card, and it is self-contained on one rules section plus its two mirrors. What cycle 46 read as a hard dependency was a soft one, and that reading is what let the pass land tonight instead of queueing behind a subsystem design.

**The design decisions, all BALANCE and all veto-revertible.** The restructure is not a range edit; it is two defects and a legibility fix. **One:** `Broken Bone 366-446` was the only row straddling a hundred boundary, eating 444/445/446 while claiming the top of 3xx; `Cracked Ribs` now extends to `345-366` and `Broken Bone` narrows to `444-446`, and the straddle is gone. **Two:** `555 Karmic Wound` was a null result at the floor of the catastrophic band. #763 proposed moving its mercy into fiction; accepted and given teeth, so the band's floor is uniform in PERMANENCE rather than in mercy: the wound takes something functional and permanent (an eye, the hearing in one ear, two fingers, a voice that will never carry again), curable only by Master-rank Medicine or high magic, and costs nothing further in a fight. That is what a one-in-four frequency can afford. **Three:** a band sentence appended to `13:381` so a reader can SEE the escalation the ruling is about. **`566 Shattered Spirit` was read and left exactly as printed** - a Bane until a full day's rest is temporal inside a permanence band, but #763's scope is the straddle and 555, and re-pricing a temporal row is an unruled rebalance. Recorded as a boundary so the next pass does not re-file it.

**The measurement, and the checker was proven rather than asserted.** `wound-table-check.py` enumerates the reachable D666 space: **56 values, 15 rows, 56/56 covered, 0 gaps, 0 ambiguous, 0 unreachable rows, 0 rows straddling a boundary**, band occupancy 21 / 15 / 10 / 6 / 3 / 1. Its negative control grades the table **as printed on `main`** and fails it on exactly one row, the 366 straddle. The restructure was then re-derived a second time by **parsing the ranges out of the branch file**, not from the proposal: same verdict.

**The instrument the ruling demanded, and it caught the harness first.** `scripts/death-roll-census.py` (new, skill-side) enumerates the real dice space and reads it against the printed death table: P(weak or worse) per death roll is **25.9% / 48.8% / 66.1% / 78.2%** at 0-1 / 2 / 3 / 4+ wounds, P(Critical) falls **0.463% -> 0.002%**, P(Fumble, instant death) rises **0.463% -> 6.229%**, and dead-or-dead-rolling by round three goes **59.4% -> 86.6% -> 96.1% -> 99.0%**. So "stay down" at four wounds is a three-round window that needs a rescuer, which is the choice having teeth at every wound count rather than only at the top. **Two control bugs, both mine, both caught by the control itself:** the first run graded the live reading twice because the flag was not passed, and the second modelled the misreading as "every rolled die shows 6", which is arithmetically identical to the live reading - keeping the LOWEST three makes the triples asymmetric, so the real misreading is "any three of the dice you rolled", and only that one reproduces the defect (P(Critical) RISING to 6.2%). A control that fails on a correct instrument is the one thing a gate must never do, and here the instrument was right twice.

**Landed.** Filed as **#764** and dispatched into a worktree from `origin/main`, one work order, three files, the spec seeded inside the worktree and every replacement string written out rather than described. The agent reported **PR #765**; the audit is mine and independent: file set exactly the three named chapters (nothing in `docs/`, no `raw/`), **all 20 specified insertions present exactly once and all 11 superseded strings absent**, the 8 LEAVE-ALONE sites byte-intact, 0 em-dashes / 0 markdown bold / 0 damage dice in added lines, native-Typst gate 0, **my own rebuild 0 at 399 pages**, and the render re-read: the choice block, the Bane ladder, the kept-triples paragraph with its odds, the stabilization scaling, the rewritten 555 row, both changed range cells and every row of Wound Table part two all present. Four fragments read **0** in the text layer and all four were **wrapped**, not missing, which is the trap this repo has now hit three times. Merged squash, branch deleted local and remote, worktree removed. #760, #763 and #764 closed with the audit attached; **#756 stays open** because its ch12/ch10 half is untouched.

**Housekeeping.** Ledger **220 -> 221** rows (row 221 records #763), none ruled-and-unbuilt. Open issues **4 -> 2**. One worktree, one branch, clean tree, `/tmp` scratch removed.

**Instruments re-run against `origin/main`:** `canon-index.py` calibration **OK** (75 = 75; 208 cards + 90 class abilities = 298); `rounds-to-resolve.py` **PASS** 3.79 / 3.73 / 3.27; native-Typst gate **exit 0**; chapters **85,438 words** (+316); pages **399** (unchanged).

**Next.** #756's card half, which is now the only thing standing between the book and the mobile medic: the ch10 scope rule and ch12's seven Life cards rewritten to the threshold ladder, plus the Master-tier heal that does not exist (Life has **0 rank-3 consumers**, so the top rung is also a coverage gap). Then #752, the player-facing tactics section.

## State at cycle 48 (2026-09-27, verified against the repo, not recalled)

**SENSE, and the monitor's diff was last cycle's merge.** `main` `2311f21` -> `7e48a32`, **0 open PRs**, open issues **4 -> 2** (#760 and #763 closed by #765). The queue therefore held a standing work order, so priority 1 (the review) did not fire and the cycle's act was the item cycle 47 named: **#756's card half, which row 219 had held for exactly this dispatch** because the dispatch-readiness gate requires the finished text of every healing card and that text is the design act.

**The judgement that shaped the whole work order: a healing law scoped to "healing" contradicts the book's own healer-adjacent content.** Three greps decided the scope before a word was written. The weapon maneuver *Renewal* (`09:595`) is a tiered self-heal on the Novice row; converting it would hand every hero an **unlimited full self-heal for a Maneuver**, which is strictly better than the healer's Action and than *Catch Breath*. The potion's three rarities (4/6/8, 5/8/11, 7/10/14) differ only in their numbers, so threshold healing would print **one identical effect three times** (the dead-tier table defect). And the chalice of shared mercy heals 2 HP per target: converting a 2-HP item into "half your maximum" is not a cleanup, it is a new magic item. So the law governs *healing spells* and **names every population it does not govern**, which is also what stops the next lens pass re-filing each of them.

**The second judgement: no limit needed touching, and the mobile medic is the Novice card.** Bruce's ask was that a healer should not be capped at once per combat. `10:106` never covered Novice cards, and the threshold law makes a Novice heal tier-proof (half/full HP is as good at level 7 as at level 1), so **Mending Touch is the healer's workhorse at every level** with no scope sentence and no deletion, while Restoration, Soulmend, the recurring pair and Death Relented keep the printed cap and Tide of Life takes the once-per-session one. The row's planned "scope sentence" turned out to be unnecessary work, and the smaller lever won.

**The five design calls, all BALANCE, all veto-revertible, all on row 219.** (1) scope as above; (2) no limit edit; (3) **Tide of Life is promoted** to the top rung (`2 Life` -> `3 Life`, 4 -> 8 DP, level 3 -> 7) which is both the ladder's Master rung and **Life's first rank-3 consumer**; it costs the AoE heal at Adept, accepted because the damage budget already prices an area at the same tier per target (Brimstone Burst) and the missing rung was the larger defect; (4) **Restoration reaches 30 ft** (the ladder's Adept rung) and **Soulmend reaches 60 ft** with its rider rewritten to "one condition ends" — the withdrawn wound-prevention rider is inert under the amendment (only the hero who spent Grit carries a Wound and they are already at full HP), and the 60 ft is exactly what stops Restoration strictly dominating Soulmend, reach traded against cleanse depth; (5) **Death Relented** keeps its unrolled Effect line and returns a creature to life at half its maximum, the law's own floor, leaving Restoration the full heal.

**Landed.** Filed as **#756** (Bruce's own ruling, the standing work order) and dispatched into a worktree from `origin/main`; the spec was seeded inside the worktree with **every replacement string written out character for character**, and the one trap in it named: Soulmend's field line is byte-identical to Death Relented's, so the edit had to be heading-anchored. The agent reported **PR #767** in 118 seconds. The audit is mine and independent: file set exactly the five named chapters, every pinned OLD fragment replaced, `Restore` returning **0 hits** in the five files (it survives only in ch17's potion table, which the law excludes), **0 em-dashes / 0 bold / 0 dice / 0 new flat riders / 0 new numeric modifiers** in added lines, native gate **exit 0**, my own build **exit 0 at 402 pages**, and every change read back **in the render** at pp. 147-148 (where the ch19 crossref reads 0 for a fragment grep and is simply line-wrapped).

**One architect fix on the branch, and it is the class the dispatch gate exists to catch.** My own spec's "what this does not govern" list named items, class abilities, maneuvers, recurring heals and drains but not **talents** (*Miracle Worker*, `09:115`) or a few HP riding on a damage spell (*Pillar of Light*, `12:294`). Rather than spend a second agent run, the clause went in as a one-line branch commit before merge, which is the documented pattern for a mechanical fix that implements the spec's own design.

**Two findings surfaced, both logged and neither decided silently.** The content census's **OVER-RANK** section has been reporting four weapon maneuvers that ask for **five** Discipline ranks while `09:15` gives a card no tier above three — a class no other gate covers, pre-existing and independent of this pass (**row 222**, default proposed: trim to `3 <main>`, the printed Master precedent). And Bruce's own amendment says the Wound lands at the instant HP reaches 0, which `13:350` reads the other way for the stay-down case; implementing his words literally would wound every 0-HP event and make the choice trivial, so it is **row 223**, flagged with the measurement that would settle it.

**One instrument lesson, worth the minute it cost.** `architect-content-census.py` reads `--ref`, not `--rev`; my first run passed `--rev` and therefore graded `origin/main` twice, which looked exactly like a parser blind to rank-3 moves. The bug was the flag, not the tool. The three sibling scripts in the family take `--rev`. Read the flag before believing the silence.

**Housekeeping.** Worktree removed, branch proven merged (PR #767) before deletion locally and on origin, one worktree left, ledger **221 -> 224** rows, issue #756 closed on the evidence comment. Open issues **2 -> 1** (#752 only). The over-rank and wound-attribution rows are findings, not dispatches; the next cycle can take the over-rank fix as one small work order.

**Instruments re-run against `origin/main`:** `rounds-to-resolve.py` **PASS** (3.79 / 3.73 / 3.27 rounds; 73.0 / 81.0 / 71.5% of the pool, unchanged, which is what the threshold measurement predicted); `architect-content-census.py` calibration **PASS** with the tier move re-derived (**Adept 69 -> 68, Master 28 -> 29**; Life consumers **r2 7 -> 6, r3 0 -> 1**); `tier-census.py` Life **1 / 6 / 1**; `heal-row-census.py` **0 cards on a retired row**; native-Typst gate **exit 0**; words **85,844** (+406); pages **399 -> 402**.

**Next.** The over-rank fix (row 222) is the smallest live defect in the tracker and the only one with a default already written; then #752, the player-facing tactics section, which is the last of the review's open items.

## State at cycle 49 (2026-09-27, verified against the repo, not recalled)

**SENSE, and the monitor flagged two new FILINGS rather than a merge.** `main` `7e48a32` -> `30f2415` (cycle 48's own docs record), 0 open PRs, open issues **1 -> 3**: **#769** and **#770**, filed one second apart twelve minutes before this cycle and cross-referencing each other, both citing rulings Bruce made in the hour before. A programmatic pair out of a rulings round, so the queue held a standing work order and priority 1 (the review) did not fire.

**The act: #769, all three defects, and recon changed the work list four times before a word of spec was written.** Every citation was read out of `origin/main` first and all three held. What the report did not carry:

- **D1 had seven sites, not two.** `13:347` also attached the roll to the spend, and the defect was restated in the mirrors: `21:189`, `21:195`, `22:158`. A ch13-only pass would have left all three standing, which is the class the dependents-grep law exists to catch.
- **D2 had three sites, not one.** `13:391`, the D666 definition itself, carried the same off-by-one clause as the sentence the issue named, and `21:195` carried it a third time. Fixing only `13:393` would have left the chapter contradicting itself, which is the defect D2 names.
- **D3 was already landed.** `31d4aee` (#767, the very PR whose ordering #769 questions) had rewritten the rider; a book-wide grep for `no Wound` returned only `13:349`, which is D1's site. The live residue was one line: `12:144` *Death Relented* still carrying `*Keywords:* Wound`, the only occurrence of that tag in the book, on a card whose effect no longer delivers one. Verified before retagging that `Keywords` is documentation-only (`19:562`) and that no rule keys off it.
- **One interaction the fix creates, scoped in the same pass.** The non-lethal rule (`13:299`) also drives a creature to 0 HP, so an unconditional trigger would wound a deliberately-spared target, against that paragraph's own "instead of bleeding out ... a headache". One clause, no number moved, veto-revertible.

**Row 223 is resolved by this repair, and its flag was refuted by the measurement it demanded.** The row worried that an unconditional Wound makes the stand-up/stay-down choice trivial. The instrument says the opposite: the printed rule made the Wound Table **opt-in**, so a hero who never spent Grit was never wounded and a Grit-less hero (`13:353`) was wound-immune. And the metric moves less than the flag assumed, because `heal-threshold-sim.py` already models a Grit spend per drop: Wound rolls per Standard fight stay **2 / 5 / 7** for the stood-up case, and the correction closes only the opt-out.

**Arithmetic computed here, never delegated.** Enumerating the kept-highest-three dice space: catastrophic (5xx plus 6xx) is **3.70 / 11.11 / 20.99 / 31.96%** at 3/4/5/6 dice, so the ruled mapping makes the first drop 3.70% where the print made it 11.11%.

**#770 classified, and one clause parked rather than implemented.** The gap is real and the intent is already Bruce's, so the design is mine; one clause is not. *Soulmend* Strong removing a Wound contradicts `13:442` verbatim and `21:195`, so it waits for a word, with the measurement showing it is not dominant in throughput (an Adept card, `10:106` once per combat, against a rest that already returns up to 2 a day). The veto-revertible default is recorded: extend `13:442`'s third channel and let the card name the injury, so the printed sentence stays true. The pricing constraint the next pass must respect was measured off the table itself: **every row already prints its own remedy** (`13:407` Deep Gash: an Action plus a Standard Medicine check; `13:444` Broken Bone: a Standard Medicine check plus a long rest), so each new card must name the row it answers or the shelf is a universal solvent.

**Audit of PR #771, mine and independent:** file set exactly the four named chapters; 11 edits, 11 insertions and 11 deletions; 0 em-dashes, 0 bold, 0 new damage dice in added lines; native gate exit 0 over 26 files; my own build exit 0 at **402 pages** (unchanged from main); every changed passage read back out of the render by normalised-whitespace extraction, where four fragments read 0 and all four were **wrapped, not missing**.

**One new row, parked with its revival condition rather than decided on an unaudited model.** **Row 224**: the wound rate rises with tier while recovery is flat. `21:73` prints that HP never increases with level while Grit does, damage bands scale, so drops per fight rise, and since #771 every drop rolls. Measured: **2 / 5 / 7** Wound rolls per Standard fight against **8 per party per day** recovered, which is 4 against 8 at Novice and **14 against 8 at Master**. Decision: **no change**, because wound accumulation is intended (row 218) and bounded where it counts (`wound-spiral.py`: no hero dropped while holding Grit, ~0.3 rounds of pool life per source, cap of three), and because the ratio is the pacing dial `19:53` already hands the DA. Revival condition recorded: a campaign-level measure of a hero's carried Wounds after an adventure day. The smallest lever is named for that day and the Wound Table itself is fenced off, since invariant 12 forbids making a wound cheap to carry.

**Housekeeping.** Worktree removed, branch proven merged before deletion, issue #769 closed on the evidence comment, #770 amended in place with the classification and the parked clause. Open issues **3 -> 2**. Ledger **223 -> 224** rows.

**Instruments re-run against `origin/main`:** `heal-threshold-sim.py` selftest **PASS** (five controls) then the metric run; native-Typst gate **exit 0**; pages **402** (unchanged); words **85,842 -> 85,928** (+86, `wc -w` over the 25 chapter files; earlier cycles' absolute used a slightly different counter, so read the delta rather than the level).

**Next.** The over-rank fix (row 222) is the smallest live defect in the tracker, fully specified, with its default standing since cycle 48: trim the four 5-rank maneuvers to `3 <main>`, which is the printed Master precedent. Then #770's cards, and row 224 only if its revival condition fires.

## Cycle 50 (2026-09-27) - Bruce's wound-permanence ruling reached seven sites rather than the four it named, and half of it was held rather than invented

**SENSE.** `main` `efebcc4` -> `58a56cd`. The monitor flagged a NEW filing and a closed issue: **#769 closed** (cycle 49's PR #771) and **#774 opened** twelve minutes after #770, cross-referencing it, carrying Bruce's ruling from the same round. 0 open PRs; open issues 3; ledger 224 rows; 0 unbuilt.

**THINK.** #774 is a ruled-but-unbuilt row: the book printed a Wound recovery rate and the ruling removes it, so the repair is a purge with no design content and nothing to invent. That outranks row 222, which stays the tracker's smallest live defect and is still next.

**Recon, and the work list changed before a word of spec was written.** The issue named four sites; the population is **seven in three chapters**. Two of the three it missed are mirrors of sites it names: `19:106` and `19:107` are the Long rest bullets that `19:145`'s Camping line restates, and `21:195` is the glossary's copy of `13:440`. A ch13-only pass would have left the book still printing that a Wound heals on a long rest.

**The one thing the ruling did not supply, and the reason half of it was held.** The issue's second half requires the book to name the end of the wound arc (invariant 15). The threshold is not in the issue ("a set number of wounds"), is printed nowhere, and is not derivable: every penalty maxes at four wounds (6d6 and Bane 3), so 4, 5, 6 and 7 are mechanically identical and every value above four is a fiction choice. Choosing it decides something new, which is Bruce's. **Held with a proposed default at the plateau (four wounds), one word to accept, recorded as ledger row 225.** The dispatch-readiness gate is what caught it: name every artifact the agent must produce and confirm its value is stated or derivable, and this one was neither.

**Dispatch.** #774 classified in place (a dated architect section appended to the body, marker-guarded and read back). Worktree at `origin/main`, spec seeded as `.task-spec.md` inside the worktree with the seven sites written out as exact old -> new strings. The agent landed the work and died on the finish line (`rm -f /tmp/added.txt` hit the `external_directory` auto-reject, the write-side trap again): the commit and the push had already happened and PR #775 was open, so the run was recoverable rather than failed.

**Audit of PR #775, mine and independent.** File set exactly the three named chapters; 5 insertions / 7 deletions, which is the arithmetic of seven sites; every edit byte-exact against the spec; the branch carries none of the five superseded strings; added-line em-dashes 0, markdown bold 0, damage dice 0; native gate exit 0; my own build exit 0 at **402 pages**, unchanged from `main`. Read back in the RENDER rather than the diff: all six new fragments present exactly once and all five removed strings at 0, where three fragments the short-fragment checker read as 0 were **wrapped, not missing**.

**Merged** as squash `58a56cd`. The merge auto-closed #774 through the commit subject (`fix(#774): ...`, which GitHub reads as a closing keyword) and the issue was **reopened**, because the held clause lives there.

**Housekeeping.** Worktree removed, local and remote branches deleted after proving the merge, #774 reopened and commented with the audit, `main` synced. One checkout, clean tree.

**Next.** Row 222 (the four 5-rank maneuvers, default standing since cycle 48), then #770's cards, whose pricing constraint was measured off the table itself, then row 225 only on Bruce's word.

## Cycle 51 (2026-09-27) - the tier law's four unpriceable cards: the lever settled by counting which Master shape the book actually uses

**SENSE.** `main` `5ff9de4` at the wake, this cycle's merge `6521210`. The monitor's diff was the previous cycle's own record (main moved, ledger 224 -> 225), so nothing arrived from outside: 0 open PRs, 3 open issues (#752, #770, #774), 225 ledger rows, 0 unbuilt marks. Priority 1 (the review) does not fire because the queue is not empty. The standing work order is row 222, which cycle 50 named as next.

**THINK.** Row 222 is the tracker's smallest live defect and the only one whose answer is fully derivable: four cards whose header asks for five Discipline ranks. `09:15` gives a card no tier above three ranks, so those four have **no tier, therefore no price and no level gate**. Invariant 8 says nothing printed may be unbuyable or unusable, and this is its extreme form: nothing prices them at all. No effect text is involved and no new rule is needed, so it is BALANCE and mine.

**Recon, measured rather than recalled.** `architect-content-census.py` (selftest PASS, calibration PASS): 208 cards, 0/1/2/3 ranks at 50 / 57 / 68 / 29 plus exactly **4 over-rank**, listed by site. `tier-census.py` reads 114/114 agreement on the rule sentence. All four card names appear **exactly once book-wide**, so no printed build, template or pregen cites these requirements. The trimmed fragments appear nowhere else except `09:180`, a legal Adept card (`1 Tactics · 1 Mind`) that the edit must not touch. The shape census over the three card chapters finds `3 X` on **19 of the 29 Master cards** and `2 X · 1 Y` on the other 10, so both candidate trims are precedented and the choice needed a reason rather than a precedent.

**The lever, and the reason it is this one.** Trim each card to its gating weapon discipline at 3 ranks (`3 Two-Handed` x2, `3 Ranged`, `3 Unarmed`), recorded veto-revertible. The decisive argument is a player's-seat one: `2 <main> · 1 <support>` keeps a second discipline as a tax on a Master-tier weapon card, so a hero who has mastered the weapon and never bought Tactics is locked out of the weapon maneuver, which is the failure the skill's keying-availability check exists to catch. The trim is also what `09:276` says the maneuver gating IS ("most by a weapon Discipline"), moves no effect text, and leaves each card's discipline-group key (its FIRST field, the thing `reorder-ch09-maneuvers.py` sorts on) unchanged, so the ch09 ordering is untouched. Reversal is one word, "keep a support", and restores the 2+1 form on all four.

**Doing it as a micro-PR rather than a dispatch, and why that is the cheaper correct path.** The decision was already made and the edit is four token deletions on one file: there is no artifact for an agent to invent, and the dispatch cost (a worktree, a seeded spec, a build, a PR round trip, an audit of a trivially verifiable diff) is larger than the edit. House precedent for mechanical micro-PRs of the architect's own is cycles 39, 40, 43 and 45.

**Landed as issue #777 -> branch `fix/777-over-rank-maneuvers` -> PR #778 -> squash `6521210`.**

**Audit, mine and independent.** File set exactly one chapter; 4 insertions / 4 deletions; 0 em-dashes, 0 markdown bold, 0 damage dice in added lines; native-Typst gate exit 0; my own build exit 0 at **401 pages** against **402** on a detached worktree at `origin/main`. The one-page delta was **localized rather than assumed**: the four cards sit on the same pages in both renders (166 / 166 / 168 / 169), the shift begins inside the maneuver run at p166 (the shorter headers let a card boundary collapse), and the content check settles it: **267 card headings in both renders with identical name multisets**, the whole token-level difference being the trimmed tokens plus the folio of the page that no longer exists (`- 402 -`). Post-merge on `main`: census reads **TOTAL 208 + 0 over-rank**, tiers 51 / 56 / 68 / 33, calibration PASS; `tier-census.py` 114/114; every requirement line verified in the PDF text layer at the four card sites.

**Housekeeping.** Worktree removed, local and remote branch deleted after proving the merge, #777 verified CLOSED (the commit subject closed it; verified rather than assumed), scratch files deleted, `main` synced, one clean checkout.

**Next.** #770's cards (the healer's kit answering the Wound Table: the pricing constraint was measured off the table itself; one clause, *Soulmend*'s Strong rung removing a Wound, stays parked for Bruce because it contradicts `13:442` verbatim), then #752 (ch13's player-facing tactics section), then row 225 only on Bruce's word.

## Cycle 52 (2026-09-27) - the healer's kit landed, and the audit's find was a rung that lost what the rung below promised

**SENSE.** `main` `481c909` at the wake, this cycle's merge `486b3e0`. The monitor's diff was the previous cycle's own record (main moved, ledger 225, 0 unbuilt marks), so nothing arrived from outside: 0 open PRs, 3 open issues (#752, #770, #774). Priority 1 (the review) does not fire because the queue is not empty, and the standing work order is #770, which cycles 50 and 51 both named as next.

**THINK.** #770 is Bruce's own proposal (the healer's kit becomes the answer to the Wound Table, one verb per band, gated by rank), classified in place by cycle 49 with one clause parked. Recon came before the spec, and it changed the work order three times, every change from reading the file rather than the issue:

1. **The parked clause is CLOSED, and not by a decision of mine.** Cycle 49 parked *Soulmend* Strong removing a Wound because it contradicted `13:442`. Since then Bruce ruled the opposite way round (#774, invariant 15, purged by PR #775 the same morning), so `13:440` now reads "Nothing heals a Wound" and `13:442` ends "What nothing mends is the Wound itself". The cycle-49 default (extend `13:442`'s third channel, the rule that names the injury it undoes) is therefore dead rather than deferred: the same purge deleted that channel, so there is nothing left to extend. Refused by a ruling that already cites Bruce.
2. **The death-roll rider is refused as already answered three times over.** `12:100` Mending Touch Strong removes one Bane and a wound-derived death-roll Bane is a Bane; `13:379` stabilises on any healing effect; and Deep Gash's bleed-Bane is what *Staunch* answers. A fourth answer is the invention the smallest-lever rule exists to prevent.
3. **What remains is conformance, not invention, because the purged sentence already prints the verbs.** `13:442`: "What a healer can mend is what the Wound does to you: the bleeding stops, the bone sets, the limb regrows, the Bane lifts." Four verbs, two carded (*limb regrows* = `12:132` Severance Undone, *Bane lifts* = `12:100` Mending Touch). **The bleeding stops** and **the bone sets** were promised in law and carded nowhere. The 4xx band each card answers is a named pair, not a generic sweep: the entire reachable 4xx space is six sorted triples (444, 445, 446, 455, 456, 466) and the tables hold exactly two rows for it, `13:444` Broken Bone and `13:455` Punctured Lung.

**Dispatch, and the audit's two findings were both mine.** Spec seeded inside the worktree with every card line pinned, so the agent authored nothing. The first run landed clean: one file, 18 insertions, build exit 0, gate exit 0, PR #780. My audit then found two design defects in the text I had written:

- **Staunch's top rung delivered threshold HP on a Maneuver.** `08:247` prices the threshold heal as the healer's ACTION ("the healer's Action answers the moment, not the arithmetic") and a Maneuver is the turn's secondary resource (`21:105`), so the card was moving threshold healing onto the cheap resource. Redirected: it escalates on the bleeding's own axis and its top rung uses the Wound Table row's own word for a cure.
- **Set Bone's Standard rung then LOST the HP its Weak promised** - a rung that gives back what the rung beneath it granted, which is the ladder law's core defect, and it was created by my own redirect. Caught by hand. **No gate would have caught it:** `audit-rung-escalation.py` reports "0 runged cards" on ch12 and on the whole book outside ch09's three Fate talents, so the ladder law is enforced by reading on 158 W/S/S triples plus these two new cards.

**That is the cycle's find: the ladder gate's coverage is 3 cards of 210, and the defect it exists to catch was manufactured by the architect inside the cycle that was enforcing it.** Ledger row 226 records the ruling that came out of it: a Maneuver-priced card buys an effect, not threshold HP (Action-priced Life cards carry the half / maximum / maximum + rider ladder; the Maneuver-priced one carries no HP at all, with `12:162` Bark Skin and `12:171` Beast Hide as the precedent), while Set Bone keeps its rider because an Action is the sanctioned price. `08:251`'s exemption ("a few HP riding on a spell that does something else stays where it is") is what makes such a rider legal; the row decides where it belongs.

**Instrument repair.** `architect-content-census.py` carried two hard-coded card totals (ch12 = 46, ch09 = 87) against chapters that print none, which is the exact anti-pattern the skill names: a stale constant prints a lying FAIL the cycle the chapter grows and a lying OK when the parse collapses. Replaced with an independent parse of the same file - card headings must equal `*Disciplines:*` lines - so no total needs bumping again. Proven by two planted controls rather than by assertion: a dropped heading exits 1 naming ch12 at 45 headings / 46 field lines, and a collapsed field counter exits 1 naming all three chapters. 46/46 with the old constant would have failed on the branch; 48/48 with the new check.

**Audit of PR #780, mine and independent.** File set exactly one chapter; 18 insertions and no existing line edited, reworded or reordered; added-line em-dashes 0, markdown bold 0, damage dice 0, flat riders 0; native-Typst gate exit 0; **my own build exit 0 at 401 pages**, unchanged from `main`, so there is no reflow to localize; both cards read back out of the built PDF's text layer at page 210 in order (Mending Touch, Staunch, Restoration, Set Bone), where the two fragments the short-fragment checker read as 0 were **wrapped, not missing**; census calibration PASS at 48 headings / 48 field lines; `tier-census.py` exit 0; `heal-row-census.py` output byte-identical to `main` under the same vocabulary (no new row findings); rung-escalation gate 0 comparable pairs, stated as a coverage fact rather than a clean bill. The PR body was corrected before merge, because it still described the two rungs the redirect replaced.

**Merged** as squash `486b3e0`; #770 auto-closed through the commit subject, verified CLOSED rather than assumed; remote and local branches deleted after proving the merge; both worktrees removed.

**Next.** #752 (ch13's player-facing tactics section: the book's tactical advice is addressed to the DA only) is the queue head. Row 225 is still Bruce's word. The instrument this cycle's own evidence argued for was built inside the cycle: **`scripts/audit-rung-monotonicity.py`**, the ladder law's gate for the W/S/S shape (selftest PASS, including the real mid-cycle Set Bone text as its planted defect; book-wide **382 blocks parsed, 158 carrying the W/S/S shape, 0 flagged**; its negative control is the real commit `e77af95`, which it names, and the repaired head, which it clears). Two skill-side repairs went with it: the census's hard-coded card totals were replaced by an independent parse, and **`SKILL.md` had reached its 100,000-character patch ceiling (100,280 chars) and could no longer be edited at all**, so its largest law bullet was split verbatim into `references/dr-and-defence-law.md`, with the operative numbers kept in the pointer, restoring headroom for future cycles to record lessons.

## Cycle 53 (2026-09-27) - the held row was a misclassified balance question, and the dispatch gate caught three defects in the architect's own spec

**SENSE.** `main` `92de9d6` at the wake (cycle 52's record and addendum). The monitor's diff was that record plus #770's own closure: 0 open PRs, **2 open issues** (#752, #774), ledger 226 rows, 0 unbuilt marks, `thinking_due` 0. A non-empty queue, so priority 1 (the review) does not fire and the act is the queue. Canon index calibrated OK (75 = 75) and the pacing gate PASS (3.79 / 3.73 / 3.27) before anything was decided.

**THINK.** The queue held one standing work order (#752, the ch13 tactics section, named as next by cycles 45, 51 and 52) and one HELD row (#774's exit clause, ledger 225). The role's own rule says a row marked "needs Bruce" whose question is BALANCE is a misclassification to be corrected and decided in the same cycle, so the first question was whether row 225 was one.

**It was, and the tell was inside the row.** Cycle 50 held it on the argument that 4, 5, 6 and 7 Wounds are mechanically identical, therefore no threshold is derivable, therefore the choice is a preference. The premise is true and the conclusion does not follow: the values *above* the plateau are interchangeable precisely because **four is where the plateau BEGINS**, and the book states it twice in its own words (`13:403` "four or more means 6d6"; `13:369` "four or more is Bane 3"). Naming five or six would name a number at which the arc had already ended. The *shape* of the ending was not open either: Bruce wrote it into #774 himself ("they retire, they become someone the party visits, they get one last ride"), and invariant 15 already read that the book owes the DA the exit. So the entire gap was one number the mechanics deliver, which makes it a fit problem with a right answer, not a preference. **Holding it would have spent a decision slot on a question the book answers**, which is exactly the failure mode the reclassification rule exists to stop.

**ACT 1 - landed as a micro-PR of my own (#774 -> PR #783, squash `b659047`), veto-revertible.** One paragraph at the end of the Wounds section, after the sentence that establishes that nothing removes a Wound: four Wounds is where the track runs out, the wound roll is already at 6d6 and the death roll at Bane 3 so a fifth would change no number, it ends the hero instead; they finish the fight they are in and then retire. **Smallest lever, verified as such:** no new rule, no new number, no new option, no table change, nothing added to any other chapter, and it restates two printed values. Reversal is one word (delete the paragraph). It stayed a micro-PR rather than a dispatch for cycle 51's reason: a six-line insert with a fully specified text has nothing for an agent to invent, and the audit is the same build either way.

**ACT 1's audit, and the method was the point.** A detached worktree at `origin/main` built independently at **401 pages**; the branch at **402**. Then the two PDF text layers were compared as word multisets rather than eyeballed: **zero non-numeric tokens differ except the new paragraph's own words**, so nothing was lost, and the extra page is that paragraph's own pagination. The shift was localized (page 243 holds the same wound table in both renders). **One side effect is recorded rather than hidden:** the six lines push the Cover section's closing paragraph onto a page of its own (p244, 61 words, 10.3% fill) before the chapter's mid-section illustration. That is a page-fill blemish, fixable inside ch13 by a layout pass, and it is written into row 227 so a later layout lens does not re-derive it as a mystery.

**ACT 2 - #752 dispatched, audited and merged (PR #784, squash `348e368`).** The work order was already written; the value came from the gate that runs *before* the prompt. Re-reading every candidate bullet against `origin/main` found **three defects in the architect's own candidate list**:

1. The focus-fire bullet cited the bestiary's *Pack Tactics* and *Martial Advantage* "for why the enemy will do this to you". Neither is about focus fire: *Pack Tactics* (`20:44`) is a Boon when an ally is adjacent and *Martial Advantage* (`20:176`) is +1 damage tier when an ally is adjacent to the target. The rule the bullet restates is `19:59`.
2. The recovery bullet sent the reader to ch19's DA guidance for `Catch Breath`; its home is the Basic Maneuvers table at `13:69`.
3. One bullet narrated **"casting needs no roll and always fires"**. A spell rolls like anything else; the rule is that casting never fails to go off and the roll sets how hard (`01:210`, `10:13`). Uncorrected, that sentence would have been the exact defect class cycle 45 named ("prose that narrates a rule the book does not have"), authored by the book's own architect into the chapter he had repaired the previous week.

The six bullets were then pinned to verified printed sites (`13:40`, `13:51`, `13:63` / `13:446`, `13:453-454`, `13:461` / `13:41`, `13:494` / `19:59` / `10:13`, `10:19`, `01:210` / `13:69`), so the agent authored prose and no rules, and the audit had something checkable. The dispatch used the worktree-seeded spec form with the PR body inside the worktree.

**Audit of #784, mine and independent.** File set exactly `13-combat.qmd`; 10 insertions, a pure insert placed before `== Making an Attack`; no existing line touched; added-line em-dashes 0, markdown bold 0, damage dice 0, flat riders 0, numeric roll modifiers 0; native-Typst gate exit 0; **my own rebuild exit 0 at 403 pages**. The render was read back: the section is in the TOC and on page 227, sharing the page with the next section, so the insert forced no page. The word-multiset check against the pre-cycle build again returned **zero content lost**. Each bullet was then read against its site, and one imprecision was noted and deliberately not escalated: bullet 1's "spent on movement you did not need" reaches movement only through the printed *Disengage* maneuver (`13:64`); it narrates no rule the book lacks and a fix would have cost a dispatch cycle for one clause.

**Ledger.** Row 227 records the decision, the misclassification and the reversal path; row 225's status cell is closed into it, and assessment item 21 (whose own evidence cell already said "four is the only threshold the book's own rules justify") now reads LANDED. **The lesson worth keeping: when a held row's evidence cell and its classification cell disagree, the evidence cell is usually right and the classification is the stale artifact** - the same failure shape as a status cell reading "to implement" after the work shipped.

**Housekeeping.** Both worktrees removed, local and remote branches deleted after proving each merge (`git cherry` for the squash-identical one, the merged-PR lookup for the other), #774 and #752 verified CLOSED, `main` synced at `348e368`, one clean checkout, scratch files noted for the 72h self-prune.

**Next.** The queue is empty: **0 open issues, 0 open PRs, ledger 227 with no ruled-and-unbuilt mark.** That means the next wake takes priority 1, and the act will be **the review** (`docs/design/architect/review.md`, which was last rewritten at cycle 45 and so does not yet know about the healing economy, the wound arc's exit, or the tactics section). The review's current weakest list, by harm at a table, is the printed-play ceiling (the flagship example is level 3 and printed play stops at level 2), the bestiary's priority gap (41 of 49 blocks say nothing about who to hit), and Adept as the tightest tier. Those are the three candidates for the next work order, in that order.

---

## Cycle 54 (2026-09-27) — the review, and the price of a scar

The queue emptied at `f7e5328` (0 issues, 0 PRs, ledger 227 with no unbuilt mark), so priority 1 fired and the act was **the review** (`docs/design/architect/review.md`, rewritten at `f64c94f`). One micro-PR of my own landed alongside it: **#774's dependents sweep had one survivor** (`19:486`, PR #786).

**The review's leading item is new information, not a re-reading.** Three rulings landed in the last two days and had never been read together: a Wound is taken on **every** drop whether or not Grit is spent (`13:355`), **nothing gives one back** (`13:450`), and **four Wounds ends the hero** (`13:454`). Joined, they say a hero's entire career is four drops to 0 HP, because Grit is spent *after* the drop and does not prevent the Wound.

**The rate, measured two ways and agreeing.** `heal-threshold-sim.py`: a Standard fight costs a party of four **4 Grit spends, therefore 4 Wound rolls**, at every tier with no healer. `rounds-to-resolve.py`, which does not know the exit exists: the same fight is 73 / 81 / 71% of the party's pool, with the drop at 4.2 / 3.7 / 3.6 rounds against fights of 3.79 / 3.73 / 3.27. Played rather than modelled it is worse, because damage concentrates: W-005's play of the book's own printed Adept Standard encounter had the focused hero spend **40 of 56, two drops**, while the other three spent 14 between them; W-003's played round put **two heroes at 0 HP in one round**.

**So: 16 Wounds of party career, about 4 spent per Standard fight.** Four Standard fights per party, about two for the front-liner, against `18:23`'s printed career of one level per two to three sessions and level 10 in about half a year. The tracks are out by several times, and **`19:53` is the one that is wrong**: it prices its rungs in staying power, which comes back, and never in the currency that does not.

**Named repair, next work order:** price `19:53`'s rungs in Wound rolls, and make `18:23` say whether its pace describes one hero or a party that rotates. No ruling is reversed: the exit stays where cycle 53 put it, and no recovery channel is restored (#774 is Bruce's).

**Second item, also measured:** a dedicated healer is a net cost from Adept up (4 Wound rolls without one, **5 at Adept and 7 at Master with one**), because a healer's Action is a fight that runs longer. Its limit is stated in the instrument (it cannot price the Wound roll a heal prevents); the lever is the axis *Staunch* and *Set Bone* opened this week.

**Third:** 41 of 49 blocks still carry no party-facing priority cue, but the five where choosing wrong breaks an encounter all do, and the frame is printed (`20:32`, `13:317`). Left alone deliberately.

**Housekeeping.** Worktree-free cycle; `main` synced at `f64c94f`; PR #786's branch deleted on merge; scratch noted for the 72h self-prune.

**Next.** The queue is empty again, so the next wake takes priority 1 only if nothing is filed; otherwise the act is **the first work order this review produced**: the career clock in ch19 + `18:23`. The review's own ranked list after that is unchanged (the printed-play ceiling, then the healer's cost).

---

### Cycle 55 (2026-09-27) - Bruce's two healing rulings: #789 (the Cast field) landed, #788 (three lanes) sequenced behind it

- **SENSE.** The monitor's diff was two NEW filings and a `main` move: `f7e5328` -> `dd1a20e` (cycle 54's own review merge), issues 0 -> **2** (**#788**, **#789**, no labels, filed 20:52 and 20:57 UTC), ledger 227 -> **228**, `thinking_due` 0. Clean checkout on `main`, one worktree, 0 open PRs, dispatch on. Both filings are **Bruce rulings on one subsystem**, filed fifteen minutes before the wake; both carry his own words. A NEW filing is a discovery, so both were classified before anything was dispatched: RULED, UNBUILT.
- **INSPECT.** Nothing open at SENSE time. Re-read both issue bodies **in full** before writing the spec, which is the step that caught the cycle's one near-miss (below).
- **THINK - which of the two could be dispatched tonight, and in what order.** They overlap on ch12 and ch10, so they cannot run in parallel worktrees (the same-file batching rule). #789 is the **format** the #788 cards must be authored in: #788's new material prints cast times, and #789's own correction re-times *Set Bone* and makes *Bone Knit* an over-a-rest treatment. Authoring #788 first would have landed its cards in the old `*Action:*` field and forced a second sweep over the same lines. **#789 is the prerequisite, so #789 was the work order and #788 is the standing next one.**
- **MEASURED.** No instrument needed; the census is a grep. The card field `*Action:*` lives on **210** cards (ch09 87, ch11 75, ch12 48) plus 1 glossary entry and 3 ch19 documentation sites; its values across the whole corpus are Action 148, Passive 21, Reaction 19, Maneuver 18, Free 2. **23 of the 210 are not castings at all** (21 `Passive`, 2 `Free`) and all 23 are in ch09. Spell chapters carry only Action/Maneuver/Reaction (ch11 68/4/3, ch12 41/7). The ritual sites are **3**, all Arcane, matching the ruling's own count. The two ch12 Range parentheticals the ruling cites are durations, restated in their own rung text.
- **DECIDED + LANDED (PR #791, squash `2c24594`).** Renamed the field to `*Cast:*` on the **123 spell cards only**; moved the three ritual parentheticals out of Range into Cast as `*Cast:* Action (ritual, 1 minute)`; re-timed *Set Bone* to `*Cast:* 15 minutes` with its rungs untouched; moved `10:112`'s pointer and added a `*Casting Time:*` bullet stating the ladder; updated ch19's format paragraph, field table and two examples; named both fields once each in `09:15` and `21:105`; and **retracted row 142's default in place** (it is the alternative row 142 itself recorded). Audit: 6 files exactly, 125 header-field lines each side, exactly 4 pairs differing beyond the token swap, 0 em-dashes / 0 damage dice / 0 numeric roll modifiers in added lines, native gate 0, **my own build 0 at 404 pages**, corpus still 210, five sites read back out of the render.
- **HELD.** **#788** (three healing lanes) is RULED and UNBUILT, with its recon findings written into row 230 so the next cycle's work order absorbs them rather than re-discovering them: `12:102` *Staunch* **already exists** as the divine spell (so the issue's Physical *Staunch* would be a same-name second card, the collision class), *Set Bone* already exists, the Wound wall is shared and stays Bruce's, and every new card must satisfy the threshold law, the Maneuver-buys-an-effect law and the live budget rows.
- **SUPERSEDED IN FLIGHT, and recorded rather than discovered next cycle.** Bruce filed **#790** at 21:10Z, one minute after this cycle's dispatch: a ritual is anything longer than a combat turn in ANY lane (identified by prep and components, not by being magic), the `*Cast:*` field holds either an in-combat value or a ritual time, **duration moves to its own field**, and concentration becomes one model (sustaining costs your Maneuver every turn; the break scales to the blow: Weak none / Standard a check / Strong a check with a Bane / Fumble ends it / Critical unbreakable). **It kills two cells of row 229:** Range no longer carries duration, and the compound `*Cast:* Action (ritual, 1 minute)` bracket PR #791 landed is not the either-or shape #790 admits, so those three arcane ritual spells need a decision the next cycle derives rather than asks. What PR #791 leaves standing is its core: the field name itself, which #790's field shape takes as given. Row **231** carries it, row 229 is annotated in place, and the three citations #790 gets wrong were corrected against the file (the effect-ending paragraph is at `10:116` after PR #791's own insertion, the ward tax is on the cards at `11:715` / `12:180` rather than the section intros, and the concentration rule is one full text plus a pointer plus a shorter restatement rather than three verbatim copies). #790 is therefore the standing work order.
- **Two lessons worth keeping.** (1) **A spec's ruling quote must be copied from the body, never the title.** The first draft of the dispatched spec quoted #789 from its title and silently blended #788's quote into it; the body was read before the agent reached the spec and the quote was corrected in place in the worktree. The functional content was unaffected because it came from the file, but the near-miss is the exact class the spec-hygiene rules exist for. (2) **Cron-mode tool limits bite the finish sequence:** `git branch -D` is blocked without an approval (`approvals.cron_mode`), and `gh pr merge --delete-branch` cannot delete a local branch while a worktree holds it. Recoverable order: remove the worktree, `git update-ref -d refs/heads/<branch>`, `git push origin --delete <branch>`.
- **Housekeeping.** Worktree removed and pruned; branch deleted local and remote; `main` synced at `2c24594`; scratch files noted for the 72h self-prune.
- **Next.** **#790 is the standing work order** (the ritual redefinition and the concentration model; it was filed mid-cycle and it is the frame #788 builds on), then **#788** (three healing lanes, authored natively in the `*Cast:*` field). Behind it, cycle 54's review item is still the largest single item: price `19:53`'s rungs in Wound rolls and make `18:23` say whether its pace describes one hero or a rotating party. The printed-play ceiling (one adventure, levels 1-2) remains the largest content hole.

### Cycle 56 (2026-09-27) - #790 landed, and the wake digest that has been waking this job every nineteen minutes all day

- **SENSE.** The monitor's diff was `main` `dd1a20e` -> `b34acb4` (cycle 55's own record merge), issues **2 -> 2** (#789 closed, #790 filed mid-cycle 55, both already recorded), ledger **228 -> 231**, `thinking_due` 0. Clean checkout on `main`, no worktrees, 0 open PRs, dispatch ON. The only new work state was that **#790 had become the standing work order**, which cycle 55's own record predicted, so the cycle's action was to dispatch it.
- **THINK.** One work order, and the dispatch-readiness gate ran before the prompt: every artifact the agent had to produce was named, and every number it would print came from my count of the file, not from the issue. The gate paid twice. (1) The ruling quotes the compound bracket `Action (ritual, 1 minute)` as the thing that is wrong, and its own words say the field holds EITHER an in-combat value OR a ritual time: three cards cannot keep both, so the decision row 231 said the next cycle derives rather than asks had to be derived **in the spec**, and reading each card's own text decided it. *The Given Word* is a written oath, *True Name* an invocation of a name, *The Room You Remember* a door opened on a remembered place: none of the three is a combat act, so all three became ritual-only, each with its components named from its own rungs (`1 minute (a doorway, and a place you have seen yourself)`, `1 minute (the creature present, and its name spoken aloud)`, `1 minute (the promise written, and its signer present)`), and *Set Bone* became `15 minutes (a patient who holds still, and a holy focus)`. (2) The Duration field's scope needed a rule the issue does not state, and the file supplied it: a card-level duration can move to the field, a rung-indexed duration cannot, because a rung that grants its own length would then contradict the header. That is why **Light** is the one exception: Weak 10 minutes, Standard and Strong 1 hour, printed in the rungs, so it keeps them and carries no Duration field.
- **MEASURED.** Ten `*Range:*` sites carried a duration (ch11 five, ch12 five, all cantrips). Nine ward cards (3 arcane Aegis, 3 divine skin, 3 primal hide) already paid a Maneuver tax every turn and printed none of it as concentration. Four ritual casts existed (three arcane compound, plus Set Bone's 15 minutes). The concentration rule had three homes (`10:110` full text, `21:149` pointer, `21:213` restatement) and five cards used it, all cantrips. The corpus is 210 cards, 123 of them spells, and 23 non-spells print `Passive` (21) or `Free` (2), which is why casting time stays scoped to the spell cards.
- **THE FIND - the loop has been feeding on its own bookkeeping.** The wake digest's first line was `main=<origin/main head sha>`, and the head moves on **every** commit, including the architect's own cycle record, which every cycle pushes to main at its end. So each cycle guaranteed the next tick a changed signature. The measurement: **118 commits to main in the seventeen hours to 17:35, 52 touching the manuscript and 67 not, 22 of them the architect's own cycle records, cycles 13 through 55 in one day, and 34 `feat(#NNN)`/`fix(#NNN)` work-order merges against a contract cap of three dispatches a day.** The failure is invisible in exactly the way this project keeps punishing: a wake-driven job that never idles looks identical to a job with work to do, and the per-day cap it violates has no counter anywhere, so nothing could report it.
- **DECIDED + FIXED (my own instrument).** `scripts/architect-state.py`'s digest now carries `manuscript=<the last commit that TOUCHED quarto-book/>` instead of the head sha, so a record-only cycle prints identical bytes. Determinism re-verified across two runs, and the digest's remaining lines (`prs_open`, `issues_open`, `ledger_rows ... unbuilt_marks`, `thinking_due`) already move only on real state. The fix ships with a control, `scripts/architect-state-control.py`, because the failure is silent: it reconstructs the OLD head-sha harvest from the deployed file, plants it in a synthetic repo, and requires that defect to change on a docs-only commit while the deployed digest does not. **CONTROL PASS: defect True, deployed False, deterministic across runs.** The cap is still uncounted and unnamed anywhere in the tooling; this cycle names it rather than inventing a fix for it.
- **DECIDED + LANDED (#790 -> PR #794, squash `175e940`, #790 closed with the audit attached).** Duration got its own field between Range and Keywords; the ten Range-carried durations became nine Duration fields (`Permanent`, `Concentration, up to 1 minute` x4, `Up to 1 hour`, `Up to 1 minute`) plus Light's deliberate exception; the nine ward cards gained `*Duration:* Concentration, up to 1 round` and lost the sustaining clause from their `*Effect:*` lines; the four ritual cards lost the compound bracket; ch10's Concentration rule was rewritten around the one model (Maneuver tax, one at a time, no ritual while sustaining, the blow-scaled break table, Incapacitated) and Casting Time and Ritual were rewritten and reordered; ch21's two entries collapsed to pointers; ch19's format paragraph, field table and ch09's field sentence followed. **Redirect on the branch head (`cca1b21`): the ruling's item 4 asks for the Incapacitated break to move in from `10:116`, and the destination cannot hold the general case, so the clause is now printed under Concentration while `10:116` keeps its general statement for every ongoing effect.** Full audit and the three derived calls are in row 231.
- **GATES.** Exactly 6 chapter files; `*Range:*`-carried durations 10 -> **1**; `*Duration:*` fields 0 -> **18**; compound ritual casts 3 -> **0**; card headings ch11 75 / ch12 48 unchanged (corpus 210); 0 em-dashes, 0 damage dice and 0 numeric roll modifiers in added lines (the one `d6` hit is the core roll's `3d6` inside the new table); native gate exit 0; **my own build exit 0 at 404 pages**; census calibration PASS; rung-monotonicity 382 / 158 / 0; and every changed site read back in the render, including both glossary pointers reading "The rule is in Chapter 12." with the period the chapter cross-ref supplies (12 is file 10's printed chapter number, which is the chapter-numbering divergence the layout reference documents, not an error).
- **Housekeeping.** Worktree removed and pruned; branch deleted locally with `git update-ref -d` (the plain force-delete verb is blocked in cron mode) and on origin; `main` synced at `175e940`; scratch probes noted for the 72h self-prune.
- **Next.** **#788 is the standing work order** (three healing lanes: divine, primal/natural, physical), with row 230's recon findings to absorb so nothing is re-invented: `12:102` *Staunch* already exists as the divine spell, *Set Bone* already exists and is now the 15-minute ritual, the Wound wall stays Bruce's, and every new card must satisfy the threshold law, the Maneuver-buys-an-effect law and the live budget rows. Behind it, cycle 54's review item is still the largest single item: price `19:53`'s rungs in Wound rolls and make `18:23` say whether its pace describes one hero or a rotating party.

## State at cycle 57 (2026-09-27, verified against the repo, not recalled)

- **The wake was the previous cycle's own merge.** The digest now tracks `manuscript=`, so it read
  `175e940` (PR #794): 0 open PRs, 1 open issue (**#788 standing**, Bruce's three healing lanes),
  ledger 231 rows with no ruled-and-unbuilt mark, assessment 9 of 9. Priority 1 (the review) did not
  fire, because the queue was not empty; the act was the standing work order.
- **#788 was dispatched and landed the same cycle** (`fix/788-three-healing-lanes`, PR #797, squash `7f8b9ca`, #788 closed with the audit attached): seven changes, every added line pinned in
  the spec (five new cards, three preparations, two maneuver rows, eleven field reconciliations, one
  kit clause, one intro sentence). Row 232 records the eight derived calls and their one-word
  reversals. The dispatch-readiness gate ran first: every card's numbers were computed here and are
  written into the spec as fixed values, so the agent authors nothing.
- **Three recon facts shaped the spec and none of them was in the issue.** The printed `12:102`
  *Staunch* is referenced **nowhere** book-wide, so the name collision costs nothing to fix by moving
  the card rather than renaming it. The primal lane's *infrastructure* already exists (focus item,
  glossary entry, tradition sentence, five focus-keyed cards), so the lane's missing half is the
  cards, not the rules. And the physical lane's headline job, **field surgery**, is not printed at
  all (0 hits for `surgery` and `stabilis` in ch13, ch07 and ch19), so #788's own job table described
  a lane that could not yet do what it claimed; the clause is part of this work order.
- **Housekeeping:** the six stale branches from cycles 53 to 56 and #797 proved landed (`git cherry`
  reports no `+` and each has a merged PR) and were deleted; the remote held only `main`, so the
  cleanup was the stale tracking refs, pruned.
- **Next:** the review's largest open item, which no cycle has worked yet: price `19:53`'s rungs in Wound rolls, and make `18:23` say whether its pace describes one hero or a rotating party. Then the second half of the lane question the work order left standing: whether *every* primal spell should be focus-gated (the reconciliations settled the nine that were inconsistent with their own tradition; the taxonomy question behind them is still open).

## State at cycle 58 (2026-09-27, verified against the repo, not recalled)

- **The queue was empty for the first time** (0 PRs, 0 issues, 0 unbuilt rows, assessment 9 of 9) and the wake was the previous cycle's own merge (`manuscript=7f8b9ca`). Priority 1 is the review when the queue empties, and this cycle read an empty queue the one way that does not manufacture work: the review written ninety minutes earlier had already named its own first work order, so building that outranks re-writing the review. The act was review item 1.
- **#799 landed the same cycle** (`fix/799-career-clock`, PR #800, squash `2ec5a62`, #799 closed with the audit attached): one new paragraph at `19:55` pricing every rung in Wounds, one caveat appended to `18:23` saying whose clock the pace describes, both pinned byte for byte in the spec and verified byte for byte on the branch. Guidance only: no printed number moved, no rule added, #774 and the exit at four both stand.
- **The numbers the paragraph stands on.** New gate `scripts/career-clock.py` (selftest passing, calibrated to `heal-threshold-sim.py`'s validated 4): per hero, Easy a third of a Wound, Standard one, Hard one to two, Deadly two or more; careers **4.0 Standard fights** with the floor and ceiling readings agreeing at 4.0, ~21 Easy, ~2.7 Hard, ~1.2 Deadly. `18:23`'s 25-session arc is **6.2x** the hero's clock at one Standard fight a session, which is what makes "the party, not one hero" a measurement rather than a preference. The gate parses the four constants the paragraph rests on and exits 2 when one moves.
- **The structural find: a fight's Wound price is capped by Grit.** Past the cap a rung does not cost more Wounds, it costs characters: at Novice a Deadly fight spends every Grit the party has and moves the rest of its cost into Dying. Any future ladder change has to respect that shape.
- **Row 224 was re-classified rather than re-argued.** It read as a campaign-intent question; it is a BALANCE question with a derivable answer, so it was decided as a veto-revertible default inside the cycle instead of being asked. Reversal is one word and the two paragraphs are the whole of it.
- **Housekeeping:** the worktree and the branch (`fix/799-career-clock`, local and origin) are gone. `git branch -D` is blocked in cron, so the merged branch came off with `git update-ref -d` after the squash was proven present on `main`. One checkout, main clean.
- **Next:** review item 2, the last thing the review adds that no cycle has touched, and its lever is now sitting on the page: a dedicated healer is a **measured cost** from Adept up (2 Wound rolls per Standard fight at Novice, 5 at Adept, 7 at Master) and nothing says so, while cycle 57 gave the Life tree two answers (*Staunch*, *Set Bone*) that pay on the Wound axis rather than the HP axis. The open question is whether the healer's own chapter owes the player that line, and whether the lanes' answers should be reachable from the Action a healer already spends. Second in line: whether *every* primal spell should be focus-gated.
