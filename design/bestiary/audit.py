"""Read-only bestiary checks and exact reference-dice enumeration; no simulation."""
from pathlib import Path
from functools import lru_cache
import itertools, math, re
R=Path(__file__).resolve().parent
errors=[]
def field(s,k):
 m=re.search(r'\*\*'+re.escape(k)+r':\*\*\s*([^\n·]+)',s)
 return m[1].strip() if m else ''
def need(test,msg):
 if not test: errors.append(msg)
@lru_cache(None)
def probabilities(attribute,banes):
 counts=[0,0,0]
 for dice in itertools.product(range(1,7),repeat=3+banes):
  kept=sorted(dice)[:3]; total=sum(kept)+attribute
  ix=0 if total<=8 else 1 if total<=14 else 2
  if kept==[1,1,1]:ix=0
  if kept==[6,6,6]:ix=2
  counts[ix]+=1
 return [v/(6**(3+banes)) for v in counts]
cs={}; ids=set();elig={};used=set()
for p in sorted((R/'creatures').glob('*.md')):
 s=p.read_text(); prefix=p.name+': '
 keys=['ID','Status','Category','Role','Adventure band','Habitat','HP','CV','Footprint','Stability','Speed','Attributes','Resistance','Weakness','Condition immunity','Evasion','Threat','Senses','Communication','Healing','Offensive-healing defense','Signs','Purpose','Tactics and retreat','Counterplay and conversation','Rewards','Eligibility','Reference damage','Reference type','Expected targets','Utility factor','Regeneration per turn']
 for key in keys:need(bool(field(s,key)),prefix+'missing '+key)
 need(s.startswith('# ') and '\n\n*' in s.split('## Rules')[0],prefix+'missing narrative')
 ident=field(s,'ID');need(ident not in ids,prefix+'duplicate ID');ids.add(ident)
 try:
  hp=int(field(s,'HP'));cv=int(field(s,'CV'));st=int(field(s,'Stability'))
  ev=int(field(s,'Evasion'));th=int(field(s,'Threat'));u=float(field(s,'Utility factor'))
  regen=int(field(s,'Regeneration per turn'));targets=int(field(s,'Expected targets'))
  damage=[int(x) for x in field(s,'Reference damage').split('/')]
  need(hp>0 and cv>0 and 0<=st<=3 and 0<=ev<=3 and 0<=th<=3,prefix+'invalid numeric stat')
  need(len(damage)==3 and damage==sorted(damage),prefix+'invalid damage profile')
  need(field(s,'Reference type') in {'physical','fire','cold','lightning','Life','radiant','mental'},prefix+'unknown damage type')
  need(1<=u<=2 and targets in (1,2),prefix+'unsupported CV input')
  for n in re.findall(r'\b(\d+)\b',field(s,'Resistance')):need(int(n)<=3,prefix+'resistance exceeds cap')
  attrs=re.findall(r'(Brawn|Fortitude|Agility|Guile|Knowledge|Reason) ([+-]\d+)',field(s,'Attributes'))
  need(len(attrs)==6 and len(dict(attrs))==6,prefix+'six attributes required')
  need(all(-2<=int(v)<=2 for _,v in attrs),prefix+'attribute outside selected draft range')
  need(bool(re.fullmatch(r'[123]x[123]',field(s,'Footprint'))),prefix+'invalid footprint')
  band=int(field(s,'Adventure band'));need(band in (1,3,7),prefix+'invalid band')
  resistance=re.search(r'Physical (\d+)',field(s,'Resistance'));res=int(resistance[1]) if resistance else 0
  incoming=sum(p*max(1,d-res) for p,d in zip(probabilities(1,ev),(3,5,7)))
  armor=1 if field(s,'Reference type')=='physical' else 0
  outgoing=sum(p*max(1,d-armor) for p,d in zip(reversed(probabilities(1,th)),damage))*targets
  expected=max(1,math.ceil(3*math.sqrt((hp+2*regen)/incoming*outgoing)*u))
  need(cv==expected,prefix+f'CV {cv} != computed {expected}')
  first=s.split('### Main — ',1)[1].split('\n### ')[0]
  primary=[int(n) for n in re.findall(r'\*\*(?:Weak|Standard|Strong):\*\* (\d+) ',first)]
  need(primary==damage,prefix+'CV reference differs from primary attack')
  cs[p.stem]=cv
 except (ValueError,ZeroDivisionError):errors.append(prefix+'unparseable numeric field')
 for block in re.split(r'^### Main — ',s,flags=re.M)[1:]:
  block=block.split('\n### ')[0]
  need(field(block,'Attack attribute') in {'Brawn','Fortitude','Agility','Guile','Knowledge','Reason'},prefix+'missing attack attribute')
  need(field(block,'Target defense') in {'Brawn','Fortitude','Agility','Guile','Knowledge','Reason'},prefix+'missing target defense')
  for tier in ['Weak','Standard','Strong']:need('**'+tier+':**' in block,prefix+'attack missing '+tier)
  need('**Target:**' in block and '**Spell:**' in block,prefix+'missing targeting or spell declaration')
 for ability in re.findall(r'\.\./\.\./monster-abilities/([a-z-]+)\.md',s):used.add(ability)
 e=field(s,'Eligibility')
 if e!='Ineligible':
  m=re.fullmatch(r'(Animal|Fey|Spirit|Elemental|Undead|Construct) ([137])',e)
  need(bool(m),prefix+'bad summon eligibility')
  if m:elig.setdefault((m[1],int(m[2])),[]).append(p.stem)
  for phrase in ['No Reactions','no activity','**Carrying:**']:
   need(phrase.lower() in s.lower(),prefix+'missing summon restriction '+phrase)
for cat in ['Animal','Fey','Spirit','Elemental','Undead','Construct']:
 for tier in (1,3,7):need(bool(elig.get((cat,tier))),f'no {cat} tier {tier} selection')
abilities=list((R.parent/'monster-abilities').glob('*.md'))
for p in abilities:
 if p.name=='README.md':continue
 s=p.read_text();need('## Rules' in s and '**Action:**' in s and '**ID:**' in s,p.name+': incomplete ability')
 ident=field(s,'ID');need(ident not in ids,p.name+': duplicate ID');ids.add(ident)
 need(p.stem in used,p.name+': no creature uses this ability')
for p in list(R.rglob('*.md'))+abilities:
 for link in re.findall(r'\]\(([^)]+)\)',p.read_text()):
  if '://' not in link and not link.startswith('#'):need((p.parent/link.split('#')[0]).resolve().exists(),f'{p.name}: broken link {link}')
# Published encounter sums: check the actual arithmetic in the authoring document.
scenes=[('The false toll',{'road-bandit':3,'bandit-bow':1}),('The opened barrow',{'bone-sentry':3,'bone-archer':2}),('Tracks around the camp',{'wolf':4}),('The bridge has an owner',{'bridge-troll':1,'road-bandit':1,'bandit-bow':1}),('The watch will not stand down',{'shield-soldier':2,'grave-cultist':1})]
text=(R/'encounters.md').read_text()
for name,roster in scenes:
 row=next((x for x in text.splitlines() if x.startswith('| '+name+' |')),'')
 expected=sum(cs.get(k,0)*n for k,n in roster.items())
 need(bool(row) and row.split('|')[3].strip()==str(expected),name+': encounter total differs')
roster=(R/'roster.md').read_text();selection=(R/'summon-choices.md').read_text()
for slug in cs:need(f'(creatures/{slug}.md)' in roster,slug+': missing roster entry')
for values in elig.values():
 for slug in values:need(f'(creatures/{slug}.md)' in selection,slug+': missing summon index')
for err in errors:print(err)
assert not errors,f'{len(errors)} bestiary issues'
print(f'{len(cs)} creatures; {len(abilities)-1} separate monster abilities; {sum(map(len,elig.values()))} summon entries across all 18 category/tier pairs.')
print('Fields, attributes, resistance cap, attack procedures, links, summon restrictions, CV enumeration and encounter sums pass. Balance is not certified.')
