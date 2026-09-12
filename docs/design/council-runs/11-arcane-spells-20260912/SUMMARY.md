# Synod run 20260912-2020 - hol-rulebook, Chapter 11 Arcane Spells

**Verdict:** REJECTED 7-0 (seven refutes, zero supports, all seven un-rebutted; reject_quorum 4;
terminal reject-majority: `check` returned `action=recommend`, no judge, no impasse, no sealed
ruling, so `rulings_applied` is empty by construction).
**Chain:** verify -> ok (13 events). **Wall rejections:** 0. **Prescreen:** 7/7 clean first pass.

Second chapter of the 2026-09-12 run (the allowed cap of two). Chapter 10 Magic System was the first
(run 20260912-2001).

## Telemetry
- 7 voters, quorum 4, 1 round. All 7 briefs rendered, all 7 dispatched and reconciled 7/7.
- 40 cards scanned: 10 cantrips (11:31-119) and 30 growing spells (11:123-517), matching the count
  the chapter claims at 11:19. No tables and no callouts in the file, so the layout lens worked from
  the render alone (PDF pages 166-178).
- Stance split: 7 refute, 0 support. No rebuttals in the ledger.
- Single model (config default) for all roles; decorrelation untested (Q4 caveat, machine-readable
  in report.md).
- **Process note 1:** the wave-1 `delegate_task` call hit the 420 s tool timeout while all three
  members had already written their findings to disk (librarian-r1.json 11549 bytes, researcher-r1
  7388, contrarian-r1 6699). Work was recovered from disk; no re-dispatch. Same recovery as the ch09
  run on 2026-09-11.
- **Process note 2:** the problem statement, as first written, mis-stated the chapter's structure
  ("2 tables in total"). Verified before any brief was rendered that the file has zero tables and
  zero callout blocks, and corrected the statement in the working copy (run `problem.md` and the
  `/tmp` source) so every member briefed on the accurate figure. The ledger's scaffold event retains
  the original wording; the correction happened before the first `brief` render, so no member ever
  read the wrong count.

## What the council CLEARED (verified correct, not re-flagged)
- Card set and count: 40 `===` cards, 10 cantrips + 30 spells, no card missing a rung other than the
  one defect below.
- The damage spine: every Novice block on 2/4/6 except the cantrip row (1/3/5), every Adept line
  6/9/12 and every Master line 9/15/21. No damage dice anywhere (the only dice in the chapter are the
  3d6 check roll and the cantrip `d6`-free text).
- Zero em-dashes in the chapter body. Both cross-references resolve with a single trailing stop
  (11:19 to the damage budget, 11:21 back to the magic-system chapter).
- The three cross-chapter mirrors agree: ch10's spell table, ch19's card-format examples, ch20's
  bestiary spell list.
- One `{=typst}` fence, label present, callouts and tables absent so nothing can overflow or drop.

## Implemented same session (PR #485, merged 2026-09-12)
Build exit 0, native-Typst gate exit 0, 16/16 render assertions against the rebuilt PDF including
negative controls. 17 one-line repairs, ch11 only.

TIER 1 (blocking):
- **Silver Tongue had no Adept rung** (11:399) - the only one of 30 growing cards without one, so the
  4 DP / level-3 purchase bought nothing. Its Standard also lasted *shorter* than its Weak (2 turns
  vs 1 scene) and its Master dropped the Bane rather than adding to it. Adept rung added; the ladder
  made strictly additive.
- **Static Shock** (11:99) paid a bare `+1 vs. metal armor`: a flat damage rider and a numeric
  modifier at once. Restated as `+1 damage tier against metal armor` (cf. 20:176).
- **Acid Splash** (11:110) doubled itself, 5 acid + 5 more next turn = 10 on an at-will cantrip with
  no row to hold it; and (11:108) measured penetration in `hardness`, a stat occurring nowhere else
  in the manuscript. Cling kept as flavour; penetration restated as DR (cf. 16:21, 17:308).
- **Glacial Prison** (11:212) removed Restrained and substituted Frozen 2 at Master - the chapter's
  only subtract-on-upgrade - and its Adept rung silently dropped the Restrained its own Novice rungs
  impose. Both additive now.
- **Wind Wall** (11:330) printed one sentence on Weak and Standard alike, so the middle rung bought
  nothing. Standard now blocks 1 round, Strong 2 rounds plus the push (cf. 12:194 Sacred Barrier).

TIER 2 (copyedit): Force Dart's darts declared split (11:347, cf. 11:165 and 11:230); Gust's
Adept/Master rungs retaining the Prone their own Keyword line advertises (11:314); Caustic Mist's
keyword field cleaned of a qualifier (11:267); Unseen Hand's `Lift N lb` reworded off the collision
with ch13's named Lift effect (11:379); the section caption's trailing comma dropped (11:320); five
Range values capitalised against the book's convention (11:365/428/454/467/506 -- Self 21 uses,
Touch 12); and a one-sentence rounding rule for the halves the chapter prints (11:19), which were
otherwise unresolved fractions, since ch13:154 rounds only for resistance.

## Deferred, with reasons (both filed as issues the same session)
- **Issue #486** - the 30 spells sit under one flat `== Arcane Spells` heading across nine pages while
  the divine mirror splits by Discipline. A 30-block reorder plus new headings is a structural change
  that needs its own reviewable diff; burying it in a set of one-line repairs would ship a change
  nobody could audit.
- **Issue #487** - Burning Volley (p170->171), Storm Javelin (171->172) and Caustic Mist (172->173)
  have their titles stranded at a page foot, and the divine mirror does the same around p183. The
  cure is a shared card style (keep-together block), so a ch11-only patch would make the chapter
  inconsistent with the book.

## Open design questions handed back (recorded in decisions-pending.md)
1. Whether cantrip damage should be keyed to a budget row at all: the chapter prints a 1/3/5 cantrip
   scale that no rule names. Keying it to the Novice row would make free at-will cantrips strictly
   better than paid Novice spells, so the council did not "fix" it.
2. Whether a retaliation/reflect value is a fixed small number by convention, or must be derived from
   the card's own row: 11:375 `reflects 3 damage` mirrors 12:160 `takes 2 radiant damage`. Both sites
   are consistent in shape; treated as conventions, not defects, pending a ruling.
3. Whether Adept and Master rungs **add to** or **replace** the Novice block book-wide. The chapter's
   cards do both, and only the two explicit contradictions were repaired; a book-wide reconciliation
   would touch every spell card in ch11 and ch12.

## Known limitations
- Cantrip rows were flagged by five of seven members as having no home in the budget table. The
  council read that as a design gap rather than a chapter defect and did not edit the numbers.
- The near-blank page holding the section figure (p174) was considered and left: a section figure on
  its own page is a legitimate plate position, and the placeholder art is not the real art.
- Single-model run: this validates the pipeline, not model decorrelation.
