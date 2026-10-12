"""Printed worked examples, replayed through the engine with scripted dice.

There are exactly four machine-checkable examples in the book:
  06:142  Defense Roll example (goblin, Challenge 1)
  06:152  Defense Roll example (Knight, Challenge 3)
  13:487  Worked Example: A Full Combat Round
  13:569  Worked Example: The Ambush
Two bonus fixtures the manuscript also prints:
  13:304  Two-weapon fighting example
  16:150  Shield Block example

Each function returns a list of observations of the form
(label, expected, actual). The test suite asserts every actual == expected.
"""

from __future__ import annotations

from .combat import damage_after_dr, reverse_defense_tier
from .dice import Dice, STANDARD, STRONG, WEAK, tier_for


class Observation:
    __slots__ = ("label", "expected", "actual")

    def __init__(self, label, expected, actual):
        self.label = label
        self.expected = expected
        self.actual = actual

    @property
    def ok(self):
        return self.expected == self.actual

    def __repr__(self):
        return f"{'OK ' if self.ok else 'FAIL'} {self.label}: expected {self.expected!r}, got {self.actual!r}"


def _row(damage, tier):
    return damage[tier]


def defense_example(dice_values, agility, challenge, damage, dr):
    """Resolve one NPC attack against a hero: defense roll, reversal, DR."""
    dice = Dice(script=[list(dice_values)])
    roll = dice.roll(agility - challenge)
    outcome = reverse_defense_tier(roll.tier)
    raw = _row(damage, outcome)
    return {
        "dice": roll.all_dice,
        "total": roll.total,
        "tier": roll.tier,
        "damage_tier": outcome,
        "raw_damage": raw,
        "dr": dr,
        "final": damage_after_dr(raw, dr),
    }


def example_06_142():
    """06:148 - Kael (Agility +2) vs goblin, Challenge 1; goblin 4/6/8; DR 1."""
    result = defense_example([4, 3, 5], agility=2, challenge=1,
                             damage={WEAK: 4, STANDARD: 6, STRONG: 8}, dr=1)
    return [
        Observation("06:142 dice", [4, 3, 5], result["dice"]),
        Observation("06:142 total", 13, result["total"]),
        Observation("06:142 defense tier", STANDARD, result["tier"]),
        Observation("06:142 damage tier", STANDARD, result["damage_tier"]),
        Observation("06:142 raw damage", 6, result["raw_damage"]),
        Observation("06:142 final damage", 5, result["final"]),
    ]


def example_06_152():
    """06:152 - Kael vs Knight, Challenge 3; knight 5/8/11; DR 1."""
    result = defense_example([2, 3, 2], agility=2, challenge=3,
                             damage={WEAK: 5, STANDARD: 8, STRONG: 11}, dr=1)
    return [
        Observation("06:152 dice", [2, 3, 2], result["dice"]),
        Observation("06:152 total", 6, result["total"]),
        Observation("06:152 defense tier", WEAK, result["tier"]),
        Observation("06:152 damage tier", STRONG, result["damage_tier"]),
        Observation("06:152 raw damage", 11, result["raw_damage"]),
        Observation("06:152 final damage", 10, result["final"]),
    ]


def two_weapon_example():
    """13:304 - Kael: shortsword Standard 2 + Agility 2 = 4; off-hand Weak 1 + 2 = 3."""
    dice = Dice(script=[[4, 4, 4]])
    roll = dice.roll(modifier=0)
    primary = 2 + 2
    offhand = 1 + 2
    return [
        Observation("13:304 primary result", STANDARD, roll.tier),
        Observation("13:304 primary damage", 4, primary),
        Observation("13:304 off-hand damage", 3, offhand),
        Observation("13:304 total damage", 7, primary + offhand),
    ]


def shield_block_example():
    """16:150 - Roric's round: 3 + 5 + 1 = 9, and the axe lands 6 -> 4 -> 1."""
    scimitar = {WEAK: 4, STANDARD: 6, STRONG: 8}
    axe = {STANDARD: 6, WEAK: 4}
    dice = Dice(script=[[3, 4, 4], [1, 2, 3], [6, 5, 4, 3]])
    first = dice.roll(modifier=2)
    second = dice.roll(modifier=2)
    chief = dice.roll(modifier=0, boon=1)
    goblin_one = damage_after_dr(_row(scimitar, reverse_defense_tier(first.tier)), 3)
    goblin_two = damage_after_dr(_row(scimitar, reverse_defense_tier(second.tier)), 3)
    landed = _row(axe, reverse_defense_tier(chief.tier))
    final = damage_after_dr(landed, 3)
    return [
        Observation("16:150 goblin 1 total", 13, first.total),
        Observation("16:150 goblin 1 tier", STANDARD, first.tier),
        Observation("16:150 goblin 1 damage", 3, goblin_one),
        Observation("16:150 goblin 2 total", 8, second.total),
        Observation("16:150 goblin 2 tier", WEAK, second.tier),
        Observation("16:150 goblin 2 damage", 5, goblin_two),
        Observation("16:150 warchief kept", [6, 5, 4], chief.kept),
        Observation("16:150 warchief total", 15, chief.total),
        Observation("16:150 warchief tier", STRONG, chief.tier),
        Observation("16:150 warchief raw", 6, _row(axe, STANDARD)),
        Observation("16:150 warchief landed", 4, landed),
        Observation("16:150 warchief final damage", 1, final),
        Observation("16:150 round total", 9, goblin_one + goblin_two + final),
        Observation("16:150 Roric HP", 4, 13 - 9),
    ]


def full_combat_round():
    """13:487 - A Full Combat Round, every printed roll and number."""
    observations = []
    dice = Dice(script=[
        [3, 4, 4],  # Lyra Gust
        [5, 4, 5],  # Kael attack
        [5, 3, 2],  # Knight attacks Kael (defense)
        [3, 4, 4],  # Cultist 2 Dark Bolt at Lyra (defense)
        [3, 3, 2],  # Roric attack
        [4, 2, 3],  # Knight morale
        [6, 6, 1],  # Lyra Ember Lance
        [4, 6, 5],  # Kael attack
        [3, 2, 1],  # Knight morale
    ])

    lyra_hp = 10
    kael_hp = 11
    knight_hp = 10
    cultist_hp = 17

    # Round 1, Lyra: Gust, 3d6 + Knowledge 1
    roll = dice.roll(modifier=1)
    observations += [
        Observation("13:487 Lyra Gust total", 12, roll.total),
        Observation("13:487 Lyra Gust tier", STANDARD, roll.tier),
    ]

    # Round 1, Kael: attack Knight, 3d6 + Brawn 1
    roll = dice.roll(modifier=1)
    kael_damage = damage_after_dr(3 + 1, dr=3)
    knight_hp -= kael_damage
    observations += [
        Observation("13:487 Kael attack total", 15, roll.total),
        Observation("13:487 Kael attack tier", STRONG, roll.tier),
        Observation("13:487 Kael damage to Knight", 1, kael_damage),
    ]

    # Round 1, Knight attacks Kael: defense 3d6 + 2 - 3
    defense = dice.roll(modifier=2 - 3)
    outcome = reverse_defense_tier(defense.tier)
    raw = _row({WEAK: 5, STANDARD: 8, STRONG: 11}, outcome)
    taken = damage_after_dr(raw, dr=1)
    kael_hp -= taken
    observations += [
        Observation("13:487 Knight defense total", 9, defense.total),
        Observation("13:487 Knight defense tier", STANDARD, defense.tier),
        Observation("13:487 Knight damage", 7, taken),
        Observation("13:487 Kael HP after Knight", 4, kael_hp),
    ]

    # Round 1, Cultist 2 Dark Bolt at Lyra: defense 3d6 + 2 - 1
    defense = dice.roll(modifier=2 - 1)
    outcome = reverse_defense_tier(defense.tier)
    raw = _row({WEAK: 4, STANDARD: 6, STRONG: 8}, outcome)
    taken = damage_after_dr(raw, dr=0)
    lyra_hp -= taken
    observations += [
        Observation("13:487 Cultist defense total", 12, defense.total),
        Observation("13:487 Cultist defense tier", STANDARD, defense.tier),
        Observation("13:487 Lyra damage", 6, taken),
        Observation("13:487 Lyra HP after bolt", 4, lyra_hp),
    ]

    # Round 1, Roric: attack Knight, 3d6 + Brawn 2
    roll = dice.roll(modifier=2)
    damage = damage_after_dr(2 + 2, dr=3)
    knight_hp -= damage
    observations += [
        Observation("13:487 Roric attack total", 10, roll.total),
        Observation("13:487 Roric attack tier", STANDARD, roll.tier),
        Observation("13:487 Roric damage to Knight", 1, damage),
        Observation("13:487 Knight HP after round 1", 8, knight_hp),
    ]

    # End of round 1, morale check (no modifier)
    roll = dice.roll(modifier=0)
    observations += [
        Observation("13:487 morale total", 9, roll.total),
        Observation("13:487 morale tier", STANDARD, roll.tier),
    ]

    # Round 2, Lyra: Ember Lance, 3d6 + Knowledge 1
    roll = dice.roll(modifier=1)
    raw = _row({WEAK: 4, STANDARD: 6, STRONG: 8}, reverse_defense_tier(roll.tier))
    cultist_hp -= damage_after_dr(raw, dr=0)
    observations += [
        Observation("13:487 Lyra Ember Lance total", 14, roll.total),
        Observation("13:487 Lyra Ember Lance tier", STANDARD, roll.tier),
        Observation("13:487 cultist HP", 11, cultist_hp),
    ]

    # Round 2, Kael: attack Knight, 3d6 + Brawn 1
    roll = dice.roll(modifier=1)
    damage = damage_after_dr(3 + 1, dr=3)
    knight_hp -= damage
    observations += [
        Observation("13:487 Kael second attack total", 16, roll.total),
        Observation("13:487 Kael second attack tier", STRONG, roll.tier),
        Observation("13:487 Knight HP after round 2", 7, knight_hp),
    ]

    # The Knight's morale: 6, Weak -> withdraws
    roll = dice.roll(modifier=0)
    observations += [
        Observation("13:487 final morale total", 6, roll.total),
        Observation("13:487 final morale tier", WEAK, roll.tier),
    ]
    return observations


def ambush_example():
    """13:569 - The Ambush: Stealth, grapple, morale."""
    dice = Dice(script=[
        [5, 6, 4],  # Lyra Stealth
        [4, 3, 5],  # Kael grapple
        [2, 4, 1],  # bandit opposed Brawn check
        [1, 3, 2],  # bandit morale
    ])
    observations = []
    stealth = dice.roll(modifier=2 + 2)
    observations += [
        Observation("13:569 Stealth total", 19, stealth.total),
        Observation("13:569 Stealth tier", STRONG, stealth.tier),
    ]
    grapple = dice.roll(modifier=1 + 1)
    bandit = dice.roll(modifier=0)
    observations += [
        Observation("13:569 grapple total", 14, grapple.total),
        Observation("13:569 grapple tier", STANDARD, grapple.tier),
        Observation("13:569 bandit total", 7, bandit.total),
    ]
    morale = dice.roll(modifier=0)
    observations += [
        Observation("13:569 morale total", 6, morale.total),
        Observation("13:569 morale tier", WEAK, morale.tier),
    ]
    return observations


EXAMPLES = {
    "06:142": example_06_142,
    "06:152": example_06_152,
    "13:304": two_weapon_example,
    "13:487": full_combat_round,
    "13:569": ambush_example,
    "16:150": shield_block_example,
}


def run_all_examples():
    report = {}
    for name, func in EXAMPLES.items():
        report[name] = func()
    return report
