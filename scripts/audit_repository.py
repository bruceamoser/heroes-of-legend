#!/usr/bin/env python3
"""Check the active source tree, without reading archived editions from Git."""
from pathlib import Path
import re, sys
ROOT = Path(__file__).resolve().parents[1]
RETIRED = ('quarto-book', 'source-doc', 'assets', 'docs', 'engine', 'playtest',
           '.agent', '.roomodes', '.github/issues', 'design/layout-test', 'design/reviews')
errors = [f'Retired tree restored: {p}' for p in RETIRED if (ROOT / p).exists()]
files = [ROOT / 'README.md', ROOT / 'AGENTS.md']
for folder in ('design', '.github', '.roo', 'release'):
    files.extend(p for p in (ROOT / folder).rglob('*.md')
                 if not {'generated', 'output'} & set(p.parts))
for p in files:
    for target in re.findall(r'\[[^\]]*\]\(([^)]+)\)', p.read_text()):
        target = target.split('#', 1)[0]
        if not target or '://' in target or target.startswith('mailto:'):
            continue
        if not (p.parent / target).exists():
            errors.append(f'{p.relative_to(ROOT)}: missing {target}')
    if p.name == 'SKILL.md' or p in [ROOT/'AGENTS.md', ROOT/'.github/copilot-instructions.md']:
        for pattern in (r'3d6\s*\+[^\n]*\+\s*Skill Bonus', r'Novice\s*→\s*Adept\s*→\s*Master chains',
                        r'canonical[^\n]*quarto-book'):
            if re.search(pattern, p.read_text(), re.I):
                errors.append(f'{p.relative_to(ROOT)}: obsolete instruction {pattern}')
if errors:
    print('\n'.join(errors)); sys.exit(1)
print(f'{len(files)} current Markdown files: links and source-authority checks pass; retired trees absent.')
