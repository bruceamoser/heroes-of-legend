"""Aggregate reports and output writing for `hol-engine run`."""

from __future__ import annotations

import json
import os
from collections import Counter, defaultdict
from pathlib import Path

from .cards import CardBook
from .characters import build_party
from .combat import Combat
from .dice import combat_seed
from .rules import rules as default_rules

import random


def parse_events_mode(value):
    if value in (None, "first:100"):
        return 100
    if value == "none" or value is False:
        return 0
    if value == "all" or value is True:
        return -1
    if isinstance(value, int):
        return value
    text = str(value)
    if text.startswith("first:"):
        return int(text.split(":", 1)[1])
    raise ValueError(f"unknown events mode {value!r}")


def run_one(data, index, rules, cardbook, party_chars, record_events=False, script=None):
    run = data["run"]
    rng = random.Random(combat_seed(int(run["seed"]), index))
    combat = Combat(
        index,
        int(run["seed"]),
        data.get("party") or [],
        data.get("opposition") or [],
        data.get("policies") or {},
        rules=rules,
        round_limit=int(run.get("round_limit", 20)),
        rng=rng,
        script=script,
        record_events=record_events,
        flags=run.get("flags") or {},
        cards=cardbook,
        party_chars=party_chars,
    )
    return combat.run()


def run_all(data, rules=None, cardbook=None, iterations=None):
    rules = rules or default_rules()
    cardbook = cardbook or CardBook(rules)
    run = data["run"]
    iterations = int(iterations if iterations is not None else run["iterations"])
    party_chars = build_party(data.get("party") or [], rules, cardbook)
    events_budget = parse_events_mode((data.get("run") or {}).get("events", "first:100"))
    results = []
    for i in range(iterations):
        record = events_budget == -1 or i < events_budget
        results.append(run_one(data, i, rules, cardbook, party_chars, record_events=record))
    return results, party_chars


def _percentile(values, p):
    if not values:
        return None
    values = sorted(values)
    idx = min(len(values) - 1, int(round((len(values) - 1) * p)))
    return values[idx]


def summarize(data, results, party_specs=None):
    run = data["run"]
    n = len(results)
    outcomes = Counter(r["outcome"] for r in results)
    rounds = [r["rounds"] for r in results]
    tiers = Counter()
    hero_stats = {}
    class_stats = defaultdict(lambda: {
        "deaths": 0, "plateaus": 0, "encounters": 0, "wounds": 0, "damage_dealt": 0,
        "damage_taken": 0, "downs": 0,
    })
    wound_counter = Counter()
    wound_row_counter = Counter()
    wound_row_by_tier = defaultdict(Counter)
    p_by_combat = []
    specs_by_id = {str(s.get("id") or s.get("name") or s.get("class")): s for s in (party_specs or data.get("party") or [])}
    for result in results:
        info = {
            "id": None,
            "class": None,
            "tier": None,
            "wounds": Counter(),
            "rows": Counter(),
            "died": 0,
            "plateau": 0,
            "down": 0,
            "damage_dealt": 0,
            "damage_taken": 0,
            "heals": 0,
            "grit": 0,
            "encounters": 0,
        }
        hero_wounds_this = []
        for hero in result["heroes"]:
            hid = hero["id"]
            if hid not in hero_stats:
                spec = specs_by_id.get(str(hid), {})
                hero_stats[hid] = {
                    "id": hid,
                    "class": hero.get("class") or spec.get("class"),
                    "tier": hero.get("tier"),
                    "wounds": Counter(),
                    "rows": Counter(),
                    "died": 0,
                    "plateau": 0,
                    "down": 0,
                    "damage_dealt": 0,
                    "damage_taken": 0,
                    "heals": 0,
                    "grit": 0,
                    "encounters": 0,
                    "healing_done": 0,
                }
            entry = hero_stats[hid]
            entry["encounters"] += 1
            entry["wounds"][hero["wounds"]] += 1
            entry["died"] += 1 if hero["died"] else 0
            entry["plateau"] += 1 if hero["plateau"] else 0
            entry["down"] += 1 if hero.get("dying_at_end") else 0
            entry["damage_dealt"] += hero["damage_dealt"]
            entry["damage_taken"] += hero["damage_taken"]
            entry["heals"] += hero["heals_cast"]
            entry["healing_done"] += hero.get("healing_done", 0)
            entry["grit"] += hero["grit_spent"]
            hero_wounds_this.append(hero["wounds"])
            if hero["wounds"] >= 4:
                wound_counter["p_4plus"] += 1
            for row in hero["wound_rows"]:
                entry["rows"][row["row"]] += 1
                wound_row_counter[row["row"]] += 1
                wound_row_by_tier[hero.get("tier") or "?"][row["row"]] += 1
            cls = hero.get("class")
            class_entry = class_stats[cls]
            class_entry["encounters"] += 1
            class_entry["deaths"] += 1 if hero["died"] else 0
            class_entry["plateaus"] += 1 if hero["plateau"] else 0
            class_entry["wounds"] += hero["wounds"]
            class_entry["damage_dealt"] += hero["damage_dealt"]
            class_entry["damage_taken"] += hero["damage_taken"]
            class_entry["downs"] += 1 if hero.get("dying_at_end") else 0
            tiers[hero.get("tier") or "?"] += 1
        p_by_combat.append(hero_wounds_this)
    total_wound_rolls = sum(wound_row_counter.values()) or 1
    summary = {
        "run": {
            "name": run.get("name"),
            "seed": run.get("seed"),
            "iterations": n,
            "round_limit": int(run.get("round_limit", 20)),
            "flags": run.get("flags") or {},
            "encounter": encounter_label(data),
        },
        "outcomes": {
            "party_win": outcomes.get("party_win", 0),
            "party_loss": outcomes.get("party_loss", 0),
            "timeout": outcomes.get("timeout", 0),
        },
        "pacing": {
            "mean_rounds": round(sum(rounds) / n, 3) if n else None,
            "median_rounds": _percentile(rounds, 0.5),
            "p10": _percentile(rounds, 0.10),
            "p90": _percentile(rounds, 0.90),
            "round_counts": dict(sorted(Counter(rounds).items())),
            "p_3_to_4_rounds": round(sum(1 for r in rounds if 3 <= r <= 4) / n, 4) if n else None,
        },
        "wound_load": {
            "distribution": {str(k): v for k, v in sorted(
                Counter(w for heroes in p_by_combat for w in heroes).items())},
            "p_hero_reaches_4plus": round(wound_counter["p_4plus"] / sum(len(h) for h in p_by_combat), 5)
            if p_by_combat else None,
        },
        "heroes": {},
        "classes": {},
        "wound_band_distribution": {},
        "events_sampled": None,
    }
    for hid, entry in sorted(hero_stats.items()):
        distribution = {str(k): v for k, v in sorted(entry["wounds"].items())}
        summary["heroes"][hid] = {
            "class": entry["class"],
            "tier": entry["tier"],
            "wounds_distribution": distribution,
            "wound_rows": dict(sorted(entry["rows"].items())),
            "p_dies": round(entry["died"] / entry["encounters"], 4),
            "p_wound_plateau": round(entry["plateau"] / entry["encounters"], 4),
            "p_ends_dying": round(entry["down"] / entry["encounters"], 4),
            "mean_wounds": round(
                sum(int(k) * v for k, v in entry["wounds"].items()) / entry["encounters"], 3),
            "mean_damage_dealt": round(entry["damage_dealt"] / entry["encounters"], 2),
            "mean_damage_taken": round(entry["damage_taken"] / entry["encounters"], 2),
            "mean_heals": round(entry["heals"] / entry["encounters"], 2),
            "mean_healing_done": round(entry["healing_done"] / entry["encounters"], 2),
            "mean_grit_spent": round(entry["grit"] / entry["encounters"], 2),
        }
    for cls, entry in sorted(class_stats.items(), key=lambda kv: str(kv[0])):
        summary["classes"][cls or "?"] = {
            "encounters": entry["encounters"],
            "p_dies": round(entry["deaths"] / entry["encounters"], 4),
            "p_wound_plateau": round(entry["plateaus"] / entry["encounters"], 4),
            "p_ends_dying": round(entry["downs"] / entry["encounters"], 4),
            "mean_wounds": round(entry["wounds"] / entry["encounters"], 3),
            "mean_damage_dealt": round(entry["damage_dealt"] / entry["encounters"], 2),
            "mean_damage_taken": round(entry["damage_taken"] / entry["encounters"], 2),
        }
    for row, count in sorted(wound_row_counter.items()):
        summary["wound_band_distribution"][row] = {
            "count": count,
            "pct": round(100.0 * count / total_wound_rolls, 2),
        }
    for tier, counter in sorted(wound_row_by_tier.items()):
        summary.setdefault("wound_bands_by_tier", {})[tier] = {
            row: round(100.0 * count / (sum(counter.values()) or 1), 2)
            for row, count in sorted(counter.items())
        }
    summary["stubs_active"] = active_stubs(data)
    return summary


def encounter_label(data):
    parts = []
    for spec in data.get("opposition") or []:
        parts.append(f"{spec.get('count', 1)}x {spec.get('creature')}")
    return ", ".join(parts)


def active_stubs(data):
    from .bestiary import bestiary
    active = set()
    run_flags = (data.get("run") or {}).get("flags") or {}
    declared = {"morale": "morale checks", "cover": "cover", "terrain": "terrain and positioning"}
    for flag, label in declared.items():
        if not run_flags.get(flag, False):
            active.add(label)
    bestiary_data = bestiary()
    for spec in data.get("opposition") or []:
        creature = bestiary_data.get(spec.get("creature"))
        if creature:
            for ability in creature.abilities:
                if not ability.modeled:
                    active.add(f"{creature.name}: {ability.name}")
    return sorted(active)


def format_report(summary):
    lines = []
    run = summary["run"]
    lines.append(f"run: {run['name']}  seed={run['seed']}  iterations={run['iterations']}")
    lines.append(f"encounter: {run['encounter']}")
    lines.append("")
    lines.append("== Pacing (spec 8.1) ==")
    pacing = summary["pacing"]
    lines.append(f"rounds mean={pacing['mean_rounds']} median={pacing['median_rounds']} "
                 f"p10={pacing['p10']} p90={pacing['p90']} "
                 f"P(3-4 rounds)={pacing['p_3_to_4_rounds']}")
    lines.append("round distribution: " + ", ".join(
        f"{k}:{v}" for k, v in pacing["round_counts"].items()))
    lines.append("")
    lines.append("== Wound load (spec 8.2) ==")
    wl = summary["wound_load"]
    lines.append("wounds per hero per fight: " + ", ".join(
        f"{k}W {v}" for k, v in wl["distribution"].items()))
    lines.append(f"P(a hero reaches 4+ wounds) = {wl['p_hero_reaches_4plus']}")
    lines.append("")
    lines.append("== Attrition (spec 8.3) ==")
    out = summary["outcomes"]
    total = max(1, sum(out.values()))
    lines.append(f"P(wipe)={out['party_loss']/total:.4f}  P(timeout)={out['timeout']/total:.4f}  "
                 f"P(win)={out['party_win']/total:.4f}")
    for cls, entry in summary["classes"].items():
        lines.append(f"  {cls:10s} die={entry['p_dies']:.4f} wp4={entry['p_wound_plateau']:.4f} "
                     f"dying_at_end={entry['p_ends_dying']:.4f} mean_wounds={entry['mean_wounds']}")
    lines.append("")
    lines.append("== Layer value (spec 8.4) ==")
    if summary.get("layer_study"):
        base = summary["layer_study"]["baseline"]
        lines.append(f"baseline (no layer) P(wipe)={base['p_wipe']:.4f} "
                     f"mean_damage_taken={base['mean_damage_taken']:.2f} mean_wounds={base['mean_wounds']:.3f}")
        for name, entry in summary["layer_study"]["variants"].items():
            lines.append(
                f"  {name:16s} dP(wipe)={entry['p_wipe'] - base['p_wipe']:+.4f} "
                f"dDamage={entry['mean_damage_taken'] - base['mean_damage_taken']:+.2f} "
                f"dWounds={entry['mean_wounds'] - base['mean_wounds']:+.3f}")
    else:
        lines.append("not requested by the run file (add a study.layers block)")
    lines.append("")
    lines.append("== Healer delta (spec 8.5) ==")
    if summary.get("healer_study"):
        for policy, entry in summary["healer_study"].items():
            lines.append(
                f"  policy {policy}: off P(wipe)={entry['off']['p_wipe']:.4f} "
                f"one P(wipe)={entry['one']['p_wipe']:.4f} two P(wipe)={entry['two']['p_wipe']:.4f}")
    else:
        lines.append("not requested by the run file (add a study.healers block)")
    lines.append("")
    lines.append("== Class spread (spec 8.6) ==")
    for cls, entry in summary["classes"].items():
        lines.append(f"  {cls:10s} encounters={entry['encounters']} P(die)={entry['p_dies']:.4f} "
                     f"P(carries4+)={entry['p_wound_plateau']:.4f} dmg_dealt={entry['mean_damage_dealt']:.2f} "
                     f"dmg_taken={entry['mean_damage_taken']:.2f}")
    lines.append("")
    lines.append("== Wound-band distribution (spec 8.7) ==")
    for row, entry in summary["wound_band_distribution"].items():
        lines.append(f"  {row:28s} {entry['count']:>6d}  {entry['pct']:>6.2f}%")
    lines.append("")
    lines.append("== Active stubs ==")
    for stub in summary.get("stubs_active", []):
        lines.append(f"  - {stub}")
    return "\n".join(lines)


def _study_metrics(results):
    n = max(1, len(results))
    wins = sum(1 for r in results if r["outcome"] == "party_win")
    losses = sum(1 for r in results if r["outcome"] == "party_loss")
    hero_rows = [h for r in results for h in r["heroes"]]
    return {
        "iterations": len(results),
        "p_wipe": round(losses / n, 4),
        "p_win": round(wins / n, 4),
        "mean_rounds": round(sum(r["rounds"] for r in results) / n, 3),
        "mean_damage_taken": round(sum(h["damage_taken"] for h in hero_rows) / max(1, len(hero_rows)), 2),
        "mean_wounds": round(sum(h["wounds"] for h in hero_rows) / max(1, len(hero_rows)), 3),
        "hero_deaths": sum(1 for h in hero_rows if h["died"]) / max(1, len(hero_rows)),
    }


def _variant(data, mutate, iterations, rules, cardbook):
    variant = json.loads(json.dumps(data))
    mutate(variant)
    results, _ = run_all(variant, rules, cardbook, iterations=iterations)
    return _study_metrics(results)


def study_layers(data, rules, cardbook, iterations):
    party = data.get("party") or []
    if not party:
        return None
    subject = party[0]
    layers = [
        ("none", {}),
        ("light", {"armor": "light"}),
        ("medium", {"armor": "medium"}),
        ("heavy", {"armor": "heavy"}),
        ("shield", {"shield": True}),
        ("ward-1", {"ward_dr": 1}),
        ("ward-2", {"ward_dr": 2}),
        ("ward-3", {"ward_dr": 3}),
        ("light+shield", {"armor": "light", "shield": True}),
        ("heavy+shield", {"armor": "heavy", "shield": True}),
        ("heavy+ward", {"armor": "heavy", "ward_dr": 3}),
    ]

    def make_mutator(equipment):
        def mutate(variant):
            for spec in variant["party"]:
                original = dict(spec.get("equipment") or {})
                original.pop("armor", None)
                original.pop("shield", None)
                original.pop("ward_dr", None)
                original.update(equipment)
                spec["equipment"] = original
        return mutate

    baseline = _variant(data, make_mutator({}), iterations, rules, cardbook)
    variants = {}
    for name, equipment in layers:
        if name == "none":
            continue
        variants[name] = _variant(data, make_mutator(equipment), iterations, rules, cardbook)
    return {"subject": subject.get("id") or subject.get("class"),
            "baseline": baseline, "variants": variants}


def study_healers(data, rules, cardbook, iterations):
    party = data.get("party") or []
    if not party:
        return None
    healer_index = None
    for i, spec in enumerate(party):
        if spec.get("class") == "Shepherd":
            healer_index = i
            break
    if healer_index is None:
        return None
    policies = sorted((data.get("policies") or {"default": {}}).keys())
    report = {}
    for policy in policies:
        def set_policy(variant):
            for spec in variant["party"]:
                spec["policy"] = policy
        two = json.loads(json.dumps(data))
        healer = json.loads(json.dumps(party[healer_index]))
        healer["id"] = f"{healer.get('id', 'healer')}-2"
        healer["name"] = healer.get("name", "healer") + " II"
        two["party"].append(healer)
        report[policy] = {
            "off": _variant(data, lambda v: (set_policy(v), v["party"].pop(healer_index)),
                            iterations, rules, cardbook),
            "one": _variant(data, set_policy, iterations, rules, cardbook),
            "two": _variant(two, set_policy, iterations, rules, cardbook),
        }
    return report


def write_outputs(outdir, summary, results, event_mode):
    outdir = Path(outdir)
    outdir.mkdir(parents=True, exist_ok=True)
    summary_path = outdir / "summary.json"
    summary_path.write_text(json.dumps(summary, indent=2, sort_keys=True), encoding="utf-8")
    combats_path = outdir / "combats.jsonl"
    with open(combats_path, "w", encoding="utf-8") as handle:
        for result in results:
            row = {k: v for k, v in result.items() if k != "events"}
            handle.write(json.dumps(row, sort_keys=True) + "\n")
    events_path = outdir / "events.jsonl"
    with open(events_path, "w", encoding="utf-8") as handle:
        for result in results:
            for event in result.get("events") or []:
                handle.write(json.dumps(event, sort_keys=True) + "\n")
    report_path = outdir / "report.txt"
    report_path.write_text(format_report(summary) + "\n", encoding="utf-8")
    return {
        "summary": str(summary_path),
        "combats": str(combats_path),
        "events": str(events_path),
        "report": str(report_path),
    }
