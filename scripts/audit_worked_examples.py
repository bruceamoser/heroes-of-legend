#!/usr/bin/env python3
"""Check hand-authored level-one examples directly against canonical Markdown."""
import argparse,json,re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
PROVISIONS=('food-bundle','water-flask','lighting-bundle','lesser-healing-bottle')
EXAMPLE_TRAINING_GEAR={
 'arms:bladework:': ('ordinary-melee-weapon',),
 'armor:harness:1': ('ordinary-light-armor',),
 'guard:shieldwork:': ('ordinary-shield',),
 'marksmanship:precision:': ('ordinary-ranged-weapon','ammunition-bundle'),
 'craft:repairs:': ('craft-tools',),
 'subterfuge:locks:': ('lock-tools',),
}
def slug(s):return re.sub(r'[^a-z0-9]+','-',s.lower()).strip('-')
def catalog(d):
 out={}
 for f in (d/'disciplines').glob('*.md'):
  for section in re.split(r'^## ',f.read_text(),flags=re.M)[1:]:
   path=section.splitlines()[0];prev=None
   for i,m in enumerate(re.finditer(r'^### ([^\n]+)\nDP: (\d+) \| Level: (\d+)\n(.*?)(?=\n### |\Z)',section,re.M|re.S),1):
    name,price,level,effect=m.groups();ident=f'{f.stem}:{slug(path)}:{i}';out[ident]=dict(name=name,cost=int(price),level=int(level),previous=prev,discipline=f.stem,effect=effect.strip(),source=f'disciplines/{f.name}');prev=ident
 for f in (d/'spellbooks').glob('*.md'):
  s=f.read_text();disc=slug(re.search(r'^Discipline: (.+)',s,re.M)[1]);name=re.search(r'^List: (.+)',s,re.M)[1]
  for i in range(4):
   spells=[m[1] for m in re.findall(r'^\| (\w+) \| (.+?) \| (\d+) \| (I{1,3}|IV) \|$',s,re.M) if m[3]==['I','II','III','IV'][i]]
   out[f'{f.stem}:{i}']=dict(name=name+' '+['I','II','III','IV'][i],cost=[1,2,2,3][i],level=3 if i==3 else 1,previous=f'{f.stem}:{i-1}' if i else None,discipline=disc,effect='Learn '+', '.join(spells)+'.',source=f'spellbooks/{f.name}')
 return out

def verify(book=ROOT,check_markdown=True):
 d=Path(book)/'design';entries=catalog(d);party=json.loads((d/'characters/examples.json').read_text())['party'];checks=[];results=[]
 def need(ok,msg):
  if not ok:raise ValueError(msg)
  checks.append(msg)
 need(len(party)==6,'six authored examples')
 for p in party:
  q=p['draft'];who=p['id'];a=q['attributes'];need(len(a)==6 and sum(a.values())==3 and all(-2<=v<=2 for v in a.values()),who+': attribute allocation')
  cls=(d/'classes'/f"{q['classId'][6:]}.md").read_text();ancslug={'ancestry-dwarf':'hill-dwarf','ancestry-elf':'wood-elf'}.get(q['ancestryId'],q['ancestryId'][9:]);anc=(d/'ancestries'/f'{ancslug}.md').read_text()
  for att in re.search(r'Minimum 0 in ([^.]+)',cls)[1].split(', '):need(a[att.lower()]>=0,who+': class minimum '+att)
  need(len(q['traitIds'])==2 and len(set(q['traitIds']))==2,who+': two traits')
  for t in q['traitIds']:need(f'({t}.md)' in anc,who+': ancestry trait '+t)
  ds=[];coins=40+int(re.search(r'Starting coin contribution:\*\* \+(\d+)',anc)[1])+int(re.search(r'Starting coin contribution:\*\* \+(\d+)',cls)[1])
  for key in ['culture','background']:
   origin=(d/'origins'/f"{q[key]['id'][7:]}.md").read_text();choices=re.search(r'Discipline choices:\*\* (.+)\.',origin)[1].split(', ');ds.append(slug(choices[q[key]['pair']]));coins+=int(re.search(r'Starting coin contribution:\*\* \+(\d+)',origin)[1])
  allowed=[slug(v) for v in re.search(r'Choose one of ([^.]+)',cls)[1].split(', ')];need(len(q['classDisciplines'])==1 and q['classDisciplines'][0] in allowed,who+': class discipline');ds+=q['classDisciplines'];need(len(set(ds))==3,who+': three distinct disciplines')
  sig=q['signatureId'][8:];need(f'({"../cards/"+sig+".md"})' in cls.split('## Level 1 choices')[1].split('## Level 3 choices')[0],who+': signature')
  pool=8+sum(a[k] for k in ['guile','knowledge','reason'])+int('trait-human-far-walker' in q['traitIds']);left=pool;owned=set();ledger=[]
  need(not q['purchases']['0'],who+': one creation pool')
  for purchase in q['purchases']['1']:
   ident=purchase['id'];need(ident in entries,who+': known purchase '+ident);e=entries[ident];need(ident not in owned and e['discipline'] in ds and e['level']<=1 and (not e['previous'] or e['previous'] in owned),who+': legal purchase '+ident);left-=e['cost'];need(left>=0,who+': affordable '+ident);owned.add(ident);ledger.append((ident,left))
  hp=10+int(re.search(r'HP contribution \+(\d+)',anc)[1])+int(re.search(r'HP contribution:\*\* \+(\d+)',cls)[1])+a['fortitude']+2*int('trait-dwarf-deep-constitution' in q['traitIds'])
  mental=re.search(r'2 × max\(0, (\w+)\)',cls)[1].lower();sp=int(re.search(r'Starting SP contribution:\*\* \+(\d+)',anc)[1])+2+2*max(0,a[mental])
  for path in ['soul-capacity','mind-capacity']:
   step=max([int(i.rsplit(':',1)[1]) for i in owned if i.startswith('spellcraft:'+path+':')],default=0);sp+=[0,2,4,7][step]
  gear=[];spent=bulk=hands=0
  for provision in PROVISIONS:
   need(any(item['instanceId']=='shop-starter-'+provision and item['id']=='item-'+provision and item['quantity']==1 for item in q['shopping']),who+': starting '+provision)
  free={slug for prefix,items in EXAMPLE_TRAINING_GEAR.items() if any(key.startswith(prefix) for key in owned) for slug in items}
  free_items=[dict(id='item-'+name,instanceId='inventory-learned-'+name,quantity=1,hands=1) for name in sorted(free)]
  need(set(q['loadout'])=={item['instanceId'] for item in q['shopping']+free_items},who+': complete equipment loadout')
  for item in q['shopping']+free_items:
   source=(d/'equipment'/f"{item['id'][5:]}.md").read_text();price=0 if item in free_items else int(re.search(r'Market price:\*\* (\d+)',source)[1]);b=int(re.search(r'\*\*Bulk:\*\* (\d+)',source)[1]);n=item['quantity'];spent+=price*n;bulk+=b*n;load=q['loadout'][item['instanceId']];hands+=item['hands'] if load['held'] else 0;gear.append((item['id'],source.splitlines()[0][2:],price*n,b*n,load))
   if load['worn'] and 'armor' in item['id']:need('armor:harness:1' in owned,who+': armor training')
  need(spent<=coins and bulk<=10+3*a['brawn'] and hands<=2,who+': equipment budget and capacity')
  row=dict(id=who,hp=hp,sp=sp,pool=pool,remaining=left,disciplines=ds,coins=coins,spent=spent,bulk=bulk,capacity=10+3*a['brawn'],speed=int(re.search(r'base Speed (\d+)',anc)[1]),ledger=ledger,gear=gear)
  if check_markdown:
   md=(d/'characters'/f'{who}.md').read_text();need(f'HP {hp}/{hp}' in md and f'SP {sp}/{sp}' in md and f'**{pool} DP**' in md and f'**Spent {pool-left} DP; {left} DP remaining.**' in md,who+': printed totals');need('Level 0' not in md and 'each stage' not in md,who+': single process prose')
   for ident,balance in ledger:need(entries[ident]['name'] in md and f"| {entries[ident]['cost']} | {balance} |" in md,who+': printed ledger '+ident)
   need(f'**Spent {spent} coins; {coins-spent} coins remaining.** Inventory Bulk {bulk}/' in md,who+': printed equipment totals')
   for ident,name,price,size,load in gear:
    ready='Worn' if load['worn'] else 'Held' if load['held'] else 'Carried'
    need(f'| [{name}](../equipment/{ident[5:]}.md) | {price or "Free"} | {size} | {ready} |' in md,who+': printed gear '+name)
  results.append(row)
 return {'checks':len(checks),'characters':results}
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--book',type=Path,default=ROOT);p.add_argument('--json',action='store_true');args=p.parse_args();r=verify(args.book);print(json.dumps(r,indent=2) if args.json else f"PASS: {r['checks']} canonical worked-example checks across six heroes")
