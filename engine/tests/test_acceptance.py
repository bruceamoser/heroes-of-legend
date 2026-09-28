"""Acceptance tests for the Heroes of Legend combat engine.

Nine criteria from the specification, section 11, plus regression tests for
the parsing, validation and audited constants the engine depends on.

Run with:  python -m unittest discover engine/tests -v
"""

from __future__ import annotations

import json
import random
import sys
import tempfile
import time
import unittest
from pathlib import Path

ENGINE_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ENGINE_DIR))

from hol_engine.bestiary import bestiary, parse_bestiary  # noqa: E402
from hol_engine.cards import CardBook  # noqa: E402
from hol_engine.characters import BuildError, build_party  # noqa: E402
from hol_engine.combat import Combat, damage_after_dr  # noqa: E402
from hol_engine.dice import Dice, WEAK, STANDARD, STRONG, combat_seed, tier_for  # noqa: E402
from hol_engine.examples import run_all_examples  # noqa: E402
from hol_engine.reports import run_all, summarize, write_outputs  # noqa: E402
from hol_engine.rules import Rules  # noqa: E402
from hol_engine.runfile import load, validate  # noqa: E402

RUNFILES = ENGINE_DIR / "runfiles"

HERO_SPECS = [
    {"id": "P1", "class": "Protector", "level": 1, "ancestry": "Dwarf", "culture": "Mountain",
     "attributes": {"Brawn": 2, "Fortitude": 1, "Agility": -1, "Guile": 0, "Knowledge": 0, "Reason": 1},
     "disciplines": ["Armor", "Shields"], "cards": "auto",
     "equipment": {"armor": "heavy", "shield": "large"}},
    {"id": "P2", "class": "Shepherd", "level": 1, "ancestry": "Dwarf", "culture": "Hill",
     "attributes": {"Brawn": -1, "Fortitude": 1, "Agility": 0, "Guile": 1, "Knowledge": 0, "Reason": 2},
     "disciplines": ["Protection", "Animal"], "cards": "auto",
     "equipment": {"armor": "light", "weapon": "one-hand"}},
    {"id": "P3", "class": "Blade", "level": 1, "ancestry": "Elf", "culture": "Twilight Elf",
     "attributes": {"Brawn": 1, "Fortitude": 0, "Agility": 2, "Guile": 1, "Knowledge": -1, "Reason": 0},
     "disciplines": ["Melee", "Stealth"], "cards": "auto",
     "equipment": {"armor": "light", "weapon": "one-hand"}},
    {"id": "P4", "class": "Arcanist", "level": 1, "ancestry": "Human", "culture": "Imperial",
     "attributes": {"Brawn": 0, "Fortitude": 0, "Agility": 0, "Guile": 0, "Knowledge": 2, "Reason": 1},
     "disciplines": ["Fire", "Energy"], "cards": "auto",
     "equipment": {"armor": "none", "weapon": "one-hand"}},
]

POLICIES = {
    "default": {"target_selection": "focus_lowest_hp", "maneuver_priority": ["defend", "catch_breath"],
                "grit_at_zero": "spend", "heal_policy": "at_or_below_half", "shield_block": True},
    "stay": {"target_selection": "focus_lowest_hp", "maneuver_priority": ["defend"],
             "grit_at_zero": "stay_down", "heal_policy": "at_or_below_half", "shield_block": True},
}


def make_combat(party=None, opposition=None, policies=None, script=None, index=0, seed=1):
    party = party if party is not None else HERO_SPECS
    opposition = opposition if opposition is not None else [{"creature": "Goblin", "count": 2}]
    policies = policies if policies is not None else POLICIES
    rules = Rules()
    cardbook = CardBook(rules)
    rng = random.Random(combat_seed(seed, index))
    return Combat(index, seed, party, opposition, policies, rules=rules, rng=rng,
                  script=script, record_events=True, cards=cardbook)


def by_key(combat, key):
    for combatant in combat.combatants:
        if combatant.key == key:
            return combatant
    raise KeyError(key)


class TestPrintedExamples(unittest.TestCase):
    """Acceptance 1: the engine reproduces every printed worked example."""

    def test_all_printed_examples(self):
        report = run_all_examples()
        self.assertEqual(set(report), {"06:142", "06:152", "13:304", "13:487", "13:569", "16:130"})
        failures = []
        for name, observations in report.items():
            for observation in observations:
                if not observation.ok:
                    failures.append(repr(observation))
        self.assertEqual(failures, [], "\n".join(failures))

    def test_06_142_through_the_combat_loop(self):
        """The goblin's attack is resolved by a real Combat, not a helper."""
        party = [{
            "id": "K", "class": "Blade", "level": 1, "ancestry": "Human", "culture": "Coastal",
            "attributes": {"Brawn": 0, "Fortitude": 0, "Agility": 2, "Guile": 1, "Knowledge": 0, "Reason": 0},
            "disciplines": ["Melee", "Stealth"], "skills": [], "cards": [],
            "equipment": {"armor": "light", "weapon": "one-hand"},
        }]
        # Kael has 13 HP, light armor DR 1, Agility +2, no Dodge (rank 0 here)
        # script: K initiative, goblin initiative, Kael's attack, Kael's defense
        # 2 initiative rolls, then the goblin's attack on Kael
        script = [[1, 1, 1], [1, 1, 1], [4, 3, 5]]
        combat = make_combat(party=party, opposition=[{"creature": "Goblin", "count": 1}],
                             script=script)
        goblin = combat.opposition()[0]
        combat.take_turn(goblin)
        attacks = [e for e in combat.events if e.get("event") == "attack" and e.get("target") == "K"]
        self.assertTrue(attacks, "the goblin never attacked")
        attack = attacks[0]
        self.assertEqual(attack["defense_total"], 13)
        self.assertEqual(attack["defense_tier"], "standard")
        self.assertEqual(attack["final_damage"], 5)
        self.assertEqual(by_key(combat, "K").stats["damage_taken"], 5)


class TestAudit(unittest.TestCase):
    """Acceptance 2: --audit passes."""

    def test_every_citation_matches(self):
        rules = Rules()
        ok, failures = rules.audit()
        self.assertTrue(ok, "\n".join(json.dumps(f) for f in failures))

    def test_cli_audit_exit_code(self):
        from hol_engine.cli import main
        self.assertEqual(main(["audit"]), 0)


class TestDefensiveLayers(unittest.TestCase):
    """Acceptances 3 and 4: ward-on-armour is a no-op; Shield Block floors at 1."""

    def test_ward_on_armour_is_a_noop(self):
        combat = make_combat()
        hero = by_key(combat, "P1")
        self.assertEqual(hero.armor_dr, 3)
        hero.ward_dr = 2
        hero.concentration = True
        self.assertEqual(hero.effective_dr(), 3)
        # and the whole damage pipeline agrees with armour alone
        self.assertEqual(damage_after_dr(6, hero.effective_dr()), damage_after_dr(6, 3))

    def test_ward_capped_by_tier_ceiling(self):
        combat = make_combat()
        hero = by_key(combat, "P1")
        hero.armor_dr = 0
        hero.ward_dr = 2
        hero.concentration = True
        self.assertEqual(hero.effective_dr(), 2)
        hero.ward_dr = 3
        self.assertEqual(hero.effective_dr(), 3)
        hero.ward_dr = 6
        self.assertEqual(hero.effective_dr(), 3)

    def test_shield_dr_never_below_one(self):
        self.assertEqual(damage_after_dr(1, 0, 3), 1)
        self.assertEqual(damage_after_dr(2, 0, 3), 1)
        self.assertEqual(damage_after_dr(4, 0, 3), 1)
        self.assertEqual(damage_after_dr(6, 3, 1), 2)

    def test_shield_block_once_per_round(self):
        # 6 initiative rolls, then two defense rolls
        script = [[1, 1, 1], [2, 2, 2], [3, 3, 3], [5, 5, 5], [2, 2, 2], [3, 3, 3]] + [[4, 4, 4], [4, 4, 4]]
        combat = make_combat(script=script)
        hero = by_key(combat, "P1")
        hero.hp = 100
        creature = combat.opposition()[0]
        attack = creature.creature.attacks[0]
        combat.monster_attack(creature, hero, attack)
        self.assertFalse(hero.reaction_ready)
        first = hero.stats["damage_taken"]
        combat.monster_attack(creature, hero, attack)
        second = hero.stats["damage_taken"] - first
        # Gorma: heavy DR 3, large shield DR 3, goblin Standard 6
        self.assertEqual(first, 1)
        self.assertEqual(second, 3)


class TestWounds(unittest.TestCase):
    """Acceptances 5 and 6."""

    def test_every_drop_costs_exactly_one_wound_even_if_healed(self):
        combat = make_combat(policies={**POLICIES, "default": {**POLICIES["default"], "grit_at_zero": "spend"}})
        hero = by_key(combat, "P1")
        creature = combat.opposition()[0]
        hero.hp = 1
        combat._damage(creature, hero, 5)
        self.assertEqual(hero.wounds, 1)
        self.assertEqual(len(hero.wound_rows), 1)
        # a grit spend gets the hero up, and does not undo the wound
        self.assertGreater(hero.hp, 1)
        # a heal in the same round does not undo it either
        healer = by_key(combat, "P2")
        combat.heal(healer, hero, healer.source.card("Mending Touch"))
        self.assertEqual(hero.wounds, 1)

    def test_every_drop_is_one_wound_stay_down(self):
        combat = make_combat(policies={**POLICIES, "default": POLICIES["stay"]})
        hero = by_key(combat, "P1")
        creature = combat.opposition()[0]
        hero.hp = 1
        combat._damage(creature, hero, 5)
        self.assertEqual(hero.wounds, 1)
        self.assertTrue(hero.dying)
        self.assertEqual(hero.hp, 0)

    def test_no_effect_removes_a_wound(self):
        combat = make_combat()
        hero = by_key(combat, "P1")
        healer = by_key(combat, "P2")
        hero.wounds = 3
        cardbook = CardBook(Rules())
        for card in cardbook.cards.values():
            if card.kind == "heal":
                combat.heal(healer, hero, card)
                self.assertEqual(hero.wounds, 3, f"{card.name} removed a wound")
        # condition-ending effects do not remove wounds either
        hero.add_condition("Poisoned", rounds=3, potency=2)
        restoration = cardbook.get("Restoration")
        healer.source.level = 3
        combat.heal(healer, hero, restoration)
        self.assertEqual(hero.wounds, 3)
        # stabilization and death rolls do not remove wounds
        hero.dying = True
        hero.hp = 0
        hero.death_failures = 0
        combat.death_roll(hero)
        self.assertEqual(hero.wounds, 3)

    def test_deaths_door_is_not_healed_away(self):
        combat = make_combat()
        hero = by_key(combat, "P1")
        healer = by_key(combat, "P2")
        hero.dying = True
        hero.unconscious = True
        hero.deaths_door = True
        hero.hp = 0
        combat.heal(healer, hero, healer.source.card("Mending Touch"))
        self.assertTrue(hero.deaths_door)
        self.assertTrue(hero.dying)

    def test_names_triples_win_over_ranges(self):
        combat = make_combat()
        self.assertEqual(combat._wound_row(111)["name"], "Lucky Scrape")
        self.assertEqual(combat._wound_row(222)["name"], "Unnatural Mark")
        self.assertEqual(combat._wound_row(666)["name"], "Death's Door")
        self.assertEqual(combat._wound_row(135)["name"], "Blood in the Eyes")
        self.assertEqual(combat._wound_row(444)["name"], "Broken Bone")
        self.assertIn("gap", combat._wound_row(411)["name"])

    def test_d666_keeps_highest_three_and_sorts_ascending(self):
        dice = Dice(script=[[1, 6, 2, 5]])
        kept, value = dice.d666(extra_dice=1)
        self.assertEqual(kept, [2, 5, 6])
        self.assertEqual(value, 256)
        dice = Dice(script=[[1, 1, 1]])
        kept, value = dice.d666(extra_dice=0)
        self.assertEqual(value, 111)


class TestDeterminism(unittest.TestCase):
    """Acceptance 7: same seed, byte-identical output."""

    def test_same_seed_same_bytes(self):
        data = load(RUNFILES / "novice-goblins.yaml")
        data["run"]["iterations"] = 60
        rules = Rules()
        cardbook = CardBook(rules)
        with tempfile.TemporaryDirectory() as one, tempfile.TemporaryDirectory() as two:
            results_a, _ = run_all(data, rules, cardbook, iterations=60)
            summary_a = summarize(data, results_a)
            write_outputs(Path(one), summary_a, results_a, 60)
            results_b, _ = run_all(data, rules, cardbook, iterations=60)
            summary_b = summarize(data, results_b)
            write_outputs(Path(two), summary_b, results_b, 60)
            for name in ("summary.json", "combats.jsonl", "events.jsonl", "report.txt"):
                a = (Path(one) / name).read_bytes()
                b = (Path(two) / name).read_bytes()
                self.assertEqual(a, b, f"{name} is not byte-identical")

    def test_per_combat_seed_replays_in_isolation(self):
        data = load(RUNFILES / "novice-goblins.yaml")
        rules = Rules()
        cardbook = CardBook(rules)
        from hol_engine.characters import build_party
        party = build_party(data["party"], rules, cardbook)
        from hol_engine.reports import run_one
        first = run_one(data, 7, rules, cardbook, party, record_events=True)
        second = run_one(data, 7, rules, cardbook, party, record_events=True)
        self.assertEqual(json.dumps(first, sort_keys=True), json.dumps(second, sort_keys=True))


class TestMultiattack(unittest.TestCase):
    """Acceptance 8: a printed multiattack creature runs and telemetry shows it."""

    def test_ancient_dragon_multiattack_in_telemetry(self):
        leader = {
            "id": "P5", "name": "Marta", "class": "Leader", "level": 1, "ancestry": "Human",
            "culture": "Coastal",
            "attributes": {"Brawn": 0, "Fortitude": 0, "Agility": 0, "Guile": 2, "Knowledge": 0, "Reason": 1},
            "disciplines": ["Tactics", "Shields"], "cards": "auto",
            "equipment": {"armor": "light", "shield": "small", "weapon": "two-hand"},
        }
        party = HERO_SPECS + [leader]
        combat = make_combat(party=party, opposition=[{"creature": "Ancient Dragon", "count": 1}])
        result = combat.run()
        events = result["events"]
        attacks_by_round = {}
        for event in events:
            if event.get("event") == "attack" and event.get("actor") == "AN1":
                attacks_by_round[event["round"]] = attacks_by_round.get(event["round"], 0) + 1
        self.assertTrue(attacks_by_round, "the dragon never attacked")
        self.assertGreaterEqual(max(attacks_by_round.values()), 3,
                                f"multiattack did not appear: {attacks_by_round}")

    def test_bestiary_multiattack_parses(self):
        data = bestiary()
        dragon = data["Ancient Dragon"]
        sequence = dragon.attack_sequence()
        counts = {attack.name: count for attack, count, _ in sequence}
        self.assertEqual(counts["Bite"], 1)
        self.assertEqual(counts["Claw"], 2)
        self.assertEqual(counts["Tail"], 1)
        young = data["Young Dragon"].attack_sequence()
        self.assertEqual(sum(count for _, count, _ in young), 3)


class TestPerformance(unittest.TestCase):
    """Acceptance 9: 10000 iterations, 4 heroes vs 6 creatures, under 60 seconds."""

    def test_10k_under_60s(self):
        data = load(RUNFILES / "novice-goblins.yaml")
        self.assertEqual(data["opposition"][0]["count"], 6)
        start = time.time()
        results, _ = run_all(data, Rules(), CardBook(Rules()), iterations=10000)
        elapsed = time.time() - start
        self.assertEqual(len(results), 10000)
        self.assertLess(elapsed, 60.0, f"10000 iterations took {elapsed:.1f}s")


class TestValidationAndConstruction(unittest.TestCase):
    def test_all_canonical_runfiles_validate(self):
        for path in sorted(RUNFILES.glob("*.yaml")):
            with self.subTest(path=path.name):
                data = load(path)
                problems = validate(data)
                self.assertEqual(problems, [], "\n".join(problems))

    def test_illegal_attribute_sum_is_refused(self):
        bad = dict(HERO_SPECS[0])
        bad["attributes"] = {"Brawn": 2, "Fortitude": 2, "Agility": 0, "Guile": 0, "Knowledge": 0, "Reason": 0}
        with self.assertRaises(BuildError):
            build_party([bad])

    def test_illegal_level_is_refused(self):
        bad = dict(HERO_SPECS[0])
        bad["level"] = 11
        with self.assertRaises(BuildError):
            build_party([bad])

    def test_auto_cards_are_legal_and_ledgered(self):
        chars = build_party(HERO_SPECS)
        for char in chars:
            self.assertGreater(char.max_hp, 0)
            for entry in char.ledger:
                self.assertIn(entry.wallet, ("background", "class"))
                self.assertGreaterEqual(entry.dp, 0)
            for card in char.cards:
                for discipline, rank in card.disciplines.items():
                    if char.wildcard and rank == 1:
                        continue
                    self.assertGreaterEqual(char.discipline_rank(discipline), rank)

    def test_bestiary_parses_every_block(self):
        data = parse_bestiary()
        self.assertGreaterEqual(len(data), 49)
        for name, creature in data.items():
            self.assertGreater(creature.hp, 0, name)
            self.assertGreaterEqual(creature.dr, 0, name)
            if creature.attack_sequence():
                for attack, count, optional in creature.attack_sequence():
                    self.assertGreaterEqual(count, 1, f"{name}/{attack.name}")

    def test_challenge_penalty_rules(self):
        data = bestiary()
        self.assertEqual(data["Goblin"].challenge_penalty, -1)
        self.assertEqual(data["Knight"].challenge_penalty, -3)
        self.assertEqual(data["Ancient Dragon"].challenge_penalty, -6)
        self.assertEqual(data["Lich"].challenge_penalty, -6)


class TestDiceRules(unittest.TestCase):
    def test_tiers(self):
        self.assertEqual(tier_for(8), WEAK)
        self.assertEqual(tier_for(9), STANDARD)
        self.assertEqual(tier_for(14), STANDARD)
        self.assertEqual(tier_for(15), STRONG)

    def test_boon_keeps_highest_bane_keeps_lowest(self):
        boon = Dice(script=[[1, 2, 6, 6]]).roll(boon=1)
        self.assertEqual(boon.kept, [6, 6, 2])
        bane = Dice(script=[[6, 6, 2, 1]]).roll(bane=1)
        self.assertEqual(bane.kept, [1, 2, 6])
        cancel = Dice(script=[[4, 3, 5]]).roll(boon=1, bane=1)
        self.assertEqual(cancel.kept, [4, 3, 5])

    def test_triples_read_on_kept_dice(self):
        roll = Dice(script=[[6, 6, 6, 1]]).roll(boon=1)
        self.assertEqual(roll.kept, [6, 6, 6])
        self.assertTrue(roll.triple6)
        roll = Dice(script=[[1, 1, 1, 6]]).roll(bane=1)
        self.assertEqual(roll.kept, [1, 1, 1])
        self.assertTrue(roll.triple1)


if __name__ == "__main__":
    unittest.main()
