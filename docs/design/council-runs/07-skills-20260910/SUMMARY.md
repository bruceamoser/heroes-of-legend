# Synod run 20260910-2025 - hol-rulebook, Chapter 07 Skills (Wave 2, chapter 9)

**Verdict:** REJECTED 4-3 (four un-rebutted refutes against three supports; terminal reject-majority, no judge, no impasse).
**Chain:** verify -> ok (13 events). **Wall rejections:** 0. **Prescreen:** 7/7 clean.

## Telemetry
- 7 voters, quorum 4, 1 round. All 7 briefs rendered, all 7 dispatched (3 + 3 + 1), all 7 findings ingested clean on first prescreen. Rendered-vs-dispatched reconciled: 7/7.
- Single model (config default) for all roles; decorrelation untested (Q4 caveat, machine-readable in report.md).
- Stance split: support = researcher, game-architect, editor-in-chief. Refute = layout-expert, author, contrarian, librarian.

## Why the split is real, not a consensus artifact
The three supports cleared the chapter's NUMBERS (23-row roster, six attribute keys, +1/+2/+3 bonuses at 2/4/8 DP with the L3/L7 gates, the six-rung difficulty ladder, both worked examples) - the librarian re-derived all of it independently and confirmed it. The four refutes found defect classes a numeric audit does not look for: a divergent passive key, a dropped sub-zero case, label placement, a chapter source with no true-minus glyph, and name collisions.

## Contested claims, adjudicated in-run
1. **Insight (contrarian) - CONFIRMED in substance, one citation wrong.** ch07:187 keys Insight to Reason; ch13:224, ch13:508, ch14:30, ch21:154 all derive passive Insight from Knowledge. The contrarian's ch14:111 arithmetic was itself wrong (printed 13 where Knowledge +2 + 7 = 9), and re-deriving it exposed a second ch14 defect at :121 (printed 11 where 0 + 7 = 7). Both are ch14's, and both were fixed in this run's PR.
2. **Name collisions (author) - CONFIRMED on all four sub-claims, and wider.** Parry is a ch07 skill and a ch09 weapon maneuver; Stealth/Sleight/Lore/Religion are also Discipline names; the Craft group heading duplicated the Craft skill directly beneath it; and the Knowledge/Subterfuge group headings also collide with ch08 discipline categories.

## Implementation (same day)
- PR (ch07 + ch14): TIER 1 - two section labels moved onto the line directly under their headings (book convention per ch05:497/ch08:218/ch18:112); true-minus glyphs in the three difficulty rows and two worked-example lines (tier ranges 1-8/9-14/15-18+ deliberately left as hyphens); the "Totals of Zero or Less" case restored with a pointer to @sec-chapter-core-resolution. TIER 2 - a passive-Insight sentence beside the Social table naming both keys; a roster-intro paragraph disambiguating skill names from Discipline and maneuver names; the Craft group renamed to Crafting. TIER 3 defaults - passive Insight stays Knowledge-based with the split documented (veto-able); both Parry names kept, the TIER 2 sentence carrying the distinction (veto-able).
- Cross-chapter: ch14 passive Insight arithmetic corrected at :111 and :121, with the :121 tier comparison reworded ("Standard beats Weak") because the corrected passive is Weak, not Standard.
- Build exit 0; 0 em-dashes added; 0 new damage dice; only sanctioned 3d6 references.

## Known limitations
- Single-model homogeneity (Q4).
- The librarian flagged one provenance claim as unverified (a claimed prior ch06 minus-glyph fix); it was not repeated as fact.
- The author lens's density/voice observations were NOT implemented - the same lens reported voice and consistency hold, so trimming prose is an editorial taste call, routed to decisions-pending.
