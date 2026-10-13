"""Read-only reproduction of issue 1141's catalog at historical commit 9b5eb4c.

Run from any directory: python3 design/reviews/survey_1141.py
Gameplay classifications are editorial judgments recorded in the CSV, not inferred.
"""
import csv
import subprocess
import itertools
import json
import re
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from index import field

REF = "9b5eb4c"
REPO = ROOT.parent
def historical(path):
    return subprocess.check_output(["git", "show", REF+":"+str(path.relative_to(REPO))], cwd=REPO, text=True)
def old_files(folder):
    paths = subprocess.check_output(["git", "ls-tree", "-r", "--name-only", REF, "design/"+folder], cwd=REPO, text=True).splitlines()
    return [REPO/p for p in paths if p.endswith(".md")]

cards = {}
for p in old_files('cards'):
    s = historical(p)
    if field(s, 'Tier / minimum level') == 'Universal' or field(s, 'Type') == 'Signature':
        continue
    cards[field(s, 'ID')] = {
        'tier': field(s, 'Tier / minimum level'),
        'action': field(s, 'Action'),
        'requirements': field(s, 'Requirements to learn'),
    }
rows = list(csv.DictReader((ROOT / 'reviews/1141-card-survey.csv').open()))
assert len(rows) == len(cards) == len({r['id'] for r in rows})
for r in rows:
    assert all(r[k] == cards[r['id']][k] for k in ('tier', 'action', 'requirements')), r['id']
requirements = {id: re.findall(r'([A-Z][a-z]+) ([123])', c['requirements'])
                for id, c in cards.items()}
report = {'shared_cards': len(cards), 'tiers': {}, 'disciplines': {}}
for t in ('1', '3', '7'):
    subset = [r for r in rows if r['tier'] == t]
    report['tiers'][t] = {
        'cards': len(subset),
        'classification': dict(Counter(r['classification'] for r in subset)),
        'passive': sum(r['action'] == 'Passive' for r in subset),
        'requirements': dict(Counter('none' if not requirements[r['id']] else
                           'single' if len(requirements[r['id']]) == 1 else 'mixed'
                           for r in subset)),
    }
for d in sorted({d for reqs in requirements.values() for d, rank in reqs}):
    report['disciplines'][d] = [sum(c['tier'] == t and any(x == d for x, _ in requirements[id])
                                   for id, c in cards.items()) for t in ('1', '3', '7')]

# Enumerate every printed culture pair, background pair and legal class-rank pair.
# Grant-only snapshot: no DP purchases yet. A real level-1 character also has L0 buys.
def origins(kind):
    result = []
    for p in [p for p in old_files('origins') if p.name.startswith(kind+'-')]:
        pairs = re.findall(r'^- (\w+) 1 and \[[^\]]+\]\(../cards/([^)]*)\.md\)', historical(p).replace('**', ''), re.M)
        assert len(pairs) == 2, p
        result.extend((d, id, p.stem) for d, id in pairs)
    return result

cultures, backgrounds = origins('culture'), origins('background')
# Only actual crafting permission qualifies Recipe Study; owning Craft rank alone does not.
crafting = {'trail-workshop', 'make-something-useful', 'smoke-in-a-bottle'}
for d, id, source in cultures + backgrounds:
    assert cards[id]['tier'] == '1' and requirements[id] == [(d, '1')], source
novice = {id: reqs for id, reqs in requirements.items() if cards[id]['tier'] == '1'}
cache = {}
def eligible(ranks, known):
    key = (tuple(sorted(ranks)), bool(known & crafting))
    if key not in cache:
        cache[key] = {id for id, reqs in novice.items()
                      if all(d in ranks and r == '1' for d, r in reqs)
                      and (id != 'ordinary-recipe-study' or key[1])}
    return cache[key]

report['origins'] = {'culture_pairs': len(cultures), 'background_pairs': len(backgrounds)}
report['grant_only_access'] = {}
for p in old_files('classes'):
    m = re.search(r'choose two distinct rank-1 disciplines from ([^.]+)\.', historical(p))
    assert m, p
    choices = m[1].split(', ')
    low = (999, None)
    high = (-1, None)
    total = 0
    for c, b, pair in itertools.product(cultures, backgrounds, itertools.combinations(choices, 2)):
        ranks = {c[0], b[0], *pair}
        known = {c[1], b[1]}
        count = len(eligible(ranks, known) - known)
        witness = {'culture': c[2], 'culture_card': c[1], 'background': b[2],
                   'background_card': b[1], 'class_ranks': pair, 'distinct_ranks': sorted(ranks)}
        if count < low[0]: low = (count, witness)
        if count > high[0]: high = (count, witness)
        total += 1
    report['grant_only_access'][p.stem] = {'combinations': total, 'min_unowned': low, 'max_unowned': high}
print(json.dumps(report, indent=2))
