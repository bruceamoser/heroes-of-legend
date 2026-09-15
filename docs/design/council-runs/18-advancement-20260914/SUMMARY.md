# Council run — Heroes of Legend chapter 18, Advancement

**Run:** `~/.hermes/councils/hol-rulebook/runs/20260914-0414`
**Engine:** Synod `hol-rulebook` (7 voting members, quorum 4, max_rounds 2)
**Source:** `18-advancement.qmd` (sha256 `d48ac353…c2309`, 6230 bytes at registration)
**Outcome:** all three topics contested after round 2 → blind judge → **three sealed rulings (r-001, r-002, r-003)** → recommendation `confidence 0.82`, **chain ok**.
**Implementation:** PR #543 (chapter repair, ch18 + ch22), PR #544 (gate hardening). Merged 2026-09-15 (main `d941ca8`).
**Voters dispatched:** all 7 in round 1 (3+3+1 waves), 3 rebuttal lenses in round 2. Every rendered brief was dispatched (7/7, 3/3).

## Telemetry

| Item | Count |
|---|---|
| Findings | 10 (round 1: 7, all `refute`; round 2: 3) |
| Topics | 3, all `ruled` (no topic reached the reject quorum of 4 refutes in a terminal state; each was contested with 3 refutes and carried to the judge) |
| Rulings | 3 sealed (r-001 t-01, r-002 t-02, r-003 t-03) |
| Wall rejections | **0** — 10/10 pre-ingest prescreens clean, judge brief wall-clean on first assembly |
| Member rewrites needed | 0 |
| Ledger events | 20 (charter, problem, 3 digests, 10 findings, 3 rulings, recommendation, close) |

## Findings and disposition

| Id | Lens | Topic | Defect | Disposition |
|---|---|---|---|---|
| f-001 | game-architect | t-01 | `:93` Reveling settles its benefit in commercial language ("fund", "it costs what a night costs") after #523 removed coin | MECHANICAL — rewritten in grant vocabulary |
| f-002 | researcher | t-01 | the same defect from a canon sweep (also raised `:80`/`:97` discount-shaped rewards) | merged with f-001 (ONE defect, two signatures) |
| f-003 | contrarian | t-02 | Reveling is an automatic, uncapped reputation faucet | MECHANICAL — printed bound added |
| f-004 | author | t-03 | the gains column calls the level 3/6/9 grant a "Progression Discipline", which `08-disciplines.qmd:102-104` calls a Discipline rank; mirrored in ch22 | MECHANICAL, two files — renamed + cross-reference added |
| f-005 | editor-in-chief | t-02 | `:71` promises reputation governs "title eligibility" with no implementer in the book | MECHANICAL — promise deleted (ruling's default) |
| f-006 | layout-expert | t-01 | **the `{=typst}` fence at `:3` was never closed; the shipped PDF printed the whole chapter as its own source** | MECHANICAL — closing fence + gate hardening (PR #544) |
| f-007 | librarian | t-03 | the *Archmage* title grants an Adept card with no level floor | MECHANICAL — level 3 stated |
| f-008 | contrarian | t-03 | round-2 challenge: broke f-007's premise (a payment-framed gate) without reaching the defect | recorded; ruling r-003 rejected the premise and kept the defect |
| f-009 | researcher | t-02 | round-2 recomputation: could break neither reputation defect; tightened the crossing figure to night fourteen | recorded; corrected r-002 c1 |
| f-010 | librarian | t-03 | round-2 canon tally and disposition classification | recorded; drove the tiering of the repair |

**Dissent recorded (1):** librarian, t-03 — whether a granted card is held outright or lapses with the title; canon already models the contingent shape (item grants that end when attunement ends).

## Sealed rulings

- **r-001 (t-01)** — both defects stand: restate the Reveling benefit in grant vocabulary with no price attached; terminate the raw-Typst block. Conditions: confine the commerce repair to that sentence; do not reopen the arithmetic; accept the fence repair only on a clean rebuild showing decorated headings and both ladders as real tables; leave the award's magnitude to t-02.
- **r-002 (t-02)** — both defects stand: the carousing award cannot ship as an automatic, uncapped point and needs a **printed** bound (level link, per-arc cap, or DA assignment); close the title-eligibility promise by deletion or by naming the required standing. Conditions: any restatement of the crossing uses night fourteen, not fifteen; no repair may rest on the claim that the points are irreversible (a setback strips a whole band); the meter must be printed in the chapter; do not invent a mapping to the ch19 faction scale.
- **r-003 (t-03)** — both defects stand and are repaired narrowly in place: restate the milestone label in the rank vocabulary of the defining chapter + glossary, land it in **both** files, and add the missing cross-reference; the title example's card grant must carry its tier's level requirement; no redesign. Conditions: the granted-card lifetime needs explicit wording (not assumed); a title may not waive a card's tier floor; the chapter-local reward defects and the reputation defects remain separate matters.

## Process notes

1. **The run was scaffolded at 04:14 by an earlier session and left with no findings.** Rather than scaffold a second run and split the audit trail, the statement was corrected in place and **all seven briefs re-rendered** before any voter was dispatched. No finding was produced under the old text.
2. **The problem statement carried a stale law.** Convention 5 asserted the Iron Skin talent "carries DR 2/5/8", but it is a single-tier +2 DR card (`09-talents-abilities.qmd:45-47`) — a pre-refactor rung structure. Left in, it would have instructed the council to report a compliant single-tier card as a missing-rung defect. Corrected to the one-card law before dispatch (the trap this skill's "sync the problem statement with current canon" rule exists for).
3. **The headline defect was not in the council's scope vocabulary at all** — an unclosed fence is invisible to content greps, damage-budget checks and rung audits, and the repo's own structural gate counted openers only. It took an independent read of the chapter as a unit.
4. **The orchestrator reproduced f-006 on the artifact** (`pdftotext` on the built PDF, plus fence counts across all 26 files) rather than trusting the report, and then reproduced the gate's blindness by running the new checker against `main~1`'s content. Both reproductions are in the PR bodies.
5. **Three leads were checked and cleared rather than filed**: "a hall of your own" at `:81` is #523's own replacement for the cut stronghold promise (confirmed in that commit's diff); "skill rank" at `:103` is book-wide vocabulary (`03:57`, `07:155`); the hyphen ranges and the abbreviated `Rep` header match book convention. The librarian carried all three as its own observations and asserted nothing about them.
6. **Judge-brief wall was clean on first assembly** — the only run in the recent sequence to reach the judge without a member rewrite, which is what the pre-ingest lint exists to protect.
7. Run-dir hygiene: no stray files written by members inside the run dir; the councils root holds no litter from this run. One member wrote a scratch copy of its role card to `/tmp` (outside the run dir, harmless).
