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

## Queue — ordered, each item tied to its pillar

| # | Work | Source | Why it is ordered here |
|---|---|---|---|
| 1 | **Dispatch the Fate + Summon completion spec** | `discipline-completion-spec-20260916.md`, rows 125/151 | Ruled, specced, undispatched for nine days. Until it lands the book advertises a Discipline nobody can buy and prices one nothing consumes. Clear the shield-DR blocker first or the spec is not dispatchable as written. |
| 2 | **Refresh stale ledger rows** — row 155 still reads as unbuilt while #650 is merged | ledger hygiene | Cheap, and it is the exact defect that makes the next reader re-plan finished work. The ledger is law; law that lies is worse than no law. |
| 3 | **#561 — ch09 council pass, substantive tier** | open issue | Already scoped per-line; no design fork. |
| 4 | **#587 — level 0/1 DP pools** | open issue, **blocked on Bruce** | A design question. Do not implement; keep it visible and unguessed. |
| 5 | **23-license** — Wave 2 stands at 24/25 | row 2 | Outstanding chapter. |
| 6 | **Closing balance audit** — one full-book budget walk | row 2 | The closing act of the build pass; waits on #1 landing. |

## Next action

Cycle 1: SENSE (canon index rebuild, ledger read, tracker read), verify that the
completion spec's numbers still hold against the live corpus (they were measured
2026-09-16), clear or re-file the shield-DR blocker, then dispatch item #1 as a single
work order.

## Cycle log

| Cycle | Did | Moved | Next |
|---|---|---|---|
| 0 (bootstrap) | role card + cycle contract written; state files created; baselines measured; repo state verified | the loop exists | run cycle 1 on item #1 |
