"""Read-only authoring checks; not a simulation or a verdict on enjoyable play."""
from pathlib import Path
import re
from index import field
R=Path(__file__).resolve().parent
ONE_DP={'another-tongue','message-by-heart','catch-that','a-party-piece','quick-exit','look-over-here'}
errors=[];ids={};files=list(R.rglob('*.md'));cards={}
for p in files:
 s=p.read_text()
 if p.parent.name in ('cards','equipment','recipes','disciplines','classes','ancestries','origins'):
  if s.count('## Rules\n')!=1:errors.append(f'{p.name}: expected one Rules section')
  else:
   introduction=s.split('## Rules\n')[0].split('\n\n',1)[1].strip()
   if not introduction or not introduction.startswith('*') or introduction.startswith('**'):errors.append(f'{p.name}: missing narrative before Rules')
 for target in re.findall(r'\]\(([^)]+)\)',s):
  if '://' in target or target.startswith('#'):continue
  if not (p.parent/target.split('#')[0]).resolve().exists():errors.append(f'{p.relative_to(R)}: missing {target}')
 if p.parent.name=='cards':
  cards[p.resolve()]=s
  for k in ['ID','Type','Tier / minimum level','DP','Requirements to learn','Action','Attribute','Target / range / shape','Duration','Limits','Equipment / acquisition']:
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
  expected_price='1' if id in ONE_DP else str({'1':2,'3':4,'7':8}.get(tier,''))
  if tier in ('1','3','7') and field(s,'DP')!=expected_price:errors.append(f'{p.name}: tier price')
  if id in ONE_DP and (tier!='1' or req!='None' or field(s,'Type') in ('Universal','Signature') or not field(s,'Limits').startswith('Purchase once')):errors.append(f'{p.name}: invalid one-DP exception')
  if not field(s,'Attribute').startswith('None') and not all('**'+x+':**' in s for x in ('Weak','Standard','Strong')):
   # Some early signature/utility prototypes print their exact 1/2/3 resolution in prose.
   if not re.search(r'\b\d+/\d+/\d+\b|Weak:',s):errors.append(f'{p.name}: roll outcomes not explicit')
for id in ONE_DP-set(ids):errors.append(f'Missing approved one-DP card: {id}')
for p in (R/'origins').glob('*.md'):
 s=p.read_text()
 opts=re.findall(r'- (?:\*\*)?([A-Za-z ]+) 1(?:\*\*)? and \[[^\]]+\]\(([^)]+)\)',s)
 if len(opts)!=2:errors.append(f'{p.name}: expected two paired choices')
 for d,target in opts:
  cp=(p.parent/target).resolve();cs=cards.get(cp,'')
  if field(cs,'Tier / minimum level')!='1':errors.append(f'{p.name}: non-Novice grant {target}')
  if field(cs,'Requirements to learn') not in (d.strip()+' 1','None'):errors.append(f'{p.name}: unsatisfied grant {target}')
for p in (R/'paths').glob('*.md'):
 targets=re.findall(r'\]\(\.\./cards/([^)]*)\)',p.read_text())
 if len(targets)!=3:errors.append(f'{p.name}: expected three path anchors')
 elif [field(cards.get((R/'cards'/x).resolve(),''),'Tier / minimum level') for x in targets]!=['1','3','7']:errors.append(f'{p.name}: path tier order')
for p in (R/'classes').glob('*.md'):
 if len(re.findall(r'\.\./cards/signature-',p.read_text()))!=9:errors.append(f'{p.name}: signature choices')
for a in ['human','elf','dwarf','halfling']:
 if len(list((R/'ancestries').glob('trait-'+a+'-*.md')))!=5:errors.append(a+': trait choices')
for e in errors:print(e)
assert not errors,f'{len(errors)} errors'
print(f'{len(files)} Markdown files; {len(ids)} cards; narrative/Rules separation, links, fields, discipline names, tier prices, origin grants and path tiers pass.')
