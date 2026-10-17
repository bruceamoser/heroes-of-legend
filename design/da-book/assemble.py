"""Assemble a reviewable Markdown manuscript; never rewrite authored game content."""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re

HERE = Path(__file__).resolve().parent
DESIGN = HERE.parent
OUT = HERE / 'output'
MANIFEST = HERE / 'source-manifest.json'
LINK = re.compile(r'\[([^\]]+)\]\(([^)]+)\)')


def read(source):
    return (DESIGN / source).read_text()


def title(source):
    return read(source).splitlines()[0].removeprefix('# ')


def field(text, name):
    match = re.search(r'\*\*' + re.escape(name) + r':\*\*\s*([^\n·]+)', text)
    if not match:
        raise ValueError(f'Missing field {name}')
    return match[1].strip()


def anchor(source):
    return re.sub(r'[^a-z0-9-]', '-', source.removesuffix('.md').lower()).strip('-')


def validate(manifest):
    creatures = [s for family in manifest['families'] for s in family['sources']]
    groups = [
        (creatures, 'bestiary/creatures', 192),
        (manifest['monster_abilities'], 'monster-abilities', 93),
        (manifest['summons'], 'bestiary/summons', 73),
    ]
    for sources, folder, count in groups:
        actual = {str(p.relative_to(DESIGN)) for p in (DESIGN / folder).glob('*.md') if p.name != 'README.md'}
        if len(sources) != count or len(set(sources)) != count or set(sources) != actual:
            raise ValueError(f'{folder}: missing, repeated or unexpected sources')
    sources = [s for group in manifest.get('shared_sections', {}).values() for s in group] + manifest['chapters'] + manifest['appendices'] + creatures + manifest['monster_abilities'] + manifest['summons'] + [manifest['conditions'], manifest['wounds']]
    if len(sources) != len(set(sources)):
        raise ValueError('A manuscript source appears more than once')
    for source in sources:
        path = (DESIGN / source).resolve()
        if not path.is_relative_to(DESIGN) or not path.is_file():
            raise ValueError(f'Invalid source: {source}')
    wound_rows = re.findall(r'^\| [1-6]{3} \|.*$', read(manifest['wounds']).split('## Physical\n', 1)[1], re.M)
    if len(wound_rows) != 280:
        raise ValueError('Expected all 280 wound results')
    return sources, creatures, wound_rows


def assemble():
    manifest = json.loads(MANIFEST.read_text())
    sources, creatures, wound_rows = validate(manifest)
    included = {(DESIGN / s).resolve(): s for s in sources}
    parts = ['# ' + manifest['title'], '*Manuscript draft for review. CV values and encounter budgets remain uncalibrated.*']
    parts.append('Edit the authored Markdown sources, not this generated reading copy. This is a prose and reference assembly, not a typeset book.')
    parts.append('## Contents\n\n' + '\n'.join(f'- [{title(s)}](#{anchor(s)})' for s in manifest['chapters'] + manifest['appendices']))
    parts.append('- [Creature indexes](#creature-indexes)\n- [Creature design ledger](#creature-design-ledger)')

    def rewrite_links(text, source):
        def replace(match):
            label, target = match.groups()
            if '://' in target or target.startswith('#'):
                return match[0]
            relative, _, fragment = target.partition('#')
            path = (DESIGN / source).parent.joinpath(relative).resolve()
            if path in included:
                return f'[{label}](#{anchor(included[path])})'
            dest = os.path.relpath(path, OUT)
            return f'[{label}]({dest}' + ('#' + fragment if fragment else '') + ')'
        return LINK.sub(replace, text)

    def append_source(source, text=None, heading_shift=0):
        text = read(source) if text is None else text
        if heading_shift:
            text = re.sub(r'^(#{1,6}) ', lambda m: '#' * min(6, len(m[1]) + heading_shift) + ' ', text, flags=re.M)
        parts.append(f'<a id="{anchor(source)}"></a>\n\n' + rewrite_links(text.strip(), source))

    def remove_editorial(text):
        # These are isolated metadata/navigation lines, never embedded mechanics.
        lines = [line for line in text.splitlines() if not line.startswith(('**Status:**', '**ID:**', '[Creature procedure]', '[DA creature card]'))]
        return '\n'.join(lines).strip()

    for source in manifest['chapters']:
        append_source(source)
        for supplement in manifest.get('shared_sections', {}).get(source, []):
            append_source(supplement, remove_editorial(read(supplement)), heading_shift=1)
        if source.endswith('/10-bestiary.md'):
            for family in manifest['families']:
                parts.append('## ' + family['name'])
                for creature in family['sources']:
                    full = read(creature)
                    if '## Design notes — not needed during play' not in full:
                        raise ValueError('Missing design-note boundary: ' + creature)
                    play = full.split('## Design notes', 1)[0]
                    append_source(creature, play, heading_shift=2)

    for source in manifest['appendices']:
        append_source(source)
        if source.endswith('appendix-b-monster-abilities.md'):
            ability_sources = sorted(manifest['monster_abilities'], key=lambda s: title(s).casefold())
            parts.append('| Ability | Action |\n|---|---|\n' + '\n'.join(f'| [{title(s)}](#{anchor(s)}) | {field(read(s), "Action")} |' for s in ability_sources))
            for ability in ability_sources:
                append_source(ability, remove_editorial(read(ability)), heading_shift=1)
        elif source.endswith('appendix-c-summoned-forms.md'):
            summon_sources = sorted(manifest['summons'], key=lambda s: (field(read(s), 'Eligibility'), title(s)))
            parts.append('| Summoned form | Eligibility |\n|---|---|\n' + '\n'.join(f'| [{title(s)}](#{anchor(s)}) | {field(read(s), "Eligibility")} |' for s in summon_sources))
            for summon in summon_sources:
                # Shared command explanation is in the appendix introduction and chapter 9.
                text = '\n'.join(line for line in read(summon).splitlines() if not line.startswith('Main command: Main + Maneuver;'))
                append_source(summon, remove_editorial(text), heading_shift=1)
        elif source.endswith('appendix-d-table-tools.md'):
            conditions = read(manifest['conditions'])
            table = conditions[conditions.index('| Condition |'):].split('\n\n', 1)[0]
            append_source(manifest['conditions'], '## Conditions at a glance\n\n' + table)
            wounds = '## Physical\n' + read(manifest['wounds']).split('## Physical\n', 1)[1]
            # Keep all tables and remedies intact; remove historical revision commentary.
            wounds = wounds.replace('Physical includes sonic and force injuries. Broad activity Banes replace the earlier limb-, Force-, and attribute-specific penalties.', 'Physical includes sonic and force injuries.')
            wounds = wounds.replace('Elemental 556 converts the earlier single-turn\nParalysis to **Paralyzed 1** under the shared decay rule.', '')
            wounds = wounds.replace('Frightened uses the creature or phenomenon responsible as its source and now decays\nnormally; it no longer has the earlier until-safely-away duration.', 'Frightened uses the creature or phenomenon responsible as its source and decays normally.')
            append_source(manifest['wounds'], '## Wound tables\n\n' + wounds, heading_shift=1)

    records = []
    for family in manifest['families']:
        for source in family['sources']:
            text = read(source)
            name = title(source)
            cv = int(re.search(r'\(CV (\d+)\)', name)[1])
            records.append((name, cv, family['name'], field(text, 'Habitat'), field(text, 'Role'), source))
    parts.append('<a id="creature-indexes"></a>\n\n# Creature Indexes\n\nCV remains a playtest estimate. Family, habitat and role labels grant no mechanical traits.')
    for label, key in [('Name', lambda r: r[0].casefold()), ('CV', lambda r: (r[1], r[0])), ('Family', lambda r: (r[2].casefold(), r[0])), ('Role', lambda r: (r[4].casefold(), r[0]))]:
        parts.append('## By ' + label + '\n\n| Creature | CV | Family | Habitat | Role |\n|---|---:|---|---|---|\n' + '\n'.join(f'| [{name.rsplit(" (CV", 1)[0]}](#{anchor(source)}) | {cv} | {family} | {habitat} | {role} |' for name, cv, family, habitat, role, source in sorted(records, key=key)))
    habitats = {}
    for record in records:
        for habitat in record[3].split(';'):
            habitats.setdefault(habitat.strip().casefold(), []).append(record)
    parts.append('## By Habitat\n\nA creature appears under every habitat listed on its card.')
    for habitat, members in sorted(habitats.items()):
        parts.append('### ' + habitat.capitalize() + '\n\n' + ', '.join(f'[{r[0]}](#{anchor(r[5])})' for r in sorted(members, key=lambda r: r[0].casefold())) + '.')
    parts.append('<a id="creature-design-ledger"></a>\n\n# Creature Design Ledger\n\nPreparation material, kept outside combat cards. These worksheets document current estimates, not balance certification. Creature-roll references are authoring aids; use the dedicated player profile for an eligible summon.')
    for source in sorted(creatures, key=lambda s: title(s).casefold()):
        notes = read(source).split('## Design notes — not needed during play', 1)[1]
        notes = '\n'.join(line for line in notes.splitlines() if not line.startswith('**Status:**'))
        parts.append('## ' + title(source) + '\n\n' + rewrite_links(notes.strip(), source))

    book = '\n\n'.join(parts) + '\n'
    # Every remedy row survives the assembly verbatim; the bound tables are not summarized.
    if any(book.count(row) < wound_rows.count(row) for row in set(wound_rows)):
        raise ValueError('Wound result lost during assembly')
    for source in sources:
        if book.count(f'id="{anchor(source)}"') != 1:
            raise ValueError('Missing or duplicate source anchor: ' + source)
    all_anchors = set(re.findall(r'<a id="([^"]+)"', book))
    for target in re.findall(r'\]\(#([^)]*)\)', book):
        if target not in all_anchors:
            raise ValueError('Unresolved manuscript anchor: ' + target)
    inventory = '# Manuscript source inventory\n\nGenerated reading inventory; edit the manifest or original source files.\n\n| Source | SHA-256 |\n|---|---|\n'
    hashes = {}
    for source in sources:
        digest = hashlib.sha256((DESIGN / source).read_bytes()).hexdigest()
        hashes[source] = digest
        inventory += f'| [{source}]({os.path.relpath(DESIGN / source, OUT)}) | {digest} |\n'
    hashes['da-book/source-manifest.json'] = hashlib.sha256(MANIFEST.read_bytes()).hexdigest()
    hashes['da-book/assemble.py'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    return {'manuscript.md': book, 'source-inventory.md': inventory, 'source-hashes.json': json.dumps(hashes, indent=2) + '\n'}, len(sources)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true', help='Verify generated files are current without rewriting them')
    args = parser.parse_args()
    outputs, count = assemble()
    if args.check:
        for name, text in outputs.items():
            if not (OUT / name).exists() or (OUT / name).read_text() != text:
                raise SystemExit('Stale or missing output: ' + name)
    else:
        OUT.mkdir(exist_ok=True)
        for name, text in outputs.items():
            (OUT / name).write_text(text)
    print(f'{count} sources; 192 creatures; 93 monster abilities; 73 summons; 280 wound results. ' + ('Assembly current.' if args.check else 'Markdown assembly written.'))


if __name__ == '__main__':
    main()
