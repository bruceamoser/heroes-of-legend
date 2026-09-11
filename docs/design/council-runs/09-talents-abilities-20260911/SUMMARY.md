# Synod run 20260911-2024 - hol-rulebook, Chapter 09 Talents & Abilities

**Verdict:** REJECTED 7-0 (seven refutes, zero supports, all seven un-rebutted; reject_quorum 4;
terminal reject-majority, no judge, no impasse).
**Chain:** verify -> ok (13 events). **Wall rejections:** 0. **Prescreen:** 7/7 clean first pass.

## Telemetry
- 7 voters, quorum 4, 1 round. All 7 briefs rendered, all 7 dispatched (3 + 3 + 1) and reconciled
  7/7. 42 cards audited by a source parser (21 talents, 4 basic attacks, 17 weapon maneuvers).
- Single model (config default) for all roles; decorrelation untested (Q4 caveat, machine-readable
  in report.md).
- Stance split: 7 refute, 0 support. No rebuttals in the ledger.
- Process note: the wave-A dispatch tool call timed out at 420 s while all three members had
  already written their findings to disk; work was recovered from disk, no re-dispatch needed.
  One member-id collision (librarian and contrarian both emitted `f-002` because the dispatch
  prompt carried the wrong id literal) was fixed by rewriting the single metadata field on the
  librarian's finding to `f-001`; no finding content was hand-edited.

## What the council found
Verified CORRECT: the 21-talent roster, the 4 basic attacks (1/2/3 and the 1/1/2 unarmed floor,
one-roll principle), the +1-damage-tier substitution and its use on Power Strike / Pinpoint Strike /
Death Blow / Dangerous Gambit / Charge, no damage dice anywhere, zero em-dashes, every @sec
reference resolving, and the seal/glossary condition vocabulary.

Implemented same session (PR #482, build exit 0, native-Typst gate exit 0, all render-verified):
- The talent definition was false about the chapter's own cards: 09:13 said talents are passive and
  always on, while 7 of 21 carry an Action (Reaction/Action/Maneuver/Free). Definition widened;
  ch21:85's glossary entry mirrored (it also named Fortune's Favor as its example, which is a
  Reaction talent).
- Combat Reflexes' Adept tier granted "+1 Initiative", the ONLY numeric roll modifier left in the
  book (and a conversion this chapter's own cards had already made for rolls). Converted to a Boon
  on the Initiative roll, and its Master tier was made a strict superset of Adept per the passive
  card law (#357).
- Death Blow's Master tier dropped the Adept tier's adjacent splash, breaking the superset law.
  The lower tier's benefit now carries forward.
- 09:301 claimed every maneuver is gated by weapon Disciplines; Shield Slam requires Armor and
  Renewal requires Protection. Corrected.
- Renewal was the only card in the book carrying a frequency inside its Action field
  ("Maneuver, once per scene"); moved into the body like every other limited card.
- Miracle Worker's Novice frequency trailed its effect while its own Adept line leads with it.

## Blocked, not implemented (logged in decisions-pending #103, #104)
- **#103 The maneuver base-row model.** The researcher found five damaging maneuvers printing a row
  BELOW their tier; the game-architect read the same rows as correct. Adjudicated in synthesis on
  canon: ch08:227-230 keys Damage to Discipline Requirement ("the table is the law"), ch08:208 makes
  a 2-rank card Adept, ch08:122 lists Shield Slam itself as the Adept example, and every one of
  ch11/ch12's 2-rank cards prints 6/9/12 as its base (Brimstone Burst, Caustic Mist, Pillar of
  Light, Restoration, Touch of the Grave and 8 more) while every 1-rank card prints 2. Under that
  reading Riposte, Parry and Brace owe 6/9/12, Shield Slam owes 6/9/12 (not 1/2/3) and Cyclone owes
  9/15/21. Counter-evidence: ch09:15 describes the base block as "the Novice effect" for every
  active card. Cyclone (3 ranks) cannot be fixed by the ch11 pattern at all, because its own Adept
  line would then sit BELOW its base, which makes this a card-format decision, not a number tweak.
  Recommended default recorded; needs one word from Bruce.
- **#104 Weapon Focus' "+2 / +3 damage tiers".** These are the only multi-step tier bumps in the
  book (every other site, in 6 chapters, is "+1 damage tier"). The council's suggested mechanical
  fix is not executable: restating Adept as "+1 tier" would make it identical to Novice and leave a
  dead tier, so the ladder's Adept/Master rungs need a designer's intent.
- **Card page-flow (layout lens): VERIFIED-NOT.** The lens reported 5 of 42 cards torn (heading at a
  page foot, stat line overleaf). A corrected `pdftotext` page-boundary check (a first version
  flagged 42/42 because it also matched the TOC and missed the `❧` heading ornament; the fixed
  version matches the ornamented heading on its content page) finds 40 of 42 cards with their
  heading and `Disciplines:` line on one page and 0 torn, the remaining 2 being the curly-apostrophe
  names. No issue filed.

## Process notes
- Documented, then followed: ch08's `(@sec-x).` render lesson was applied to every new crossref
  this session (no typed stop after a parenthetical reference).
- The chapter's four `is`-less/`Armor`/`Protection` gating and all 10 edits were verified with
  `pdftotext` short-fragment probes after the build, not by reading the diff.
