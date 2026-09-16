#!/usr/bin/env python3
"""Discipline-vocabulary gate for the collapse series (issue #563).

One script, every mode, file:line for each survivor of the retired weapon-family
vocabulary, so each vocabulary PR in the series verifies by output instead of by
argument. Read-only: the script never edits a chapter. Standard library only.

Modes
-----
--taxonomy    ch08: the armament category holds exactly Melee, Two-Handed, Ranged,
              Unarmed; no Blades, Axes, Polearms, Heavy Weapon, or Archery leaf
              remains; exactly one Defense leaf owns shield work.
--cards       ch09: no *Disciplines:* line names a collapsed family.
--classes     ch05: no Disc Req cell and no class grant names a collapsed family.
--kit         no kit-point vocabulary survives: kit point, six points, Typical Kit,
              Granted Pack, Kit Gear, free with every kit. Disguise Kit and
              Healer's Kit are item names, not economy, and are exempt.
--requires    the card field is Requires, not Kit: no *Kit:* field and no
              "Kit field" prose survives in any chapter, and the Kit and Kit
              Point terms do not come back. Disguise Kit and Healer's Kit are
              item names; ordinary English uses (the simplest tool in your kit)
              pass.
--shield      the Discipline that owns the shield items (ch15/ch16/ch22) is the
              same one that owns the shield cards (ch09/ch05); no other leaf
              claims shield work in the ch08 taxonomy.
--gear        every row of the armor, shield, and weapon tables prints a
              Requirement naming a real Discipline rank, and no row is strictly
              dominated by another row printed in the same table. Domination is
              judged on the table's own numeric axes (Requirement, DR, Slots,
              Cost); a table with fewer than two such axes cannot express one.
--protection  no Protection used as a martial key: no shield card and no shield
              requirement asks for Protection (issue #588 splits the Defense
              category, Shields martial and Protection the ward school). The four
              ward keys and the header at 12:157-190, Protection Value and its four
              users, and the four motivation and fiction lines 02:247, 02:441,
              02:594 and 01b:29 all pass. A clean run also reports the ch08 leaf
              total, twenty-five after the split.
--report      print the counts used in this series as a table, so each PR can
              paste the before/after. The baseline below was measured 2026-09-15:
              31 weapon-keyed maneuver headers; 54 armament rank cells across the
              nine ch05 class cost tables; six class-ability cells in the series'
              single-key reading; 193 lines across twelve chapters naming a
              collapsed family.

No mode flag runs every check (eight checks plus --report). Exit 0 = zero
findings, 1 = findings printed.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CHAPTERS = ROOT / "quarto-book" / "chapters"

COLLAPSED = ("Blades", "Axes", "Polearms", "Heavy Weapon", "Archery")
ARMAMENT = ("Melee", "Two-Handed", "Ranged", "Unarmed")
FAMILIES = COLLAPSED + ("Unarmed",)

COLLAPSED_RE = re.compile(r"\b(?:" + "|".join(re.escape(n) for n in COLLAPSED) + r")\b")
FAMILY_RE = {name: re.compile(r"\b" + re.escape(name) + r"\b") for name in FAMILIES}

KIT_TERMS = (
    "kit point",
    "six points",
    "Typical Kit",
    "Granted Pack",
    "Kit Gear",
    "free with every kit",
)
KIT_ITEM_NAMES = ("disguise kit", "healer's kit")

OLD_FIELD_RE = re.compile(r"\*+Kit\b")
OLD_FIELD_PHRASE_RE = re.compile(r"\bKit field\b", re.IGNORECASE)

PROTECTION_EXEMPT = {
    ("02-character-creation.qmd", 247),
    ("02-character-creation.qmd", 441),
    ("02-character-creation.qmd", 594),
    ("01b-opening-fiction.qmd", 29),
}

DISCIPLINES_RE = re.compile(r"\*Disciplines:\*\s*(.*?)(?:\s*·\s*\*|$)")

CELL_RE = re.compile(r"\[([^\[\]]*)\]")
RANK_RE = re.compile(r"\b([123])\s+([A-Z][A-Za-z'\-]*(?:\s+[A-Z][A-Za-z'\-]*)*)")

CH: dict[str, list[str]] = {}


def load() -> None:
    CH.clear()
    for path in sorted(CHAPTERS.glob("*.qmd")):
        CH[path.name] = path.read_text(encoding="utf-8").split("\n")


def where(name: str) -> str:
    return f"quarto-book/chapters/{name}"


def finding(name: str, lineno: int, message: str) -> str:
    return f"{where(name)}:{lineno}: {message}"


def short(name: str) -> str:
    return name.split("-")[0]


def parse_cells(line: str) -> list[str]:
    out = []
    for raw in CELL_RE.findall(line):
        cell = raw.strip()
        while len(cell) >= 2 and cell.startswith("*") and cell.endswith("*"):
            cell = cell[1:-1].strip()
        out.append(cell)
    return out


def iter_tables(lines):
    """Yield (header_lineno, header_cells, [(row_lineno, row_cells), ...])."""
    i = 0
    while i < len(lines):
        if "table.header(" in lines[i]:
            header = parse_cells(lines[i])
            rows = []
            j = i + 1
            while j < len(lines):
                s = lines[j].strip()
                if s.startswith(")") or s.startswith("table.header(") or s.startswith("#figure"):
                    break
                if s.startswith("["):
                    cells = parse_cells(s)
                    if cells:
                        rows.append((j + 1, cells))
                j += 1
            yield i + 1, header, rows
            i = j
        i += 1


def parse_requirements(text: str) -> list[tuple[int, str]]:
    """Return [(rank, name)] from text like '2 Blades + 1 Heavy Weapon'."""
    if not text:
        return []
    if text.strip().lower() in ("none", "no prereq", "any"):
        return []
    out: list[tuple[int, str]] = []
    for part in re.split(r"\+|,|·|\bor\b", text):
        m = RANK_RE.match(part.strip())
        if not m:
            continue
        name = m.group(2).strip()
        for suffix in (" Discipline", " discipline", " rank", " ranks", " Rank", " Ranks"):
            if name.endswith(suffix):
                name = name[: -len(suffix)].strip()
        if name:
            out.append((int(m.group(1)), name))
    return out


def generic_name(name: str) -> bool:
    low = name.lower()
    return "discipline" in low or low.startswith("any") or low in ("weapon", "armor", "shield")


def taxonomy(lines):
    """Return [(lineno, category, leaf, represents)] for the ch08 taxonomy table."""
    for _start, header, rows in iter_tables(lines):
        if header[:3] == ["Category", "Discipline", "Represents"]:
            entries = []
            category = None
            for lineno, cells in rows:
                if len(cells) < 3:
                    continue
                if cells[0]:
                    category = cells[0]
                entries.append((lineno, category, cells[1], cells[2]))
            return entries
    return []


def leaf_names() -> set[str]:
    lines = CH.get("08-disciplines.qmd", [])
    return {entry[2] for entry in taxonomy(lines)}


def check_taxonomy() -> list[str]:
    lines = CH["08-disciplines.qmd"]
    entries = taxonomy(lines)
    if not entries:
        return [finding("08-disciplines.qmd", 1, "no Discipline taxonomy table found")]
    by_name = {leaf: (lineno, category, represents) for lineno, category, leaf, represents in entries}
    findings = []
    for family in COLLAPSED:
        if family in by_name:
            lineno = by_name[family][0]
            findings.append(finding("08-disciplines.qmd", lineno,
                                    f"collapsed family '{family}' is still a Discipline leaf"))
    missing = [a for a in ARMAMENT if a not in by_name]
    if missing:
        anchor = next((e[0] for e in entries if e[2] in FAMILIES), entries[0][0])
        findings.append(finding("08-disciplines.qmd", anchor,
                                f"armament leaves missing from the taxonomy: {', '.join(missing)}"))
    category = None
    for name in ARMAMENT + COLLAPSED:
        if name in by_name:
            category = by_name[name][1]
            break
    if category:
        for lineno, cat, leaf, _rep in entries:
            if cat == category and leaf not in ARMAMENT and leaf not in COLLAPSED:
                findings.append(finding("08-disciplines.qmd", lineno,
                                        f"'{leaf}' remains in the {cat} category alongside the armament leaves"))
    defense = [(lineno, leaf, rep) for lineno, cat, leaf, rep in entries if cat == "Defense"]
    owners = [(lineno, leaf) for lineno, leaf, rep in defense if "shield" in rep.lower()]
    if len(owners) > 1:
        for lineno, leaf in owners:
            findings.append(finding("08-disciplines.qmd", lineno,
                                    f"Defense leaf '{leaf}' claims shield work "
                                    f"({len(owners)} leaves claim it; exactly one may)"))
    elif not owners:
        anchor = defense[0][0] if defense else entries[0][0]
        findings.append(finding("08-disciplines.qmd", anchor,
                                "no Defense leaf claims shield work; exactly one must"))
    return findings


def check_cards() -> list[str]:
    name = "09-talents-abilities.qmd"
    lines = CH[name]
    leaves = leaf_names()
    findings = []
    for i, line in enumerate(lines):
        m = DISCIPLINES_RE.search(line)
        if not m:
            continue
        payload = m.group(1).strip()
        for family in COLLAPSED:
            if FAMILY_RE[family].search(payload):
                findings.append(finding(name, i + 1,
                                        f"*Disciplines:* names collapsed family '{family}'"))
        if leaves:
            for rank, req in parse_requirements(payload):
                if req in leaves or generic_name(req):
                    continue
                findings.append(finding(name, i + 1,
                                        f"*Disciplines:* requirement '{rank} {req}' is not a Discipline leaf"))
    return findings


def class_grants(lines):
    for _start, header, rows in iter_tables(lines):
        if header[:2] == ["Class", "Role"] and "L1 Discipline" in header:
            idx = header.index("L1 Discipline")
            for lineno, cells in rows:
                if idx < len(cells):
                    yield lineno, "L1 Discipline grant", cells[idx]
    for i, line in enumerate(lines):
        if line.startswith("*Class Discipline (L1):*"):
            yield i + 1, "Class Discipline grant", line


def check_classes() -> list[str]:
    name = "05-classes.qmd"
    lines = CH[name]
    findings = []
    for _start, header, rows in iter_tables(lines):
        if "Disc Req" not in header:
            continue
        idx = header.index("Disc Req")
        for lineno, cells in rows:
            if idx >= len(cells):
                continue
            cell = cells[idx]
            for family in COLLAPSED:
                if FAMILY_RE[family].search(cell):
                    findings.append(finding(name, lineno,
                                            f"Disc Req cell '{cell}' names collapsed family '{family}'"))
    for lineno, label, text in class_grants(lines):
        for family in COLLAPSED:
            if FAMILY_RE[family].search(text):
                findings.append(finding(name, lineno,
                                        f"{label} '{text.strip()}' names collapsed family '{family}'"))
    return findings


def kit_match_is_exempt(low: str, start: int, end: int) -> bool:
    for item in KIT_ITEM_NAMES:
        pos = low.find(item)
        while pos >= 0:
            if pos <= start and end <= pos + len(item):
                return True
            pos = low.find(item, pos + 1)
    return False


def check_kit() -> list[str]:
    findings = []
    for name, lines in CH.items():
        for i, line in enumerate(lines):
            low = line.lower()
            for term in KIT_TERMS:
                start = low.find(term.lower())
                while start >= 0:
                    end = start + len(term)
                    if not kit_match_is_exempt(low, start, end):
                        findings.append(finding(name, i + 1,
                                                f"kit-point vocabulary survives: '{term}'"))
                    start = low.find(term.lower(), start + 1)
    return findings


def check_requires() -> list[str]:
    findings = []
    for name, lines in CH.items():
        for i, line in enumerate(lines):
            if OLD_FIELD_RE.search(line):
                findings.append(finding(name, i + 1,
                                        "retired Kit field or kit term survives; the field is *Requires:*"))
            m = OLD_FIELD_PHRASE_RE.search(line)
            if m:
                findings.append(finding(name, i + 1,
                                        f"old field name survives in prose: '{m.group(0)}'"))
    return findings


def taxonomy_shield_owner():
    entries = taxonomy(CH["08-disciplines.qmd"])
    owners = [(lineno, leaf) for lineno, cat, leaf, rep in entries
              if cat == "Defense" and "shield" in rep.lower()]
    return entries, owners


def shield_item_sites():
    """Requirement lines that gate a shield item, in ch15, ch16, and ch22."""
    sites = []
    for name in ("15-equipment.qmd", "16-armor-shields.qmd", "22-reference-sheets.qmd"):
        for i, line in enumerate(CH[name]):
            low = line.lower()
            if not re.search(r"\bshield\b|\bbuckler\b", low):
                continue
            found = list(parse_requirements(line))
            for m in re.finditer(r"\(([123])\s+([A-Z][A-Za-z]+)", line):
                found.append((int(m.group(1)), m.group(2)))
            for m in re.finditer(r"\b([123])\s+([A-Z][A-Za-z]+)\s+Discipline\b", line):
                found.append((int(m.group(1)), m.group(2)))
            for m in re.finditer(r"\b(?:the|in the)\s+([A-Z][A-Za-z]+)\s+Discipline\b", line):
                found.append((None, m.group(1)))
            for rank, req in found:
                sites.append((name, i + 1, rank, req, line.strip()))
    return sites


def card_requirement_sites():
    """Requirement lines on ch09/ch05 cards that cannot be used without a shield."""
    name9 = "09-talents-abilities.qmd"
    lines = CH[name9]
    block_start = 0
    block_title = ""
    for i, line in enumerate(lines):
        if line.startswith("===") or line.startswith("=="):
            block_start = i
            block_title = line.lstrip("=").strip()
        if "*Disciplines:*" not in line:
            continue
        body = " ".join(lines[block_start:i + 1])
        has_tag = re.search(r"\*(?:Kit|Requires):\*\s*shield\b", body)
        uses_shield = re.search(r"\bwith a shield\b|\bwielding a shield\b|\bshield attack\b", body, re.I)
        if has_tag or uses_shield:
            payload = DISCIPLINES_RE.search(line)
            text = payload.group(1).strip() if payload else line.strip()
            yield name9, i + 1, block_title, text

    name5 = "05-classes.qmd"
    for _start, header, rows in iter_tables(CH[name5]):
        if "Disc Req" not in header:
            continue
        idx = header.index("Disc Req")
        for lineno, cells in rows:
            if idx >= len(cells):
                continue
            body = " ".join(cells)
            if re.search(r"\bwith a shield\b", body, re.I):
                yield name5, lineno, cells[0], cells[idx]


def req_label(rank, req) -> str:
    return f"{rank} {req}" if rank else req


def check_shield() -> list[str]:
    findings = []
    entries, owners = taxonomy_shield_owner()
    if len(owners) != 1:
        for lineno, leaf in owners:
            findings.append(finding("08-disciplines.qmd", lineno,
                                    f"Defense leaf '{leaf}' claims shield work"))
        if not owners:
            findings.append(finding("08-disciplines.qmd", entries[0][0] if entries else 1,
                                    "no Defense leaf claims shield work"))
        expected = None
    else:
        expected = owners[0][1]

    item_sites = []
    seen = set()
    for name, lineno, rank, req, text in shield_item_sites():
        key = (name, lineno, req)
        if key in seen:
            continue
        seen.add(key)
        item_sites.append((name, lineno, rank, req, text))
    card_sites = list(card_requirement_sites())
    item_owners = {req for _name, _lineno, _rank, req, _text in item_sites}
    card_owners = {req for _name, _lineno, _title, text in card_sites
                   for _rank, req in parse_requirements(text)}
    if expected is not None:
        for name, lineno, rank, req, _text in item_sites:
            if req != expected:
                findings.append(finding(name, lineno,
                                        f"shield item requires {req_label(rank, req)}, "
                                        f"but '{expected}' owns shields"))
        for name, lineno, title, text in card_sites:
            for _rank, req in parse_requirements(text):
                if req != expected:
                    findings.append(finding(name, lineno,
                                            f"shield card '{title}' requires {req}, "
                                            f"but '{expected}' owns shields"))
    elif item_owners != card_owners:
        item_side = ", ".join(sorted(item_owners)) or "nothing"
        card_side = ", ".join(sorted(card_owners)) or "nothing"
        for name, lineno, rank, req, _text in item_sites:
            findings.append(finding(name, lineno,
                                    f"shield item requires {req_label(rank, req)}, "
                                    f"but the shield cards use {card_side} (items use {item_side})"))
        for name, lineno, title, text in card_sites:
            for _rank, req in parse_requirements(text):
                findings.append(finding(name, lineno,
                                        f"shield card '{title}' requires {req}, "
                                        f"but the shield items use {item_side} (cards use {card_side})"))
    return findings


def gear_table_kind(header) -> str:
    if not header:
        return ""
    first = header[0].lower()
    low = [h.lower() for h in header]
    if first == "armor" and "dr" in low:
        return "armor"
    if first == "shield":
        return "shield"
    if first == "weapon":
        return "weapon"
    return ""


def requirement_index(header):
    low = [h.lower() for h in header]
    for exact in ("req", "requirement", "requirements"):
        if exact in low:
            return low.index(exact)
    for i, h in enumerate(low):
        if "req" in h:
            return i
    for exact in ("disciplines required", "disciplines"):
        if exact in low:
            return low.index(exact)
    return None


def category_index(header):
    low = [h.lower() for h in header]
    if "category" in low:
        return low.index("category")
    return None


def header_discipline(header) -> str:
    for cell in header:
        m = re.match(r"(.+?)\s+req(?:uirement)?s?$", cell, re.I)
        if m:
            return m.group(1).strip()
    return ""


def leaf_like(name: str, leaves: set[str]) -> bool:
    low = name.lower()
    for leaf in leaves:
        if leaf.lower() == low:
            return True
        if leaf.lower() + "s" == low or leaf.lower() == low + "s":
            return True
    return low in ("shield", "weapon", "armor")


def number(cell: str):
    m = re.search(r"\d+", cell.replace(",", ""))
    return float(m.group()) if m else None


def requirement_rank(cell: str):
    reqs = parse_requirements(cell)
    if not reqs:
        return None
    return float(sum(rank for rank, _name in reqs))


GEAR_AXES = {
    "dr": (True, number),
    "slots": (False, number),
    "cost": (False, number),
    "req": (False, requirement_rank),
    "requirement": (False, requirement_rank),
    "disciplines required": (False, requirement_rank),
    "shield req": (False, requirement_rank),
    "protection req": (False, requirement_rank),
}


def domination_findings(header, rows) -> list[tuple[int, str]]:
    axes = []
    for i, cell in enumerate(header):
        key = cell.lower()
        if key in GEAR_AXES:
            high, extract = GEAR_AXES[key]
            axes.append((i, high, extract))
    if len(axes) < 2:
        return []
    parsed = []
    for lineno, cells in rows:
        values = []
        for idx, _high, extract in axes:
            if idx >= len(cells):
                break
            value = extract(cells[idx])
            if value is None:
                break
            values.append(value)
        else:
            parsed.append((lineno, cells[0], values))
    out = []
    for lineno, row, values in parsed:
        for other_lineno, other, other_values in parsed:
            if other_lineno == lineno:
                continue
            weak = all((a >= b) if high else (a <= b)
                       for (_idx, high, _extract), a, b in zip(axes, other_values, values))
            strict = any((a > b) if high else (a < b)
                         for (_idx, high, _extract), a, b in zip(axes, other_values, values))
            if weak and strict:
                out.append((lineno, f"row '{row}' is strictly dominated by '{other}' "
                                    "on every numeric column this table prints"))
                break
    return out


def check_gear() -> list[str]:
    findings = []
    leaves = leaf_names()
    for name in ("15-equipment.qmd", "16-armor-shields.qmd", "22-reference-sheets.qmd"):
        for start, header, rows in iter_tables(CH[name]):
            kind = gear_table_kind(header)
            if not kind:
                continue
            req_idx = requirement_index(header)
            header_disc = header_discipline(header)
            if header_disc and leaves and not leaf_like(header_disc, leaves):
                findings.append(finding(name, start,
                                        f"{kind} table Requirement header '{header_disc}' "
                                        "is not a real Discipline"))
            cat_idx = category_index(header)
            for lineno, cells in rows:
                reqs: list[tuple[int, str]] = []
                if req_idx is not None and req_idx < len(cells):
                    cell = cells[req_idx].strip()
                    reqs = parse_requirements(cell)
                    rank_only = kind == "shield" and header_disc and re.fullmatch(r"[123]", cell)
                    if not reqs and cell and cell.lower() not in ("none", "-") and not rank_only:
                        findings.append(finding(name, lineno,
                                                f"{kind} row '{cells[0]}' prints no "
                                                "Requirement naming a Discipline rank"))
                elif kind == "weapon" and cat_idx is not None and cat_idx < len(cells):
                    category = cells[cat_idx].strip().lower()
                    derived = {"melee": [(1, "Melee")], "two-handed": [(2, "Two-Handed")],
                               "ranged": [(1, "Ranged")], "unarmed": []}.get(category, [])
                    reqs = derived
                else:
                    findings.append(finding(name, lineno,
                                            f"{kind} row '{cells[0]}' prints no Requirement"))
                if leaves:
                    for rank, req in reqs:
                        if req in leaves or generic_name(req):
                            continue
                        findings.append(finding(name, lineno,
                                                f"{kind} requirement '{rank} {req}' "
                                                "is not a real Discipline rank"))
            for lineno, message in domination_findings(header, rows):
                findings.append(finding(name, lineno, f"{kind} {message}"))
    return findings


def martial_protection_sites():
    """Yield (chapter, line, text) for every shield card and shield requirement.

    A martial Protection key is one attached to a shield: the shield items in
    ch15/ch16/ch22, the ch08 Tower Shield example, and the ch09/ch05 cards that
    cannot be used without a shield. Prose that merely mentions a shield (a
    hero's shield-wall memory, the opening fiction) is not a key site.
    """
    for name, lineno, _title, text in card_requirement_sites():
        yield name, lineno, text
    for name in ("08-disciplines.qmd", "15-equipment.qmd", "16-armor-shields.qmd",
                 "22-reference-sheets.qmd"):
        for i, line in enumerate(CH[name]):
            if re.search(r"\bshield\b|\bbuckler\b", line, re.I):
                yield name, i + 1, line


def check_protection() -> list[str]:
    patterns = (
        (re.compile(r"\[\*?Protection\*?\]"), "[Protection]"),
        (re.compile(r"\b[123]\s+Protection\b"), "N Protection"),
        (re.compile(r"Protection\s*\(\d\)"), "Protection (N)"),
        (re.compile(r"Protection\s+Discipline"), "Protection Discipline"),
        (re.compile(r"Protection\s+Req(?:uirement)?s?\b"), "Protection Req header"),
    )
    findings = []
    for name, lineno, text in martial_protection_sites():
        if (name, lineno) in PROTECTION_EXEMPT:
            continue
        scrubbed = re.sub(r"Protection\s+Value", "", text)
        hits = [label for pattern, label in patterns if pattern.search(scrubbed)]
        if "*Disciplines:*" in scrubbed and re.search(r"\bProtection\b", scrubbed):
            hits.append("*Disciplines:* Protection")
        for hit in hits:
            findings.append(finding(name, lineno,
                                    f"Protection used as a martial key ({hit})"))
    for lineno, category, leaf, represents in taxonomy(CH["08-disciplines.qmd"]):
        if category == "Defense" and leaf == "Protection" and "shield" in represents.lower():
            findings.append(finding("08-disciplines.qmd", lineno,
                                    "Protection's taxonomy row still claims shield work"))
    return findings


def report() -> None:
    lines5 = CH["05-classes.qmd"]
    lines8 = CH["08-disciplines.qmd"]
    lines9 = CH["09-talents-abilities.qmd"]

    first_counts = {name: 0 for name in FAMILIES}
    secondary = []
    headers_total = 0
    for i, line in enumerate(lines9):
        m = DISCIPLINES_RE.search(line)
        if not m:
            continue
        reqs = parse_requirements(m.group(1))
        family_reqs = [(rank, req) for rank, req in reqs if req in FAMILIES]
        if not family_reqs:
            continue
        headers_total += 1
        if reqs and reqs[0][1] in FAMILIES:
            first_counts[reqs[0][1]] += 1
        for rank, req in family_reqs:
            if req in COLLAPSED and (not reqs or reqs[0][1] != req):
                secondary.append((i + 1, rank, req))

    armament_cells = 0
    armament_by = {name: 0 for name in FAMILIES}
    cost_tables = 0
    for _start, header, rows in iter_tables(lines5):
        if header != ["Discipline", "Cost", "Discipline", "Cost"]:
            continue
        cost_tables += 1
        for _lineno, cells in rows:
            if cells and cells[0] in FAMILIES:
                armament_cells += 1
                armament_by[cells[0]] += 1

    single_key = 0
    all_family = 0
    other_cells = []
    for _start, header, rows in iter_tables(lines5):
        if "Disc Req" not in header:
            continue
        idx = header.index("Disc Req")
        for lineno, cells in rows:
            if idx >= len(cells):
                continue
            reqs = [req for _rank, req in parse_requirements(cells[idx])]
            collapsed = [req for req in reqs if req in COLLAPSED]
            if not collapsed:
                continue
            all_family += 1
            if len(collapsed) == 1 and all(req in FAMILIES for req in reqs):
                single_key += 1
            else:
                other_cells.append(f"05:{lineno}")

    kit_lines = {}
    kit_line_set = set()
    for name, lines in CH.items():
        for i, line in enumerate(lines):
            low = line.lower()
            for term in KIT_TERMS:
                start = low.find(term.lower())
                if start >= 0 and not kit_match_is_exempt(low, start, start + len(term)):
                    kit_lines.setdefault(term, set()).add((name, i + 1))
                    kit_line_set.add((name, i + 1))

    family_by_chapter = []
    for name, lines in CH.items():
        count = sum(1 for line in lines if COLLAPSED_RE.search(line))
        if count:
            family_by_chapter.append((count, name))
    family_by_chapter.sort(key=lambda pair: (-pair[0], -int(short(pair[1]).rstrip("b"))))
    family_total = sum(count for count, _name in family_by_chapter)

    entries = taxonomy(lines8)
    leaf_total = len(entries)

    w = 62
    print("Discipline vocabulary report (issue #563, baseline measured 2026-09-15)")
    print("=" * w)
    print()
    print("Armament-keyed maneuver headers (ch09 *Disciplines:* lines)")
    print("-" * w)
    for family in sorted(FAMILIES, key=lambda name: (-first_counts[name], name)):
        print(f"  {family:<14}{first_counts[family]:>4}")
    print(f"  {'first-key total':<14}{sum(first_counts.values()):>4}")
    for lineno, rank, req in secondary:
        print(f"  09:{lineno}: second key {rank} {req}")
    print(f"  {'TOTAL':<14}{headers_total:>4}")
    print()
    print("Armament rank cells in the nine ch05 class cost tables")
    print("-" * w)
    for family in FAMILIES:
        print(f"  {family:<14}{armament_by[family]:>4}")
    print(f"  {'cost tables':<14}{cost_tables:>4}")
    print(f"  {'TOTAL cells':<14}{armament_cells:>4}")
    print()
    print("Class-ability requirement cells naming a collapsed family (ch05)")
    print("-" * w)
    print(f"  single-key weapon-only cells (baseline six: 05:635, 639, 656, 660, 684, 687): {single_key}")
    print(f"  other cells naming a collapsed family: {all_family - single_key}"
          + (f" ({', '.join(other_cells)})" if other_cells else ""))
    print(f"  all cells naming a collapsed family:   {all_family}")
    print()
    print("Kit-point vocabulary lines")
    print("-" * w)
    for term in KIT_TERMS:
        print(f"  {term:<22}{len(kit_lines.get(term, ())):>4}")
    print(f"  {'distinct lines':<22}{len(kit_line_set):>4}")
    print()
    print("Lines naming a collapsed family, by chapter")
    print("-" * w)
    for count, name in family_by_chapter:
        print(f"  {short(name):<6}{count:>4}  {name}")
    print(f"  {'TOTAL':<6}{family_total:>4}  across {len(family_by_chapter)} chapters")
    print()
    print(f"Taxonomy leaves (ch08): {leaf_total}")
    print()


def main(argv) -> int:
    parser = argparse.ArgumentParser(
        prog="check-discipline-vocabulary.py",
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument("--taxonomy", action="store_true", help="check the ch08 taxonomy")
    parser.add_argument("--cards", action="store_true", help="check ch09 *Disciplines:* lines")
    parser.add_argument("--classes", action="store_true", help="check ch05 requirement cells and grants")
    parser.add_argument("--kit", action="store_true", help="fail on surviving kit-point vocabulary")
    parser.add_argument("--requires", action="store_true",
                        help="fail on the retired Kit field and kit-term vocabulary")
    parser.add_argument("--shield", action="store_true", help="check the single shield owner")
    parser.add_argument("--gear", action="store_true", help="check armor, shield, and weapon tables")
    parser.add_argument("--protection", action="store_true", help="check Protection as a martial key only")
    parser.add_argument("--report", action="store_true", help="print the series baseline counts")
    args = parser.parse_args(argv)

    load()
    checks = (
        ("taxonomy", args.taxonomy, check_taxonomy),
        ("cards", args.cards, check_cards),
        ("classes", args.classes, check_classes),
        ("kit", args.kit, check_kit),
        ("requires", args.requires, check_requires),
        ("shield", args.shield, check_shield),
        ("gear", args.gear, check_gear),
        ("protection", args.protection, check_protection),
    )
    selected = [(mode, fn) for mode, flag, fn in checks if flag]
    if not selected and not args.report:
        selected = [(mode, fn) for mode, _flag, fn in checks]

    if args.report:
        report()

    findings: list[str] = []
    for _mode, fn in selected:
        findings.extend(fn())

    if not selected and not args.report:
        return 0
    if findings:
        print(f"FAIL: {len(findings)} discipline-vocabulary finding(s):\n")
        for item in findings:
            print("  " + item)
        return 1
    if selected:
        ran = ", ".join(mode for mode, _fn in selected)
        notes = ""
        if any(mode == "protection" for mode, _fn in selected):
            leaves = len(taxonomy(CH["08-disciplines.qmd"]))
            notes = f" Zero martial Protection hits. Discipline leaves: {leaves}."
        print(f"OK: {ran}: zero findings.{notes}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
