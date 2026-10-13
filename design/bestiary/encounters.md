# Provisional CV and encounter preparation

**These numbers are authoring estimates, not calibrated encounter ratings.** No new
combat simulation was run for this catalog. The point is to make the roster sortable
and expose unusually costly combinations before the next testing pass.

The [agreed encounter goals](../rules/encounters.md) remain: four heroes, roughly
4 rounds typical, 6 hard, 10 extreme; typical wound incidence roughly 20–30% without
a healer and 5–15% with one. A budget label alone cannot promise those results.

## Reproducible seed calculation

This implements the earlier `sqrt(E × O) × U` proposal with an explicit reference
and a scale factor of 3. Every creature prints its inputs; the audit recomputes CV.

1. Enumerate all 3d6 outcomes for a reference hero with attribute +1. Evasion adds
   that many Banes to attacks against the creature. Retain the worst three dice;
   natural 111/666 take their usual tiers. The reference hero deals **3/5/7 physical**.
2. Apply the creature’s printed physical resistance, minimum 1 per damaging event.
   Let **I** be that expected incoming damage per attack.
3. **E = (HP + 2 × printed regeneration per turn) / I**. The two regeneration ticks
   are an explicit seed assumption, not a combat-duration prediction. Fire can remove
   them; actual tests must record whether the party discovers and uses that counter.
4. For **O**, reverse the +1 defender’s outcome probabilities to read the creature’s
   reference attack. Threat supplies defense Banes. Apply reference physical resistance
   1 against physical damage, 0 against other types, then multiply by the printed
   expected targets (1 or 2). No assumed damage from conditions is hidden in O.
5. **CV = ceiling(3 × sqrt(E × O) × U)**, minimum 1. **U** is the printed provisional
   utility factor. It covers capabilities not explicitly modeled in E/O: mobility,
   control, range, reactions, healing, alternate area attacks and special senses.

The reference attack is a **comparison fixture**, not a replacement player card
or a new damage standard. O does not use the monster’s attack attribute: against
heroes, the hero’s defense attribute determines the distribution. Those monster
attributes still matter when a player controls it.

All current entries have a damaging primary action. A future pure controller must
receive a reviewed contribution estimate; this formula must not turn it into a
zero-cost enemy. Life resistance reducing healing is also absent from this simple
reference fight; healer access is a separate scenario axis.

## Utility rubric and uncertainty

| U range | Intended use |
|---|---|
| 1.00 | Straightforward single-target damage and ordinary movement |
| 1.10–1.25 | One situational advantage: range, movement, modest displacement, defenses |
| 1.30–1.45 | Strong control, several useful options, flight with offense, or an ambush package |
| 1.50–1.65 | Healing, repeatable disabling pressure, alternate area damage, or major combined utility |

Values are intentionally visible judgments. They are not derived probabilities.
The audit cannot prove that Dazed 2 is worth a particular multiplier. A dragon’s
alternate breath can exceed the two-target expectation; a flying foe in an open
field may be much harder than its CV, and much easier under a low ceiling.
A shield soldier using Defend and Shield Hunker every round also needs a focused
test: those modifiers are represented only by U, not separately enumerated in I.

## Initial budgets to test after catalog review

For a first testing grid, **propose B(L) = 32 + 8 × L** for four same-level heroes:

| Level | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Standard CV seed | 40 | 48 | 56 | 64 | 72 | 80 | 88 | 96 | 104 | 112 |

This is an initial hypothesis, not a conclusion that eight CV per level matches
purchased advancement. Fixed attributes/HP and freely chosen cards make builds
matter. Change this entire row if playtests disagree; do not distort creatures
merely to preserve the row. Tier-3 and tier-7 signature access may cause step changes.

**Same level:** `budget = B(L) × party size / 4 × difficulty`.
**Mixed levels:** `budget = sum(B(each hero level) / 4) × difficulty`.
Use easy 0.75, standard 1, hard 1.5, extreme 2 as the earlier proposed multipliers.
For three level-1 heroes standard is 30; five is 50 and hard is 75. For levels
1, 1, 3, 3 standard is `(40 + 40 + 56 + 56) / 4 = 48`. These are arithmetic examples,
not evidence that the fights last a set number of rounds.

## Ready-to-run encounter drafts

Each scene includes a reason to fight, a way to avoid it and a terrain warning.
Use actual [level-1 characters](../characters/README.md), their supplies and their
free hands when testing, rather than invented optimized stat lines.

| Scene | Roster | CV total | What makes it an adventure |
|---|---|---:|---|
| The false toll | 3 Road Bandits + 1 Bandit Bow | 36 | A blocked cart is a bluff. The bow has a tree perch; expose the bluff or reach the perch. |
| The opened barrow | 3 Bone Sentries + 2 Bone Archers | 33 | Return the stolen burial token to stop the watch. Keep the entrance wide enough to avoid a doorway lock. |
| Tracks around the camp | 4 Wolves | 32 | The camp blocks the route to a den. Move the camp or escort the pack past it. Pack Hunter makes isolation matter. |
| The bridge has an owner | 1 Bridge Troll + 1 Road Bandit + 1 Bandit Bow | 41 | Toll collectors have an uneasy partnership. Fire and the drop can dominate the CV; offer another crossing. |
| The watch will not stand down | 2 Shield Soldiers + 1 Grave Cultist | 38 | Soldiers believe the cultist has legal authority. Show the forged orders; otherwise test layered defensive Boons. |

Totals are checked against the roster by the audit. An encounter slightly below or
above the seed is useful; do not add filler merely to hit the integer exactly.
No encounter label means that all four heroes should be forced to fight it.

## Composition limits for the first tests

- Begin with three to five enemies, modest terrain, and a clear retreat route.
  Many weak enemies gain many Main Actions even at equal CV; test swarms of actors
  separately from a single swarm creature.
- Introduce one disabler, healer, area attacker or grappler at a time. Do not put
  several Dazed/Paralyzed sources into the first supposedly standard fight.
- A solo creature has one turn and one Reaction. This roster adds no legendary
  turns. For a dragon scene, use objectives, terrain and separately budgeted allies
  rather than assuming its CV automatically solves solo action economy.
- Include all active waves in the encounter total. A retreating wave that returns
  healed is not free. A damaging environmental hazard needs its own tested allowance;
  do not hide it behind “interesting terrain.”
- Record rounds, HP loss, healing actions/costs, supplies, Grit, new wounds, escapes,
  disabled turns and whether the players found the counterplay. Average damage alone
  cannot establish the intended feel.

After review, test the ordinary roster first, then healer mirrors, shield formations,
large-body forced movement, summon commands, flight, grapples and mental disabling.
Only then fit level budgets and utility factors to observed play.
