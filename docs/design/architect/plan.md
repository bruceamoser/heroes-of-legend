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

## Queue — ordered, each item tied to its pillar

**Ordering note (2026-09-26, per #659):** until `assessment.md`'s coverage table reads 9 of 9, the
queue's source of direction is that file's **"What matters now"**, not the order below. The rows here
are the *filed* work; the assessment says what outranks which. Read them together.

| # | Work | Source | Why it is ordered here |
|---|---|---|---|
| 1 | **#655 — the Fate module** (9 class cost rows, the Comprehensive row, 5 talents, 2 spells) | row 125; ledger row 159 | Ruled, specced, filed, and runnable the moment dispatch is enabled. Until it lands the book advertises a Discipline nobody can buy. |
| 2 | **Rebuild the nine ch02 printed builds** (gear ranks unpaid; culture-skill duplication) | rows 161, 162, walkthrough W-001 | **Blocked on two one-word rulings.** It is the largest cohesion defect in the book (26 DP + 18 DP across 9 builds) but every fix direction rewrites printed content, so it waits. Same file as #655's second half (ch02 is not in #655's file set; ch05 is). |
| 3 | **Retitle the three mis-titled ch09 talents** (`09:94`, `09:184`, `09:189`) | ledger row 160 | Three cards, one convention, and half of #655's file set, so it runs AFTER #655 merges. |
| 4 | **The Summon module** (row 151) | `discipline-completion-spec-20260916.md` section 2 | Writes the same nine class tables as #655, so it serialises behind it. Re-derive the bestiary Challenge values at dispatch time. |
| 5 | **#561 — ch09 council pass, substantive tier** | open issue | Already scoped per-line; no design fork. |
| 6 | **#587 — level 0/1 DP pools** | open issue, **blocked on Bruce** | A design question. Now carries the walkthrough's measurement; do not implement. |
| 7 | **23-license** — Wave 2 stands at 24/25 | row 2 | Outstanding chapter. |
| 8 | **Closing balance audit** — one full-book budget walk | row 2 | The closing act of the build pass; waits on items 1 and 4 landing. |
| 9 | **The economy's line-level repairs** - the true-price statement, 4 misnamed structures | assessment 2 (cycle 3) | **Filed as #661.** Mechanical and determinate, no ruling needed, so the engine can take it today. It is the cheapest fix in the book's most expensive defect class: 44 DP of unfunded spend in rows 161/162 traces to a price the book states incorrectly. |
| 10 | **Pacing lever 2 - size the Standard encounter to the party's actions** (1.5 creatures per hero) | row 165, cycle 6 decision | **FILED as #663** (cycle 6). The law is Bruce's (row 165); the lever is now chosen by the architect as a veto-revertible default, so this is dispatchable rather than blocked: per-hero budget, six creatures for a party of four, seven at Adept and Master, landing 3.79 / 3.15 / 3.36 rounds. Moves `19:53` / `19:55` and ch20's encounter table only. Dispatch is gated off, so the issue carries every number and no agent has run. **First item to dispatch when the gate opens.** |

## Next action

Cycle 7: **Assessment 3 - creation and progression**, the sweep's next subsystem and the same
territory as the role card's level walkthrough, so two obligations are served by one piece of work.
Assessment 2 supplied the inputs: the class pool is 8 DP, the rank supply is 3 progression picks,
and the career budget is 44-52 DP. Specifically: **can the tightest legal hero be built** (Knowledge
and Fortitude at -2 gives 4 Background DP, and the Shepherd already overspends 8), and **does any
level arrive with nothing worth buying** (3-4 DP per level against a 2/4/8 card ladder and a 1/3/7
gate)? Both answers are arithmetic over tables already in the book, and both close priorities 2 and 5.
Two filed work orders now outrank a new assessment if dispatch opens: **#663** (pacing, top of the
queue) and **#661** (the true price of a card). Neither has run, so the first act of cycle 7 is to
check whether either moved and, if the gate is open, to dispatch #663.

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
