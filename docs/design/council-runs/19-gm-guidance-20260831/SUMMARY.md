# Council Run 20260831-2023 — ch19 (Dungeon Architect's Guide)

**Council:** hol-rulebook · **Chapter:** `quarto-book/chapters/19-gm-guidance.qmd` (566 lines)
**Verdict:** REJECTED 7-0 (refute 7 / support 0, quorum 4, reject_quorum 4 — terminal, no judge)

## Findings (f-001..f-007, round 1)

| ID | Role | Stance | Confidence | Core claim |
|----|------|--------|-----------|------------|
| f-001 | game-architect | refute | 0.92 | Kelvath C2 at 6/9/12 (band violation) + flat +1 rider; Brimstone Burst example teaches off-row center riders (also in ch11); Train/Fortify faction actions drift from ch18; poultice 3 HP and narration 2/3 off-budget; check-notation drift |
| f-002 | researcher | refute | 0.90 | Kelvath band + seal-break flat rider; narration hits inconsistent with DR 1; skill-challenge 2-failure stop vs 3+-failure row; Fortitude (Endurance) inverted; Fortify Position +5 vs ch18 +10; stale class nouns; flat check bonuses |
| f-003 | contrarian | refute | 0.85 | Kelvath band; Brimstone Burst example riders; challenge contradiction + 3-player math; encounter multiplier undefined; +1 sword generic; reputation economy gameable; tether geometrically meaningless; stale nouns; surprise-round phrasing; 1d3 |
| f-004 | author | refute | 0.85 | Voice holds; stale class labels (345/71); check-notation drift (159/312); 'GM' art captions vs DA; 'boon' collides with Boon keyword; reputation ladder duplicated (368 vs 401); W:/S:/St: vs Weak:/Standard:/Strong: |
| f-005 | editor-in-chief | refute | 0.92 | Skill-challenge self-contradiction; card-templates misstate book grammar ((Spell) label, Disc:/Duration invented, examples alter published cards); stale class nouns; check notation; scenes interleaved with advice headings |
| f-006 | layout-expert | refute | 0.82 | #### faction headings (only in book) render unornamented; blockquote heading breaks example-card pattern; range punctuation en-dash vs hyphen; zero em-dashes; TOC-safe callouts verified |
| f-007 | librarian | refute | 0.85 | Four-function frame holds; load-bearing: Fortify Position +5 vs +10, Kelvath band + rider, poultice 3 HP; stale nouns; +1 sword; check mixes; flat check bonuses; cosmetic: darkness -2/-4, Harder/Deadly, 1d3, surprise round, Brimstone Burst drift |

## Wall

No wall rejections. All 7 findings passed pre-ingest lint (prescreen.py) and the member-side self-check; no judge-brief was needed (terminal reject).

## Process notes

- Round 1 only; check returned `action=recommend` (state `rejected`) — no impasse, no judge, no rulings.
- All findings ingested with topic t-01; `note-round` recorded 7 findings.
- `close` accepted the librarian recommendation; `verify` → `chain: ok`, 13 events.

## Disposition (implemented as PR #387)

Mechanical/canon: Kelvath 2/4/6 + tier-bump; Fortify Position +10 + @sec-strongholds cross-ref; Train +2; poultice 4 HP; narration 'after its armor'; challenge intro reconciled; card-templates aligned to real grammar; ch11 Brimstone Burst center riders stripped; check notation ×4; stale class nouns; '+1 sword' -> 'a single enchanted sword'; 'surprise round' -> ambush phrasing; darkness -2; Harder -> Hard; Allied Boon -> Allied Favor; track table gains Allied 50%; #### -> bold run-ins; blockquote heading -> bold run-in; en-dash range.
Design defaults (veto-revertible in decisions-pending.md): encounter multiplier band/party-size note; Kelvath tether 10 ft + Water Bolt note fix; crafting Bane/Boon.
Kept as-is: 1d3 (matches ch18 Recruit precedent); interleaved callouts (book sidebar convention, out of TOC).
