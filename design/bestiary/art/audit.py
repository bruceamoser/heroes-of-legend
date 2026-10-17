#!/usr/bin/env python3
"""Verify the shared book/VTT portrait catalog against authored creatures."""
from pathlib import Path
from collections import Counter
import hashlib
import json
import re
from PIL import Image

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]


def audit():
    entries = json.loads((HERE / 'manifest.json').read_text())['entries']
    prompts = json.loads((HERE / 'prompts.json').read_text())
    creatures = {}
    for source in (HERE.parent / 'creatures').glob('*.md'):
        text = source.read_text()
        creature_id = re.search(r'^\*\*ID:\*\* (\S+)', text, re.M).group(1)
        creatures[creature_id] = str(source.relative_to(ROOT))
    errors = []
    ids = [e['id'] for e in entries]
    if set(ids) != set(creatures) or len(ids) != len(set(ids)):
        errors.append('Creature ID coverage differs from the authored catalog')
    for field in ('illustration', 'sha256'):
        values = [e.get(field) for e in entries]
        if len(set(values)) != len(values):
            errors.append('Missing or repeated ' + field)
    for entry in entries:
        label = entry['id']
        if entry['source'] != creatures.get(label):
            errors.append(label + ': source mismatch')
        path = ROOT / entry['illustration']
        if entry['status'] not in ('existing', 'generated') or not path.is_file():
            errors.append(label + ': portrait not ready')
            continue
        if hashlib.sha256(path.read_bytes()).hexdigest() != entry['sha256']:
            errors.append(label + ': image hash mismatch')
        with Image.open(path) as im:
            if (im.width, im.height) != (entry['width'], entry['height']):
                errors.append(label + ': dimensions mismatch')
            if im.mode != 'RGBA' or im.getextrema()[3][0] == 255 or not entry['alpha']:
                errors.append(label + ': no transparent background')
        if entry['status'] == 'generated' and entry.get('prompt_id') not in prompts:
            errors.append(label + ': generation prompt missing')
    return {'creatures': len(creatures), 'portraits': len(entries),
            'provenance': dict(Counter(e['status'] for e in entries)), 'errors': errors}


if __name__ == '__main__':
    report = audit()
    print(json.dumps(report, indent=2))
    raise SystemExit(bool(report['errors']))
