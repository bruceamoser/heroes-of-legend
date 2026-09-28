"""Dice: seeded per combat, plus scripted-roll mode for printed examples.

Randomness is always local to a Dice instance. There is no module-level RNG
and no wall-clock seeding anywhere in the engine.
"""

from __future__ import annotations

import random
import zlib


WEAK = "Weak"
STANDARD = "Standard"
STRONG = "Strong"

ORDER = {WEAK: 0, STANDARD: 1, STRONG: 2}


class ScriptedRollsExhausted(RuntimeError):
    pass


class ScriptedRollTooShort(RuntimeError):
    pass


def tier_for(total: int) -> str:
    if total <= 8:
        return WEAK
    if total <= 14:
        return STANDARD
    return STRONG


def tier_shift(tier: str, steps: int) -> str:
    value = ORDER[tier] + steps
    value = max(0, min(2, value))
    return [WEAK, STANDARD, STRONG][value]


def combat_seed(seed: int, index: int) -> int:
    """Per-combat seed from crc32(seed, combat_index). No wall clock."""
    data = f"{seed}:{index}".encode("utf-8")
    return zlib.crc32(data) & 0xFFFFFFFF


class Roll:
    __slots__ = ("all_dice", "kept", "total", "tier", "triple6", "triple1", "boon", "bane", "modifier")

    def __init__(self, dice, kept, boon=0, bane=0, modifier=0):
        self.all_dice = list(dice)
        self.kept = list(kept)
        self.total = sum(kept) + modifier
        self.modifier = modifier
        self.tier = tier_for(self.total)
        self.triple6 = all(d == 6 for d in kept)
        self.triple1 = all(d == 1 for d in kept)
        self.boon = boon
        self.bane = bane

    def as_dict(self):
        return {
            "dice": self.all_dice,
            "kept": self.kept,
            "total": self.total,
            "tier": self.tier,
            "triple6": self.triple6,
            "triple1": self.triple1,
        }


class Dice:
    """Rolls 3d6 with Boons and Banes; scripted lists take priority over rng."""

    def __init__(self, rng: random.Random | None = None, script: list | None = None):
        self.rng = rng if rng is not None else random.Random(0)
        self.script = script
        self.script_pos = 0
        self.roll_count = 0

    def clone_with_script(self, script):
        return Dice(self.rng, script)

    def _next(self, count):
        if self.script is not None:
            if self.script_pos >= len(self.script):
                raise ScriptedRollsExhausted(
                    f"scripted dice exhausted after {self.script_pos} rolls (needed {count} more dice)"
                )
            group = list(self.script[self.script_pos])
            self.script_pos += 1
            if len(group) < count:
                raise ScriptedRollTooShort(f"scripted roll {self.script_pos - 1} has {len(group)} dice, need {count}")
            return group[:count]
        return [self.rng.randint(1, 6) for _ in range(count)]

    def roll(self, modifier: int = 0, boon: int = 0, bane: int = 0) -> Roll:
        net = max(-3, min(3, boon - bane))
        count = 3 + abs(net)
        dice = self._next(count)
        if net > 0:
            kept = sorted(dice, reverse=True)[:3]
        elif net < 0:
            kept = sorted(dice)[:3]
        else:
            kept = list(dice)
        self.roll_count += 1
        return Roll(dice, kept, boon=boon, bane=bane, modifier=modifier)

    def d6(self) -> int:
        result = self._next(1)[0]
        self.roll_count += 1
        return result

    def d666(self, extra_dice: int, modifier: int = 0) -> tuple[list[int], int]:
        """Wound table roll: 3d6 + extra, keep the highest three, sort ascending."""
        count = 3 + max(0, min(3, extra_dice))
        dice = self._next(count)
        kept = sorted(sorted(dice, reverse=True)[:3])
        value = kept[0] * 100 + kept[1] * 10 + kept[2]
        self.roll_count += 1
        return kept, value
