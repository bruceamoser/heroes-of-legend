#!/usr/bin/env python3
"""Verify independent signature choices and canonical card/index agreement."""
import json
import re
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
data = json.loads((ROOT / 'design/signature-development.json').read_text())
assert data['schemaVersion'] == 2, 'Independent signatures require schema 2'
assert data['choiceLevels'] == [1, 3, 7]
records = data['signatures']
assert len(records) == 90
assert len({r['id'] for r in records}) == 90
counts = Counter((r['classId'], r['level']) for r in records)
assert len(counts) == 30 and all(n == 3 for n in counts.values())
for record in records:
    sid = record['id']
    assert not {'foundationId', 'upgradeFrom', 'includes', 'conditionalIncludes', 'components'} & record.keys(), sid
    card = (ROOT / 'design/cards' / (sid + '.md')).read_text()
    body = card.split('## Rules\n', 1)[1].split('\n---', 1)[0].strip()
    assert body == record['rulesMarkdown'].strip(), sid + ': index differs from card'
    assert not re.search(r'^### ', body, re.M), sid + ': bundled procedure heading'
    for label in ['Action', 'Attribute', 'Target / range / shape', 'Duration']:
        assert f'**{label}:**' in body, sid + ': missing ' + label
    gate = re.search(r'\*\*Requirements to learn:\*\* (.+)', card).group(1)
    assert gate == f"Class {record['classId'].removeprefix('class-').title()}; minimum level {record['level']}", sid + ': unexpected prerequisite'
print('Signature audit passed: 90 independent choices; card/index text matches.')
