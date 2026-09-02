# Council Run — ch23 (License), 2026-09-02

- **Council:** hol-rulebook (Synod engine, 7 voters, quorum 4)
- **Run dir:** `~/.hermes/councils/hol-rulebook/runs/20260902-2006`
- **Source:** `quarto-book/chapters/23-license.qmd` (label `23-license`, 108 lines)
- **Verdict:** t-01 **REJECTED 7-0** (all seven voters refute, 0 supports, 0 rebuttals, 0 sealed rulings). Single round (round 1 hit reject quorum 4; terminal, no judge).
- **Confidence:** 0.95 (librarian).
- **Wall rejections:** 0. All 7 findings passed the pre-ingest wall lint clean on first screen; no `judge-brief` wall rejections (no judge needed).
- **Ledger:** 13 events, `verify` chain ok.

## Findings (round 1)
| id | role | stance | conf | headline |
|----|------|--------|------|----------|
| f-001 | librarian | refute | 0.85 | contact [TBD] placeholder; PI class list omits 9th class; (2 sub-claims later corrected by verification: no "Additional Material" section in OGL, and no tier-label mismatch) |
| f-002 | contrarian | refute | 0.80 | hostile-licensee stress test: 8-of-9 class gap, OGC lacks the OGL §2 "only be Used under this License" notice, bestiary inclusion/exclusion boundary, contact TBD; voice descriptors tested and found present |
| f-003 | researcher | refute | 0.92 | OGL 1.0a version + SRD attribution + all named exemplars + chapter scope all verified correct; the one factual defect is the 8-name PI class list missing Shadow |
| f-004 | game-architect | refute | 0.95 | PI class list names 8 of the 9 locked classes, dropping Shadow; OGC declaration otherwise matches the actual mechanics |
| f-005 | author | refute | 0.85 | PI class list drops Shadow; "Battle-Scarred Mentor" voice label anchored only in a design doc, not a published chapter; names otherwise consistent |
| f-006 | editor-in-chief | refute | 0.86 | not publishable: PI class list omits Shadow, contact [TBD] unresolvable, opener art still a placeholder; structure + cross-refs otherwise sound |
| f-007 | layout-expert | refute | 0.90 | back-to-back pagebreaks (lines 11+13) produce a wholly blank page (verified in built PDF, printed p.369); caption leaks file-level build instruction; em-dash law satisfied, OGL bold run-in labels are a deliberate verbatim-legal convention |

## Process notes
- **Verify-before-trust corrections (orchestrator, source of record):** two of the librarian's round-1 sub-claims were dropped after independent verification against the actual book and OGL 1.0a text: (a) the OGL 1.0a has no "Additional Material" section, so the book's copyright line correctly sits inside the COPYRIGHT NOTICE per section 6 (line 29); (b) the OGC declaration's tier labels "Weak/Standard/Strong" match the core-resolution chapter (ch06:29-31), so there is no tier-naming mismatch. The voice-descriptor claim was split: "Veteran Adventurer" is in the published book (ch10:108); "Battle-Scarred Mentor" is in the tracked design doc `.github/issues/fix-105-authorial-voice.md` only.
- **Disposition tiers:** 2 Tier-1 chapter-local mechanical (blank sheet from double pagebreak; Shadow missing from PI class list) + 3 Tier-3 design/legal defaults (OGC §2 license-only-use notice; keep both voice descriptors; book-wide caption convention) + 1 genuinely blocked (contact address, no address exists in the repo). All implementable items shipped same session; design items logged in `decisions-pending.md` as implemented defaults (veto to revert); the contact item is blocked pending Bruce.
- **Atomicity:** all three chapter-local edits (pagebreak, Shadow, OGC notice) are in `23-license.qmd` and shipped as ONE PR.
- **Not actionable (book-wide draft state):** the EIC's "opener art is a placeholder" item is true of every chapter in this v0.1.0 draft build (final art TBD book-wide); it is not a ch23-local fix and requires the final art, which is out of scope.
