"""Read-only catalog breadth audit. Counts access routes, not game balance."""
import argparse
import json
from pathlib import Path
import re
import subprocess

from index import field

ROOT = Path(__file__).resolve().parent
TIERS = ('1', '3', '7')


def survey(ref=None):
    def files(folder):
        if ref:
            names = subprocess.check_output(
                ['git', 'ls-tree', '-r', '--name-only', ref, '--', f'design/{folder}'],
                cwd=ROOT.parent, text=True).splitlines()
            return [(name, subprocess.check_output(
                ['git', 'show', f'{ref}:{name}'], cwd=ROOT.parent, text=True))
                for name in names if name.endswith('.md')]
        return [(str(p.relative_to(ROOT.parent)), p.read_text())
                for p in sorted((ROOT / folder).glob('*.md'))]

    disciplines = [s.splitlines()[0].removeprefix('# ') for _, s in files('disciplines')]
    cards = []
    all_cards = files('cards')
    for path, source in all_cards:
        if field(source, 'Type') == 'Signature':
            continue
        requirements = {d: int(r) for d, r in re.findall(
            r'([A-Za-z]+) ([123])', field(source, 'Requirements to learn'))}
        if requirements:
            cards.append(dict(id=Path(path).stem, tier=field(source, 'Tier / minimum level'),
                              action=field(source, 'Action'), requirements=requirements))

    rows = {}
    for discipline in sorted(disciplines):
        tiers = {}
        for tier in TIERS:
            choices = [c for c in cards if c['tier'] == tier and discipline in c['requirements']]
            # A rank-1 side requirement on a Master card is not a Master route
            # for that discipline. Dual-rank-2 Master techniques still count.
            invested = [c for c in choices if c['requirements'][discipline] >= (1 if tier == '1' else 2)]
            tiers[tier] = dict(total=len(choices),
                               single=sum(len(c['requirements']) == 1 for c in choices),
                               actions={a: [c['id'] for c in choices if c['action'] == a]
                                        for a in ('Main Action', 'Maneuver', 'Reaction', 'Passive')},
                               invested_actions={a: [c['id'] for c in invested if c['action'] == a]
                                                 for a in ('Maneuver', 'Reaction')})
        rows[discipline] = dict(tiers=tiers, culture=0, background=0,
                                culture_routes=[], background_routes=[])

    for path, source in files('origins'):
        kind = Path(path).stem.split('-')[0]
        for discipline in re.findall(r'^- (?:\*\*)?([A-Za-z]+) 1(?:\*\*)? and ', source, re.M):
            if discipline not in rows:
                raise ValueError(f'{path}: unknown discipline {discipline}')
            rows[discipline][kind] += 1
            rows[discipline][kind + '_routes'].append(Path(path).stem)
    return dict(card_count=len(all_cards), disciplines=rows)


def problems(data):
    errors = []
    for name, row in data['disciplines'].items():
        for tier, counts in row['tiers'].items():
            for action, choices in counts['invested_actions'].items():
                if not choices:
                    errors.append(f'{name}: level {tier} lacks an invested {action} route')
        for kind in ('culture', 'background'):
            if not row[kind]:
                errors.append(f'{name}: no {kind} route')
    return errors


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline', help='Also survey a Git commit/ref without changing the checkout')
    parser.add_argument('--json', action='store_true')
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    current = survey()
    if args.json:
        output = {'current': current}
        if args.baseline:
            output['baseline'] = survey(args.baseline)
        print(json.dumps(output, indent=2))
    else:
        print('Discipline | Novice all/solo | Adept all/solo | Master all/solo | Culture/Background choices')
        for name, row in current['disciplines'].items():
            cells = [f"{row['tiers'][t]['total']}/{row['tiers'][t]['single']}" for t in TIERS]
            print(' | '.join([name, *cells, f"{row['culture']}/{row['background']}"]))
        print('Mixed cards count in each required discipline; signatures and no-requirement cards are excluded.')
        print('Choice counts are not encounter balance or equal mechanical value.')
    if args.check:
        errors = problems(current)
        for error in errors:
            print(error)
        if errors:
            raise SystemExit(1)
        if not args.json:
            print('All disciplines have invested Maneuver/Reaction routes at every tier and both origin routes.')


if __name__ == '__main__':
    main()
