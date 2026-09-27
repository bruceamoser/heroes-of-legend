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
- **Walkthrough W-001 ran.** `architect/walkthroughs/w-001-first-session.md`. Playable is no longer
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

## Next action

Cycle 11: **dispatch #670** (creation economy: the level-1 4 DP award, the nine builds' ledgers, the culture-skill swap) now that #671 has landed the entry-requirement values its per-build table assumes; then **#672** (recurring effects are budgeted on their total). **Assessment 6 (social conflict)** is still the sweep's next unassessed subsystem and the last member of the pillar trio: it takes the cycle when the dispatch queue is thin or a work order parks. #655, #661, #668 and #561 remain in the queue behind these.

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

### Cycle 11 (2026-09-27) - #670 dispatched, audited and merged (PR #674 `5c52f12`); the pacing gate's second verdict recorded

- **SENSE.** `main` at `59c6563`, 0 PRs, 7 open issues (#671 closed by cycle 10), ledger 175 rows. Dispatch ON.
- **DISPATCH GATE (before the prompt was written) - four things the work order had wrong.** (1) `18:66` is the quote block: the level-1 row is **`18:47`** and the printed total is `18:63` (not `22:270`), and the same mis-cite sat in five docs; (2) the chapter's own Quick-Build summary `02:30` prints "Class DP: 8 DP" and was **not in the work list** at all; (3) "three on +2/+4 surplus" is **four** (the ninth build trims); (4) Makeva's header carries the `*Step 7, ` prefix the other eight lack. All four amended into #670 before dispatch.
- **DISPATCH.** Worktree `/tmp/wt-670`, branch `fix/670-creation-economy` from `origin/main`, spec seeded as `.task-spec.md`, opencode in background. The spec carried every build's fixed arithmetic (pool, loadout ranks at the class's own rate, cards, closing line) and the **13 named skill swaps and surplus spends** so the agent authored no number and no skill name.
- **INSPECT.** File set exactly the four named chapters; em-dashes in added lines 0; markdown bold 0; native-Typst gate exit 0; independent build exit 0, **392 pages**; a parser reading the branch file re-derived all **nine ledgers - 9/9 closing at 12 DP, 0 mismatches, 0 culture-note residuals**. **The audit found a defect my own spec caused:** three added lines put a crossref inside a parenthesis and typed the sentence period after the closing paren, rendering `(Chapter 10.).` and `in Chapter 20.).` The repair is the book's own precedent (`08:99`): the ref ends the clause and **nothing** is typed after it. Repaired on-branch (first attempt replaced one double period with the other - the bare `Chapter 20..` - and the render gate caught that too), then re-verified: bare double period **0**.
- **MERGE.** #674 squash-merged, remote and local branch deleted, **#670 closed**, worktree removed, merged tree byte-identical to the audited branch tip (`git diff --stat cdf6136 origin/main` empty).
- **RECORD.** Rows 161/162/165/166/169 marked IMPLEMENTED; `18:66` corrected to `18:47` in five docs; two new rows: **177** (the pacing gate's second verdict - a Standard fight spends 89.3 / 99.8 / 92.9 percent of the per-respite pool against `19:53`'s "some resources", with the Catch Breath model gap named as the first thing to settle) and **178** (the punctuation sweep, **filed as #675**, 15 sites in 10 files).
- **Next.** Dispatch **#672** (recurring effects, row 171's work order); **#675** (mechanical, disjoint files) rides the cycle after. The sweep is still 5 of 9 - social conflict (6) is next once the queue thins, and row 177 is the first item on the balance queue that needs its model settled before a lever is chosen.
