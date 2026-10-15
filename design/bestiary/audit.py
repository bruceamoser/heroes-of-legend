"""Read-only card, perspective and CV checks. Not a combat simulation."""
from pathlib import Path
from functools import lru_cache
import itertools,math,re
R=Path(__file__).resolve().parent
errors=[]
def need(ok,msg):
 if not ok:errors.append(msg)
def field(s,k):
 m=re.search(r'\*\*'+re.escape(k)+r':\*\*\s*([^\n·]+)',s)
 return m[1].strip() if m else ''
def mod(s):
 m=re.match(r'(\d+) (Bane|Boon)',s)
 return int(m[1])*(1 if m[2]=='Bane' else -1) if m else 0
@lru_cache(None)
def probabilities(n):
 counts=[0,0,0]
 for dice in itertools.product(range(1,7),repeat=3+abs(n)):
  ds=sorted(dice);kept=ds[:3] if n>=0 else ds[-3:];t=sum(kept)+1
  ix=0 if t<=8 else 1 if t<=14 else 2
  if kept==[1,1,1]:ix=0
  if kept==[6,6,6]:ix=2
  counts[ix]+=1
 return [v/6**(3+abs(n)) for v in counts]
ids=set();cs={};elig={};used=set();attacks_count=0
for p in sorted((R/'creatures').glob('*.md')):
 s=p.read_text();pre=p.name+': ';play=s.split('## Design notes')[0]
 need('## Design notes — not needed during play' in s,pre+'missing terminal design section')
 need('Adventure band' not in s and '**Procedure:**' not in play,pre+'obsolete card fields')
 need('**Reference damage:**' not in play and '**Utility factor:**' not in play,pre+'worksheet in play section')
 for k in ['Attributes','HP','Speed','Size','Evasion','Threat','Stability','Armor DR','Resistances','Weaknesses','Immunities','Healing','Senses','ID','CV','Reference damage','Reference type','Expected targets','Utility factor','Regeneration per turn']:
  need(bool(field(s,k)),pre+'missing '+k)
 ident=field(s,'ID');need(ident not in ids,pre+'duplicate ID');ids.add(ident)
 try:
  hp=int(field(s,'HP'));cv=int(field(s,'CV'));st=int(re.match(r'\d+',field(s,'Stability'))[0]);ev=mod(field(s,'Evasion'))
  need(s.splitlines()[0].endswith('(CV '+str(cv)+')'),pre+'title CV differs from worksheet')
  card_attrs=re.findall(r'(Brawn|Fortitude|Agility|Guile|Knowledge|Reason) ([+-]\d+)',field(play,'Attributes'))
  need(len(dict(card_attrs))==6 and all(-2<=int(v)<=2 for _,v in card_attrs),pre+'invalid attributes')
  need(play.index('**Attributes:**')<play.index('**HP:**'),pre+'attributes must precede HP')
  need(0<=st<=3,pre+'Stability exceeds cap')
  need(st==0 or '**Heavy Frame — Passive:** Stability '+str(st) in play,pre+'Stability lacks explicit source')
  drfield=field(s,'Resistances');dr=int(re.match(r'\d+',field(s,'Armor DR'))[0])
  res=re.search(r'Physical \((\d+)\)',drfield)
  need((int(res[1]) if res else 0)==dr,pre+'Armor DR disagrees with Physical resistance')
  need(0<=dr<=3,pre+'Armor DR exceeds cap')
  extra=any(k.lower()!='physical' for k in re.findall(r'([A-Za-z]+) \(\d+\)',drfield))
  need(('*' in field(s,'Armor DR'))==extra,pre+'Armor DR asterisk mismatch')
  need(all(int(n)<=3 for n in re.findall(r'\d+',drfield)),pre+'resistance exceeds cap')
  reference=list(map(int,field(s,'Reference damage').split('/')));typ=field(s,'Reference type')
  u=float(field(s,'Utility factor'));regen=int(field(s,'Regeneration per turn'));targets=int(field(s,'Expected targets'))
  blocks=[]
  for title in ('| Main Actions | Defense | Damage |','| Maneuvers | Effect |','| Reactions | Effect |','## Details'):
   need(title in play,pre+'missing '+title)
  rows={};defenses={}
  main_table=play.split('| Main Actions | Defense | Damage |',1)[1].split('\n\n',1)[0]
  for line in main_table.splitlines():
   cells=[x.strip() for x in line.split('|')[1:-1]]
   if len(cells)==3 and cells[0]!='---':rows[cells[0]]=cells[2];defenses[cells[0]]=cells[1]
  need('Basic Melee' in rows and bool(re.fullmatch(r'\d+/\d+/\d+',rows.get('Basic Melee',''))),pre+'missing or invalid Basic Melee')
  need(defenses.get('Basic Melee')=='Agility',pre+'Basic Melee defense must be Agility')
  need(all(name=='Basic Melee' or '### '+name+'\n' in play for name in rows),pre+'Main Action missing details')
  need(play.index('## Actions')<play.index('## Details'),pre+'action tables must precede details')
  for b in re.split(r'^### ',play,flags=re.M)[1:]:
   if '**Player defense:**' not in b:continue
   name=b.splitlines()[0]
   need(name in rows,pre+'attack missing from table '+name)
   defense=field(b,'Player defense').split('.')[0]
   need(defenses.get(name)==defense,pre+'table defense mismatch '+name)
   need(defense in {'Brawn','Fortitude','Agility','Guile','Knowledge','Reason'},pre+'invalid defense attribute')
   outcome_cells=[v.strip() for v in rows.get(name,'').split('/')]
   damage=[v.split(' + ',1)[0] for v in outcome_cells]
   need(len(damage)==3 and all(v.isdigit() for v in damage),pre+'invalid damage row '+name)
   damage_type=field(b,'Damage type').rstrip('.')
   vals=[]
   for t,d,cell in zip(('Weak','Standard','Strong'),damage,outcome_cells):
    m=re.search(r'\*\*'+t+r' defense:\*\* ([^\n]*?)(?= \*\*|\n|$)',b)
    expected_effect=m[1].rstrip('.') if m else ''
    printed_effect=cell.split(' + ',1)[1] if ' + ' in cell else ''
    need(printed_effect==expected_effect,pre+'table effect mismatch '+name+' '+t)
    base='No damage.' if damage_type=='None' else d+' '+damage_type+' damage.'
    vals.append(base+(' '+m[1] if m else ''))
   blocks.append((name,b,vals))
  need(bool(blocks),pre+'no attacks')
  primary=blocks[0];th=mod(field(play,'Threat'))
  actual=[int(re.match(r'(\d+)',v)[1]) for v in reversed(primary[2])]
  need(actual==reference,pre+'reference differs from printed primary damage')
  inc=sum(pr*max(1,d-dr) for pr,d in zip(probabilities(ev),(3,5,7)))
  out=sum(pr*max(1,d-(1 if typ=='physical' else 0)) for pr,d in zip(reversed(probabilities(th)),reference))*targets
  calc=max(1,math.ceil(3*math.sqrt((hp+2*regen)/inc*out)*u));need(cv==calc,pre+f'CV {cv} != {calc}')
  cs[p.stem]=cv;attacks_count+=len(blocks)
  ref=re.search(r'\*\*Summoning:\*\* ([^\n]+)',s);need(bool(ref),pre+'missing summon permission')
  eligible=ref and not ref[1].startswith('Ineligible')
  if eligible:
   m=re.match(r'(Animal|Fey|Spirit|Elemental|Undead|Construct) ([137])',ref[1]);need(bool(m),pre+'invalid category/tier')
   if m:elig.setdefault((m[1],int(m[2])),[]).append(p.stem)
   sp=R/'summons'/(p.stem+'.md');need(sp.exists(),pre+'missing player reference');ps=sp.read_text()
   need(ps.splitlines()[0]==s.splitlines()[0],pre+'summon title differs')
   for phrase in ['No activity','no Reactions','**Attributes:**','**Defense modifier:**']:
    need(phrase.lower() in ps.lower(),pre+'player reference missing '+phrase)
   need(mod(field(ps,'Defense modifier'))==-ev,pre+'summon defense modifier wrong')
   attrs=re.findall(r'(Brawn|Fortitude|Agility|Guile|Knowledge|Reason) ([+-]\d+)',field(ps,'Attributes'))
   need(dict(attrs)==dict(card_attrs),pre+'summon attributes differ')
   need(len(dict(attrs))==6 and all(-2<=int(v)<=2 for _,v in attrs),pre+'invalid summon attributes')
  else:ps=s.split('## Design notes')[1]
  # Every attacker table must be the precise reverse of its corresponding DA outcomes.
  for name,b,vals in blocks:
   row=next((l for l in ps.splitlines() if l.startswith('| '+name+' |')),'')
   need(bool(row),pre+'missing attacker reference '+name)
   if row:
    cells=[x.strip() for x in row.split('|')[1:-1]]
    normalize=lambda v:re.sub(r'[.;]','',v).strip()
    need(list(map(normalize,cells[3:]))==list(map(normalize,reversed(vals))),pre+'perspective mismatch '+name)
    need(mod(cells[2])==-th,pre+'attack modifier mismatch '+name)
 except (ValueError,IndexError,TypeError,AttributeError) as ex:errors.append(pre+'unparseable data '+str(ex))
 used.update(re.findall(r'\.\./\.\./monster-abilities/([a-z-]+)\.md',s))
for cat in ['Animal','Fey','Spirit','Elemental','Undead','Construct']:
 for tier in (1,3,7):need(bool(elig.get((cat,tier))),f'no {cat} {tier} selection')
abilities=list((R.parent/'monster-abilities').glob('*.md'))
for p in abilities:
 if p.name=='README.md':continue
 s=p.read_text();ident=field(s,'ID');need(ident not in ids,p.name+': duplicate ID');ids.add(ident)
 need('## Rules' in s and field(s,'Action'),p.name+': incomplete ability')
 need(p.stem in used,p.name+': unused ability')
for p in list(R.rglob('*.md'))+abilities:
 for link in re.findall(r'\]\(([^)]+)\)',p.read_text()):
  if '://' not in link and not link.startswith('#'):need((p.parent/link.split('#')[0]).resolve().exists(),str(p)+': broken '+link)
scenes=[('The false toll',{'road-bandit':3,'bandit-bow':1}),('The opened barrow',{'bone-sentry':3,'bone-archer':2}),('Tracks around the camp',{'wolf':4}),('The bridge has an owner',{'bridge-troll':1,'road-bandit':1,'bandit-bow':1}),('The watch will not stand down',{'shield-soldier':2,'grave-cultist':1})]
txt=(R/'encounters.md').read_text()
for name,roster in scenes:
 row=next((l for l in txt.splitlines() if l.startswith('| '+name+' |')),'')
 expected=sum(cs.get(k,0)*v for k,v in roster.items());need(bool(row) and row.split('|')[3].strip()==str(expected),name+': wrong total')
need(len(list((R/'summons').glob('*.md')))==sum(map(len,elig.values())),'orphan summon reference')
for err in errors:print(err)
assert not errors,f'{len(errors)} bestiary issues'
print(f'{len(cs)} creatures; {attacks_count} attack choices; {len(abilities)-1} monster abilities; {sum(map(len,elig.values()))} player references.')
print('Defense/attacker outcome parity, modifiers, Stability grants, fields, links, summon coverage and CV arithmetic pass. No balance claim.')
