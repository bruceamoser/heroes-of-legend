# Council run — Heroes of Legend chapter 21, Glossary

**Run:** `~/.hermes/councils/hol-rulebook/runs/20260915-0158`
**Engine:** Synod `hol-rulebook` (7 voting members, quorum 4, max_rounds 2)
**Source:** `21-glossary.qmd` (238 lines, 16,111 bytes, sha256 `71cfa2b9cf2bfd50…` as registered)
**Outcome:** t-03 closed **rejected** on four refutes (terminal, no ruling). t-01 and t-02 reached the round cap and were ruled by a blind judge, sealing **r-001** and **r-002**. Recommendation confidence 0.85, `chain: ok`, 19 ledger events.
**Implementation:** PR #549 (merged, main `a040906`) — 7 files, 28 replacements. Chapter file 238 → 250 lines.
**Recovered:** the immediately preceding run's record commit (`e9749dd`, the 19-gm-guidance trail) was found UNPUSHED on local main and is pushed with this commit; `origin/main` had only the Wave-1 `19-gm-guidance-20260831` directory.

## Telemetry

| Item | Count |
|---|---|
| Findings | 9 (round 1: 6, round 2: 3) |
| Topics | 3 — t-03 rejected on 4 refutes (reject quorum 4, terminal); t-01 and t-02 contested to the cap, ruled by r-001/r-002 |
| Rulings | 2 sealed (r-001 t-01, r-002 t-02) |
| Wall rejections | **0** — 9/9 pre-ingest prescreens clean, judge brief wall-clean on first assembly |
| Member rewrites needed | 0 |
| Ledger events | 19 |
| Voters dispatched | all 7 in round 1 (3+3+1 waves); 3 rebuttal lenses in round 2 |

## Findings and disposition

| Id | Lens | Topic | Defect | Disposition |
|---|---|---|---|---|
| f-001 | game-architect | t-01 | `21:115` defines DR as armour-only with a flat cap of 3; contradicts `16:25`, `09:48` and the book's own worked totals | MECHANICAL (r-001) — entry rewritten; the class re-derived to six carriers, all fixed |
| f-002 | researcher | t-02 | `21:47` and `08:230` print attribute-scaled Adept 3/6/9 and Master 6/12/18, the RETIRED rows minus three | MECHANICAL (r-002) — both sites re-derived to 2/5/8 and 4/7/11 |
| f-003 | contrarian | t-03 | the Boon and Bane entries define only step one of the counted ladder owned by `06:59-65` | MECHANICAL — the steps and the cancellation rule added |
| f-004 | author | t-01 | `21:221` invents the compound label *Challenge Rating (Challenge)* for the party-level measure | MECHANICAL (r-001) — retitled to *Challenge* with the penalty sense; the party-level measure left to `20:650` |
| f-005 | editor-in-chief | t-03 | the chapter's own coverage promise fails on `respite`, `Concealment` and cantrips | MECHANICAL — three entries added |
| f-006 | layout-expert | t-03 | conditions printed in two conflicting shapes with nothing governing; union 23 = Table 13.3, so structural | MECHANICAL — roster completed to 23, the `X` explained, Table 13.3 named |
| f-007 | researcher | t-02 | `21:67` enumerates 23 Disciplines; the owning roster carries 24 | MECHANICAL (r-002) — Fate added at `21:67` and the `22:234` mirror; the orphan-member question RESERVED |
| f-008 | contrarian | t-03 | the seven weapon-property entries render as ONE paragraph (reproduced in the built PDF) | MECHANICAL — blank lines inserted; same run fixed at `06:83-85` (source probe 1 → 7) |
| f-009 | librarian | t-03 | Concentration defined twice, `21:145` and `21:205`, diverging wording, neither carrying the check's difficulty | MECHANICAL — Magic Terms owns it with `10:103`'s difficulty; Combat Terms points there |

**Dissent recorded: 0.** No minority position survived to the synthesis.

## Sealed rulings

- **r-001 (t-01)** — the glossary is defective against its owning chapters: rewrite the DR entry to stack armour with talent bonuses under a banded ceiling rather than a constant of three, and retitle the invented compound label to the book's locked resolution term, giving it that term's penalty sense while returning the party-level monster measure to the chapter that already names it.
  - C1: the repair must reach the owning chapter and EVERY mirror, and must not treat the finding's sites as the complete list.
  - C2: the resolution term's canonical sense is the core-resolution chapter's; the party-level measure stays with its own chapter.
  - C3: any enumeration of affected sites must be re-derived from the files, not inherited from the challenged count.
- **r-002 (t-02)** — the printed upper-tier bases are stale and must be replaced with 2/5/8 (Adept) and 4/7/11 (Master), the lowest band's floor retained as the named exception, applied at BOTH sites; and the Discipline entry must mirror its owning chapter's roster.
  - C1: the corrected triples must be keyed to the owning chapter's current table.
  - C2: the roster repair must be repeated in the mirrors carrying the truncated list.
  - C3: the question of whether the book should ship a Discipline no class table prices or sells is RESERVED to the owning chapter, the class cost tables and the card library, and must NOT be settled here.

## Verification

- native-Typst gate `OK - 26 files` (exit 0); build exit 0, **387 pages** (was 386)
- render assertions on the rebuilt PDF (`pdftotext`; positive control "Always Hit" = 8; dump 492,403 bytes):
  - present: the stacking clause, the banded ceiling (2 hits), `Esoteric (Mind, Summon, Fate)`, `2/5/8 and 4/7/11` (2), `Unaware for X minutes` (2), the retitled *Challenge* gloss
  - absent: `Nothing else adds to it`, `never exceeds 3`, `from your armor alone`, `3/6/9 and 6/12/18`, `Stealth vs passive Insight`
  - all seven weapon-property entries on their own rendered line
  - doubled crossref periods (`Chapter N..`): **0**
- 0 em-dashes in added lines; file set chapters-only; `docs/design/` untouched by the code change

## Process notes

1. **The orchestrator's own pre-audit found four of the nine defects before dispatch** (the DR entry, the attribute-scaled pair, the missing Discipline member, the condition-list structure) and cleared nineteen suspects as sound, including two it had listed as leads that the lenses then REFUTED on the record (an armour speed penalty that does not exist in the current book, and a condition-coverage count that checked out). Both refutations are results and are carried in the summary above rather than quietly dropped.
2. **The council's disposition was executed in full, including all five t-03 items whose topic was rejected and therefore ruled on by nobody.** A rejected topic is the council agreeing the chapter fails that proposition; reading it as "no decision, nothing to do" would have dropped five real repairs, and the precedent (ch19) shows the same trap.
3. **A ruling condition changed the work.** r-001 C3 forbade inheriting the finding's site count, and re-deriving it from the files found SIX carriers of the retired DR law, not the three the finding named, plus two correct sites (`13:98`, `06:108`) that a blind sweep would have corrupted. The judge's condition is what produced the correct blast radius.
4. **A withdrawn observation became a ledger finding.** The layout lens reported but did not file the fused weapon-property run; it was handed to a lens that had not yet been dispatched (round 2's contrarian), which reproduced it in the built PDF and filed it as f-008. Orchestrator-found items that no lens claimed (Asleep, Shield Block, Surprise, the focus requirement) are implemented and disclosed in the PR body as orchestrator-verified, never passed off as council findings.
5. **A stance field was filed inverted and is corrected in the synthesis, not in the ledger.** f-002 recorded `support` while every other defect-asserting finding recorded `refute`, so the engine booked one spurious support on t-02. The chain forbids an edit and a re-ingested duplicate is not a repair, so the correction is carried in the Stage-4 brief as ORCHESTRATOR-VERIFIED and disclosed here. The defect itself was upheld; only the tally was affected.
6. **One item was deliberately NOT fixed.** `20:146` prints Brimstone Burst on the Novice row while `08:243` makes it an Adept card, and the card itself (`11:179-185`) prints the same stale row. That is the subject of the still-open issue #546; fixing only the bestiary mirror would break the mirror while leaving the card wrong.
7. Recovered file hygiene: no stray files inside the run dir; the councils root carries no litter; a member wrote a validation scratch file to `/tmp` (outside the run dir, harmless).
