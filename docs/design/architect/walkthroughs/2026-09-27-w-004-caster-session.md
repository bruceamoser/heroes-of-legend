# W-004 — Caster session (Sera Ashvein, level 1 Arcanist)

Date: 2026-09-27. Cycle 28. Method: `references/architect-role.md` → walkthrough 1/3 (first-session + round),
played on the book alone, dice in the open. Prior transcripts: W-001 first session, W-002 level gate, W-003 round.

## Why this walkthrough

"Magic always fires" is the pillar the scorecard had no transcript behind. Every prior transcript was
martial: a first-session build, a level-gate sweep, a round economy. The magic subsystem had been
*assessed* (Assessment 5) but never *played*, and its four design questions were filed rather than
rolled. Sera Ashvein is a fully printed level-1 build (`02:330-366`), so no hero had to be invented.

## The hero, rebuilt from the book

| Field | Value | Source |
|---|---|---|
| Attributes | Knowledge +2, Reason +1, Fort 0, Agi 0, Brawn 0, Guile 0 | `02:333` |
| Ancestry/culture | Human (Fire, +1 DP), Imperial (+1 Arcana, Energy) | `02:335-337` |
| Background DP | 11 = Craft/History/Alchemy/Nature/Lore (5x2) + Earth rank 1 | `02:339-348` |
| Class DP | 12 = Melee r1 (4) + Ember Lance (2) + Burning Volley (2) + Arcane Feedback (2) + Perception N (2) | `02:352-360` |
| Casting | 3d6 + Knowledge(+2) + Arcana(+1) = **+3** | `10:31-33` |
| Derived | HP 12, Init +0, Move 30 ft, Carry 10 slots | `02:364` |

Both pools close exactly (11/11, 12/12). **No build question the book failed to answer.** The one
ambiguity recon surfaced was `*Favored Skills*` on the class sheet (below).

## The session

**Scene 1 — approach (no combat).** Cantrips only. Sera's at-will options are the whole arcane cantrip
list (`10:80`), free, no DP, no focus. A Novice spell card (4/6/8) is the paid upgrade from a cantrip's
1/3/5 (`10:82`). Clean.

**Scene 2 — the caster's first round.** Ember Lance (`11:168`): `Requires: focus:arcane`, Action, 30 ft.
Sera's loadout carries the focus (`02:362`, 0 slots), so no downgrade. Arcane Shield is a **free** action,
once per round, so the Maneuver stays open. Her tier spread at +3:

| Modifier | Weak | Standard | Strong |
|---|---|---|---|
| Sera, casting +3 | 4.6% | 57.9% | **37.5%** |
| a Brawn+1 martial, +1 | 16.2% | 67.6% | 16.2% |

The caster's floor is the same Weak band, but her Strong is more than double. That is the "magic always
fires" pillar showing up as a distribution, and it is intentional.

**Scene 3 — the book's own starter fight.** `19:303` builds a party of four against **4 Drowned
Guardians: HP 14, DR 1, Vulnerable (Fire)** (`19:312`), in the flood. That stat block is the book's
first encounter *and* it is the one combination the damage rules never resolve: armour **and** a
vulnerability.

| Ember Lance tier | rolled | type modifier, then DR | DR, then type modifier |
|---|---|---|---|
| Weak | 4 fire | **7** | 6 |
| Standard | 6 fire | **11** | 10 |
| Strong | 8 fire | **15** | 14 |

One point on every hit, and a Level-1 caster's signature spell hits the ambiguity on round one. Measured
out: a Standard Ember Lance does 11 to a 14 HP guardian (**1.27 hits**), while a Brawn +1 martial's Basic
Melee does 4 - 1 = 3 (**4.67 hits**). The encounter is *designed* to reward fire, so that spread is the
vulnerability working, not a defect.

**Scene 4 — the boss.** Kelvath (C2): HP 32 (solo, sized for four attackers), DR 3, 4/6/8 at will
(`19:337`). Sera takes 6 per Standard hit against 12 HP (**2.0 hits to drop**). Her own fire has no
vulnerability to exploit here: 6 - 3 = 3, so 10.7 hits, or **2.7 rounds of four-hero output** against
ruling 165's 3-4 round window. Thin but inside the frame, and the fight's real pressure is Tidal Surge.

## The gap it found

**The book never states whether DR comes off before or after a resistance/vulnerability multiplier.**

- `13:155` gives the half (round down) / double rule. Every worked example applies DR as a plain
  subtraction (`13:473`, `13:494`, `13:506`). **No worked example in the book combines the two.**
- 50 bestiary blocks print DR; 4 print a resistance or vulnerability; the starter adventure's own
  guardian is both, facing a party that will bring fire.
- The order is not a preference. DR-then-type reaches **0**: 4 fire against DR 3 resistant is 1, halved
  and rounded down is 0, and `06:91` ("minimum 1 damage from any hit") plus `16:27` ("a hit must always
  be able to land for something") both forbid it.

Decided (architect, cycle 28, veto-revertible): **apply the type modifier first, subtract DR after it,
floor at 1.** One clause at the rule's own home, `13:155`. No new mechanic; the lever is the floor rule
the book already prints.

## Also found while reconning the caster's chapter group

- `05:340` Leader *Lead by Example*: the last **numeric roll modifier** in the book (`+2 bonus on their
  next roll`), contradicted by the book's own restatement at `02:470` ("a **Boon** on their next roll").
- `05:568` *Leverage*: the last **flat damage rider** in the book (`+2 bonus damage`), in a table whose
  five siblings all print `+1 damage tier`.
- `07:41`: `*Favored Skills*` is printed on all nine class sheets and marked in the printed builds, but
  ch07 already says all skills cost the same for every class and never uses the word, while ch02/ch05
  use "Favored" for a cheap *Discipline* rate.

All three landed with the gap above in PR #714. Both law gates in `SKILL.md` were blind to them: each
regex requires the number glued to its noun, and `bonus` sat in between.

## Scorecard

| Outcome | Before | After |
|---|---|---|
| Playable — transcripts | 3 (all martial) | **4**, first caster session |
| Playable — open questions this session | 1 (`Favored Skills`) | **0** |
| Cohesive — rules the book left unstated | 1 (the damage order) | **0** |
| Succinct — dead fields | 1 (`Favored Skills`, 9 sheets) | **0** |
| Law survivors (roll modifier / flat rider) | 1 each | **0** each |

**Clean at every other check:** the casting procedure, tier table, level gates, cantrip at-will rule,
focus and its downgrade, concentration (with its target stated), ritual, ending another caster's effect,
the per-encounter/per-session limits, `Arcana` as a skill (ch07:167), `Recharge` (`20:28`, `21:239`) and
Morale Check (`13:311`) are each defined and locatable. The caster loop works from the book alone.
