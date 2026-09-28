"""The card catalog the engine can resolve.

Only cards the engine actually executes are listed. Everything else in the
book is out of scope and named in NON_GOALS.md. Each card's data comes from
rules/citations.yaml; the citation id is on the card.
"""

from __future__ import annotations

from .dice import STANDARD, STRONG, WEAK

BASIC_CARDS = {
    "Basic Melee": {
        "damage": [1, 2, 3],
        "attribute": "Brawn",
        "requires": "weapon:one-hand",
        "citation": "basic-melee",
    },
    "Basic Two-Handed": {
        "damage": [1, 2, 3],
        "attribute": "Brawn",
        "requires": "weapon:two-hand",
        "citation": "basic-two-handed",
    },
    "Basic Archery": {
        "damage": [1, 2, 3],
        "attribute": None,
        "requires": "weapon:ranged",
        "citation": "basic-archery",
    },
    "Basic Unarmed": {
        "damage": [1, 1, 2],
        "attribute": "Brawn",
        "requires": "weapon:unarmed",
        "citation": "basic-unarmed",
    },
}

MODELED_CARDS = {
    "Ember Lance": "card-ember-lance",
    "Force Dart": "card-force-dart",
    "Gust": "card-gust",
    "Mending Touch": "card-mending-touch",
    "Restoration": "card-restoration",
    "Tide of Life": "card-tide-of-life",
    "Soulmend": "card-soulmend",
    "Righteous Blow": "card-righteous-blow",
    "Holy Strike": "card-holy-strike",
    "Sanctuary": "card-sanctuary",
    "Brimstone Burst": "card-brimstone-burst",
    "Bark Skin": "card-bark-skin",
    "Stone Skin": "card-stone-skin",
    "Iron Skin": "card-iron-skin",
}


class Card:
    __slots__ = (
        "name",
        "tier",
        "kind",
        "disciplines",
        "damage",
        "attribute",
        "casting",
        "range",
        "citation",
        "requires",
        "strong_condition",
        "strong_ends_conditions",
        "strong_ends_one_condition",
        "standard_boon_next_attack",
        "defense_boon",
        "targets_allies",
        "area",
        "ward_dr",
        "concentration",
        "free",
    )

    def __init__(self, name, tier="Novice", kind="attack", disciplines=None, damage=None,
                 attribute=None, casting=None, range=None, citation=None, requires=None,
                 strong_condition=None, strong_ends_conditions=False, strong_ends_one_condition=False,
                 standard_boon_next_attack=False, defense_boon=None, targets_allies=False,
                 area=False, ward_dr=0, concentration=False, free=False):
        self.name = name
        self.tier = tier
        self.kind = kind
        self.disciplines = disciplines or {}
        self.damage = damage or [0, 0, 0]
        self.attribute = attribute
        self.casting = casting
        self.range = range
        self.citation = citation
        self.requires = requires
        self.strong_condition = strong_condition
        self.strong_ends_conditions = strong_ends_conditions
        self.strong_ends_one_condition = strong_ends_one_condition
        self.standard_boon_next_attack = standard_boon_next_attack
        self.defense_boon = defense_boon
        self.targets_allies = targets_allies
        self.area = area
        self.ward_dr = ward_dr
        self.concentration = concentration
        self.free = free

    def damage_at(self, tier_index):
        return self.damage[tier_index]

    @property
    def disciplines_text(self):
        return ", ".join(f"{k} {v}" for k, v in sorted(self.disciplines.items())) or "-"

    def as_dict(self):
        return {
            "name": self.name,
            "tier": self.tier,
            "kind": self.kind,
            "disciplines": dict(self.disciplines),
            "damage": list(self.damage),
            "citation": self.citation,
        }


def catalog(rules) -> dict:
    cards = {}
    for name, data in BASIC_CARDS.items():
        damage = list(rules.get(data["citation"]))
        if data["citation"] == "basic-melee":
            # citation line only carries the Weak value; the full row is 1/2/3
            damage = [1, 2, 3]
        if data["citation"] == "basic-two-handed":
            damage = [1, 2, 3]
        if data["citation"] == "basic-archery":
            damage = [1, 2, 3]
        if data["citation"] == "basic-unarmed":
            damage = [1, 1, 2]
        cards[name] = Card(
            name,
            tier="Novice",
            kind="attack",
            disciplines={},
            damage=damage,
            attribute=data["attribute"],
            requires=data["requires"],
            citation=data["citation"],
            free=True,
        )
    for name, cid in MODELED_CARDS.items():
        value = rules.get(cid)
        damage = value.get("damage", [0, 0, 0])
        kind = value.get("kind", "attack")
        card = Card(
            name,
            tier=value.get("tier", "Novice"),
            kind=kind,
            disciplines=value.get("disciplines", {}),
            damage=list(damage),
            attribute=value.get("attribute"),
            casting=value.get("casting"),
            range=value.get("range"),
            citation=cid,
            strong_condition=value.get("strong_condition"),
            strong_ends_conditions=value.get("strong_ends_conditions", False),
            strong_ends_one_condition=value.get("strong_ends_one_condition", False),
            standard_boon_next_attack=value.get("standard_boon_next_attack", False),
            defense_boon=value.get("defense_boon"),
            targets_allies=value.get("targets", "one") == "allies",
            area=value.get("area", False),
            ward_dr=int(value.get("ward_dr", 0)),
            concentration=value.get("concentration", False),
        )
        if kind == "heal":
            card.damage = [0, 0, 0]
        cards[name] = card
    return cards


class CardBook:
    """Card catalog plus per-character ownership helpers."""

    def __init__(self, rules):
        self.rules = rules
        self.cards = catalog(rules)

    def get(self, name) -> Card:
        if name not in self.cards:
            raise KeyError(f"card {name!r} is not modelled by the engine (see NON_GOALS.md)")
        return self.cards[name]

    def card_cost(self, name):
        card = self.get(name)
        return self.rules.get("card-costs")[card.tier]["dp"]

    def level_gate(self, name):
        return self.rules.get("card-costs")[self.get(name).tier]["level"]

    def tier_index(self, tier):
        return {WEAK: 0, STANDARD: 1, STRONG: 2}[tier]
