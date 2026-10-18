"""Read-only creature action survey. Counts choices, not power or encounter balance."""
from pathlib import Path
from collections import Counter
import argparse
import json
import re
import subprocess

ROOT = Path(__file__).resolve().parents[2]
DESIGN = ROOT / 'design'
UNIVERSAL = {'Basic Melee', 'Defend', 'Opportunity Attack'}
KINDS = ('Main Actions', 'Maneuvers', 'Reactions')


def template_rules(path):
    rules = path.read_text().split('**Action:**', 1)[1].split('\n', 1)[1]
    return re.split(r'\n\n(?:Only creatures|\*\*Limits:\*\*|\[Creature procedure)', rules, maxsplit=1)[0].strip()


def summon_rules(slug, rules):
    """Expected perspective/timing for review checks; never rewrites authored profiles."""
    rules = rules.replace('until its next turn', 'until the start of the controller’s next turn')
    rules = rules.replace("until the start of this creature's next turn", 'until the start of the controller’s next turn')
    rules = rules.replace('before the end of this turn', 'before the end of the controller’s turn')
    rules = rules.replace('before turn end', 'before the end of the controller’s turn')
    rules = rules.replace('Once per turn', 'Once per controller turn')
    if slug == 'watch-the-opening':
        return 'Gain 1 Boon on its next attack before the end of the controller’s turn. One attack only; repeated uses do not stack.'
    if slug == 'shambling-advance':
        rules = rules.replace('imposes 1 additional Bane on the player defense', 'gains 1 Boon')
        rules = rules.replace('For a player-controlled creature, gain 1 attack Boon instead. ', '')
    return rules


def action_rows(source, kind):
    play = source.split('## Design notes', 1)[0]
    match = re.search(r'^\| ' + re.escape(kind) + r' \|[^\n]*\n\|[-| ]+\|\n((?:\|[^\n]*\n)*)', play, re.M)
    return [line.split('|')[1].strip() for line in match[1].splitlines()
            if line.split('|')[1].strip() not in UNIVERSAL] if match else []


def survey(baseline=None):
    def read(path):
        if baseline:
            return subprocess.check_output(['git', 'show', baseline + ':' + str(path.relative_to(ROOT))], cwd=ROOT, text=True)
        return path.read_text()
    creatures = {}
    categories = {}
    totals = Counter()
    for path in sorted((DESIGN / 'bestiary/creatures').glob('*.md')):
        source = read(path)
        category = re.search(r'\*\*Category:\*\* (.*?) ·', source)[1]
        cv = int(re.search(r'\*\*CV:\*\* (\d+)', source)[1])
        actions = {kind: action_rows(source, kind) for kind in KINDS}
        creatures[path.stem] = dict(name=source.splitlines()[0][2:].rsplit(' (CV', 1)[0], category=category, cv=cv, **actions)
        counts = categories.setdefault(category, Counter())
        for bucket in (totals, counts):
            bucket['creatures'] += 1
            for kind, names in actions.items():
                bucket[kind + ' choices'] += len(names)
                bucket[kind + ' creatures'] += bool(names)
            bucket['both'] += bool(actions['Maneuvers'] and actions['Reactions'])
            bucket['neither'] += not (actions['Maneuvers'] or actions['Reactions'])
    templates = Counter()
    for path in (DESIGN / 'monster-abilities').glob('*.md'):
        if path.name == 'README.md':
            continue
        # New files are absent from the old revision; list the actual old tree.
        if baseline:
            continue
        action = re.search(r'\*\*Action:\*\* ([^\n]+)', read(path))[1].split(';')[0]
        templates[action] += 1
    if baseline:
        paths = subprocess.check_output(['git', 'ls-tree', '-r', '--name-only', baseline, '--', 'design/monster-abilities'], cwd=ROOT, text=True).splitlines()
        for name in paths:
            if not name.endswith('.md') or name.endswith('/README.md'):
                continue
            source = subprocess.check_output(['git', 'show', baseline + ':' + name], cwd=ROOT, text=True)
            templates[re.search(r'\*\*Action:\*\* ([^\n]+)', source)[1].split(';')[0]] += 1
    return dict(totals=dict(totals), categories={k: dict(v) for k, v in sorted(categories.items())}, templates=dict(templates), creatures=creatures)


def audit(data):
    """Check review coverage, source attribution and summon exclusions; no per-creature quota."""
    errors = []
    review = (DESIGN / 'bestiary/action-coverage.md').read_text()
    recorded = {}
    for match in re.finditer(r'^\| \[[^\n]+\]\(creatures/([a-z-]+)\.md\) \| (\d+) → (\d+) \| (\d+) → (\d+) \| (\d+) → (\d+) \| (.+) \|$', review, re.M):
        slug, old_m, maneuvers, old_r, reactions, old_cv, cv, reason = match.groups()
        if slug in recorded:
            errors.append(slug + ': duplicate review row')
        recorded[slug] = (int(maneuvers), int(reactions), int(cv))
        if not reason.strip():
            errors.append(slug + ': missing design judgment')
    if set(recorded) != set(data['creatures']):
        errors.append('Review must cover every creature exactly once')
    names = {}
    reviewed = set(re.findall(r'\]\(\.\./monster-abilities/([a-z-]+)\.md\)', review))
    normalize = lambda text: re.sub(r'\s+', ' ', text).strip()
    index = (DESIGN / 'monster-abilities/README.md').read_text()
    for path in (DESIGN / 'monster-abilities').glob('*.md'):
        if path.name == 'README.md':
            continue
        source = path.read_text()
        name = source.splitlines()[0][2:]
        action = re.search(r'\*\*Action:\*\* ([^\n]+)', source)[1].split(';')[0]
        names[name] = (path, action)
        if f']({path.name}) | {action}' not in index:
            errors.append(path.name + ': missing/wrong action in monster ability index')
    # These three older abilities are fully authored inline on their own creature.
    inline = {'Smoke pots', 'Scatter caltrops', 'Helping hands'}
    for slug, creature in data['creatures'].items():
        actual = (len(creature['Maneuvers']), len(creature['Reactions']), creature['cv'])
        if recorded.get(slug) != actual:
            errors.append(slug + ': review counts/CV differ from creature')
        source = (DESIGN / 'bestiary/creatures' / (slug + '.md')).read_text()
        play = source.split('## Design notes', 1)[0]
        for kind, action in [('Maneuvers', 'Maneuver'), ('Reactions', 'Reaction')]:
            rows = creature[kind]
            if len(rows) != len(set(rows)):
                errors.append(slug + ': duplicate ' + action)
            for name in rows:
                if name in inline:
                    continue
                if name not in names:
                    errors.append(slug + ': unknown monster ability ' + name)
                    continue
                path, expected = names[name]
                if action != expected:
                    errors.append(slug + ': wrong action type ' + name)
                if f'../../monster-abilities/{path.name}' not in source:
                    errors.append(slug + ': missing ability-source link ' + name)
                if path.stem in reviewed:
                    rules = template_rules(path)
                    if normalize(rules) not in normalize(play):
                        errors.append(slug + ': reviewed rules differ from template ' + name)
                if (f'### {name}\n' not in play and f'**{name}:**' not in play
                        and not re.search(r'^\| ' + re.escape(name) + r' \| (?!.*(?:See details|see details))[^\n]+', play, re.M)):
                    errors.append(slug + ': missing playable details ' + name)
        summon = DESIGN / 'bestiary/summons' / (slug + '.md')
        if summon.exists():
            text = summon.read_text()
            if action_rows(text, 'Reactions') or re.search(r'^### .+ — Reaction\b|^\*\*[^\n]+ — Reaction:', text, re.M):
                errors.append(slug + ': summon has an independent Reaction')
            if 'no Reactions' not in text:
                errors.append(slug + ': summon lost no-Reactions rule')
            for name in creature['Maneuvers']:
                # A separate profile must either explicitly include or omit a Maneuver;
                # a missing one is a review flag for this full synchronization pass.
                if name not in text:
                    errors.append(slug + ': summon missing reviewed Maneuver ' + name)
                if name in names and names[name][0].stem in reviewed:
                    path = names[name][0]
                    expected = summon_rules(path.stem, template_rules(path))
                    if normalize(expected) not in normalize(text):
                        errors.append(slug + ': summon Maneuver rules/perspective differ ' + name)
    return errors


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline', help='Compare to an existing Git revision')
    parser.add_argument('--check', action='store_true', help='Validate reviewed assignments and exclusions')
    parser.add_argument('--json', action='store_true')
    args = parser.parse_args()
    data = survey()
    result = dict(current=data)
    if args.baseline:
        result['baseline'] = survey(args.baseline)
    errors = audit(data) if args.check else []
    result['errors'] = errors
    if args.json:
        print(json.dumps(result, indent=2, ensure_ascii=False))
    else:
        for label in ('baseline', 'current'):
            if label in result:
                print(label + ': ' + json.dumps(result[label]['totals']))
                print('  templates: ' + json.dumps(result[label]['templates']))
        for error in errors:
            print(error)
        if args.check and not errors:
            print('Complete review, ability attribution, action types and summon exclusions pass. No per-creature quota or balance claim.')
    if errors:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
