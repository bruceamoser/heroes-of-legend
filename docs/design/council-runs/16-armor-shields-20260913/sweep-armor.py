#!/usr/bin/env python3
"""Armour-table dominance sweep for Heroes of Legend ch16 (Armor & Shields).

Built for council run 20260913-0322, ruling r-001 condition 2:
  "Any adopted repair must be re-swept over all eight rows on every axis the
   table prints, with the before-and-after count of strictly dominated pairs
   reported and zero new pairs required."

Axes the table prints (r-001 condition 3 bars shield-augmented comparisons,
because a shield stacks with every body-armour row):
  cost        lower is better
  discipline  lower rank requirement is better
  dr          higher is better
  stealth     no Bane is better
  speed       no 5 ft cut is better

A strictly dominates B iff A is at least as good on every axis and strictly
better on at least one. Run with no arguments for the as-printed baseline.
"""
import itertools
import json
import sys

AXES = ("cost", "discipline", "dr", "stealth", "speed")


def as_printed():
    """The eight rows exactly as ch16 prints them before any repair."""
    return {
        "Padded":         dict(cost=5,   discipline=0, dr=1, bane=False, slow=False),
        "Leather":        dict(cost=10,  discipline=0, dr=2, bane=False, slow=False),
        "Studded Leather": dict(cost=25, discipline=1, dr=2, bane=False, slow=False),
        "Chain Shirt":    dict(cost=50,  discipline=1, dr=3, bane=True,  slow=False),
        "Breastplate":    dict(cost=100, discipline=2, dr=4, bane=False, slow=False),
        "Half Plate":     dict(cost=150, discipline=2, dr=4, bane=True,  slow=True),
        "Chain Mail":     dict(cost=75,  discipline=2, dr=5, bane=True,  slow=True),
        "Plate":          dict(cost=300, discipline=3, dr=6, bane=True,  slow=True),
    }


def dominates(a, b):
    at_least_as_good = (
        a["cost"] <= b["cost"]
        and a["discipline"] <= b["discipline"]
        and a["dr"] >= b["dr"]
        and (not a["bane"] or b["bane"])
        and (not a["slow"] or b["slow"])
    )
    strictly_better = (
        a["cost"] < b["cost"]
        or a["discipline"] < b["discipline"]
        or a["dr"] > b["dr"]
        or (b["bane"] and not a["bane"])
        or (b["slow"] and not a["slow"])
    )
    return at_least_as_good and strictly_better


def sweep(rows):
    pairs = [(x, y) for x, y in itertools.permutations(rows, 2) if dominates(rows[x], rows[y])]
    losers = sorted({y for _, y in pairs})
    winners = sorted({x for x, _ in pairs})
    return {
        "dominated_pairs": len(pairs),
        "losing_rows": losers,
        "pairs": [f"{x} > {y}" for x, y in pairs],
        "winners": winners,
        "rows": list(rows),
    }


def implicit_rates(rows):
    """Successive marginal cost per printed DR step, cheapest first."""
    ordered = sorted(rows.items(), key=lambda kv: (kv[1]["dr"], kv[1]["cost"]))
    out = []
    for (n1, a), (n2, b) in zip(ordered, ordered[1:]):
        if b["dr"] > a["dr"]:
            out.append({
                "step": f"{n1} -> {n2}",
                "extra_gp": b["cost"] - a["cost"],
                "extra_dr": b["dr"] - a["dr"],
                "gp_per_dr": round((b["cost"] - a["cost"]) / (b["dr"] - a["dr"]), 2),
                "other_changes": [
                    k for k in ("discipline", "bane", "slow")
                    if a[k] != b[k]
                ],
            })
    return out


def main():
    rows = as_printed()
    if len(sys.argv) > 1:
        rows = json.load(open(sys.argv[1]))
    result = {"label": "as-printed" if len(sys.argv) == 1 else sys.argv[1],
              "axes": list(AXES), "sweep": sweep(rows), "marginal_steps": implicit_rates(rows)}
    print(json.dumps(result, indent=1))
    print(f"\nBEFORE/AFTER COUNT: {result['sweep']['dominated_pairs']} strictly dominated "
          f"pairs from {len(result['sweep']['losing_rows'])} losing rows", file=sys.stderr)


if __name__ == "__main__":
    main()
