#!/usr/bin/env python3
"""Verify copied example procedures, DP arithmetic and path references from source.

Reads authored Markdown directly; no generated catalog or fixture overrides.
This checks transcription and arithmetic, not balance or every runtime behavior.
"""
import argparse
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]


def verify(book=ROOT):
    design = Path(book) / "design"
    checks = []

    def require(condition, context):
        if not condition:
            raise ValueError(context)
        checks.append(context)

    def read_card(filename):
        return (design / "cards" / filename).read_text()

    characters = sorted(path for path in (design / "characters").glob("*.md") if path.name != "README.md")
    require(len(characters) == 6, "all six authored examples are present")
    for path in characters:
        text = path.read_text()
        signature = re.search(r"Free signature: \[[^]]+\]\(\.\./cards/([^)]*)\)", text)[1]
        card = read_card(signature)
        procedure = card.split("## Rules\n", 1)[1].split("\n---", 1)[0].strip()
        require(procedure in text, f"{path.name}: complete signature procedure")
        limit = re.search(r"\*\*Limits:\*\* ([^\n]+)", card)[1]
        require("**Signature limit:** " + limit in text, f"{path.name}: signature limit")
        for match in re.finditer(r"\[([^]]+)\]\(\.\./cards/([^)]*)\)", text):
            require(match[1] == read_card(match[2]).splitlines()[0][2:], f"{path.name}: current title {match[2]}")
        checklist = text.split("## Complete learned-card checklist\n", 1)[1].split("\n## ", 1)[0]
        rows = list(re.finditer(r"^- \[([^]]+)\]\(\.\./cards/([^)]*)\) — ([^;]+); ([^\n]+)\.$", checklist, re.M))
        require(len(rows) == len(re.findall(r"^- \[", checklist, re.M)), f"{path.name}: every checklist row parsed")
        for match in rows:
            source = read_card(match[2])
            action = re.search(r"\*\*Action:\*\* (.*?)(?= · |\n)", source)[1]
            attribute = re.search(r"\*\*Attribute:\*\* ([^\n]+)", source)[1]
            require((match[3], match[4]) == (action, attribute), f"{path.name}: checklist {match[1]}")
        # Attribute order is declared in the table, independently of printed DP totals.
        attributes = re.search(r"\| ([+-]\d) \| ([+-]\d) \| ([+-]\d) \| ([+-]\d) \| ([+-]\d) \| ([+-]\d) \|", text)
        require(attributes is not None, f"{path.name}: attributes parsed")
        values = list(map(int, attributes.groups()))
        require(sum(values) == 3, f"{path.name}: attribute total")
        base = 10 + sum(values[3:])
        require(int(re.search(r"base pool is \*\*(\d+) DP", text)[1]) == base, f"{path.name}: mental base pool")
        adaptable = int("trait-human-far-walker" in text)
        stages = re.split(r"(?=## Level [01] —)", text)[1:]
        require(len(stages) == 2, f"{path.name}: both creation stages")
        for section in stages:
            title = section.splitlines()[0]
            duplicates = int(re.search(r"(?:Opening|Fresh) pool: \*\*[^\n]*?\+ (\d+)(?: duplicate compensation)? =", section)[1])
            expected = base + adaptable + duplicates
            printed = int(re.search(r"(?:Opening|Fresh) pool: \*\*[^\n]*? = (\d+) DP", section)[1])
            require(printed == expected, f"{path.name} {title}: pool including explicit Adaptable grant")
            table = re.search(r"\| Purchase \| Requirements held / price basis \| DP spent \| Remaining \|\n([\s\S]*?)(?=\n\n)", section)[1]
            purchases = list(re.finditer(r"^\|[^\n]+\| (\d+) \| (\d+) \|$", table, re.M))
            require(bool(purchases), f"{path.name} {title}: purchase rows parsed")
            spent = 0
            for purchase in purchases:
                spent += int(purchase[1])
                require(int(purchase[2]) == expected - spent, f"{path.name} {title}: running balance {spent}")
            closing = re.search(r"\*\*Spent (\d+); (\d+) DP expires", section)
            require((int(closing[1]), int(closing[2])) == (spent, expected - spent), f"{path.name} {title}: spent and expiry")
    paths = sorted((design / "paths").glob("*.md"))
    require(len(paths) == 36, "all 36 path guides are present")
    for path in paths:
        for match in re.finditer(r"\[([^]]+)\]\(\.\./cards/([^)]*)\)", path.read_text()):
            require(match[1] == read_card(match[2]).splitlines()[0][2:], f"{path.name}: current title {match[2]}")
    require("**Limits:** Once on your turn." in read_card("signature-leader-hold-your-nerve.md"), "Blow the Horn: exact CHG-LDR-019 limit")
    return {"checks": len(checks), "result": "pass", "characters": len(characters), "paths": len(paths), "scope": "complete copied signature procedures and limits, current names/checklists, attribute-derived DP pools and running balances, path names, approved Blow the Horn limit"}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--book", type=Path, default=ROOT)
    args = parser.parse_args()
    print(json.dumps(verify(args.book), indent=2))


if __name__ == "__main__":
    main()
