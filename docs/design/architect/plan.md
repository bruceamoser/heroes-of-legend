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

## Queue — ordered, each item tied to its pillar

| # | Work | Source | Why it is ordered here |
|---|---|---|---|
| 1 | **#655 — the Fate module** (9 class cost rows, the Comprehensive row, 5 talents, 2 spells) | row 125; ledger row 159 | Ruled, specced, filed, and runnable the moment dispatch is enabled or the distribution table is cleared. Until it lands the book advertises a Discipline nobody can buy. |
| 2 | **Retitle the three mis-titled ch09 talents** (`09:94`, `09:184`, `09:189`) | ledger row 160, found cycle 1 | Three cards, one convention, and half of #655's file set, so it runs AFTER #655 merges rather than beside it. |
| 3 | **The Summon module** (row 151) | `discipline-completion-spec-20260916.md` section 2 | Writes the same nine class tables as #655, so it serialises behind it. Re-derive the bestiary Challenge values at dispatch time. |
| 4 | **#561 — ch09 council pass, substantive tier** | open issue | Already scoped per-line; no design fork. |
| 5 | **#587 — level 0/1 DP pools** | open issue, **blocked on Bruce** | A design question. Do not implement; keep it visible and unguessed. |
| 6 | **23-license** — Wave 2 stands at 24/25 | row 2 | Outstanding chapter. |
| 7 | **Closing balance audit** — one full-book budget walk | row 2 | The closing act of the build pass; waits on items 1 and 3 landing. |

## Next action

Cycle 2: **run the first walkthrough** (first-session, per the role card) and write the transcript to
`architect/walkthroughs/`. Playable has now been unmeasured for two cycles and it is the outcome this
role exists for; the two ledger items that could have been worked instead are filed (#655, row 160).
Then check whether #655 has been dispatched, and if it has not, keep the queue visible without
re-arguing it.

## Cycle log

| Cycle | Did | Moved | Next |
|---|---|---|---|
| 0 (bootstrap) | role card + cycle contract written; state files created; baselines measured; repo state verified | the loop exists | run cycle 1 on item #1 |
| 1 (2026-09-26) | SENSE: bootstrap merged (#654), rows 125/151 re-verified against `origin/main@eb8b5e0`, tracker read. THINK: priority (a), a ruled-but-unbuilt row. DECIDE: the Fate module is ruled and dispatchable; its three unruled defaults got ledger row 159; a fresh ch09 title/tier defect got row 160. DISPATCH: blocked by design (`HOL_ARCHITECT_DISPATCH` unset), so the work order was filed as **#655** with every number pre-computed. | **#655** filed; rows 125 and 151 commented; rows 159 and 160 added; scorecard gained the title-vs-tier instrument | cycle 2: walkthrough #1 (Playable), then #655 dispatch if enabled |
