# Synod run 20260910-2003 — hol-rulebook, Chapter 06 Core Resolution Mechanics (Wave 2, chapter 8)

**Verdict:** REJECTED 7-0 (seven un-rebutted refutes, terminal reject-majority; no judge, no impasse).
**Chain:** verify → ok (13 events). **Wall rejections:** 0. **Pre-ingest lint catches:** 0.

## Telemetry
- 7 voters, quorum 4, 1 round. All 7 briefs rendered; all 7 dispatched (3 + 3 + 1) and reconciled against
  the rendered packet list before closing the round. All 7 findings clean on first prescreen.
- Single model (config default) for all roles; decorrelation untested (Q4 caveat, machine-readable in report.md).
- Concluded 2026-09-10 16:2x local. Close: 0 sealed rulings, `rulings_applied: []`, no dissent (unanimous).

## Disposition implemented (PRs #456, #457 — merged)

**TIER 1 (mechanical, ch06):** bullets restored (5 `+` → `-`); the collapsed `#enum` block split into three
numbered formulas; minus glyphs restored (U+2212); goblin defense arithmetic restored its intermediate step
("4, 3, 5 = 12, then adds +1 = 13"); greataxe sentence no longer contradicts its own DR result; `Sleight of
Hand` → `Thievery` (ch07 keys lock work to Thievery); `Makeva the Odd` → `Makeva Quickfoot, the Odd`;
doubled reference period dropped.

**TIER 2 (substantive):** Knight worked example corrected to canon — ch20's Knight (Challenge 3) longsword is
`6/9/12`, so Strong is **12**, not 5; leather 12−2=10, plate 12−6=6. Fumble table completed: Friendly Fire
names its damage source, Off Balance converts to "the next Defense Roll you make has a Bane" (the NPC never
rolls), Gear Damage drops the undefined "degrades one step" ladder and denies armor degradation. Fumble
prose reconciled with always-hit (a fumbled *attack* still connects for Weak damage; the complication stacks).
Coverage added: hero-vs-hero / no-hero resolution line, a Critical-and-Fumble-on-Defense sentence, an
opposed-roll example, and a Boon/Bane example. `13-combat.qmd`'s duplicated Defense Roll formulas + outcome
table removed (ch06 is canonical; the two copies had already drifted).

**TIER 3 (implemented defaults, veto-able — logged in decisions-pending):** Critical d6=1 no longer doubles
past the damage cap (one budget row higher, never above 21); "Challenge" disambiguated (a stat block's positive
rating is the negative penalty on your roll).

**BOOK-WIDE (scope ruling from the layout lens):** two migration regressions fixed across 16 files —
`#enum(numbering: "1.")[...]` blocks collapsed by the Typst conversion (5 files), and every markdown bullet
list rendered numbered (189 lines). 21 doubled reference periods → 0.

## Open items routed out (not ch06-local)
- **#75 crossref chapter numbers re-confirmed:** the ch06 run's EIC independently re-derived it (all 78+
  `@sec-chapter-*` links render one lower than the TOC's own chapter numbering). Needs Bruce. NOT shipped —
  book-wide render/theme issue, no safe per-chapter fix.
- **Author lens's density finding (TIER 2g, cut/fold two of three "rationale" blocks) — NOT implemented.**
  The same lens reported voice and consistency hold; trimming prose is an editorial taste call, not a defect.
  Left for Bruce rather than guessed.
- Theme wart (new, minor): a section reference carries its own terminal period, so a mid-sentence reference
  renders "…in Chapter 9. for the full rules."

## Known limitations
- Single-model homogeneity (Q4).
- `docs/design/decisions-pending.md` #77 is closed by this run (third direction: drop the author's period,
  since the reference supplies its own).
