# Council Run Summary — ch14 "Social Conflict"

**Run dir (live):** `~/.hermes/councils/hol-rulebook/runs/20260826-2008/`
**Date:** 2026-08-26 (convened by the 16:00 cron walkthrough)
**Engine:** synod council.py, charter `hol-rulebook` (7 voters, quorum 4, max 2 rounds)
**Source:** `14-social-conflict` (ch14, 134 lines at audit time)
**Verdict:** **REJECTED 6-1** (t-01, both rounds; layout-expert supported on the presentation lens only)
**Findings:** 7 (round 1: 7 members; round 2: 4 re-verified positions, 3 members converged on round-1 stances)
**Rulings:** none (no judge needed; no impasse)
**Confidence:** 0.9 (librarian)

## Positions

| Member | R1 | R2 | Core claim |
|--------|----|----|------------|
| game-architect | refute | refute | Example roll 4 arithmetic false (15+0+2=16); opposed-model split vs ch19:187-196; ch06:53 (locked) routes active social contests to opposed rolls |
| researcher | refute | (converged) | Two invented mechanics: Intimidation not in the ch07 roster; '+1 circumstance bonus' not in the ch06 lever set (Boons/Banes are) |
| contrarian | refute | (converged) | Undefined failure semantics on the Hostile attitude row (Standard "fails" while core tiers make it a success); attitude drift vs success-count win condition can run past 3 |
| author | refute | refute | Voice holds, but the example's named mechanics (Intimidation, flat +1) contradict the book's own chapters; "Insight Boon" mislabels the lever |
| editor-in-chief | refute | refute | Guidance blocks sit after the example instead of beside the procedure; example's round 3 "no roll needed" ending contradicts the 3-success win condition |
| layout-expert | support | support | Clean render (PDF pp. 224-231), zero em-dashes, no ch14-specific layout defect; all suspected items are book-wide conventions |
| librarian | refute | refute | Synthesized the disposition plan below |

## Disposition plan (librarian synthesis)

**Mechanical (shipped as micro-PR #373, 2026-08-26):**
- Critical/Fumble row added to the single-roll attitude path (ch06 core rules)
- Active Deception tied to the target's passive Insight per the opposed-rolls rule
- Invented '+1 circumstance bonus' replaced with a Boon (ch06 lever) at both guidance sites

**Substantive (dispatched 2026-08-27, worktree `fix/council-ch14-substantive-20260827`):**
1. Add Intimidation (Brawn) to the skill roster: ch07 (22 -> 23 skills), ch22 quick-reference table. ch21 has no per-skill entries (verified false positive, no change). ch14/ch18/ch19 already treat Intimidation as real.
2. ch14 adopts the opposed extended-conflict model from ch19 (opposed rolls, 5-row tier table, stakes-declared, first to 3 successes, attitude drift on fail); ch19 trims to a pointer.
3. Worked example re-derived against the opposed model (warden passive Insight 13, lieutenant 11; Boon = 4d6 keep highest three; conflict ends Round 2 at 3 successes).
4. Phantom class fix in the Face Problem callout ("the ranger" -> real class).
5. Primer "Four skills" -> five skills + Performance blurb.

**Design defaults (implemented, logged veto-revertible in decisions-pending.md):**
- Intimidation joins the roster (ch14:27, ch18:94, ch19:83/187 already use it; adding it makes the book consistent, removing it breaks four sites)
- Opposed model lives in ch14, ch19 points (ch06:53 locked reference)
- Boon is the only situational bonus lever; no flat circumstance numbers

## Wall rejections

None. Pre-ingest wall lint (prescreen.py, 10-word rule) ran clean on both waves (7 findings round 1, 4 round 2). No judge-brief was ever needed.

## Process notes

- Round 2 re-verification: game-architect, author, editor-in-chief re-derived every round-1 claim against source lines and held their refutes with sharpened line refs (14:109 arithmetic, 14:122/131 circumstance bonus, 14:133 phantom class).
- The mechanical tier shipped before the substantive dispatch (pipeline: council -> micro-PR same day -> substantive next session).
- Run dir committed as this chapter's audit trail per the walkthrough contract.
