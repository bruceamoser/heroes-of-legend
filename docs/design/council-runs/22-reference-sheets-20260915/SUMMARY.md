# Council run — Heroes of Legend chapter 22, Quick Reference Sheets

**Run:** `~/.hermes/councils/hol-rulebook/runs/20260915-0226`
**Engine:** Synod `hol-rulebook` (7 voting members, quorum 4, max_rounds 2)
**Source:** `22-reference-sheets.qmd` (472 lines, 18,851 bytes, sha256 `f0340ce97f45062d…` as registered)
**Outcome:** t-02 closed **rejected** on four refutes (terminal, no ruling). t-01 and t-03 reached the round cap and were ruled by a blind judge, sealing **r-001** and **r-002**. Recommendation confidence 0.88, `chain: ok`, 18 ledger events.
**Implementation:** PR #550 (merged, main `20fa15e`) — 2 files, 7 replacements. Page count **387 → 386**.

## Telemetry

| Item | Count |
|---|---|
| Findings | 9 (round 1: 6, round 2: 3) |
| Topics | 3 — t-02 rejected on 4 refutes (reject quorum 4, terminal); t-01 and t-03 contested to the cap, ruled by r-001/r-002 |
| Rulings | 2 sealed (r-001 t-01, r-002 t-03) |
| Wall rejections | **0** — 9/9 pre-ingest prescreens clean, judge brief wall-clean on first assembly |
| Member rewrites needed | 0 |
| Ledger events | 18 |
| Voters dispatched | all 7 in round 1 (3+3+1 waves); 3 rebuttal lenses in round 2 |

**Why this chapter matters more than its size.** A reference sheet owns no mechanic: every row restates a rule belonging to another chapter. That makes it the highest-risk file in the book and the place a superseded rule survives longest. It was last reviewed on 2026-09-01, before the band renumber (#532), the card refactor (#537/#538), the hero-DR ruling and the Challenge ruling.

## Findings and disposition

| Id | Lens | Topic | Defect | Disposition |
|---|---|---|---|---|
| f-001 | game-architect | t-01 | `22:194`'s Parry row says a shield "gives DR", against the same file's `:365`/`:398` | MECHANICAL (r-001) — clause deleted |
| f-002 | researcher | t-02 | the same row, filed independently with the wave's comparison tallies | corroborated f-001 |
| f-003 | editor-in-chief | t-03 | Grit is absent from the whole lookup surface though `:79` charges uses against it | MECHANICAL (r-002) — gate restored at `:147-158` |
| f-004 | author | t-02 | `22:93` Asleep X drifted from its owner in both cells | MECHANICAL — mirrors `13:192` |
| f-005 | layout-expert | t-03 | folio 365 prints content-free (fill −4.6%, 4 words) | MECHANICAL (r-002) — the break at `:118` deleted |
| f-006 | contrarian | t-02 | the INVERSE direction: ch22's budget block is correct while the owners carry retired numbers | routes to #546, not to this chapter |
| f-007 | researcher | t-03 | rebuilt the book twice and reproduced the blank folio independently; each table measured | corroborated f-005 with the causal measurement |
| f-008 | librarian | t-02 | `22:107` Marked is the SECOND drifted conditions row, one cell not two | MECHANICAL — effect cell restored, Ends untouched |
| f-009 | contrarian | t-01 | the shield-DR count is one too low: a second carrier exists at `20-bestiary:116` | MECHANICAL (r-001) — folded into the authored DR total |

**Dissent recorded: 2** (verbatim in the recommendation): f-002's minority position on the mirror-scope reading, and f-005's on the page-count bookkeeping.

## Sealed rulings

- **r-001 (t-01)** — the Parry-row claim is established and the repair must NOT be scoped as a single-site deletion. C1: the site list must be re-derived from a whole-book search and the count restated. C2: on this sheet the clause is deleted; in a bestiary stat block the value is folded into the creature's authored DR total or removed with its line, never blind-deleted. C3: the rest of the chapter is not reopened on this topic except to confirm no third carrier.
- **r-002 (t-03)** — both defects stand. C1: the omitted resource's tier values and spend procedure are restored, together with the dropped derived-stat line. C2: the baseline is the corrected page count and chapter span, and the repair is accepted only after a clean rebuild shows the affected folio content-filled and the count reduced. C3: the folio repair is a one-line change and the chapter's surviving rows must be verified intact.

## Verification

- native-Typst gate `OK - 26 files` (exit 0); build exit 0
- **r-002 C2 acceptance met exactly:** page count 387 → 386, folio 365 fill **−4.6% → 98.6%** (4 → 140 words)
- **r-002 C3 intactness:** 23 tables re-checked structurally (columns/align/header/cells), all 23 condition names present in the render
- render assertions (`pdftotext`; positive control "Always Hit" = 8; dump 492,911 bytes): `Unaware for X minutes` 3, `Always by a specific creature` 2, `chain shirt and a shield` 1, the Grit paragraph 1, the derived-stat line 1; `Shield: +1 DR` 0, `Speed, Carry Slots` 0
- the one surviving `gives DR` in the PDF is a ch06 worked example about leather armour, not a shield
- 0 em-dashes in added lines; 0 doubled crossref periods
- clean members carried on the record: 23/23 tables structurally sound, 5/5 `@sec-` refs resolve, 23/23 skill attribute keys match, armour DR and Slots columns sound, 23/23 condition counts, level progression 32 DP verified, damage bands sound

## Process notes

1. **The judge's conditions did the load-bearing work.** r-001 C1 forbade inheriting the finding's instance count, and the re-derived search found a SECOND carrier (`20-bestiary:116`) that the mirror-scoped count could not see; r-001 C2 then required a different repair shape for the stat-block instance (fold, never delete), which a single-site fix would have got wrong in the opposite direction.
2. **The contrarian's inverse-direction finding is what kept chapter 22 out of an owner-side repair.** f-006 showed the sheet's own budget block is the CORRECT mirror while `08:222`, `11:171-175`, `13:510` and `20:144` carry the retired numbers — so the four sites the librarian's plan proposed to fix here are owner-side, already scoped by open issue #546, and part of a ~25-site class. Repairing four of them would have half-converted the class, which the book's own sweep law calls worse than not converting. Routed to #546 with the council's reproduction as evidence; no ledger finding was dropped.
3. **A withheld observation became a ledger finding, again.** The author filed the Asleep drift and deliberately withheld the second conditions row; it was handed to a lens that had not yet been dispatched (round 2's librarian), which reproduced it and filed f-008. Both conditions rows were repaired in the same commit as the folio fix because the table has under one line of slack — the layout lens measured that, and the atomicity note is the reason the blank folio does not return.
4. **A render claim was reproduced before it was trusted.** f-005 rested on a measurement rather than a source reading, so round 2 aimed the researcher at rebuilding the book independently; both measurements agreed on −4.6% and the cause, and the judge's t-03 bookkeeping condition resolved the only disagreement (an earlier page-count figure taken from a text dump).
5. **Eleven verified-but-unclaimed items were carried as RESERVED rather than dropped or silently implemented**, because each needs a scope or owner decision: the missing cantrip price row, truncated example cells, knight/hero DR inconsistencies in three chapters, a *Marked* name collision at `13:389`, the British/American spelling split in ch15, and a stale comment in `style.typ:295`. All are labelled ORCHESTRATOR-VERIFIED in the recommendation so nothing is attributed to the council that the council did not find.
6. Recovered file hygiene: no stray files inside the run dir; the councils root carries no litter. Members wrote scratch scripts to `/tmp` (outside the run dir, harmless).
