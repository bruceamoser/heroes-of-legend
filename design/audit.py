"""Read-only authoring checks; not a simulation or a verdict on enjoyable play."""
from pathlib import Path
import re,json,subprocess,sys
from index import field

R=Path(__file__).resolve().parent
ONE_DP={'another-tongue','message-by-heart','catch-that','a-party-piece','quick-exit','look-over-here'}
errors=[];ids={};files=list(R.rglob('*.md'));cards={}
redirects=json.loads((R/'migration/learning-redirects.json').read_text())
for p in files:
 s=p.read_text()
 retired=p.parent.name=='cards' and p.stem in redirects
 if retired:
  target=R/redirects[p.stem]['target']
  if not target.is_file() or '## Replaced learning reference' not in s or field(s,'ID')!=p.stem:errors.append(f'{p.name}: invalid migration redirect')
 if not retired and p.parent.name in ('cards','equipment','recipes','classes','ancestries','origins'):
  if s.count('## Rules\n')!=1:errors.append(f'{p.name}: expected one Rules section')
  else:
   introduction=s.split('## Rules\n')[0].split('\n\n',1)[1].strip()
   if not introduction or not introduction.startswith('*') or introduction.startswith('**'):errors.append(f'{p.name}: missing narrative before Rules')
 for target in re.findall(r'\]\(([^)]+)\)',s):
  if '://' in target or target.startswith('#'):continue
  if not (p.parent/target.split('#')[0]).resolve().exists():errors.append(f'{p.relative_to(R)}: missing {target}')
 if p.parent.name=='cards' and not retired:
  cards[p.resolve()]=s
  for k in ['ID','Type','Tier / minimum level','DP','Requirements to learn','Action','Attribute','Target / range / shape']:
   if not field(s,k):errors.append(f'{p.name}: missing {k}')
  req=field(s,'Requirements to learn')
  if field(s,'Type')!='Signature' and req!='None':
   ranks=re.findall(r'([A-Za-z]+) ([123])',req)
   if not ranks:errors.append(f'{p.name}: unparsed discipline requirement')
   for discipline,rank in ranks:
    if not (R/'disciplines'/(discipline.lower()+'.md')).exists():errors.append(f'{p.name}: unknown discipline {discipline}')
   if len({d for d,r in ranks})!=len(ranks):errors.append(f'{p.name}: duplicate discipline requirement')
  id=field(s,'ID')
  if id in ids:errors.append(f'duplicate ID {id}')
  ids[id]=p.name
  tier=field(s,'Tier / minimum level')
  approved_universal_prices={'the-strong-arm':'3','the-last-word':'3','the-impossible-escape':'3','a-name-worth-knowing':'3','the-web-of-whispers':'3','the-lucky-trinket':'3','the-mountain-walks':'6','touched-by-the-divine':'6'}
  expected_price=approved_universal_prices.get(id, '1' if id in ONE_DP else str({'1':2,'3':4,'7':8}.get(tier,'')))
  if field(s,'Type')=='Signature':expected_price='Class choice'
  if tier in ('1','3','7') and field(s,'DP')!=expected_price:errors.append(f'{p.name}: tier price')
  if id in ONE_DP and (tier!='1' or req!='None' or field(s,'Type') in ('Universal','Signature') or not field(s,'Limits').startswith('Purchase once')):errors.append(f'{p.name}: invalid one-DP exception')
  if not field(s,'Attribute').startswith('None') and '(Basic Melee attack)' not in field(s,'Attribute') and re.search(r'Make (?:a|one|an) (?!Basic\b)[^.]*\b(?:roll|attack)\b',s,re.I) and not all('**'+x+':**' in s for x in ('Weak','Standard','Strong')):
   # Some early signature/utility prototypes print their exact 1/2/3 resolution in prose.
   if not re.search(r'\b\d+/\d+/\d+\b|Weak:|\bWeak\b.*\bStandard\b.*\bStrong\b',s,re.S):errors.append(f'{p.name}: roll outcomes not explicit')
for id in ONE_DP-set(ids):errors.append(f'Missing approved one-DP card: {id}')
for p in (R/'origins').glob('*.md'):
 s=p.read_text()
 opts=re.findall(r'- \*\*(\w+) access\*\* and \[([^]]+)\]\(([^)]+)\)',s)
 if len(opts)!=2:errors.append(f'{p.name}: expected two paired access/entry choices')
 for d,ability,target in opts:
  cp=(p.parent/target).resolve()
  if not cp.is_file():continue
  cs=cp.read_text()
  if cp.parent.name=='disciplines':valid=cs.startswith('# '+d+'\n') and ('### '+ability+'\nDP: 1 | Level: 0') in cs
  else:valid=('Discipline: '+d+'\n') in cs and ('List: '+ability.removesuffix(' I')+'\n') in cs
  if not valid:errors.append(f'{p.name}: invalid first-entry grant {ability}')
for p in (R/'paths').glob('*.md'):
 if 'replaced by sequential learning' not in p.read_text():errors.append(f'{p.name}: unmigrated suggested path')
subprocess.run([sys.executable,str(R/'player-book/nonmagical/build.py'),'--data-only'],check=True)
for p in (R/'classes').glob('*.md'):
 if len(re.findall(r'\.\./cards/signature-',p.read_text()))!=9:errors.append(f'{p.name}: signature choices')
ancestry_sources=re.findall(r'\]\((ancestries/[^)]+\.md)\)',(R/'ancestry.md').read_text())
if len(ancestry_sources)!=10 or len(set(ancestry_sources))!=10:errors.append('Expected ten distinct ancestry entries')
trait_ids=[]
for source in ancestry_sources:
 p=R/source
 choices=re.findall(r'\]\((trait-[^)]+\.md)\)',p.read_text())
 if len(choices)!=5 or len(set(choices))!=5:errors.append(p.name+': expected five distinct trait choices')
 for choice in choices:
  cp=p.parent/choice
  if not cp.is_file():continue
  trait_id=field(cp.read_text(),'ID');trait_ids.append(trait_id)
  if trait_id!=cp.stem:errors.append(cp.name+': trait ID differs from stable filename')
if len(trait_ids)!=50 or len(set(trait_ids))!=50:errors.append('Expected fifty unique linked ancestry trait IDs')
for e in errors:print(e)
assert not errors,f'{len(errors)} errors'
print(f'{len(files)} Markdown files; {len(ids)} cards; active record fields, stable redirects, links, origin grants and sequential learning graph pass.')
