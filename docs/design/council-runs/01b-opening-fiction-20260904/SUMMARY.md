# Council run — hol-rulebook / 01b-opening-fiction / 2026-09-04 20:13

- **Chapter:** ch01b (quarto-book/chapters/01b-opening-fiction.qmd, "The Last Ember", 123 lines)
- **Charter:** hol-rulebook (core four + ga/author/eic/layout, 7 voters, quorum 4, max_rounds 2)
- **Verdict:** **REJECTED 6-1** on topic t-01 (round 1: 4 support / 3 refute, contested; round 2: 6 refute / 1 support). No impasse, no judge, 0 wall rejections, ledger chain ok (20 events).
- **Model:** local Qwen3.8-27B (config default) for all members (homogeneous run; decorrelation caveat per charter Q4).

## Findings (13 total: 7 round 1 + 6 round 2)

| id | role | round | stance | one-line |
|----|------|-------|--------|----------|
| f-001 | librarian | 1 | support | anchor defined but unreferenced (logged as note, not a local defect) |
| f-002 | contrarian | 1 | refute | Zara's identity breaks: fiction = Wind+Energy storm-caster vs ch03:158 "Shepherd of the wild gods" |
| f-003 | researcher | 1 | support | roll math, discipline idiom, anchors all check out (Zara class not named in ch02/ch13) |
| f-004 | game-architect | 1 | support | mechanics hold (rank-count idiom, tier table, class bundles) |
| f-005 | author | 1 | refute | "three Armor/Wind Disciplines" misstates terminology (3 separate Disciplines) |
| f-006 | editor-in-chief | 1 | refute | dead anchor: ch01 names the story twice in plain prose, 0 inbound links |
| f-007 | layout-expert | 1 | support | renders cleanly (PDF 28-32), no em-dashes, scene-breaks deliberate, caption accurate |
| f-008 | librarian | 2 | refute | switches to EIC framing: dead anchor is a broken cross-reference record (ch01-local fix) |
| f-009 | contrarian | 2 | refute | holds f-002, rebuts f-003/f-004 (ch03:158 is the authoritative class anchor) |
| f-010 | researcher | 2 | refute | switches: full-book re-check confirms ch03:158; rebuts f-005 (ch08 idiom); adopts f-002 |
| f-011 | game-architect | 2 | refute | switches: no class starts Wind+Energy; Shepherd bundle has no elemental; hard identity contradiction |
| f-012 | author | 2 | refute | withdraws f-005 (ch08:23 idiom); adopts f-002 (Zara) |
| f-013 | editor-in-chief | 2 | refute | holds f-006, rebuts f-005/f-010; ranks f-002 as the must-ship-before-publication gate |

## Convergence
Round 2 collapsed to **two surviving defects**:
1. **f-002 (Zara identity)** — 5 independent refutes (f-009, f-010, f-011, f-012, + librarian's f-008 framing). The fiction's consistent elemental storm-speaker (01b:21/:47/:101) conflicts with ch03:158's "Shepherd of the wild gods" (Protection+Animal, no elemental).
2. **f-006 (dead anchor)** — the anchor is defined (01b:1) but no reader-facing path links it; ch01:140/:231 name the story in bare prose.
**f-005 was WITHDRAWN** (author f-012) and independently defeated (f-010/f-011/f-013): ch08:23's own worked idiom ("A warrior with 3 Blade Disciplines", "A mage with 3 Fire Disciplines") counts ranks within one Discipline (cap 3), so the fiction's phrasing is the book's established convention. **Not an item.**

Sole support/dissent: layout-expert (f-007, presentation holds; the double anchor is the book-wide pattern).

## Disposition (librarian synthesis, conf 0.85)
- **TIER 1 mechanical (shipped in PR #394):** convert ch01's two plain-prose mentions (01-introduction.qmd:140, :231) into live @sec-chapter-opening-fiction crossrefs; story file untouched.
- **TIER 3 design-flavored (shipped in PR #394 as implemented default, veto to revert, logged as decision #74):** name Zara's class in-fiction at her first action (01b:21) as an **Unbalanced** (the only class whose profile fits Wind+Energy: opposing-elemental pair, Energy Home 1/2/4 per ch05:349-363), and conform the ch03 example (03-attributes.qmd:158, :162) to the Unbalanced while keeping its Reason+Religion roll intact (Religion is a lawful Foreign skill for an Unbalanced). Routed for Bruce's veto (canon identity decision).
- **f-005 withdrawn, no action.**

## New book-wide finding (logged as decision #75, NOT fixed)
The first live crossrefs into this chapter surfaced a **systematic off-by-one in every rendered chapter crossref**: the front-matter title chapter (index.qmd, TOC "Chapter 1: Heroes of Legend") is counted in the TOC/heading numbering but not in the Typst crossref counter, so all 78+ @sec-chapter-* links render one chapter number lower than the printed TOC (verified against 8 anchors + confirmed present in the pre-ch01b build). Book-wide convention decision (same family as #71) routed to Bruce: (a) unnumber the front matter so the crossref counter aligns with the TOC, or (b) renumber the TOC/heading to match the crossrefs. The two new links are correct relative to the book's existing 78 and do not worsen the offset.

## Wall / process notes
- Pre-ingest wall lint (prescreen.py) run before every round's ingest: **0 leaks** across all 13 findings.
- All 7 round-1 briefs rendered and all 7 dispatched (reconciled, no missing voter). Round 2: all 6 remaining voters dispatched in 2 waves of 3 (layout-expert's round-1 stance carried as latest position, consistent with a support that did not change).
- delegate_task batches hit the 420s client timeout repeatedly but the subagents continued in the background; findings were polled on disk and reconciled against the ledger before ingest (no lost or stale finding).
- One schema fault at `close`: the librarian's `resolved` array used strings where the engine requires {topic, outcome} objects. Fixed mechanically (string → object split on ": "), re-validated, closed clean. Engine behavior was correct (exit 4, schema).
