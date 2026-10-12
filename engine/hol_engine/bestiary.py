"""Bestiary parser for 20-bestiary.qmd.

Parses every stat block into a Creature. A block that cannot be parsed
raises CreatureParseError with the offending text: the engine never fills
in a default for a stat block it did not read.
"""

from __future__ import annotations

import re
from pathlib import Path

from .rules import default_paths

CHALLENGE_RE = re.compile(r"Challenge\s+([0-9]+(?:\s*/\s*2)?|\u00bd)")
HEADING_RE = re.compile(r"^===\s*(.+?)\s*\(([^)]*Challenge[^)]*)\)\s*$")
HP_DR_RE = re.compile(r"HP\s+(\d+),\s*DR\s+(\d+)")
ATTR_RE = re.compile(r"Attributes:\s*(.+?)\.\s")
ATTR_TOKEN_RE = re.compile(r"(Brawn|Fortitude|Agility|Guile|Knowledge|Reason)\s*([+-]?\d+)")
ATTACK_RE = re.compile(r"^\*([^*]+?):\*\s*(\d+)/(\d+)/(\d+)(.*)$")
AUTO_DAMAGE_RE = re.compile(r"^\*([^*]+?):\*\s*Automatic\s+(\d+)\s+damage(.*)$")
MULTIATTACK_RE = re.compile(r"^\*Multiattack:\*\s*(.+)$")
ABILITY_RE = re.compile(r"^\*([^*]+?):\*\s*(.+)$")

ATTRIBUTES = ["Brawn", "Fortitude", "Agility", "Guile", "Knowledge", "Reason"]

# Ability names the engine implements. Everything else is recorded as a
# stub (see NON_GOALS.md) and reported when the creature is in a run.
MODELED_ABILITIES = {
    "pack tactics": "pack_tactics",
    "leadership": "leadership",
    "martial advantage": "martial_advantage",
    "blood frenzy": "blood_frenzy",
    "knockdown": "knockdown",
    "relentless": "relentless",
    "regeneration": "regeneration",
    "shambling": "shambling",
}

RECHARGE_RE = re.compile(r"\(Recharge\)")


class CreatureParseError(RuntimeError):
    def __init__(self, name, detail, text):
        super().__init__(f"cannot parse stat block '{name}': {detail}\n  offending text: {text!r}")
        self.name = name
        self.detail = detail
        self.text = text


class Attack:
    __slots__ = ("name", "damage", "extra", "auto", "recharge", "condition_on_strong", "optional")

    def __init__(self, name, damage, extra="", auto=False, recharge=False, condition_on_strong=None, optional=False):
        self.name = name
        self.damage = tuple(damage)
        self.extra = extra
        self.auto = auto
        self.recharge = recharge
        self.condition_on_strong = condition_on_strong
        self.optional = optional


class Ability:
    __slots__ = ("name", "text", "handler", "recharge")

    def __init__(self, name, text, handler=None, recharge=False):
        self.name = name
        self.text = text
        self.handler = handler
        self.recharge = recharge

    @property
    def modeled(self):
        return self.handler is not None


class Creature:
    __slots__ = (
        "name",
        "challenge",
        "challenge_text",
        "hp",
        "dr",
        "attributes",
        "attacks",
        "multiattack",
        "abilities",
        "raw",
        "notes",
    )

    def __init__(self, name, challenge, challenge_text, hp, dr, attributes, attacks, multiattack, abilities, raw, notes):
        self.name = name
        self.challenge = challenge
        self.challenge_text = challenge_text
        self.hp = hp
        self.dr = dr
        self.attributes = attributes
        self.attacks = attacks
        self.multiattack = multiattack
        self.abilities = abilities
        self.raw = raw
        self.notes = notes

    @property
    def challenge_penalty(self):
        if self.challenge <= 1:
            return -1
        return -min(self.challenge, 6)

    def attack_by_name(self, name):
        low = name.strip().lower()
        for attack in self.attacks:
            if attack.name.lower() == low:
                return attack
        for attack in self.attacks:
            haystack = attack.name.lower()
            if haystack.startswith(low) or low.startswith(haystack) or low in haystack or haystack in low:
                return attack
        raise CreatureParseError(self.name, f"multiattack references unknown attack {name!r}", name)

    def attack_sequence(self):
        if self.multiattack:
            result = []
            for name, count, optional in self.multiattack:
                result.append((self.attack_by_name(name), count, optional))
            return result
        if not self.attacks:
            return []
        best = max(self.attacks, key=lambda a: sum(a.damage))
        return [(best, 1, False)]

    @property
    def stubbed_abilities(self):
        return [a.name for a in self.abilities if not a.modeled]

    @property
    def modeled_abilities(self):
        return [a.name for a in self.abilities if a.modeled]


def _parse_challenge(value):
    value = value.strip().replace(" ", "")
    if value in ("1/2", "\u00bd"):
        return 0.5
    return float(value)


def _parse_attributes(text, name):
    match = ATTR_RE.search(text)
    attributes = {attr: 0 for attr in ATTRIBUTES}
    if not match:
        return attributes, "no Attributes line; all attributes +0"
    body = match.group(1)
    found = False
    for token in body.split(","):
        token = token.strip()
        if token.lower().startswith("others"):
            continue
        m = ATTR_TOKEN_RE.match(token)
        if not m:
            raise CreatureParseError(name, f"unrecognised attribute token {token!r}", text)
        attributes[m.group(1)] = int(m.group(2))
        found = True
    if not found and "others" not in body.lower():
        raise CreatureParseError(name, "Attributes line has no attributes", text)
    return attributes, None


def _parse_multiattack(text, attacks):
    body = text.strip()
    entries = []
    optional = False
    if "if available" in body:
        optional = True
        body = body.replace("if available", "")
    if body.lower().startswith("may make both"):
        rest = body[len("may make both"):].strip().rstrip(".").strip()
        rest = re.sub(r"\s+as one action$", "", rest)
        parts = re.split(r"\s+and\s+", rest)
        if len(parts) != 2:
            raise CreatureParseError("multiattack", f"cannot split 'both ... and': {text!r}", text)
        return [(p.strip(), 1, False) for p in parts]
    body = body.rstrip(".")
    parts = [p.strip() for p in re.split(r"\s*\+\s*", body) if p.strip()]
    for part in parts:
        m = re.match(r"^(\d+)\s+(.+)$", part)
        if m:
            count = int(m.group(1))
            attack_name = m.group(2)
        elif part.lower().endswith(" twice"):
            count = 2
            attack_name = part[: -len(" twice")].strip()
        else:
            count = 1
            attack_name = part
        entries.append((attack_name, count, optional and attack_name.lower().startswith("breath")))
    return entries


def parse_block(name, challenge_text, body):
    challenge = _parse_challenge(CHALLENGE_RE.search(challenge_text).group(1))
    hp_dr = HP_DR_RE.search(body)
    if not hp_dr:
        raise CreatureParseError(name, "no 'HP N, DR M' line", body[:200])
    hp = int(hp_dr.group(1))
    dr = int(hp_dr.group(2))
    attributes, attr_note = _parse_attributes(body, name)
    attacks = []
    abilities = []
    multiattack = None
    for line in body.splitlines():
        line = line.strip()
        if not line:
            continue
        auto = AUTO_DAMAGE_RE.match(line)
        if auto:
            attacks.append(Attack(auto.group(1), (int(auto.group(2)),) * 3, auto.group(3).strip(), auto=True))
            continue
        atk = ATTACK_RE.match(line)
        if atk:
            extra = atk.group(5).strip()
            condition = None
            cond = re.search(r"\+\s*Poisoned\s+(\d+)\s+on a Strong hit", extra)
            if cond:
                condition = ("Poisoned", int(cond.group(1)))
            attacks.append(Attack(atk.group(1), (int(atk.group(2)), int(atk.group(3)), int(atk.group(4))), extra, condition_on_strong=condition))
            continue
        multi = MULTIATTACK_RE.match(line)
        if multi:
            multiattack = _parse_multiattack(multi.group(1), attacks)
            continue
        ability = ABILITY_RE.match(line)
        if ability:
            ability_name = ability.group(1).strip()
            handler = MODELED_ABILITIES.get(ability_name.lower())
            recharge = bool(RECHARGE_RE.search(ability_name))
            abilities.append(Ability(ability_name, ability.group(2).strip(), handler, recharge))
    if multiattack is not None:
        resolved = []
        for entry_name, count, is_optional in multiattack:
            resolved.append((entry_name, count, is_optional))
        multiattack = resolved
    notes = []
    if attr_note:
        notes.append(attr_note)
    return Creature(name, challenge, challenge_text, hp, dr, attributes, attacks, multiattack, abilities, body, notes)


def parse_bestiary(path=None):
    if path is None:
        _, chapters = default_paths()
        matches = sorted(Path(chapters).glob("20-*.qmd"))
        if not matches:
            raise FileNotFoundError("cannot find 20-bestiary.qmd")
        path = matches[0]
    text = Path(path).read_text(encoding="utf-8")
    lines = text.splitlines()
    blocks = []
    current = None
    for line in lines:
        heading = HEADING_RE.match(line.strip())
        if heading:
            if current:
                blocks.append(current)
            current = [heading.group(1).strip(), heading.group(2).strip(), []]
        elif current is not None:
            if line.startswith("=== ") or (line.startswith("== ") and not line.startswith("===")):
                blocks.append(current)
                current = None
            else:
                current[2].append(line)
    if current:
        blocks.append(current)
    creatures = {}
    errors = []
    for block_name, challenge_text, body_lines in blocks:
        body = "\n".join(body_lines)
        try:
            creature = parse_block(block_name, challenge_text, body)
        except CreatureParseError as exc:
            errors.append(exc)
            continue
        if creature.name in creatures:
            errors.append(CreatureParseError(creature.name, "duplicate stat block name", creature.name))
            continue
        creatures[creature.name] = creature
    if errors:
        message = "\n".join(str(e) for e in errors)
        raise CreatureParseError("bestiary", f"{len(errors)} stat block(s) failed to parse", message)
    return creatures


_cache = None


def bestiary() -> dict:
    global _cache
    if _cache is None:
        _cache = parse_bestiary()
    return _cache


def creature(name) -> Creature:
    data = bestiary()
    if name not in data:
        close = [n for n in data if name.lower() in n.lower()]
        hint = f" (did you mean {close[0]}?)" if close else ""
        raise KeyError(f"no stat block named {name!r} in the bestiary{hint}")
    return data[name]
