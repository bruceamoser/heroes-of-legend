# Synod run 20260912-2001 - hol-rulebook, Chapter 10 Magic System

**Verdict:** REJECTED 7-0 (seven refutes, zero supports, all seven un-rebutted; reject_quorum 4;
terminal reject-majority: `check` returned `action=recommend`, no judge convened, no impasse, no
ruling sealed).
**Chain:** `verify` -> ok (13 events). **Wall rejections:** 0. **Prescreen:** 1 leak caught
pre-ingest, 0 at judge-brief (no judge was needed).

## Telemetry
- 7 voters, quorum 4, 1 round. All 7 briefs rendered, all 7 dispatched (3 + 3 + 1) and reconciled
  7/7 against `briefs/round-01/`.
- Single model (config default, Qwen) for all roles; decorrelation untested (Q4 caveat,
  machine-readable in `report.md`).
- Stance split: 7 refute, 0 support. No rebuttals in the ledger.
- **Pre-ingest lint earned its keep.** The researcher filed 13 evidence items; item 11's `claim`
  carried a >=10-word run shared with the problem statement ("the book's global figure offset
  ch08 prints 10.1"). Caught by `prescreen.py` BEFORE ingest, at a cost of one 21 s member
  re-dispatch rewriting that single field. The same leak found at `judge-brief` would have been
  fatal (the ledger is append-only) and would have forced a whole-council re-run. No member
  finding was hand-edited by the orchestrator.
- Chapter is 138 lines / ~9.9 KB: 1 H1, 7 H2, 0 H3, 2 tables, 0 `@`-tokens before this pass
  (the chapter had no outbound cross-references at all), 1 typst fence.

## What the council found
Unanimously verified CLEAN: the flat 2/4/8 DP costs, the 1/2/3 Discipline ladder, the L3/L7 gates,
the three budget rows themselves, the worked roll (12 + 2 + 1 = 15, Strong), the arcane/divine
attribute split (Knowledge / Reason, matching 03:160 and 21:181), zero damage dice, zero
em-dashes, one typst fence, every table `outlined: false`, and the `_Figure 12.1_` caption as the
book-wide figure-number offset (ch08 prints 10.1, ch09 11.1) rather than a ch10 defect.

Verified BROKEN, in three clusters:

1. **A canon contradiction carried by a worked example.** The chapter taught a spell one way and
   the card shipped another: `10:133` gave an **Adept** Brimstone Burst a 15-point centre bonus
   ("twelve damage each, fifteen for those near the center"). 15 is the Master Strong row; the
   Adept row is 6/9/12; the source-of-record card (`11:143`), its GM mirror (`19:571`) and the
   bestiary list (`20:146`) all print a flat 12. This is the same off-row centre rider the
   ch11/ch19 sweep had already stripped from the card and its mirror, surviving in the framework
   chapter that cites it as the teaching example.
2. **Two absolutes that outlawed the book's own shipped rules.** `10:65` "There are no wildcard
   Discipline substitutions" made the Odd's **class signature** illegal (`05:287`, `02:301`,
   `21:81`, and actually played at `13:498`); `10:29` "no concentration roll" contradicted the
   Fortitude maintenance check 86 lines below in the same file.
3. **Unstated rules where the chapter is the only home for them.** The cost to raise a card, the
   precedence between the per-encounter and per-session limits, the concentration target, and the
   question of whether cantrips roll at all. Plus an incomplete tradition roster (Mind and Plants
   both ship: `11:391`, `11:280`, `12:330`) and a notation clash on the Master prereq cell.

## Implemented same session
**PR #483 (merged, `quarto-book/chapters/10-magic-system.qmd` only, 20 insertions / 18 deletions,
build exit 0, native-Typst gate exit 0, 18/18 render assertions against the rebuilt PDF, 0
em-dashes in added lines, 0 damage dice):** the off-row centre bonus removed and the unit unified
to "20-ft" (M1); the Eccentric Spellcasting carve-out added at `10:65` and the restated level
gates cut (M2); the concentration absolute scoped to the casting roll (M3); `3 Fire` in the
Master prereq cell per `08:208` (M4); Mind added to the arcane list and Plants to both, with
Plants named as the shared Discipline (M5); the Master per-session cap declared the tighter limit
(M6); the concentration procedure completed, Standard or better on 3d6 + Fortitude, repeated on
damage (M7); the raise-cost rule stated (M8, default); cantrips declared free and resolving on the
one roll (M9/M10, defaults); first outbound cross-references added, phrased so the engine's own
trailing stop is not doubled (M11); the opener and the Limitations callout de-duplicated against
`01:210`, `01:212` and `05:184` (M12); and the spell-table columns rebalanced
`12.96/11.11/27.78/48.15 -> 26/11/24/39`, which stopped the built PDF hyphenating a card name
mid-word (`Ember Lance (Mas-` / `ter rank)` on p161).

**PR #484 (merged, `01`, `02`, `08`, `19`, build exit 0, 11/11 render assertions):** cantrip
pricing reconciled across six chapters (`08:214`, `02:145`, `19:604` priced no-prereq basics
INCLUDING cantrips at 2 DP while `10:89`, `11:27`, `12:27` grant them free; ten cantrips per
tradition at 2 DP is 20 DP against a ~52 DP career budget and no printed template buys one); the
false wildcard absolute at `08:265`; and `01:223`, the last book-wide survivor of the #480
cross-reference punctuation law, which printed `Chapter 10., then dig into`.

## Orchestrator verification (verify-before-trust)
- Every council claim was re-derived from the file before implementation: the three Brimstone
  cross-references, the Odd's signature in four chapters, `08:208`'s notation, the three
  Plants/Mind cards, the cantrip counts against the templates, and the ch08/02/19 price lines.
- **Two of the council's render claims were checked against the built PDF rather than the source,
  which is where the layout claim was confirmed:** `pdftotext -f 161` shows the mid-word
  hyphenation and the pre-fix column percentages, and the post-fix render no longer hyphenates.
- **My own audit script produced three false failures**, all resolved by re-reading the artifact:
  (a) the cantrip-roll sentence WAS present and only failed an ASCII-vs-typographic apostrophe
  match; (b) "sorry, I used my good spell already" and (c) "three times before lunch" each still
  appear once in the PDF because `01:210`/`01:212` own them. Counting occurrences (2 -> 1) proved
  the de-duplication instead of the fragment-presence test.
- **My first two cross-reference phrasings were wrong and the render caught it.** `@sec-*` renders
  its own trailing stop, so `"...lives in @sec-chapter-disciplines, and..."` printed
  `Chapter 10., and`. Rebuilt and re-verified after restructuring both to the book's established
  "See Chapter N. for X" form.
- Deliberately NOT changed: the `_Figure 12.1_` caption (book-wide offset convention), the
  8 `#pagebreak()`s and the resulting half-empty pages (book-wide per-H2 convention), the
  "That's"-verdict closers (Tier 3 voice polish, not a defect), and the researcher's
  Intellect sub-claim (dismissed with evidence, recorded in decisions-pending #105).

## Process notes
- Wave order 3 + 3 + 1 with a single member re-dispatch folded into wave 2; all 7 findings landed
  on disk before any ingest, so the lint gate ran once over the full set.
- The two render defects in the orchestrator's OWN first draft were found only because the ruling
  was verified in the rebuilt PDF rather than in the source diff, which is exactly the rule the
  skill states. Source-clean and render-broken is a real category.
- Run dir committed as `docs/design/council-runs/10-magic-system-20260912/` with the members'
  findings, all seven briefs, the problem statement, the recommendation and the ledger.

## Trailing
- Ch.10 is now the 12th of 25 Wave-2 chapters. Next pending: `11-arcane-spells`.
- Open mechanics rulings that block implementation: decisions-pending #103 (multi-rank maneuver
  base row, BLOCKED - do not let an agent fix it) and #104 (Weapon Focus multi-step tier bumps).
