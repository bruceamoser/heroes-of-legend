"""Run-file loading and validation."""

from __future__ import annotations

from pathlib import Path

from .bestiary import bestiary
from .characters import ANCESTRIES, ARMOR_DATA, CULTURES, SHIELD_DATA, WEAPON_RANK, BuildError, Builder
from .rules import rules as default_rules
from .yamlmini import load as yaml_load


class RunFileError(RuntimeError):
    pass


REQUIRED_RUN_FIELDS = ["name", "seed", "iterations"]


def load(path):
    data = yaml_load(str(path))
    if not isinstance(data, dict):
        raise RunFileError(f"{path}: run file must be a mapping")
    return data


def load_policies(data):
    policies = data.get("policies") or {}
    if "default" not in policies:
        policies["default"] = {}
    return policies


def validate(data, rules=None) -> list:
    """Return a list of human-readable problems; empty means valid."""
    rules = rules or default_rules()
    problems = []
    run = data.get("run")
    if not isinstance(run, dict):
        problems.append("missing 'run' block")
        run = {}
    for field in REQUIRED_RUN_FIELDS:
        if run.get(field) in (None, ""):
            problems.append(f"run.{field} is required")
    if run.get("iterations") is not None:
        try:
            if int(run["iterations"]) <= 0:
                problems.append("run.iterations must be positive")
        except (TypeError, ValueError):
            problems.append("run.iterations must be an integer")
    party = data.get("party")
    if not isinstance(party, list) or not party:
        problems.append("'party' must be a non-empty list")
    else:
        ids = set()
        for i, spec in enumerate(party):
            label = spec.get("id") or f"party[{i}]"
            if not isinstance(spec, dict):
                problems.append(f"{label}: must be a mapping")
                continue
            cid = spec.get("id") or spec.get("name") or spec.get("class")
            if cid in ids:
                problems.append(f"{label}: duplicate party id {cid!r}")
            ids.add(cid)
            try:
                Builder(rules).build(spec)
            except BuildError as exc:
                problems.append(f"{label}: {exc}")
    opposition = data.get("opposition")
    if not isinstance(opposition, list) or not opposition:
        problems.append("'opposition' must be a non-empty list")
    else:
        known = bestiary()
        for i, spec in enumerate(opposition):
            label = f"opposition[{i}]"
            if not isinstance(spec, dict) or "creature" not in spec:
                problems.append(f"{label}: needs a 'creature' name")
                continue
            if spec["creature"] not in known:
                problems.append(f"{label}: no stat block named {spec['creature']!r}")
            count = spec.get("count", 1)
            try:
                if int(count) <= 0:
                    problems.append(f"{label}: count must be positive")
            except (TypeError, ValueError):
                problems.append(f"{label}: count must be an integer")
            if spec.get("challenge_override") is not None:
                try:
                    value = float(spec["challenge_override"])
                    if value <= 0:
                        problems.append(f"{label}: challenge_override must be positive")
                except (TypeError, ValueError):
                    problems.append(f"{label}: challenge_override must be a number")
            policy = spec.get("policy", "default")
            if policy not in load_policies(data):
                problems.append(f"{label}: unknown policy {policy!r}")
    if isinstance(party, list):
        policy_names = load_policies(data)
        for i, spec in enumerate(party):
            if isinstance(spec, dict):
                policy = spec.get("policy", "default")
                if policy not in policy_names:
                    problems.append(f"party[{i}]: unknown policy {policy!r}")
    policies = load_policies(data)
    for name, policy in policies.items():
        if not isinstance(policy, dict):
            problems.append(f"policy {name!r}: must be a mapping")
            continue
        selection = policy.get("target_selection", "focus_lowest_hp")
        if selection not in ("focus_lowest_hp", "focus_highest_threat", "random", "nearest"):
            problems.append(f"policy {name!r}: unknown target_selection {selection!r}")
        grit = policy.get("grit_at_zero", "spend")
        if grit not in ("spend", "stay_down", "spend_if_wounded_below_n"):
            problems.append(f"policy {name!r}: unknown grit_at_zero {grit!r}")
        heal = policy.get("heal_policy", "at_or_below_half")
        if heal not in ("never", "every_round", "at_or_below_half", "only_at_zero"):
            problems.append(f"policy {name!r}: unknown heal_policy {heal!r}")
        for maneuver in policy.get("maneuver_priority", []):
            if maneuver not in ("defend", "catch_breath"):
                problems.append(f"policy {name!r}: unknown maneuver {maneuver!r}")
    study = data.get("study")
    if study is not None and not isinstance(study, dict):
        problems.append("'study' must be a mapping")
    return problems


def describe(data):
    """Constructed characters for `hol-engine explain`."""
    from .cards import CardBook
    from .characters import build_party

    builder = Builder()
    characters = build_party(data.get("party") or [])
    creatures = []
    for spec in data.get("opposition") or []:
        creature = bestiary().get(spec.get("creature"))
        if creature is None:
            creatures.append({"name": spec.get("creature"), "error": "no stat block"})
            continue
        creatures.append({
            "name": creature.name,
            "challenge": creature.challenge,
            "challenge_penalty": creature.challenge_penalty,
            "hp": creature.hp,
            "dr": creature.dr,
            "attributes": dict(creature.attributes),
            "attacks": [
                {"name": a.name, "damage": list(a.damage), "auto": a.auto, "extra": a.extra}
                for a in creature.attacks
            ],
            "multiattack": [
                {"attack": a.name, "count": count, "optional": optional}
                for a, count, optional in creature.attack_sequence()
            ],
            "abilities_modeled": creature.modeled_abilities,
            "abilities_stubbed": creature.stubbed_abilities,
            "count": int(spec.get("count", 1)),
        })
    return {"characters": [c.as_dict() for c in characters], "creatures": creatures}
