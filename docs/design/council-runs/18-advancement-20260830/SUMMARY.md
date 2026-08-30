# Council Run SUMMARY — ch18 (18-advancement)

- **Run:** 20260830-2051 · **Council:** hol-rulebook (Synod engine, 7 voters, quorum 4, max_rounds 2)
- **Verdict:** REJECTED as written, round 1, **7-0 unanimous refute** (librarian, contrarian, researcher, game-architect, author, editor-in-chief, layout-expert all refute; no rebuttals; no impasse; no judge)
- **Disposition:** ONE atomic PR **#385** (branch `fix/council-18-20260830`, squash-merged, branch deleted)
- **Build:** exit 0 (`cd quarto-book && ./build.sh`), PDF produced

## The load-bearing defect

Per-level DP income (3-4/level, **no carry-over**) cannot fund the locked 2/4/8 card economy:
an 8-DP Master card is categorically unpurchasable, and 4-DP Adept cards are reachable only
on the two 4-point milestone levels (1, 5). Forced spend turns the residue into panic buys
(f-003/f-007). Fix: **DP carry over** to the next level (totals unchanged at 32) — the economy
becomes fundable by saving; the "spend every point" pressure is removed. Canon-determined
arithmetic per the final economy (merged #195).

## Other fixes (all in #385)

- **Reputation gates reconciled** (three unreconciled scales): stronghold requirement now names
  the scale ("Group Reputation Renowned (7+) or faction standing Allied (+3)"); Followers trigger
  uses "faction standing Allied (+3)" and "Heroic (10-14)" (band-exact; was overrunning into
  Legendary).
- **Zero-rider law:** Dragonslayer title (+1 damage) and Armory upgrade (+1 damage) → **+1 damage
  tier** (titles and strongholds included in the law).
- **Stale vocabulary:** "cleric" → Shepherd; "Wizard's Tower" → **Arcanist's Tower** (table +
  prose + 3 upgrade refs; implemented default, veto-revertible); "skilled/rogue-ish" →
  Shadow/stealth-oriented; Sanctum names Shepherd/Leader.
- **"Fortify" → "Fortify Position"** (canonical ch19 faction-action name).
- **Followers:** permanence stated (table gains permanent; Recruit grants temporary for one
  adventure); acquisition channels unified.
- **Titles:** section renamed "Earned Titles", Rep table column "Title" → "Reputation Tier"
  (kills the three-way "Title" collision); sentence added on how titles are earned; Archmage
  reworded ("learn one Adept-tier spell card at no DP cost") — no longer a DP-economy bypass
  (implemented default, veto-revertible).
- **Group Reputation:** DA award/loss guidance paragraph added (mirrors ch19's structure).
- **Reveling:** once-per-session cap, persistence made explicit, voice beat added.
- **Stronghold HP anchored:** base **50 HP** defined; Fortify +10 temp and Reinforced Walls +25
  (to 75) now reference the base (implemented default, veto-revertible).
- **Secondary Stronghold Type example:** "Keep with a Library" (an upgrade) → "Keep with an
  Arcanist's Tower" (two types).
- **Hidden HTML comment** (Advancement rationale) → visible "Why this exists" callout (book device,
  cf. Retraining).
- **"priceless"** capitalized; **upkeep base** stated as construction cost; comma-splice/agreement
  fixes (39, 183).
- **Layout:** pagebreaks before Reveling and Earned Titles removed — both short sections now share
  a page instead of stranding as widow pages (verified via pdftotext on the built PDF).

## Verified clean (not re-flagged)

DP table arithmetic (32 DP / 3 disciplines / 2 attribute increases), attribute cap +2 at levels
4/8, Adept/Master unlock at 3/7 (ch08/ch03 match), retraining example (both Novice 2-DP skills,
Intimidation keyed to Brawn), all four @anchors resolve (@sec-faction-system, @sec-chapter-bestiary,
@sec-strongholds), follower HP 4-8 matches Guard/Bandit/Cultist stat blocks, Train faction action
reference canonical, upkeep arithmetic (5% of 1,000 gp = 50 gp), zero em-dashes, heading hierarchy
clean, all six tables structurally sound.

## Wall/process notes

- All 7 voters passed pre-ingest wall lint with zero leaks (no member rewrites needed).
- Findings: f-001..f-007 ingested round 1; note-round recorded 7; check returned recommend with
  state=rejected (7 refute / 0 support, reject quorum 4 exceeded).
- Ledger chain verified: `verify` → chain ok, 13 events.
