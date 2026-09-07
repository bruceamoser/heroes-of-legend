# Council Run Summary — ch03 (Attributes) — 2026-09-07

- **Council:** hol-rulebook (7 voters, quorum 4, max 2 rounds)
- **Run dir:** `20260907-2007`
- **Source:** `03-attributes` (quarto-book/chapters/03-attributes.qmd, 164 lines)
- **Verdict:** topic `t-01` **rejected 6-1** in round 1 (6 un-rebutted refutes, 1 support). No judge, no impasse, no sealed rulings.
- **Ledger:** 13 events, `verify` chain ok.

## Findings (7, round 1)
| id | role | stance | defect named |
|----|------|--------|--------------|
| f-001 | librarian | refute | Guile/intimidation keying (:82) + Poisoned vocabulary (:120) |
| f-002 | contrarian | refute | Guile/intimidation keying (:82), rules-lawyer exploit |
| f-003 | researcher | support | arithmetic/structure hold; Guile + Poisoned noted; Zara divine roll verified compliant |
| f-004 | game-architect | refute | Guile/intimidation keying (:82) |
| f-005 | author | refute | Guile/intimidation keying (:82) |
| f-006 | editor-in-chief | refute | Guile keying (:82) + Poisoned vocabulary (:120) + Sera Arcanist class (:148) |
| f-007 | layout-expert | refute | bare crossref doubled period (:43), confirmed in built PDF p.55 |

## Wall / process telemetry
- **Pre-ingest wall lint:** all 7 findings clean on first pass (no >=10-word verbatim span vs problem+source). No single-member rewrites, no `judge-brief` rejections.
- **Reconciliation:** all 7 rendered briefs dispatched and a finding filed for each (no dropped lens).
- **Dispatch note:** the first wave-1 `delegate_task` batch timed out at the 420s harness limit; 2 of 3 spawned (librarian, researcher) completed, the contrarian slot fell through and was re-dispatched as its own call. Wave 2 had the same timeout; EIC spawned, then GA+author were re-dispatched. Net effect: all 7 voters produced findings; the engine was never touched mid-run.
- **Model provenance:** all 7 roles on the config-default local model (Qwen3.8-27B); `decorrelation: single model` (Q4 caveat, machine-readable in report.md).

## Disposition & implementation
- **TIER 1 (mechanical, chapter-local, canon-determined) — fixed in PR #396 (merged 2026-09-07):**
  1. `:82` Guile entry drops "intimidation" (roster keys Intimidation to Brawn, ch07:139 / ch22:175, decision #29).
  2. `:120` failed-Fortitude outcome → leveled **Poisoned 2** with both effects (2 poison damage/round + Bane), per ch13:184.
  3. `:148` Knowledge example: Sera "the party's **Arcanist**" (canon ch10:115, ch08:204), was "Intellect".
- **TIER 1 (mechanical, but BOOK-WIDE convention) — deferred to decision #77:**
  4. `:43` bare crossref doubled period. Recon found the pattern is book-wide: 18 bare refs across 11 chapters (ch01 x6, ch02 x3, ch03 x1, ch05 x1, ch06 x1, ch08 x1, ch13 x2, ch15 x2, ch16 x2, ch18 x1, ch21 x1), all rendering "Chapter N.." in the built PDF. A chapter-local fix would make ch03 the only chapter in the clean form, violating the book-wide convention rule (ch13 2026-08-26). Two fix directions logged: (A) parenthetical sweep (~18 edits, 11 chapters, one PR per chapter group) or (B) accept + document. Needs Bruce.
- **TIER 2 (substantive):** none. **TIER 3 (design decisions):** none (Intimidation keying #29 and leveled-conditions vocabulary already locked; the chapter was simply stale).

## Verification (orchestrator, independent of member self-reports)
- File set: `quarto-book/chapters/03-attributes.qmd` only (git diff main...origin/branch).
- Damage/healing dice on branch: 0.
- Em-dashes in added lines: 0.
- Build: `cd quarto-book && ./build.sh` → exit 0, PDF produced.
- PR #396 audit passed; merged squash, branch deleted.
