"""Present authored creature rules once; retain unique limits and source values."""
import re

UNIVERSAL = {'Basic Melee', 'Defend', 'Opportunity Attack'}
WORLD_FIELDS = {'Healing', 'Against offensive healing', 'Senses', 'Signs', 'Purpose',
                'Tactics and retreat', 'Counterplay and conversation',
                'Encounter and conversation', 'Habitat', 'Loot'}

def sections(text):
    return {m[1]: m[2].strip() for m in re.finditer(
        r'^### ([^\n]+)\n(.*?)(?=^### |\Z)', text, re.M | re.S)}

def parse_card(text):
    play = text.split('## Design notes', 1)[0]
    pre, rest = play.split('## Actions', 1)
    actions, detail_text = rest.split('## Details', 1)
    details = sections(detail_text)
    general = details.pop('General details')
    fields = []
    traits = []
    summon = None
    for para in re.split(r'\n\s*\n', general):
        m = re.match(r'\*\*([^*]+):\*\*\s*(.*)', para, re.S)
        if not m:
            raise ValueError('Unclassified creature detail: ' + para)
        label, value = m.groups()
        if label in UNIVERSAL:
            continue
        if label == 'Summoning':
            if value != 'Ineligible.':
                sm = re.fullmatch(r'(\w+) ([137]) — \[player reference\]\(([^)]+)\)\.', value)
                if not sm:
                    raise ValueError('Unknown summon eligibility: ' + value)
                summon = sm.groups()
        elif label in WORLD_FIELDS:
            fields.append((label, value))
        elif label in details:
            details[label] += '\n\n' + value
        else:
            traits.append((label, value))
    tables = []
    for match in re.finditer(r'^\| (Main Actions|Maneuvers|Reactions) \|.*?(?=\n\s*\n|\Z)', actions, re.M | re.S):
        kind = match[1]
        rows = []
        for line in match[0].splitlines()[2:]:
            if not line.startswith('|'):
                continue
            cells = [c.strip() for c in line.strip('|').split('|')]
            title = cells[0]
            if title in UNIVERSAL:
                continue
            detail = details.get(title, '')
            if kind == 'Main Actions':
                damage = re.search(r'\*\*Damage type:\*\* ([^\n]+)', detail)
                if damage:
                    dtype = damage[1].rstrip('.').capitalize()
                    detail = re.sub(r'\s*\*\*Player defense:\*\* [^.]+\.', '', detail)
                    detail = re.sub(r'\s*\*\*Damage type:\*\* [^\n]+', '', detail)
                    # Every repeated outcome must already exist verbatim in its table.
                    def omit_outcome(m):
                        value = m[2].strip().rstrip('.')
                        if value.casefold() not in cells[2].casefold():
                            raise ValueError(f'Outcome absent from table: {title}: {value}')
                        return ''
                    detail = re.sub(r'\*\*(Weak|Standard|Strong) defense:\*\* (.*?)(?=\s*\*\*|\n|\Z)', omit_outcome, detail)
                elif title == 'Battle Mending':
                    dtype = 'Life'
                    harmful = re.search(r'Against a healing-harmed target instead, use Fortitude defense: Weak takes (\d+), Standard (\d+), Strong (\d+) Life damage\. Same cost; no healing riders\.', detail)
                    if not harmful:
                        raise ValueError('Unknown harmful healing format')
                    cells[2] = '/'.join(harmful.groups())
                    detail = detail[:harmful.start()] + 'May instead harm a healing-harmed target for the table’s damage; same cost, no healing riders.'
                else:
                    raise ValueError('Missing attack damage type: ' + title)
                rows.append([title, cells[1], dtype, cells[2]])
            else:
                # The first rules sentence is the table effect; prose and remaining
                # restrictions stay below. Do not repeat a summary of that sentence.
                paras = re.split(r'\n\s*\n', detail) if detail else []
                for i, para in enumerate(paras):
                    if para.startswith('*') and not para.startswith('**'):
                        continue
                    first = re.match(r'(.*?\.)(?:\s+|$)(.*)', para, re.S)
                    if first:
                        cells[1] = first[1]
                        paras[i] = first[2]
                    else:
                        cells[1] = para
                        paras[i] = ''
                    break
                detail = '\n\n'.join(p for p in paras if p.strip())
                rows.append(cells)
            if detail.strip():
                details[title] = detail.strip()
            else:
                details.pop(title, None)
        if rows:
            tables.append((kind, rows))
    pre = '\n'.join(pre.splitlines()[1:]).strip()
    description, stats = pre.split('**Attributes:**', 1)
    stats = '**Attributes:**' + stats
    stats = re.sub(r'(\*\*(?:Evasion|Threat):\*\*) None', r'\1 0', stats)
    left, defenses = stats.split('**Weaknesses:**', 1)
    return dict(description=description.strip(), stats=left.strip(),
                defenses='**Weaknesses:** ' + defenses.strip(), tables=tables,
                details=details, traits=traits, fields=fields, summon=summon)


def validate_universal_reference(paths, guide):
    """Keep the shared Basic Melee reference faithful to every authored profile."""
    exceptions = {}
    default = None
    for names, damage in re.findall(r'^\| ([^|]+) \| (\d+/\d+/\d+) \|$', guide, re.M):
        if names == 'All other creatures in this bestiary':
            default = damage
        else:
            for name in names.split('; '):
                exceptions[name] = damage
    actual_names = set()
    for path in paths:
        source = path.read_text()
        name = source.splitlines()[0][2:].rsplit(' (CV', 1)[0]
        actual_names.add(name)
        damage = re.search(r'^\| Basic Melee \| Agility \| ([^|]+)', source, re.M)
        if not damage or damage[1].strip() != exceptions.get(name, default):
            raise ValueError('Shared Basic Melee reference differs from source: ' + name)
    if set(exceptions) - actual_names:
        raise ValueError('Unknown creature in shared Basic Melee reference')
