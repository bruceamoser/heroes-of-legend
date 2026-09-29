"""Character construction: ancestry, culture, class, DP spend, derived stats.

The builder refuses illegal characters. It never quietly discounts a card or
grants a discipline; every DP that moves is written to a ledger that
`hol-engine explain` prints.
"""

from __future__ import annotations

from .cards import CardBook
from .rules import rules as default_rules

ATTRIBUTE_NAMES = ["Brawn", "Fortitude", "Agility", "Guile", "Knowledge", "Reason"]

DISCIPLINES = [
    "Fire", "Earth", "Wind", "Water", "Melee", "Two-Handed", "Ranged", "Unarmed",
    "Shields", "Protection", "Armor", "Animal", "Plants", "Energy", "Life",
    "Religion", "Mind", "Summon", "Fate", "Stealth", "Sleight", "Lore", "Tactics",
]

COST_STRUCTURES = {
    "H": [1, 2, 4],
    "A": [2, 4, 8],
    "F": [3, 6, 12],
    "O": [4, 8, 16],
}

# From 05:807-829 (comprehensive cost table). H=Home A=Adjacent F=Foreign O=Opposed.
CLASS_COSTS = {
    "Protector": {
        "Fire": "O", "Earth": "O", "Wind": "O", "Water": "O", "Melee": "H", "Two-Handed": "H",
        "Ranged": "A", "Unarmed": "H", "Shields": "H", "Protection": "O", "Armor": "H",
        "Animal": "F", "Plants": "O", "Energy": "O", "Life": "O", "Religion": "O", "Mind": "O",
        "Summon": "O", "Fate": "O", "Stealth": "A", "Sleight": "O", "Lore": "O", "Tactics": "A",
    },
    "Blade": {
        "Fire": "O", "Earth": "O", "Wind": "O", "Water": "O", "Melee": "H", "Two-Handed": "A",
        "Ranged": "H", "Unarmed": "H", "Shields": "F", "Protection": "O", "Armor": "O",
        "Animal": "O", "Plants": "O", "Energy": "O", "Life": "O", "Religion": "O", "Mind": "O",
        "Summon": "O", "Fate": "O", "Stealth": "H", "Sleight": "H", "Lore": "O", "Tactics": "A",
    },
    "Arcanist": {
        "Fire": "H", "Earth": "H", "Wind": "H", "Water": "H", "Melee": "O", "Two-Handed": "O",
        "Ranged": "O", "Unarmed": "O", "Shields": "O", "Protection": "H", "Armor": "O",
        "Animal": "A", "Plants": "A", "Energy": "H", "Life": "A", "Religion": "O", "Mind": "H",
        "Summon": "H", "Fate": "A", "Stealth": "O", "Sleight": "O", "Lore": "A", "Tactics": "O",
    },
    "Shepherd": {
        "Fire": "O", "Earth": "O", "Wind": "O", "Water": "O", "Melee": "F", "Two-Handed": "O",
        "Ranged": "O", "Unarmed": "F", "Shields": "O", "Protection": "H", "Armor": "O",
        "Animal": "H", "Plants": "H", "Energy": "A", "Life": "H", "Religion": "H", "Mind": "A",
        "Summon": "O", "Fate": "O", "Stealth": "O", "Sleight": "O", "Lore": "A", "Tactics": "F",
    },
    "Intellect": {
        "Fire": "A", "Earth": "A", "Wind": "A", "Water": "A", "Melee": "F", "Two-Handed": "F",
        "Ranged": "F", "Unarmed": "O", "Shields": "F", "Protection": "A", "Armor": "O",
        "Animal": "A", "Plants": "H", "Energy": "H", "Life": "H", "Religion": "H", "Mind": "H",
        "Summon": "A", "Fate": "A", "Stealth": "F", "Sleight": "F", "Lore": "H", "Tactics": "H",
    },
    "Odd": {disc: "A" for disc in DISCIPLINES},
    "Leader": {
        "Fire": "O", "Earth": "O", "Wind": "O", "Water": "O", "Melee": "H", "Two-Handed": "H",
        "Ranged": "A", "Unarmed": "A", "Shields": "H", "Protection": "A", "Armor": "A",
        "Animal": "F", "Plants": "O", "Energy": "H", "Life": "A", "Religion": "A", "Mind": "F",
        "Summon": "O", "Fate": "F", "Stealth": "F", "Sleight": "O", "Lore": "A", "Tactics": "H",
    },
    "Unbalanced": {
        "Fire": "X", "Earth": "X", "Wind": "X", "Water": "X", "Melee": "O", "Two-Handed": "O",
        "Ranged": "O", "Unarmed": "H", "Shields": "O", "Protection": "H", "Armor": "O",
        "Animal": "H", "Plants": "H", "Energy": "H", "Life": "A", "Religion": "F", "Mind": "F",
        "Summon": "A", "Fate": "F", "Stealth": "F", "Sleight": "O", "Lore": "O", "Tactics": "F",
    },
    "Shadow": {
        "Fire": "O", "Earth": "O", "Wind": "O", "Water": "O", "Melee": "H", "Two-Handed": "O",
        "Ranged": "H", "Unarmed": "A", "Shields": "O", "Protection": "O", "Armor": "O",
        "Animal": "O", "Plants": "O", "Energy": "O", "Life": "O", "Religion": "O", "Mind": "H",
        "Summon": "O", "Fate": "H", "Stealth": "H", "Sleight": "H", "Lore": "O", "Tactics": "F",
    },
}

CLASS_DISCIPLINES = {
    "Protector": ["Armor", "Shields"],
    "Blade": ["Melee", "Stealth"],
    "Arcanist": ["Fire", "Energy"],
    "Shepherd": ["Protection", "Animal"],
    "Intellect": ["Lore"],
    "Odd": [],
    "Leader": ["Tactics", "Shields"],
    "Unbalanced": ["Fire", "Water"],
    "Shadow": ["Stealth", "Sleight"],
}

CLASS_HEALTH = {
    "Protector": "Brawn", "Blade": "Agility", "Arcanist": "Knowledge", "Shepherd": "Reason",
    "Intellect": "Knowledge", "Odd": None, "Leader": "Guile", "Unbalanced": "Brawn", "Shadow": "Guile",
}

CLASS_FAVORED = {
    "Protector": ["Athletics", "Endurance", "Survival", "Perception", "Persuasion", "Medicine"],
    "Blade": ["Acrobatics", "Deception", "Perception", "Sleight of Hand", "Stealth", "Thievery"],
    "Arcanist": ["Alchemy", "Arcana", "History", "Lore", "Nature"],
    "Shepherd": ["Medicine", "Nature", "Religion", "Survival"],
    "Intellect": ["History", "Lore", "Medicine", "Arcana", "Perception"],
    "Odd": ["Sleight of Hand", "Stealth", "Deception", "Acrobatics", "Performance"],
    "Leader": ["Persuasion", "Perception", "Insight", "Survival", "Endurance"],
    "Unbalanced": ["Arcana", "Deception", "Insight", "Perception", "Acrobatics"],
    "Shadow": ["Stealth", "Deception", "Sleight of Hand", "Thievery", "Acrobatics", "Perception"],
}

CASTING_SKILL = {"Arcanist": ("arcane", "Arcana"), "Intellect": ("arcane", "Arcana"),
                 "Shepherd": ("divine", "Religion"), "Odd": ("arcane", "Arcana"),
                 "Unbalanced": ("arcane", "Arcana"), "Leader": ("divine", "Religion")}

# Auto card plans: bought in order, after loadout ranks. Basic attacks are free
# and always available; these are the class-identity purchases.
AUTO_PLANS = {
    "Protector": ["Sanctuary"],
    "Blade": [],
    "Arcanist": ["Ember Lance", "Force Dart", "Brimstone Burst"],
    "Shepherd": ["Mending Touch", "Righteous Blow", "Bark Skin", "Restoration", "Tide of Life"],
    "Intellect": ["Force Dart"],
    "Odd": ["Ember Lance", "Mending Touch"],
    "Leader": ["Sanctuary"],
    "Unbalanced": ["Ember Lance"],
    "Shadow": [],
}

# Default weapon category per class (drives which Basic attack is primary).
CLASS_WEAPON = {
    "Protector": "one-hand", "Blade": "one-hand", "Arcanist": "one-hand", "Shepherd": "one-hand",
    "Intellect": "one-hand", "Odd": "ranged", "Leader": "two-hand", "Unbalanced": "two-hand",
    "Shadow": "one-hand",
}

ANCESTRIES = {
    "Human": {"discipline": None, "background_dp": 1, "trait": "Versatile"},
    "Elf": {"discipline": "Ranged", "background_dp": 0, "trait": "Elven Grace"},
    "Dwarf": {"discipline": "Melee", "background_dp": 0, "trait": "Sturdy", "hp_bonus": 2},
    "Halfling": {"discipline": "Melee", "background_dp": 0, "trait": "Lucky"},
}

CULTURES = {
    "Imperial": {"ancestry": "Human", "skills": ["Persuasion", "History"], "disciplines": None},
    "Nomadic": {"ancestry": "Human", "skills": ["Survival", "Nature"], "disciplines": ["Ranged", "Two-Handed"]},
    "Coastal": {"ancestry": "Human", "skills": ["Athletics", "Survival"], "disciplines": ["Two-Handed", "Shields"]},
    "High Elf": {"ancestry": "Elf", "skills": ["Arcana", "History"], "disciplines": ["Energy", "Melee"]},
    "Wood Elf": {"ancestry": "Elf", "skills": ["Stealth", "Nature"], "disciplines": ["Animal", "Ranged"]},
    "Twilight Elf": {"ancestry": "Elf", "skills": ["Deception", "Insight"], "disciplines": ["Water", "Melee"]},
    "Mountain": {"ancestry": "Dwarf", "skills": ["Craft", "Athletics"], "disciplines": ["Armor", "Melee"]},
    "Deep": {"ancestry": "Dwarf", "skills": ["Endurance", "Lore"], "disciplines": ["Melee", "Shields"]},
    "Hill": {"ancestry": "Dwarf", "skills": ["History", "Persuasion"], "disciplines": None},
    "Riverfolk": {"ancestry": "Halfling", "skills": ["Acrobatics", "Sleight of Hand"], "disciplines": ["Melee", "Ranged"]},
    "Burrower": {"ancestry": "Halfling", "skills": ["Stealth", "Survival"], "disciplines": ["Shields", "Melee"]},
    "Wanderer": {"ancestry": "Halfling", "skills": ["Insight", "Performance"], "disciplines": None},
}

ARMOR_DATA = {
    "light": {"rank": 1, "dr": 1, "slots": 2},
    "medium": {"rank": 2, "dr": 2, "slots": 3},
    "heavy": {"rank": 3, "dr": 3, "slots": 4},
}

# 16:108: a shield is one item - no rank, no DR, 1 slot; what Shields ranks
# buy is Shield Block depth (16:114).
SHIELD_DATA = {"slots": 1}

# 15:27: every equipment tag prints None in its Rank column, so gear asks for
# no Discipline rank; every weapon category carries a 0 surcharge.
WEAPON_RANK = {"unarmed": 0, "one-hand": 0, "two-hand": 0, "ranged": 0}


class BuildError(RuntimeError):
    pass


class LedgerEntry:
    __slots__ = ("wallet", "item", "detail", "dp")

    def __init__(self, wallet, item, detail, dp):
        self.wallet = wallet
        self.item = item
        self.detail = detail
        self.dp = dp


class Character:
    def __init__(self, cid, name, cls, level):
        self.id = cid
        self.name = name
        self.cls = cls
        self.level = level
        self.ancestry = None
        self.culture = None
        self.attributes = {}
        self.disciplines = {}
        self.skills = {}
        self.cards = []
        self.max_hp = 0
        self.hp = 0
        self.grit_max = 0
        self.grit = 0
        self.armor = None
        self.armor_dr = 0
        self.shield = None
        self.ward_dr = 0
        self.weapon = "one-hand"
        self.background_dp = 0
        self.class_dp = 0
        self.ledger = []
        self.notes = []
        self.wildcard = False

    @property
    def tier(self):
        tiers = default_rules().get("grit-tiers")["tiers"]
        for name, (low, high) in tiers.items():
            if low <= self.level <= high:
                return name
        raise BuildError(f"level {self.level} is outside the tier table (1-10)")

    @property
    def health_attribute(self):
        if self.cls == "Odd":
            return getattr(self, "notes_health", None) or "Guile"
        return CLASS_HEALTH[self.cls]

    def discipline_rank(self, name):
        return self.disciplines.get(name, 0)

    def skill_rank(self, name):
        return self.skills.get(name, 0)

    def has_card(self, name):
        return any(c.name == name for c in self.cards)

    def card(self, name):
        for card in self.cards:
            if card.name == name:
                return card
        return None

    def defense_options(self):
        agi = self.attributes.get("Agility", 0)
        brawn = self.attributes.get("Brawn", 0)
        options = [("raw", agi)]
        if self.skill_rank("Dodge"):
            options.append(("dodge", agi + self.skill_rank("Dodge")))
        if (self.weapon != "unarmed" or self.shield) and self.skill_rank("Parry"):
            options.append(("parry", brawn + self.skill_rank("Parry")))
        return options

    def defense(self):
        return max(self.defense_options(), key=lambda item: item[1])

    def casting_modifier(self, card):
        if card.casting == "arcane":
            return self.attributes.get("Knowledge", 0) + self.skill_rank("Arcana")
        if card.casting == "divine":
            return self.attributes.get("Reason", 0) + self.skill_rank("Religion")
        return 0

    def as_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "class": self.cls,
            "level": self.level,
            "tier": self.tier,
            "ancestry": self.ancestry,
            "culture": self.culture,
            "attributes": dict(self.attributes),
            "disciplines": dict(self.disciplines),
            "skills": dict(self.skills),
            "cards": [c.name for c in self.cards],
            "hp": self.max_hp,
            "grit": self.grit_max,
            "armor": self.armor,
            "armor_dr": self.armor_dr,
            "shield": self.shield,
            "ward_dr": self.ward_dr,
            "weapon": self.weapon,
            "dp": {"background": self.background_dp, "class": self.class_dp},
            "ledger": [{"wallet": e.wallet, "item": e.item, "detail": e.detail, "dp": e.dp} for e in self.ledger],
            "notes": list(self.notes),
        }


class Builder:
    def __init__(self, rules=None, cards=None):
        self.rules = rules or default_rules()
        self.cards = cards or CardBook(self.rules)

    def class_cost(self, cls, discipline, rank):
        if cls == "Odd":
            structure = "A"
        elif cls == "Unbalanced" and discipline in ("Fire", "Earth", "Wind", "Water"):
            structure = self._unbalanced_element_structure(discipline)
        else:
            structure = CLASS_COSTS[cls].get(discipline)
        if structure is None:
            raise BuildError(f"unknown discipline {discipline!r}")
        costs = COST_STRUCTURES[structure]
        if rank < 1 or rank > 3:
            raise BuildError(f"discipline rank {rank} outside 1-3")
        return costs[rank - 1]

    _unbalanced_pair = ("Fire", "Water")

    def _unbalanced_element_structure(self, discipline):
        if discipline in self._unbalanced_pair:
            return "H"
        return "O"

    def validate_attributes(self, attributes, level=1):
        if set(attributes) != set(ATTRIBUTE_NAMES):
            missing = set(ATTRIBUTE_NAMES) - set(attributes)
            extra = set(attributes) - set(ATTRIBUTE_NAMES)
            raise BuildError(f"attributes must be exactly the six: missing {sorted(missing)}, extra {sorted(extra)}")
        low, high = self.rules.get("attribute-range")
        for name, value in attributes.items():
            if value < low or value > high:
                raise BuildError(f"{name} {value:+d} outside the attribute range {low}..{high}")
        total = sum(attributes.values())
        expected = self.rules.get("attributes-sum")
        allowed = 1 if level >= 4 else 0
        allowed += 1 if level >= 8 else 0
        if total < expected or total > expected + allowed:
            raise BuildError(
                f"attribute sum is {total:+d}; creation must be +3 with at most {allowed} level increase(s)")

    def class_dp_budget(self, level):
        data = self.rules.get("level-dp-table")
        budget = self.rules.get("class-dp-level-one")["total"]
        for lvl in range(2, level + 1):
            budget += data.get(str(lvl), data.get(lvl, 0))
        return budget

    def background_dp_budget(self, attributes, ancestry):
        data = self.rules.get("background-dp")
        budget = data["base"] + attributes.get("Knowledge", 0) + attributes.get("Fortitude", 0)
        budget += ANCESTRIES[ancestry].get("background_dp", 0)
        return budget

    def build(self, spec):
        cid = spec.get("id") or spec.get("name") or spec["class"]
        name = spec.get("name") or cid
        cls = spec["class"]
        if cls not in CLASS_COSTS:
            raise BuildError(f"unknown class {cls!r}")
        level = int(spec.get("level", 1))
        if level < 1 or level > 10:
            raise BuildError(f"level {level} outside 1-10")
        ancestry = spec.get("ancestry")
        if ancestry not in ANCESTRIES:
            raise BuildError(f"unknown ancestry {ancestry!r}")
        culture = spec.get("culture")
        if culture not in CULTURES:
            raise BuildError(f"unknown culture {culture!r}")
        if CULTURES[culture]["ancestry"] != ancestry:
            raise BuildError(f"culture {culture!r} does not belong to ancestry {ancestry!r}")

        attributes = {k: int(v) for k, v in (spec.get("attributes") or {}).items()}
        self.validate_attributes(attributes, level)

        character = Character(cid, name, cls, level)
        character.ancestry = ancestry
        character.culture = culture
        character.attributes = attributes
        character.wildcard = cls == "Odd"
        character.notes_health = spec.get("health_attribute") or max(
            ATTRIBUTE_NAMES, key=lambda a: attributes[a])

        # --- grants -----------------------------------------------------
        granted = []
        ancestry_data = ANCESTRIES[ancestry]
        if ancestry_data["discipline"]:
            granted.append(ancestry_data["discipline"])
        else:
            choice = spec.get("ancestry_discipline")
            if not choice:
                choice = self._preferred_any(spec, cls, attributes)
            if choice not in DISCIPLINES:
                raise BuildError(f"ancestry_discipline {choice!r} is not a Discipline")
            granted.append(choice)
        culture_data = CULTURES[culture]
        if culture_data["disciplines"]:
            granted.extend(culture_data["disciplines"])
        else:
            choice = spec.get("culture_discipline")
            if not choice:
                choice = self._preferred_any(spec, cls, attributes, exclude=granted)
            if choice not in DISCIPLINES:
                raise BuildError(f"culture_discipline {choice!r} is not a Discipline")
            granted.append(choice)
        for discipline in CLASS_DISCIPLINES[cls]:
            granted.append(discipline)
        if cls == "Odd":
            picks = spec.get("odd_disciplines")
            if not picks:
                requested_now = list(spec.get("disciplines") or [])
                picks = requested_now if len(requested_now) == 2 else self._odd_default(spec)
            if len(picks) != 2:
                raise BuildError("Odd requires two starting Disciplines from different categories")
            granted.extend(picks)
        if cls == "Intellect":
            pick = spec.get("intellect_discipline") or self._preferred_any(spec, cls, attributes, exclude=granted)
            if pick not in DISCIPLINES:
                raise BuildError(f"intellect_discipline {pick!r} is not a Discipline")
            granted.append(pick)

        for discipline in granted:
            if discipline not in DISCIPLINES:
                raise BuildError(f"unknown discipline {discipline!r}")
            if discipline in character.disciplines:
                character.notes.append(f"{discipline} granted twice; second grant is waste (08:99)")
            character.disciplines[discipline] = 1

        # the run file may name disciplines the player bought as background
        requested = list(spec.get("disciplines") or [])
        for discipline in requested:
            if discipline not in DISCIPLINES:
                raise BuildError(f"unknown discipline {discipline!r} in disciplines")

        # culture skill bonus is a free +1 to one of the culture's skills
        culture_skill = spec.get("culture_skill")
        if culture_data["skills"]:
            options = culture_data["skills"]
            if culture_skill is None:
                culture_skill = self._preferred_skill(spec, options)
            if culture_skill not in options:
                raise BuildError(
                    f"culture_skill {culture_skill!r} must be one of {options}")
            character.skills[culture_skill] = 1
            character.notes.append(f"culture grants {culture_skill} +1")

        # --- background DP ----------------------------------------------
        bg_budget = self.background_dp_budget(attributes, ancestry)
        character.background_dp = bg_budget
        spent = 0
        for discipline in requested:
            if discipline in character.disciplines:
                character.notes.append(f"{discipline} already granted; requested rank is waste")
                continue
            cost = self.class_cost(cls, discipline, 1)
            if spent + cost > bg_budget:
                raise BuildError(
                    f"background DP exhausted: {discipline} rank 1 costs {cost}, "
                    f"{bg_budget - spent} of {bg_budget} remains")
            spent += cost
            character.disciplines[discipline] = 1
            character.ledger.append(LedgerEntry("background", f"{discipline} 1", "run file discipline", cost))
        # explicit skills first, then auto favoured skills while affordable
        explicit_skills = list(spec.get("skills") or []) if spec.get("skills") not in (None, "auto") else []
        auto_skills = [] if spec.get("skills") == [] else self._auto_skills(spec, cls, attributes, character)
        for skill in explicit_skills:
            if skill in character.skills:
                character.notes.append(f"{skill} already granted; second purchase is waste")
            cost = self.rules.get("skill-bonus")["dp"]["Novice"]
            if spent + cost > bg_budget:
                raise BuildError(f"background DP exhausted buying skill {skill}")
            character.skills[skill] = 1
            spent += cost
            character.ledger.append(LedgerEntry("background", f"{skill} Novice", "run file skill", cost))
        for skill in auto_skills:
            if skill in character.skills:
                continue
            cost = self.rules.get("skill-bonus")["dp"]["Novice"]
            if spent + cost > bg_budget:
                continue
            character.skills[skill] = 1
            spent += cost
            character.ledger.append(LedgerEntry("background", f"{skill} Novice", "auto", cost))
        # creation funds are spent, not banked (02:22): buy the cheapest
        # unheld rank-1 Discipline while any remains affordable
        while True:
            candidates = []
            for disc in DISCIPLINES:
                if disc in character.disciplines:
                    continue
                cost = self.class_cost(cls, disc, 1)
                if cost <= bg_budget - spent:
                    candidates.append((cost, disc))
            if not candidates:
                break
            cost, disc = min(candidates)
            character.disciplines[disc] = 1
            spent += cost
            character.ledger.append(LedgerEntry("background", f"{disc} 1", "spend-down", cost))
        character.notes.append(f"background DP {spent}/{bg_budget} spent")

        # --- class DP: equipment ranks ----------------------------------
        class_budget = self.class_dp_budget(level)
        character.class_dp = class_budget
        spent_class = 0
        equipment = spec.get("equipment") or {}
        weapon = equipment.get("weapon") or CLASS_WEAPON[cls]
        if weapon not in WEAPON_RANK:
            raise BuildError(f"unknown weapon category {weapon!r}")
        character.weapon = weapon
        armor_key = equipment.get("armor")
        if armor_key not in (None, "none"):
            if armor_key not in ARMOR_DATA:
                raise BuildError(f"unknown armor {armor_key!r}")
            required = ARMOR_DATA[armor_key]["rank"]
            spent_class += self._require_rank(character, "Armor", required, spent_class, class_budget)
            character.armor = armor_key
            character.armor_dr = ARMOR_DATA[armor_key]["dr"]
        shield_key = equipment.get("shield")
        if shield_key not in (None, "none"):
            character.shield = shield_key
        if equipment.get("ward_dr"):
            ward = int(equipment["ward_dr"])
            if ward < 0 or ward > 3:
                raise BuildError("ward_dr must be 0-3")
            character.ward_dr = ward

        # --- class DP: cards --------------------------------------------
        card_spec = spec.get("cards", "auto")
        if card_spec == "auto":
            plan = list(AUTO_PLANS[cls])
            for card_name in plan:
                try:
                    spent_class += self._buy_card(character, card_name, spent_class, class_budget, auto=True)
                except BuildError as exc:
                    character.notes.append(f"auto skipped {card_name}: {exc}")
        else:
            if not isinstance(card_spec, list):
                raise BuildError("cards must be 'auto' or an explicit list")
            for card_name in card_spec:
                spent_class += self._buy_card(character, card_name, spent_class, class_budget, auto=False)

        # --- class DP: skills -------------------------------------------
        for skill in auto_skills:
            if skill in character.skills:
                continue
            cost = self.rules.get("skill-bonus")["dp"]["Novice"]
            if spent_class + cost > class_budget:
                continue
            character.skills[skill] = 1
            spent_class += cost
            character.ledger.append(LedgerEntry("class", f"{skill} Novice", "auto", cost))
        character.notes.append(f"class DP {spent_class}/{class_budget} spent")
        character.notes.append(f"unspent DP: background {bg_budget - spent}, class {class_budget - spent_class}")

        # --- derived -----------------------------------------------------
        health_attr = character.health_attribute
        if health_attr is None or health_attr not in ATTRIBUTE_NAMES:
            raise BuildError(f"class {cls} needs an explicit health_attribute")
        hp = self.rules.get("hp-formula")["base"] + attributes["Fortitude"] + attributes[health_attr]
        hp += ANCESTRIES[ancestry].get("hp_bonus", 0)
        character.max_hp = hp
        character.hp = hp
        character.grit_max = self.rules.get("grit-tiers")[character.tier]
        character.grit = character.grit_max
        return character

    def _preferred_any(self, spec, cls, attributes, exclude=()):
        for card_name in AUTO_PLANS.get(cls, []):
            for discipline in self.cards.get(card_name).disciplines:
                if discipline not in exclude:
                    return discipline
        ranking = sorted(ATTRIBUTE_NAMES, key=lambda a: -attributes[a])
        priority = {"Brawn": "Melee", "Agility": "Ranged", "Knowledge": "Lore", "Reason": "Religion",
                    "Guile": "Stealth", "Fortitude": "Armor"}
        for attr in ranking:
            disc = priority.get(attr)
            if disc and disc not in exclude:
                return disc
        for disc in DISCIPLINES:
            if disc not in exclude:
                return disc
        raise BuildError("cannot choose a discipline")

    def _odd_default(self, spec):
        picks = []
        for card_name in ("Ember Lance", "Mending Touch"):
            for discipline in self.cards.get(card_name).disciplines:
                if discipline not in picks:
                    picks.append(discipline)
        return picks[:2]

    def _preferred_skill(self, spec, options):
        preference = ["Dodge", "Parry", "Arcana", "Religion", "Stealth", "Athletics"]
        for skill in preference:
            if skill in options:
                return skill
        return options[0]

    def _auto_skills(self, spec, cls, attributes, character):
        skills = []
        casting = CASTING_SKILL.get(cls)
        if casting:
            skills.append(casting[1])
        if attributes.get("Agility", 0) + 1 >= attributes.get("Brawn", 0):
            skills.append("Dodge")
        if character.shield or character.weapon == "one-hand":
            skills.append("Parry")
        for skill in CLASS_FAVORED.get(cls, []):
            if skill not in skills:
                skills.append(skill)
        return skills

    def _require_rank(self, character, discipline, rank, spent, budget):
        current = character.discipline_rank(discipline)
        total = 0
        for target in range(current + 1, rank + 1):
            cost = self.class_cost(character.cls, discipline, target)
            if spent + total + cost > budget:
                raise BuildError(
                    f"class DP exhausted raising {discipline} to {rank} for equipment "
                    f"({budget - spent - total} DP left, rank {target} costs {cost})")
            total += cost
            character.disciplines[discipline] = target
            character.ledger.append(LedgerEntry("class", f"{discipline} {target}", "equipment requirement", cost))
        return total

    def _buy_card(self, character, name, spent, budget, auto):
        card = self.cards.get(name)
        if character.level < self.cards.level_gate(name):
            raise BuildError(f"{name} is {card.tier} and gates at level {self.cards.level_gate(name)}")
        total = 0
        wildcard_used = False
        for discipline, rank in card.disciplines.items():
            current = character.discipline_rank(discipline)
            if character.wildcard and rank == 1 and current == 0 and not wildcard_used:
                character.notes.append(f"wildcard rank covers {discipline} 1 for {name}")
                wildcard_used = True
                continue
            for target in range(current + 1, rank + 1):
                cost = self.class_cost(character.cls, discipline, target)
                if spent + total + cost > budget and not card.free:
                    raise BuildError(f"cannot afford {discipline} {target} for {name} ({cost} DP)")
                total += cost
                character.disciplines[discipline] = target
                character.ledger.append(LedgerEntry("class", f"{discipline} {target}", f"prerequisite for {name}", cost))
        flat = self.rules.get("card-costs")[card.tier]["dp"]
        if not card.free:
            if spent + total + flat > budget:
                raise BuildError(f"cannot afford {name} ({card.tier}, {flat} DP)")
            total += flat
        character.cards.append(card)
        character.ledger.append(LedgerEntry("class", name, f"{card.tier} card", flat if not card.free else 0))
        return total


def build_party(specs, rules=None, cards=None):
    builder = Builder(rules, cards)
    party = []
    for spec in specs:
        party.append(builder.build(spec))
    return party
