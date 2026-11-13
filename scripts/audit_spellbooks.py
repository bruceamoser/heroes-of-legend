#!/usr/bin/env python3
"""Check authored spell lists against their playable blocks; not a balance test."""
from collections import Counter, defaultdict
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
seen = set()
actions = Counter()
cantrips = defaultdict(list)
attributes = {'Brawn', 'Fortitude', 'Agility', 'Guile', 'Knowledge', 'Reason', 'None',
              'As the transmitted spell', 'As the funded spell'}
books = sorted((ROOT / 'design/spellbooks').glob('*.md'))
for path in books:
    text = path.read_text()
    book_id = re.search(r'^ID: (.+)$', text, re.M)[1]
    discipline = re.search(r'^Discipline: (.+)$', text, re.M)[1]
    rows = [[v.strip() for v in line.strip('|').split('|')]
            for line in text.splitlines() if re.match(r'^\| (?:\d|A\d)', line)]
    blocks = re.split(r'^### ', text, flags=re.M)[1:]
    assert len(rows) == len(blocks) == 11, path
    assert [r[0] for r in rows] == [*map(str, range(1, 9)), 'A1', 'A2', 'A3'], path
    for row, block in zip(rows, blocks):
        fields = dict(re.findall(r'^\*\*([^*]+):\*\* (.+)$', block, re.M))
        required = {'ID', 'Page', 'Action', 'SP', 'Attribute', 'Target / range', 'Duration'}
        assert required <= fields.keys(), (path, row[0], required-fields.keys())
        sid = fields['ID']
        assert sid == f"spell:{book_id}:{row[0].lower()}" and sid not in seen, sid
        seen.add(sid)
        assert (row[0], row[1], row[2]) == (fields['Page'], block.splitlines()[0], fields['SP']), sid
        assert row[3] == ('I' if row[0] in ['1','2'] else 'II' if row[0] in ['3','4'] else 'III' if row[0] in ['5','6'] else 'IV'), sid
        assert fields['SP'].isdigit() and int(fields['SP']) >= 0, sid
        assert fields['Attribute'] in attributes, (sid, fields['Attribute'])
        action = fields['Action'].split(' · ')[0]
        assert action in {'Main Action', 'Maneuver', 'Reaction', 'Ritual'}, sid
        actions[action] += 1
        if action == 'Reaction':
            assert re.search(r' · (when|before|after) ', fields['Action']), sid
        if action == 'Ritual':
            assert re.search(r' · \d+ (minute|hour|day)', fields['Action']), sid
        effect = block.split('\n\n', 2)[2].strip()
        assert len(effect) > 40, sid
        if row[0] == '1':
            assert fields['SP'] == '0', sid
            if action == 'Main Action' and ('damage' in effect.lower() or 'attack' in effect.lower()):
                cantrips[discipline].append(sid)
for discipline in ['Elements','Life','Mentalism','Divination','Invocation','Force','Wards','Spellcraft']:
    assert cantrips[discipline], f'{discipline}: missing attack cantrip'
assert len(books) == 29 and len(seen) == 319
print(f'{len(books)} books; {len(seen)} unique spells; matching pages, sections and SP; explicit actions and reaction triggers.')
print(dict(actions))
