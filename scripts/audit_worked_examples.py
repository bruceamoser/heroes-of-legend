#!/usr/bin/env python3
"""Independently verify authored creation ledgers against canonical learning sources."""
import argparse,json,re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def verify(book=ROOT):
 d=Path(book)/'design';checks=[]
 def require(ok,context):
  if not ok:raise ValueError(context)
  checks.append(context)
 entries={}
 for p in (d/'disciplines').glob('*.md'):
  for name,price,level in re.findall(r'^### (.+)\nDP: (\d+) \| Level: (\d+)',p.read_text(),re.M):
   step=next((i for i,r in enumerate([' I',' II',' III',' IV'],1) if name.endswith(r)),4)
   base=re.sub(r' (I|II|III|IV)$','',name)
   prev=base+' '+['I','II','III'][step-2] if step>1 else None
   entries[name]=(p.stem.title(),int(price),int(level),prev,p)
 for p in (d/'spellbooks').glob('*.md'):
  s=p.read_text();discipline=re.search(r'Discipline: (.*)',s)[1];name=re.search(r'List: (.*)',s)[1]
  for i,r in enumerate(['I','II','III','IV']):entries[name+' '+r]=(discipline,[1,2,2,3][i],3 if i==3 else 0,name+' '+['I','II','III'][i-1] if i else None,p)
 for ident in ['another-tongue','message-by-heart','catch-that','a-party-piece','quick-exit','look-over-here']:
  p=d/'cards'/f'{ident}.md';entries[p.read_text().splitlines()[0][2:]]=(None,1,0,None,p)
 characters=sorted(p for p in (d/'characters').glob('*.md') if p.name!='README.md')
 require(len(characters)==6,'all six examples present')
 for p in characters:
  s=p.read_text();context=p.name
  sig=re.search(r'Free signature: \[[^]]+\]\(../cards/([^)]+)\)',s)[1];card=(d/'cards'/sig).read_text()
  require(card.split('## Rules\n',1)[1].split('\n---',1)[0].strip() in s,context+': complete signature procedure')
  limit=re.search(r'\*\*Limits:\*\* (.*)',card)[1];require('**Signature limit:** '+limit in s,context+': signature limit')
  attrs=list(map(int,re.search(r'\| ([+-]\d) \| ([+-]\d) \| ([+-]\d) \| ([+-]\d) \| ([+-]\d) \| ([+-]\d) \|',s).groups()))
  require(sum(attrs)==3 and all(-2<=v<=2 for v in attrs),context+': attributes')
  base=10+sum(attrs[3:]);adaptable=int('trait-human-far-walker' in s);owned=set();access=set();duplicates=0
  stages=re.split(r'## Level [01] —[^\n]+\n',s)[1:];require(len(stages)==2,context+': separate stages')
  for origin,disc,ability,target in re.findall(r'^- \[[^]]+\]\(../origins/([^)]+)\): \*\*(\w+) access\*\* and \[([^]]+)\]\(../([^)]+)\)',stages[0],re.M):
   source=(d/'origins'/origin).read_text();require(f'**{disc} access** and [{ability}](../{target})' in source,context+': exact origin choice')
   duplicates+=int(disc in access)+int(ability in owned);access.add(disc);owned.add(ability)
  classfile=re.search(r'Choose \[[^]]+\]\(../classes/([^)]+)\)',s)[1];cls=(d/'classes'/classfile).read_text();allowed=re.search(r'choose two distinct disciplines from ([^.]+)',cls)[1].split(', ')
  for stage,section in enumerate(stages):
   if stage:
    ds=re.search(r'Gain \*\*(.+) access\*\*',section)[1].split(' and ')
    require(len(ds)==2 and len(set(ds))==2 and all(x in allowed for x in ds),context+': class grants')
    duplicates=sum(x in access for x in ds);access.update(ds)
   pool=base+adaptable+duplicates;printed=int(re.search(r'Pool: \*\*.*?= (\d+) DP',section)[1]);require(pool==printed,context+': pool including explicit Adaptable and duplicates')
   table=section.split('| Learning |',1)[1].split('\n\n',1)[0];remaining=pool;spent=0
   for name,target,price,left in re.findall(r'^\| \[([^]]+)\]\(../([^)]+)\) \|[^|]+\| (\d+) \| (\d+) \|$',table,re.M):
    price=int(price);left=int(left)
    if name.endswith(' access'):
     disc=name[:-7];require(price==1 and disc not in access,context+': access cost and uniqueness');access.add(disc)
    else:
     require(name in entries,context+': current learned name '+name)
     disc,expected,level,previous,source=entries[name]
     require(source==d/target and price==expected and level<=stage,context+': entry price, gate and source '+name)
     require(name not in owned and (disc is None or disc in access) and (previous is None or previous in owned),context+': prerequisites '+name);owned.add(name)
    spent+=price;remaining-=price;require(remaining==left and left>=0,context+': running balance')
   closing=re.search(r'\*\*Spent (\d+); (\d+) DP expires',section);require(tuple(map(int,closing.groups()))==(spent,remaining),context+': stage close')
  checklist=s.split('## Learned abilities and spellbook pages')[1].split('## Equipment')[0]
  listed=re.findall(r'^- \[([^]]+)\]',checklist,re.M);require(set(listed)==owned and len(listed)==len(owned),context+': learned checklist')
  sp=6+sum([2,2,3][['I','II','III'].index(a.split()[-1])] for a in owned if a.startswith(('Soul Capacity ','Mind Capacity ')))
  require(f'SP: **{sp}/{sp}**' in s,context+': capacity total')
  purse=int(re.search(r'\(base \+ ancestry \+ culture \+ background \+ class\) = \*\*(\d+)',s)[1]);coins=purse;bulk=0
  for target,price,size,left in re.findall(r'^\| \[[^]]+\]\(../([^)]+)\) \| (\d+) \| (\d+) \| (\d+) \|$',s,re.M):
   item=(d/target).read_text();expected=5 if target=='market.md' else int(re.search(r'\*\*Market price:\*\* (\d+)',item)[1]);require(int(price)==expected,context+': market price '+target);coins-=int(price);bulk+=int(size);require(coins==int(left) and coins>=0,context+': coin balance')
  require(f'Bulk {bulk}/{10+3*attrs[0]}' in s and f'coins remaining {coins}' in s,context+': inventory totals')
 return {'result':'pass','checks':len(checks),'characters':len(characters),'scope':'signatures, attributes, origins, sequential prerequisites, class grants, independent DP balances, capacity, market prices and inventory'}
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--book',type=Path,default=ROOT);a=p.parse_args();print(json.dumps(verify(a.book),indent=2))
