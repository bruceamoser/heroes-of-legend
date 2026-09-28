"""The combat engine: it resolves attacks, reads cards, and applies the rules.

No expected values, no statistics: every attack is rolled, every defense is
rolled, DR is subtracted, wounds are rolled on the D666 table, and the
telemetry is the record of what happened.
"""

from __future__ import annotations

from .bestiary import Creature, creature as get_creature
from .cards import Card, CardBook
from .characters import Character, build_party
from .dice import STANDARD, STRONG, WEAK, Dice, combat_seed, tier_shift
from .rules import rules as default_rules

ACTION = "action"
MANEUVER = "maneuver"
REACTION = "reaction"

# 06:122-124: on a defense roll, high is good for the defender.
REVERSAL = {WEAK: STRONG, STANDARD: STANDARD, STRONG: WEAK}


def reverse_defense_tier(tier):
    return REVERSAL[tier]


def damage_after_dr(raw, dr, shield=0):
    """16:21, 16:96: subtract DR (and Shield Block DR), floor at 1."""
    if raw <= 0:
        return 0
    return max(1, raw - dr - shield)


def challenge_penalty(rating):
    """06:111: positive rating negated; minion tier and Challenge 1 are -1; cap -6."""
    if rating is None:
        return 0
    if rating <= 1:
        return -1
    return -min(rating, 6)


class Policy:
    def __init__(self, config=None):
        config = config or {}
        self.name = config.get("name", "default")
        self.target_selection = config.get("target_selection", "focus_lowest_hp")
        self.maneuver_priority = list(config.get("maneuver_priority", ["defend", "catch_breath"]))
        self.grit_at_zero = config.get("grit_at_zero", "spend")
        self.grit_wound_threshold = int(config.get("grit_wound_threshold", 4))
        self.heal_policy = config.get("heal_policy", "at_or_below_half")
        self.shield_block = bool(config.get("shield_block", True))
        self.notes = []
        if self.target_selection == "nearest":
            self.notes.append("nearest: positions are not modelled; treated as random (NON_GOALS.md)")

    def wants_heal(self):
        return self.heal_policy != "never"


class Condition:
    __slots__ = ("name", "rounds", "potency", "source", "ends")

    def __init__(self, name, rounds=None, potency=0, source=None, ends=None):
        self.name = name
        self.rounds = rounds
        self.potency = potency
        self.source = source
        self.ends = ends


class Combatant:
    __slots__ = (
        "key", "name", "side", "is_hero", "source", "policy",
        "attributes", "max_hp", "hp", "temp_hp", "grit", "grit_max", "tier",
        "armor_dr", "shield_dr", "ward_dr", "challenge_penalty", "creature",
        "cards", "weapon", "has_shield", "shield_size",
        "conditions", "reaction_ready", "action_ready", "maneuver_ready",
        "dying", "stable", "unconscious", "dead", "retired", "deaths_door",
        "death_failures", "wounds", "wound_rows",
        "defend_until_next_turn", "attack_boon_next", "attack_bane_next",
        "defense_boon", "defense_bane_rounds", "physical_bane_encounter",
        "attack_bane_encounter", "all_bane_encounter", "bane_next_brawn",
        "bleeding", "concentration", "concentration_card", "ward_active", "ward_card", "spell_used",
        "stats", "initiative", "last_damage_round", "is_creature",
        "focus_ok", "next_attack_tier_bonus", "regen_off_round",
    )

    def __init__(self, key, name, side, source, policy):
        self.key = key
        self.name = name
        self.side = side
        self.is_hero = isinstance(source, Character)
        self.is_creature = isinstance(source, Creature)
        self.source = source
        self.policy = policy
        if self.is_hero:
            self.attributes = dict(source.attributes)
            self.max_hp = source.max_hp
            self.grit_max = source.grit_max
            self.tier = source.tier
            self.armor_dr = source.armor_dr
            self.shield_dr = source.shield_dr
            self.ward_dr = source.ward_dr
            self.challenge_penalty = None
            self.cards = list(source.cards)
            self.weapon = source.weapon
            self.has_shield = source.shield is not None
            self.shield_size = source.shield
            self.focus_ok = source.cls != "Odd"
            self.creature = None
        else:
            self.attributes = dict(source.attributes)
            self.max_hp = source.hp
            self.grit_max = 0
            self.tier = None
            self.armor_dr = source.dr
            self.shield_dr = 0
            self.ward_dr = 0
            self.challenge_penalty = source.challenge_penalty
            self.cards = []
            self.weapon = None
            self.has_shield = False
            self.shield_size = None
            self.focus_ok = True
            self.creature = source
        self.hp = self.max_hp
        self.temp_hp = 0
        self.grit = self.grit_max
        self.conditions = {}
        self.reaction_ready = True
        self.action_ready = True
        self.maneuver_ready = True
        self.dying = False
        self.stable = False
        self.unconscious = False
        self.dead = False
        self.retired = False
        self.deaths_door = False
        self.death_failures = 0
        self.wounds = 0
        self.wound_rows = []
        self.defend_until_next_turn = False
        self.attack_boon_next = 0
        self.attack_bane_next = 0
        self.defense_boon = 0
        self.defense_bane_rounds = 0
        self.physical_bane_encounter = False
        self.attack_bane_encounter = False
        self.all_bane_encounter = False
        self.bane_next_brawn = False
        self.bleeding = False
        self.concentration = False
        self.concentration_card = None
        self.ward_active = 0
        self.ward_card = None
        self.spell_used = {}
        self.next_attack_tier_bonus = 0
        self.regen_off_round = -1
        self.last_damage_round = -1
        self.initiative = 0
        self.stats = {
            "damage_dealt": 0,
            "damage_taken": 0,
            "healing_done": 0,
            "heals_cast": 0,
            "attacks": 0,
            "crits": 0,
            "fumbles": 0,
            "drops": 0,
            "wounds_taken": 0,
            "grit_spent": 0,
            "conditions_applied": 0,
            "kills": 0,
        }

    @property
    def alive(self):
        return not self.dead

    @property
    def active(self):
        """Can take turns and be a threat."""
        return not self.dead and not self.unconscious and not self.dying and not self.retired

    def has_condition(self, name):
        return name in self.conditions

    def condition(self, name):
        return self.conditions.get(name)

    def add_condition(self, name, rounds=None, potency=0, source=None, ends=None):
        existing = self.conditions.get(name)
        if existing:
            if rounds is None or existing.rounds is None:
                existing.rounds = rounds
            else:
                existing.rounds = max(existing.rounds, rounds)
            existing.potency = max(existing.potency, potency)
            return existing
        self.conditions[name] = Condition(name, rounds, potency, source, ends)
        self.stats["conditions_applied"] += 1
        return self.conditions[name]

    def remove_condition(self, name):
        self.conditions.pop(name, None)

    def tick_conditions(self):
        ended = []
        for name, cond in list(self.conditions.items()):
            if cond.rounds is not None:
                cond.rounds -= 1
                if cond.rounds <= 0:
                    ended.append(name)
                    del self.conditions[name]
        return ended

    def effective_dr(self):
        ceiling = default_rules().get("dr-ceiling")[self.tier] if self.tier else 99
        ward = self.ward_active if self.ward_active else (self.ward_dr if self.concentration else 0)
        base = max(self.armor_dr, ward)
        return min(base, ceiling)

    def defense_formula(self):
        if self.is_creature:
            return ("raw", self.attributes.get("Agility", 0))
        options = [("raw", self.attributes.get("Agility", 0))]
        skills = self.source.skills
        if skills.get("Dodge"):
            options.append(("dodge", self.attributes.get("Agility", 0) + skills["Dodge"]))
        if (self.weapon != "unarmed" or self.has_shield) and skills.get("Parry"):
            options.append(("parry", self.attributes.get("Brawn", 0) + skills["Parry"]))
        return max(options, key=lambda item: item[1])

    def defense_bonus(self):
        kind, value = self.defense_formula()
        return kind, value

    def melee(self):
        return self.weapon != "ranged"


class Combat:
    def __init__(self, index, seed, party_specs, opposition_specs, policies=None, rules=None,
                 round_limit=20, script=None, rng=None, record_events=True, flags=None,
                 cards=None, party_chars=None):
        self.index = index
        self.rules = rules or default_rules()
        self.cardbook = cards or CardBook(self.rules)
        self.seed = seed
        self.flags = flags or {}
        self.round_limit = round_limit
        self.record_events = record_events
        self.events = []
        self.dice = Dice(rng if rng is not None else None, script)
        self.round = 0
        self.combatants = []
        self.policies = {}
        self.morale_checks = 0
        self._wound_rows = self.rules.wound_rows()
        self.specs = (party_specs, opposition_specs)
        self.policy_config = policies or {}
        self.party_chars = party_chars
        self._build()

    # ------------------------------------------------------------------ build
    def _build(self):
        policy_config = self.policy_config

        def make_policy(spec):
            name = spec.get("policy", "default") if isinstance(spec, dict) else "default"
            return Policy(policy_config.get(name, {}))

        party = list(self.party_chars) if self.party_chars else []
        if not party:
            for spec in self.specs[0]:
                char = build_party([spec], self.rules, self.cardbook)[0]
                party.append(char)
        opposition = []
        for spec in self.specs[1]:
            creature = get_creature(spec["creature"])
            if spec.get("challenge_override") is not None:
                creature = self._override_challenge(creature, spec["challenge_override"])
            opposition.append((creature, spec))

        for char in party:
            spec = next(s for s in self.specs[0] if (s.get("id") or s.get("name") or s["class"]) == char.id)
            self.combatants.append(Combatant(char.id, char.name, "party", char, make_policy(spec)))
        counters = {}
        for creature, spec in opposition:
            for i in range(int(spec.get("count", 1))):
                counters[creature.name] = counters.get(creature.name, 0) + 1
                key = f"{creature.name[:2].upper().replace(' ', '')}{counters[creature.name]}"
                self.combatants.append(
                    Combatant(key, creature.name, "opposition", creature, make_policy(spec)))

        # initiative: 3d6 + Agility, ties by Agility then roll-off; Shambling last
        for combatant in self.combatants:
            if combatant.is_creature and any(a.handler == "shambling" for a in combatant.creature.abilities):
                combatant.initiative = -10_000
                continue
            roll = self.dice.roll(combatant.attributes.get("Agility", 0))
            combatant.initiative = roll.total
        ordered = sorted(self.combatants, key=lambda c: (-c.initiative, -c.attributes.get("Agility", 0), c.key))
        # roll off exact ties
        i = 0
        while i < len(ordered):
            j = i
            while (j + 1 < len(ordered)
                   and ordered[j + 1].initiative == ordered[i].initiative
                   and ordered[j + 1].attributes.get("Agility", 0) == ordered[i].attributes.get("Agility", 0)):
                j += 1
            if j > i:
                for c in ordered[i:j + 1]:
                    c.initiative = c.initiative * 100 + self.dice.d6()
                ordered[i:j + 1] = sorted(ordered[i:j + 1], key=lambda c: -c.initiative)
            i = j + 1
        self.combatants = ordered

    def _override_challenge(self, creature, value):
        clone = Creature(
            creature.name, float(value), creature.challenge_text, creature.hp, creature.dr,
            dict(creature.attributes), creature.attacks, creature.multiattack, creature.abilities,
            creature.raw, list(creature.notes))
        return clone

    # --------------------------------------------------------------- helpers
    def living(self, side=None):
        return [c for c in self.combatants if c.active and (side is None or c.side == side)]

    def heroes(self):
        return [c for c in self.combatants if c.side == "party"]

    def opposition(self):
        return [c for c in self.combatants if c.side == "opposition"]

    def log(self, **event):
        if self.record_events:
            event["combat"] = self.index
            event["round"] = self.round
            self.events.append(event)

    def _pick_target(self, actor, candidates):
        if not candidates:
            return None
        policy = actor.policy
        if policy.target_selection == "focus_lowest_hp":
            return min(candidates, key=lambda c: (c.hp, c.key))
        if policy.target_selection == "focus_highest_threat":
            def threat(c):
                if c.is_creature:
                    avg = sum(sum(a.damage) for a in c.creature.attacks) / max(1, 3 * len(c.creature.attacks))
                    return avg * max(1, len(c.creature.attack_sequence()))
                return c.stats["damage_dealt"]
            return max(candidates, key=lambda c: (threat(c), c.key))
        # random and nearest (positions not modelled)
        return candidates[self.dice.rng.randrange(len(candidates))] if self.dice.script is None else candidates[0]

    # ---------------------------------------------------------------- attacks
    def _attack_modifier(self, actor, card):
        if card.casting:
            if actor.is_hero:
                if card.casting == "arcane":
                    return actor.attributes.get("Knowledge", 0) + actor.source.skill_rank("Arcana")
                return actor.attributes.get("Reason", 0) + actor.source.skill_rank("Religion")
            return 0
        if actor.is_creature:
            return 0
        if card.attribute:
            return actor.attributes.get(card.attribute, 0)
        if actor.weapon == "ranged" or card.requires == "weapon:ranged":
            return actor.attributes.get("Agility", 0)
        return actor.attributes.get("Brawn", 0)

    def _physical_bane(self, actor):
        return actor.physical_bane_encounter or actor.bane_next_brawn

    def attack_banes(self, actor, card):
        banes = 0
        boons = 0
        if actor.has_condition("Blinded"):
            banes += 2
        if actor.has_condition("Poisoned"):
            banes += 1
        if actor.has_condition("Restrained"):
            banes += 1
        if actor.attack_bane_next:
            banes += actor.attack_bane_next
        if actor.attack_bane_encounter:
            banes += 1
        if actor.all_bane_encounter:
            banes += 1
        if actor.physical_bane_encounter and not card.casting:
            banes += 1
        if actor.has_condition("Frightened"):
            banes += 1
        boons += actor.attack_boon_next
        if actor.has_condition("Hidden"):
            boons += 1
        return boons, banes

    def resolve_hero_attack(self, actor, target, card, pre_roll=None, pre_tier=None, pre_crit=False,
                            pre_fumble=False):
        boons, banes = self.attack_banes(actor, card)
        actor.attack_boon_next = 0
        actor.attack_bane_next = 0
        actor.bane_next_brawn = False
        modifier = self._attack_modifier(actor, card)
        if pre_roll is None:
            roll = self.dice.roll(modifier, boons, banes)
            actor.stats["attacks"] += 1
            tier = roll.tier
            fumble = roll.triple1
            critical = roll.triple6
            if critical:
                actor.stats["crits"] += 1
                tier = STRONG
            if fumble:
                actor.stats["fumbles"] += 1
                tier = WEAK
        else:
            roll = pre_roll
            tier = pre_tier
            critical = pre_crit
            fumble = pre_fumble
        # focus rule: a spell cast without its focus resolves one outcome lower
        focus_shift = 0
        if card.casting and card.requires and not actor.focus_ok:
            focus_shift = -1
        damage_tier = tier_shift(tier, focus_shift)
        tier_index = {WEAK: 0, STANDARD: 1, STRONG: 2}[damage_tier]
        raw = card.damage_at(tier_index)
        if card.attribute:
            raw += actor.attributes.get(card.attribute, 0)
        if actor.next_attack_tier_bonus:
            raw_tier = tier_shift(damage_tier, actor.next_attack_tier_bonus)
            raw = card.damage_at({WEAK: 0, STANDARD: 1, STRONG: 2}[raw_tier]) + (
                actor.attributes.get(card.attribute, 0) if card.attribute else 0)
            damage_tier = raw_tier
            actor.next_attack_tier_bonus = 0
        raw = max(0, raw)
        hp_before = target.hp
        dr = target.effective_dr() if target.is_hero else target.armor_dr
        shield = 0
        if target.is_hero and target.has_shield and target.policy.shield_block and target.reaction_ready \
                and raw > dr and target.shield_dr:
            shield = target.shield_dr
            target.reaction_ready = False
            self.log(event="shield_block", actor=target.key, shield_dr=shield)
        final = damage_after_dr(raw, dr, shield)
        self._damage(actor, target, final)
        if card.standard_boon_next_attack and tier in (STANDARD, STRONG):
            actor.attack_boon_next += 1
        if card.strong_condition and tier == STRONG:
            target.add_condition(card.strong_condition, rounds=3, source=actor.key)
        self.log(
            event="attack", actor=actor.key, target=target.key, action="attack",
            card=card.name, roll=roll.all_dice, kept=roll.kept, total=roll.total,
            damage_tier=damage_tier.lower(), raw_damage=raw, armor_dr=dr, shield_dr=shield,
            final_damage=final, target_hp_before=hp_before, target_hp_after=max(0, target.hp),
            critical=critical, fumble=fumble,
        )
        if fumble:
            self._fumble(actor, card)
        if critical:
            self._critical(actor, target, card)
        return final, roll, tier, critical, fumble

    def resolve_monster_attack(self, actor, target, attack, tier_bonus=0):
        """Kept for symmetry with the book's vocabulary; resolves one monster attack."""
        return self.monster_attack(actor, target, attack, tier_bonus)

    def _defense_roll(self, actor, target, attack):
        kind, defense_value = target.defense_bonus() if target.is_hero else ("raw", 0)
        boons = target.defense_boon
        banes = target.defense_bane_rounds
        if target.defend_until_next_turn:
            boons += 1
        if target.has_condition("Prone"):
            banes += 1
        if target.all_bane_encounter:
            banes += 1
        if target.physical_bane_encounter:
            banes += 1
        if target.bleeding and target.hp <= 0:
            banes += 1
        if actor.creature and self._pack_tactics(actor):
            banes += 1
        challenge = actor.challenge_penalty or 0
        modifier = defense_value + challenge
        roll = self.dice.roll(modifier, boons, banes)
        return roll

    def _pack_tactics(self, actor):
        handlers = {a.handler for a in actor.creature.abilities}
        if "pack_tactics" not in handlers and "leadership" not in handlers:
            return False
        living = [c for c in self.opposition() if c.active and c.creature.name == actor.creature.name]
        return len(living) >= 2

    def monster_attack(self, actor, target, attack, tier_bonus=0, recharge_used=None):
        defense_roll = self._defense_roll(actor, target, attack)
        reversed_tier = reverse_defense_tier(defense_roll.tier)
        if defense_roll.triple6:
            reversed_tier = WEAK
        if defense_roll.triple1:
            reversed_tier = STRONG
        damage_tier = tier_shift(reversed_tier, tier_bonus)
        index = {WEAK: 0, STANDARD: 1, STRONG: 2}[damage_tier]
        raw = attack.damage[index]
        hp_before = target.hp
        dr = target.effective_dr() if target.is_hero else target.armor_dr
        shield = 0
        if target.is_hero and target.has_shield and target.policy.shield_block and target.reaction_ready \
                and raw > dr and target.shield_dr:
            shield = target.shield_dr
            target.reaction_ready = False
            self.log(event="shield_block", actor=target.key, shield_dr=shield)
        final = damage_after_dr(raw, dr, shield)
        self._damage(actor, target, final)
        self.log(
            event="attack", actor=actor.key, target=target.key, action="attack",
            card=attack.name,
            defense_roll=defense_roll.all_dice, defense_kept=defense_roll.kept,
            defense_total=defense_roll.total, defense_tier=defense_roll.tier.lower(),
            damage_tier=damage_tier.lower(), raw_damage=raw, armor_dr=dr, shield_dr=shield,
            final_damage=final, target_hp_before=hp_before,
            target_hp_after=max(0, target.hp),
            critical=defense_roll.triple6, fumble=defense_roll.triple1,
        )
        if attack.condition_on_strong and damage_tier == STRONG:
            name, potency = attack.condition_on_strong
            target.add_condition(name, potency=potency, rounds=3, source=actor.key)
        if damage_tier == STRONG and any(a.handler == "knockdown" for a in actor.creature.abilities):
            target.add_condition("Prone", rounds=2, source=actor.key)
        if attack.auto:
            pass
        return final

    # --------------------------------------------------------------- damage
    def _damage(self, source, target, amount):
        if amount <= 0:
            return
        if target.temp_hp:
            absorbed = min(target.temp_hp, amount)
            target.temp_hp -= absorbed
            amount -= absorbed
            if amount <= 0:
                return
        hp_before = max(0, target.hp)
        target.hp -= amount
        applied = min(amount, hp_before)
        target.stats["damage_taken"] += applied
        if source is not target:
            source.stats["damage_dealt"] += applied
        if target.hp <= 0 and not target.dying and not target.dead:
            if target.is_hero:
                self._drop(source, target)
            else:
                self._creature_defeated(source, target)

    def _creature_defeated(self, source, target):
        for ability in target.creature.abilities:
            if ability.handler == "relentless":
                if ability.name.lower().startswith("relentless") and \
                        target.spell_used.get("relentless") and "once per day" in ability.text:
                    continue
                check = self.dice.roll(target.attributes.get("Fortitude", 0))
                target.spell_used["relentless"] = True
                self.log(event="relentless", actor=target.key, total=check.total, tier=check.tier.lower())
                if check.tier == STRONG:
                    target.hp = 1
                    return
        target.hp = 0
        target.dead = True
        target.unconscious = True
        if source is not None and source is not target:
            source.stats["kills"] += 1
        self.log(event="slain", actor=target.key, by=source.key if source else None)

    def _drop(self, source, target):
        target.stats["drops"] += 1
        target.wounds += 1
        target.stats["wounds_taken"] += 1
        extra = max(0, min(3, target.wounds - 1))
        kept, value = self.dice.d666(extra)
        row = self._wound_row(value)
        target.wound_rows.append({"d666": kept, "value": value, "row": row["name"]})
        self.log(event="wound", actor=target.key, d666=kept, d666_value=value,
                 row=row["name"], wounds=target.wounds, hp=target.hp)
        effect = row["mechanical"]
        self._apply_wound_effect(target, row)
        if effect == "dying-no-stabilize":
            target.deaths_door = True
            target.dying = True
            target.unconscious = True
            target.hp = 0
            return
        spend = self._grit_decision(target)
        if spend and target.grit > 0:
            target.grit -= 1
            target.stats["grit_spent"] += 1
            target.hp = target.max_hp
            self.log(event="grit", actor=target.key, grit_left=target.grit, hp=target.max_hp)
        else:
            target.dying = True
            target.unconscious = True
            target.hp = 0

    def _grit_decision(self, target):
        if target.grit <= 0 or not target.is_hero:
            return False
        policy = target.policy.grit_at_zero
        if policy == "spend":
            return True
        if policy == "stay_down":
            return False
        if policy == "spend_if_wounded_below_n":
            return target.wounds < target.policy.grit_wound_threshold
        return True

    def _apply_wound_effect(self, target, row):
        effect = row["mechanical"]
        if effect == "bane-next-brawn":
            target.bane_next_brawn = True
        elif effect == "bane-next-attack":
            target.attack_bane_next += 1
        elif effect == "bleed-1-per-turn":
            target.bleeding = True
        elif effect == "bane-attacks-encounter":
            target.attack_bane_encounter = True
        elif effect == "bane-physical-encounter":
            target.physical_bane_encounter = True
        elif effect == "bane-all-rolls":
            target.all_bane_encounter = True
        elif effect in ("permanent-loss", "permanent-limb", "limb-unusable"):
            target.attack_bane_encounter = True
        elif effect == "speech-limit":
            target.spell_used["punctured_lung"] = True

    def _wound_row(self, value):
        for row in self._wound_rows:
            low, high = row["range"]
            if low <= value <= high:
                return row
        return {"name": "Unnamed (gap in the printed table)", "mechanical": "none", "range": [value, value]}

    def _fumble(self, actor, card):
        complication = self.dice.d6()
        self.log(event="fumble", actor=actor.key, severity=complication, card=card.name)

    def _critical(self, actor, target, card):
        bonus = self.dice.d6()
        if bonus == 1:
            pass
        elif bonus == 2:
            target.add_condition("Prone", rounds=2, source=actor.key)
        self.log(event="critical", actor=actor.key, target=target.key, severity=bonus)

    # ------------------------------------------------------------------ turns
    def _heal_target(self, healer):
        policy = healer.policy
        allies = [c for c in self.heroes() if not c.dead and not c.retired]
        if not allies:
            return None
        if policy.heal_policy == "only_at_zero":
            pool = [c for c in allies if c.hp <= 0]
        elif policy.heal_policy == "at_or_below_half":
            pool = [c for c in allies if c.hp <= c.max_hp // 2 or c.dying]
        else:
            pool = list(allies)
        if not pool:
            return None
        return min(pool, key=lambda c: (c.hp - (1000 if c.dying else 0), c.key))

    def _heal_cards(self, healer):
        return [c for c in healer.cards if c.kind == "heal"]

    def _can_cast(self, healer, card):
        if card.tier in ("Adept", "Master") and healer.spell_used.get(card.name):
            return False
        if healer.spell_used.get("punctured_lung"):
            check = self.dice.roll(healer.attributes.get("Fortitude", 0))
            if check.tier == WEAK:
                return False
        return True

    def heal(self, healer, target, card):
        modifier = self._attack_modifier(healer, card)
        boons, banes = self.attack_banes(healer, card)
        roll = self.dice.roll(modifier, boons, banes)
        if roll.triple1:
            tier = WEAK
        elif roll.triple6:
            tier = STRONG
        else:
            tier = roll.tier
        healer.stats["heals_cast"] += 1
        if card.tier in ("Adept", "Master"):
            healer.spell_used[card.name] = True
        hp_before = target.hp
        was_dying = target.dying
        if tier == WEAK:
            threshold = (target.max_hp + 1) // 2
        else:
            threshold = target.max_hp
        target.hp = max(target.hp, threshold)
        if target.hp > 0 and was_dying and not target.deaths_door:
            target.dying = False
            target.unconscious = False
            target.stable = False
            target.death_failures = 0
        if tier == STRONG:
            if card.strong_ends_conditions:
                target.conditions.clear()
            elif card.strong_ends_one_condition and target.conditions:
                target.remove_condition(next(iter(target.conditions)))
            if target.attack_bane_next:
                target.attack_bane_next -= 1
            target.attack_boon_next += 1
        healer.stats["healing_done"] += max(0, target.hp - hp_before)
        self.log(event="heal", actor=healer.key, target=target.key, card=card.name,
                 roll=roll.all_dice, total=roll.total, tier=tier.lower(),
                 target_hp_before=hp_before, target_hp_after=target.hp)
        return target.hp

    def _bind_bleed(self, actor):
        roll = self.dice.roll(actor.attributes.get("Reason", 0) + actor.source.skill_rank("Medicine"))
        if roll.tier in (STANDARD, STRONG):
            actor.bleeding = False
            self.log(event="bind_bleed", actor=actor.key, total=roll.total, success=True)
            return True
        self.log(event="bind_bleed", actor=actor.key, total=roll.total, success=False)
        return False

    def take_turn(self, actor):
        if actor.dead or actor.retired:
            return
        if actor.is_creature and actor.creature and any(a.handler == "shambling" for a in actor.creature.abilities):
            pass
        # start of turn
        actor.action_ready = True
        actor.maneuver_ready = True
        actor.defend_until_next_turn = False
        if actor.is_creature:
            self._regenerate(actor)
        if actor.bleeding:
            self._damage(actor, actor, 1)
            self.log(event="bleed", actor=actor.key, damage=1)
        if actor.has_condition("Burning"):
            pot = actor.condition("Burning").potency or 1
            self._damage(actor, actor, pot)
            self.log(event="condition_tick", actor=actor.key, condition="Burning", damage=pot)
        if actor.has_condition("Poisoned"):
            pot = actor.condition("Poisoned").potency or 1
            self._damage(actor, actor, pot)
            self.log(event="condition_tick", actor=actor.key, condition="Poisoned", damage=pot)
        if actor.dead:
            return
        if actor.dying:
            self.death_roll(actor)
            return
        if actor.unconscious:
            return
        if actor.has_condition("Stunned") or actor.has_condition("Incapacitated"):
            self.log(event="turn_skipped", actor=actor.key, reason="stunned")
            return
        if actor.is_hero:
            self._hero_turn(actor)
        else:
            self._creature_turn(actor)

    def death_roll(self, actor):
        wounds = actor.wounds
        bane = 0 if wounds <= 1 else (1 if wounds == 2 else (2 if wounds == 3 else 3))
        if actor.bleeding:
            bane += 1
        roll = self.dice.roll(0, 0, bane)
        self.log(event="death_roll", actor=actor.key, kept=roll.kept, total=roll.total,
                 tier=roll.tier.lower(), failures=actor.death_failures, bane=bane,
                 triple6=roll.triple6, triple1=roll.triple1)
        if roll.triple1:
            self._die(actor)
            return
        if roll.triple6:
            actor.hp = max(1, (actor.max_hp + 1) // 2)
            actor.dying = False
            actor.unconscious = False
            actor.deaths_door = False
            actor.death_failures = 0
            return
        if roll.tier == STRONG:
            actor.hp = 1
            actor.dying = False
            actor.unconscious = False
            actor.deaths_door = False
            actor.stable = True
            actor.death_failures = 0
            return
        if roll.tier == STANDARD:
            actor.stable = True
            actor.death_failures = 0
            return
        actor.death_failures += 1
        if actor.death_failures >= 3:
            self._die(actor)
        elif actor.deaths_door and actor.death_failures:
            pass

    def _die(self, actor):
        actor.dead = True
        actor.dying = False
        actor.unconscious = True
        actor.hp = 0
        self.log(event="death", actor=actor.key, round=self.round)

    def _regenerate(self, actor):
        if not actor.creature:
            return
        if not any(a.handler == "regeneration" for a in actor.creature.abilities):
            return
        if actor.hp <= 0:
            return
        if actor.regen_off_round >= self.round - 1:
            return
        before = actor.hp
        actor.hp = min(actor.max_hp, actor.hp + 5)
        if actor.hp != before:
            self.log(event="regeneration", actor=actor.key, hp_before=before, hp_after=actor.hp)

    # -------------------------------------------------------------- hero turn
    def _hero_turn(self, actor):
        # Concentration: a ward is held by spending the Maneuver every turn
        # (10:110). Not spending it ends the effect.
        actor.ward_active = 0
        if actor.concentration:
            if actor.maneuver_ready:
                actor.maneuver_ready = False
                actor.ward_active = actor.ward_card.ward_dr if actor.ward_card else 0
                self.log(event="concentration", actor=actor.key,
                         card=actor.ward_card.name if actor.ward_card else None,
                         ward_dr=actor.ward_active, sustained=True)
            else:
                self.log(event="concentration_end", actor=actor.key,
                         card=actor.ward_card.name if actor.ward_card else None)
                actor.concentration = False
                actor.ward_card = None
        if not actor.concentration and actor.maneuver_ready:
            ward = self._ward_card(actor)
            if ward is not None:
                actor.concentration = True
                actor.ward_card = ward
                actor.ward_active = ward.ward_dr
                actor.maneuver_ready = False
                self.log(event="cast", actor=actor.key, card=ward.name, ward_dr=ward.ward_dr)
        if actor.maneuver_ready:
            for priority in actor.policy.maneuver_priority:
                if priority == "defend":
                    self._defend(actor)
                    break
                if priority == "catch_breath":
                    if self._try_catch_breath(actor):
                        break
        # Action: heal, bind, or attack
        healed = False
        if actor.policy.wants_heal() and actor.action_ready:
            heal_card = self._first_usable_heal(actor)
            if heal_card:
                target = self._heal_target(actor)
                if target is not None:
                    self.heal(actor, target, heal_card)
                    actor.action_ready = False
                    healed = True
        if not healed and actor.bleeding and actor.action_ready and actor.hp > 1:
            if self._bind_bleed(actor):
                actor.action_ready = False
        if actor.action_ready:
            enemies = self.living("opposition")
            target = self._pick_target(actor, enemies)
            if target is not None:
                card = self._attack_card(actor, target)
                if card:
                    if card.area:
                        self._resolve_area_attack(actor, card, enemies)
                    else:
                        self.resolve_hero_attack(actor, target, card)
                actor.action_ready = False

    def _resolve_area_attack(self, actor, card, targets):
        primary = targets[0]
        final, roll, tier, critical, fumble = self.resolve_hero_attack(actor, primary, card)
        for target in targets[1:]:
            if not target.active:
                continue
            self.resolve_hero_attack(actor, target, card, pre_roll=roll, pre_tier=tier,
                                     pre_crit=critical, pre_fumble=fumble)

    def _ward_card(self, actor):
        for card in actor.cards:
            if card.kind == "ward" and self._can_cast(actor, card):
                return card
        return None

    def _first_usable_heal(self, actor):
        for card in self._heal_cards(actor):
            if self._can_cast(actor, card):
                return card
        return None

    def _attack_card(self, actor, target):
        best = None
        best_score = -1
        for card in actor.cards:
            if card.kind != "attack":
                continue
            if not self._can_cast(actor, card):
                continue
            if card.requires == "weapon:ranged" and actor.weapon != "ranged":
                continue
            if card.requires == "weapon:one-hand" and actor.weapon == "ranged":
                continue
            tier_index = 1
            score = card.damage_at(tier_index)
            if card.attribute:
                score += actor.attributes.get(card.attribute, 0)
            if score > best_score:
                best_score = score
                best = card
        if best is not None:
            return best
        # Basic attacks are always available (09:223)
        return self._basic_attack(actor)

    def _basic_attack(self, actor):
        book = self.cardbook
        if actor.weapon == "ranged":
            return book.get("Basic Archery")
        if actor.weapon == "two-hand":
            return book.get("Basic Two-Handed")
        if actor.weapon == "unarmed":
            return book.get("Basic Unarmed")
        return book.get("Basic Melee")

    def _defend(self, actor):
        actor.defend_until_next_turn = True
        actor.maneuver_ready = False
        self.log(event="maneuver", actor=actor.key, maneuver="defend")

    def _try_catch_breath(self, actor):
        if not actor.maneuver_ready:
            return False
        if actor.hp >= actor.max_hp:
            return False
        uses_key = "catch_breath"
        used = actor.spell_used.get(uses_key, 0)
        if used >= actor.grit_max:
            return False
        amount = (actor.max_hp + 2) // 3
        before = actor.hp
        actor.hp = min(actor.max_hp, actor.hp + amount)
        actor.maneuver_ready = False
        actor.spell_used[uses_key] = used + 1
        self.log(event="maneuver", actor=actor.key, maneuver="catch_breath",
                 healed=actor.hp - before, uses_left=actor.grit_max - used - 1)
        return True

    # ---------------------------------------------------------- creature turn
    def _creature_turn(self, actor):
        targets = self.living("party")
        if not targets:
            return
        target = self._pick_target(actor, targets)
        sequence = actor.creature.attack_sequence()
        if not sequence:
            return
        for attack, count, optional in sequence:
            if optional:
                if not self._recharge_ready(actor, attack):
                    continue
            tier_bonus = self._creature_tier_bonus(actor, target)
            for _ in range(count):
                if target.dead or not target.active:
                    replacement = self._pick_target(actor, self.living("party"))
                    if replacement is None:
                        return
                    target = replacement
                # auto attacks (Swarm of Rats) always deal their damage
                if attack.auto:
                    self._damage(actor, target, attack.damage[1])
                    self.log(event="attack", actor=actor.key, target=target.key, action="attack",
                             card=attack.name, damage_tier="automatic", raw_damage=attack.damage[1],
                             armor_dr=0, shield_dr=0, final_damage=attack.damage[1],
                             target_hp_before=target.hp + attack.damage[1], target_hp_after=target.hp)
                    continue
                self.monster_attack(actor, target, attack, tier_bonus)
                if attack.recharge:
                    self._spend_recharge(actor, attack)

    def _recharge_ready(self, actor, attack):
        state = actor.spell_used.get(f"recharge:{attack.name}")
        if state is None:
            return True
        if state == self.round:
            return False
        roll = self.dice.d6()
        ready = roll >= 5
        self.log(event="recharge", actor=actor.key, ability=attack.name, roll=roll, ready=ready)
        if ready:
            actor.spell_used.pop(f"recharge:{attack.name}", None)
        return ready

    def _spend_recharge(self, actor, attack):
        actor.spell_used[f"recharge:{attack.name}"] = self.round

    def _creature_tier_bonus(self, actor, target):
        bonus = 0
        for ability in actor.creature.abilities:
            if ability.handler == "blood_frenzy" and actor.hp <= actor.max_hp // 2:
                bonus += 1
            if ability.handler == "martial_advantage":
                if self._pack_tactics(actor):
                    bonus += 1
        return bonus

    # ------------------------------------------------------------------ rounds
    def run(self):
        for combatant in self.combatants:
            if combatant.is_hero:
                self.log(event="build", actor=combatant.key, max_hp=combatant.max_hp,
                         tier=combatant.tier, grit=combatant.grit, disposition="hero")
            else:
                self.log(event="build", actor=combatant.key, max_hp=combatant.max_hp,
                         challenge=combatant.creature.challenge,
                         attacks=len(combatant.creature.attack_sequence()),
                         stubbed=combatant.creature.stubbed_abilities, disposition="creature")
        outcome = None
        while self.round < self.round_limit:
            self.round += 1
            for combatant in self.combatants:
                combatant.reaction_ready = True
            for combatant in self.combatants:
                if not combatant.dead and not combatant.retired:
                    self.take_turn(combatant)
                state = self._check_end()
                if state:
                    outcome = state
                    break
            if outcome:
                break
            for combatant in self.combatants:
                ended = combatant.tick_conditions()
                for name in ended:
                    self.log(event="condition_end", actor=combatant.key, condition=name)
        if outcome is None:
            outcome = "timeout"
        retired = []
        for combatant in self.heroes():
            if combatant.wounds >= self.rules.get("wound-retirement")["retire_at"] and not combatant.dead:
                combatant.retired = True
                retired.append(combatant.key)
        return self._result(outcome, retired)

    def _check_end(self):
        opposition_left = self.living("opposition")
        party_left = self.living("party")
        if not opposition_left:
            return "party_win"
        if not party_left:
            return "party_loss"
        return None

    def _result(self, outcome, retired):
        heroes = []
        for c in self.heroes():
            heroes.append({
                "id": c.key,
                "class": c.source.cls,
                "level": c.source.level,
                "tier": c.tier,
                "hp": max(0, c.hp),
                "max_hp": c.max_hp,
                "wounds": c.wounds,
                "wound_rows": list(c.wound_rows),
                "grit_spent": c.stats["grit_spent"],
                "dropped": c.stats["drops"],
                "damage_dealt": c.stats["damage_dealt"],
                "damage_taken": c.stats["damage_taken"],
                "heals_cast": c.stats["heals_cast"],
                "healing_done": c.stats["healing_done"],
                "conditions_applied": c.stats["conditions_applied"],
                "attacks": c.stats["attacks"],
                "crits": c.stats["crits"],
                "fumbles": c.stats["fumbles"],
                "died": c.dead,
                "retired": c.retired,
                "dying_at_end": c.dying and not c.dead,
                "alive": not c.dead,
            })
        creatures = [{
            "id": c.key,
            "name": c.creature.name,
            "challenge": c.creature.challenge,
            "slain": c.dead,
            "damage_taken": c.stats["damage_taken"],
            "damage_dealt": c.stats["damage_dealt"],
        } for c in self.opposition()]
        return {
            "combat": self.index,
            "seed": self.seed,
            "outcome": outcome,
            "rounds": self.round,
            "heroes": heroes,
            "creatures": creatures,
            "retired": retired,
            "events": self.events if self.record_events else None,
        }


def run_combat(index, seed, party_specs, opposition_specs, policy_config=None, round_limit=20,
               script=None, record_events=False, flags=None, rules=None, cards=None,
               party_chars=None, rng=None):
    combat_seed_value = combat_seed(seed, index)
    if rng is None:
        import random
        rng = random.Random(combat_seed_value)
    combat = Combat(index, combat_seed_value, party_specs, opposition_specs, policy_config,
                    rules=rules, round_limit=round_limit, script=script, rng=rng,
                    record_events=record_events, flags=flags, cards=cards,
                    party_chars=party_chars)
    return combat.run()
