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
- **PR #660 was already open when this cycle woke** and carried Assessment 1 (core resolution) with
  coverage at 1 of 9. Cycle 3 INSPECTED it - every probability row re-derived independently from the
  216 outcomes and confirmed correct, my own first checker being the one at fault (it capped Strong
  at 18 and dropped 4 of 216 outcomes at +2, 56 of 216 at +6) - then advanced the sweep to
  **Assessment 2, the economy** (coverage 2 of 9) and merged both as one PR.
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
  Opposed (Blade, Arcanist, Shepherd-Armor, Unbalanced). The Leader's own figures check out once every rank above the grant is paid (4 DP weapons + 2 DP armour + a card = 8), so it is not a defect.
- **Dispatch is still off** (`HOL_ARCHITECT_DISPATCH` unset). One mechanical work order filed
  (issue #661, the economy's line-level repairs), nothing dispatched.

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
| 9 | **The economy's line-level repairs** — the true-price statement and 4 misnamed cost structures | assessment 2 (cycle 3) | **Filed as #661.** Mechanical and determinate, no ruling needed, so the engine can take it today. It is the cheapest fix in the book's most expensive defect class: 44 DP of unfunded spend in rows 161/162 traces to a price the book states incorrectly. |

## Next action

Cycle 4: **Assessment 3 — creation and progression** (the sweep's next subsystem, and the same
territory as the role card's level walkthrough, so two obligations are served by one piece of work).
The questions are now sharp because Assessment 2 supplied the inputs: the class pool is 8 DP, the
rank supply is 3 progression picks, and the career budget is 44-52 DP. Specifically: **can the
tightest legal hero be built** (Knowledge and Fortitude at -2 gives 4 Background DP, and the
Shepherd already overspends 8), and **does any level arrive with nothing worth buying** (3-4 DP per
level against a 2/4/8 card ladder and a 1/3/7 gate)? Both answers are arithmetic over tables already
in the book, and both close priorities 2 and 5. Before it runs, re-check whether #655 or #661 has
been dispatched; if dispatch is enabled, a filed work order outranks a new assessment.

## Cycle log

| Cycle | Did | Moved | Next |
|---|---|---|---|
| 0 (bootstrap) | role card + cycle contract written; state files created; baselines measured; repo state verified | the loop exists | run cycle 1 on item #1 |
| 1 (2026-09-26) | SENSE: bootstrap merged (#654), rows 125/151 re-verified against `origin/main@eb8b5e0`, tracker read. THINK: priority (a), a ruled-but-unbuilt row. DECIDE: the Fate module is ruled and dispatchable; its three unruled defaults got ledger row 159; a fresh ch09 title/tier defect got row 160. DISPATCH: blocked by design (`HOL_ARCHITECT_DISPATCH` unset), so the work order was filed as **#655** with every number pre-computed. | **#655** filed; rows 125 and 151 commented; rows 159 and 160 added; scorecard gained the title-vs-tier instrument; landed as PR **#656** (PR #654 audited - docs only, merged) | cycle 2: walkthrough #1 (Playable), then #655 dispatch if enabled |
| 2 (2026-09-26) | SENSE: 0 PRs, 3 open issues, `main` unmoved at `f33a51a`, dispatch still off, nothing `s:working`, canon index re-built and calibration passed (ch11 = 68 cards). THINK: nothing in flight, so priority (d) - the instrument the role exists for. RAN walkthrough W-001 (first session) on `origin/main@f33a51a`: built a hero through Steps 1-11, walked all nine printed builds against the loadout cost model, then played ch13's worked round and a goblin scene. DECIDE: four defects, all in the creation economy the 2026-09-16 armament collapse rewrote; two single-outcome (Challenge 1/2's penalty, ch13:502's round total) fixed same day, two need one word each (rows 161 gear ranks, 162 culture skill). FILED nothing new: #655 already carries the Fate module. | **W-001 transcript** written; ledger rows **161/162/163**; **#587** commented with the 26-DP measurement; **9 book defects fixed** (`06:111`, `21:231`, `13:502`) and verified in the rebuilt PDF; scorecard: Playable 0 -> 1 transcript, two new measurements | cycle 3: level walkthrough (gates 1/3/7), or #655 dispatch if enabled |
| 3 (2026-09-26) | SENSE: main advanced to `2a13070` (cycle 2 merged), canon index re-built, calibration passed again (ch11 = 68), dispatch still off, and a **state change the monitor caught: #659 (new direction from Bruce: assess from the foundation up) plus an open PR #660** carrying Assessment 1 at coverage 1 of 9. INSPECT: re-derived every one of Assessment 1's probability rows from the 216 outcomes - all six correct, and the first checker written for the job was itself the bug (it capped Strong at 18, dropping 4/216 outcomes at +2). THINK: the sweep's next subsystem, the economy. Computed the true price of a card (2-6 DP), damage per DP (3.00 / 2.00 / 1.29), the rank supply (3 progression picks), and the 8-DP promise class by class. Also measured Assessment 1's priority 1 - Grit holds time-to-kill flat (5.8 / 5.9 / 5.8) - and reversed it. DECIDE: 3 rulings go to rows (165 Shepherd, 166 Master efficiency, 167 K/F double bank); the line-level defects are mechanical and determinate, so they go out as one filed work order. | **Assessment 2 landed** (coverage 1 -> 2 of 9); **priority 1 reversed with the numbers**; ledger rows **165/166/167** and a comment on 161; **#661 filed**; merged as PR **#660** (Assessment 1 audited and confirmed) | cycle 4: Assessment 3, creation and progression |
