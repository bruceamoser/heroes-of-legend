#!/usr/bin/env python3
"""Validate creation/advancement directly against the working catalog."""
import itertools,json
from copy import deepcopy
from pathlib import Path
from catalog import CAT,ROOT,ATTR,CARDS,CLASSES
OUT=ROOT/'results';OUT.mkdir(exist_ok=True)
COSTS={'home':[1,2,4],'adj':[2,4,8],'foreign':[3,6,12],'opp':[4,8,16]}
CONFIG=[
 ('Protector','Dwarf',[1,2,0,0,0,0],'Citadel',0,'Soldier',0,['Protection','Armor']),
 ('Blade','Human',[2,0,1,0,0,0],'Frontier',1,'Soldier',0,['Melee','Stealth']),
 ('Arcanist','Elf',[-2,0,1,1,2,1],'Academy',0,'Healer',0,['Fire','Summon']),
 ('Shepherd','Halfling',[0,1,0,1,0,1],'Crossroads',1,'Healer',0,['Life','Protection']),
 ('Intellect','Human',[-1,0,0,0,2,2],'Academy',1,'Apprentice',0,['Lore','Craft']),
 ('Leader','Human',[1,1,0,1,0,0],'Citadel',1,'Soldier',0,['Tactics','Protection']),
 ('Unbalanced','Dwarf',[2,2,0,-1,0,0],'Citadel',0,'Soldier',0,['Melee','Armor']),
 ('Shadow','Halfling',[0,0,2,1,0,0],'Crossroads',0,'Scout',1,['Stealth','Melee']),
 ('Odd','Human',[0,0,0,1,1,1],'Academy',0,'Apprentice',0,['Life','Melee'])]
ITEM_BULK={x:1 for x in ['melee','ranged','ammo','shield','medium','heavy','tools','locks','rope','supply','food','light','potion']}
def category(cl,d):
 for key in ('home','adj','opp'):
  if d in CLASSES[cl][key]:return key
 return 'foreign'
def initial(config):
 cl,anc,attrs,cu,ci,bg,bi,discs=config
 assert len(attrs)==6 and sum(attrs)==3 and all(-2<=x<=2 for x in attrs),'attribute array'
 assert all(attrs[ATTR.index(a)]>=0 for a in CLASSES[cl]['req']),'class minimum'
 assert len(set(discs))==2 and all(d in CLASSES[cl]['choices'] for d in discs),'class disciplines'
 return dict(class_name=cl,ancestry=anc,attrs=dict(zip(ATTR,attrs)),culture=[cu,ci],background=[bg,bi],class_discs=discs,traits=[t[0] for t in CAT['ancestries'][anc]['traits'][:2]],ranks={},cards=[],gear=[],recipes=[],ledger=[],pool=0,level=0,hp_purchases=[],expired=[],grit=2)
def grant_item(b,item):
 if item not in b['gear']:b['gear'].append(item)
def grant_disc(b,d):
 if d in b['ranks']:b['pool']+=1; b['ledger'].append(dict(level=b['level'],kind='duplicate',id=d,cost=-1,balance=b['pool']))
 else:b['ranks'][d]=1;b['ledger'].append(dict(level=b['level'],kind='grant discipline',id=d,cost=0,balance=b['pool']))
def eligible(b,id):
 c=CARDS[id]
 return (not c.get('requires_crafting') or any(CARDS[x].get('recipes') for x in b['cards'])) and (b['level']>=c['level'] or b['level']==0 and c['level']==1) and all(b['ranks'].get(d,0)>=r for d,r in c['req'].items()) and (not c.get('class_only') or b['class_name']==c['class_only'] and b['level']>=c['level'])
def get_card(b,id,free=False):
 c=CARDS[id];assert eligible(b,id),'card prerequisite'
 if id in b['cards'] and not c.get('repeat'):
  assert free,'duplicate purchase'
  b['pool']+=1;b['ledger'].append(dict(level=b['level'],kind='duplicate',id=id,cost=-1,balance=b['pool']));return
 if id=='hp':
  assert b['level']>=1 and b['level'] not in b['hp_purchases'],'HP purchase limit'
  b['hp_purchases'].append(b['level'])
 if id=='recipes':
  options=[r for card in b['cards'] for r in CARDS[card].get('recipes',[]) if r not in b['recipes']]
  options=list(dict.fromkeys(options));assert len(options)>=2,'two eligible unlearned recipes required'
 cost=0 if free else c['cost'];assert b['pool']>=cost,'DP budget';b['pool']-=cost
 b['cards'].append(id)
 for item in c['gear']:grant_item(b,item)
 if id=='craft':b['recipes']+= [r for r in ['arrows','torches'] if r not in b['recipes']]
 if id=='recipes':b['recipes']+=options[:2]
 if id=='grit':b['grit']+=1
 b['ledger'].append(dict(level=b['level'],kind='grant card' if free else 'buy card',id=id,cost=cost,balance=b['pool']))
def rank(b,d):
 assert b['level']>=1,'no level-0 discipline purchase'
 old=b['ranks'].get(d,0);assert old<3,'rank cap'
 cost=COSTS[category(b['class_name'],d)][old];assert b['pool']>=cost,'DP budget'
 b['pool']-=cost;b['ranks'][d]=old+1;b['ledger'].append(dict(level=b['level'],kind='buy discipline',id=d,cost=cost,rank=old+1,balance=b['pool']))
def finalize(b):
 a=CAT['ancestries'][b['ancestry']];cl=CLASSES[b['class_name']]
 hp=12+a['hp']+cl['hp']+b['attrs']['Fortitude']+int('Hardy' in b['traits'])+len(b['hp_purchases'])
 bulk=sum(ITEM_BULK[x] for x in b['gear']);capacity=10+3*b['attrs']['Brawn'];enc=max(0,bulk-capacity)
 speed=max(0,a['speed']+int('Long Stride' in b['traits'])+b['attrs']['Agility']-enc)
 res=3 if 'heavy' in b['cards'] else 2 if 'medium' in b['cards'] else 0
 return dict(**deepcopy(b),hp=hp,bulk=bulk,capacity=capacity,encumbrance=enc,speed=speed,resistance=res,bank=b['pool'])
def build(config):
 b=initial(config);mental=sum(b['attrs'][a] for a in ['Knowledge','Reason','Guile'])
 utility=['observe','climb','social','swim','navigate','animal','craft','derive','identify','potions','physical','mental']
 for stage in (0,1):
  b['level']=stage;b['pool']=10+mental
  b['ledger'].append(dict(level=stage,kind='award',id='creation',cost=-(10+mental),balance=b['pool']))
  if stage==0:
   for group,(name,option) in [(CAT['cultures'],b['culture']),(CAT['backgrounds'],b['background'])]:
    d,id=group[name][option];grant_disc(b,d);get_card(b,id,True)
   wanted=utility
  else:
   for d in b['class_discs']:grant_disc(b,d)
   get_card(b,f'sig_{b["class_name"].lower()}_1_0',True)
   priorities={
    'Protector':['medium','shield','strike','observe'],
    'Blade':['medium','precise','stealth','observe'],
    'Arcanist':['medium','identify','hands','observe'],
    'Shepherd':['medium','strike','shield','physical'],
    'Intellect':['medium','fire','derive','potions'],
    'Leader':['medium','expose','strike','observe'],
    'Unbalanced':['medium','strike','shield','grapple'],
    'Shadow':['medium','precise','shot','observe'],
    'Odd':['medium','heal','strike','observe']}
   wanted=priorities[b['class_name']]+utility
  for id in wanted:
   if id in b['cards'] or CARDS[id]['level']>max(1,stage):continue
   if stage and not eligible(b,id):
    for d,r in CARDS[id]['req'].items():
     if b['ranks'].get(d,0)<r:
      price=COSTS[category(b['class_name'],d)][b['ranks'].get(d,0)]
      if b['pool']>=price+CARDS[id]['cost']:rank(b,d)
   if eligible(b,id) and b['pool']>=CARDS[id]['cost']:get_card(b,id)
  b['expired'].append(b['pool']);b['ledger'].append(dict(level=stage,kind='expire',id='unused',cost=b['pool'],balance=0));b['pool']=0
 snapshots=[finalize(b)]
 for lvl in range(2,8):
  b['level']=lvl;b['pool']+=8+lvl;b['ledger'].append(dict(level=lvl,kind='award',id='level',cost=-(8+lvl),balance=b['pool']))
  if lvl in (3,7):b['grit']+=1;get_card(b,f'sig_{b["class_name"].lower()}_{lvl}_0',True)
  # Choose one primary route, buy its rank before card; reserve/bank when no target.
  primary='Fire' if b['class_name'] in ('Arcanist','Odd') else 'Archery' if b['class_name']=='Shadow' else 'Melee'
  desired=3 if lvl>=7 else 2 if lvl>=3 else 1
  while b['ranks'].get(primary,0)<desired:
   price=COSTS[category(b['class_name'],primary)][b['ranks'].get(primary,0)]
   if b['pool']<price:break
   rank(b,primary)
  attack={'Fire':('fire','adept_fire','master_fire'),'Archery':('shot','adept_shot','master_shot'),'Melee':('strike','adept_strike','master_strike')}[primary][desired-1]
  wanted=([('adept_heal' if lvl<7 else 'master_heal')] if b['class_name']=='Shepherd' and lvl>=3 else [])+[attack,'medium','heal','craft','derive','physical','mental','identify','potions','grit']
  for id in wanted:
   if id in b['cards'] or CARDS[id]['level']>lvl:continue
   for d,r in CARDS[id]['req'].items():
    while b['ranks'].get(d,0)<r:
     price=COSTS[category(b['class_name'],d)][b['ranks'].get(d,0)]
     if b['pool']<price+CARDS[id]['cost']:break
     rank(b,d)
   if eligible(b,id) and b['pool']>=CARDS[id]['cost']:get_card(b,id)
  if lvl in (3,7):snapshots.append(finalize(b))
 return snapshots

def validate():
 checks=0
 def reject(fn):
  nonlocal checks
  try:fn()
  except AssertionError:checks+=1
  else:raise AssertionError('invalid operation accepted')
 b=initial(CONFIG[0]);b['pool']=100
 reject(lambda:rank(b,'Fire'))
 reject(lambda:get_card(b,'fire'))
 reject(lambda:get_card(b,'master_strike'))
 b['level']=1;b['ranks']['Melee']=1;get_card(b,'strike');reject(lambda:get_card(b,'strike'))
 reject(lambda:get_card(b,'sig_blade_1_0'))
 b['pool']=0;reject(lambda:get_card(b,'observe'))
 b['pool']=20;get_card(b,'hp');reject(lambda:get_card(b,'hp'))
 b['ranks']['Melee']=3;reject(lambda:rank(b,'Melee'))
 bad=list(CONFIG[1]);bad[2]=[-1,2,0,0,1,1];reject(lambda:initial(bad))
 # Duplicate grants, item dedup, no extra discipline rank, and stage accounting.
 b=initial(CONFIG[0]);b['pool']=10;grant_disc(b,'Melee');grant_disc(b,'Melee');assert b['pool']==11 and b['ranks']['Melee']==1
 get_card(b,'strike',True);get_card(b,'strike',True);assert b['pool']==12
 get_card(b,'precise',True);assert b['gear'].count('melee')==1
 assert len(CARDS)==len(set(CARDS))
 for id,c in CARDS.items():
  assert c['level'] in (1,3,7) and c['cost']=={1:2,3:4,7:8}[c['level']]
  assert all(d in CAT['disciplines'] and r in (1,2,3) for d,r in c['req'].items())
  assert all(x in ITEM_BULK for x in c['gear'])
 for group in (CAT['cultures'],CAT['backgrounds']):
  for opts in group.values():
   for d,id in opts:assert all(k==d and r==1 for k,r in CARDS[id]['req'].items())
 return checks

def main():
 checks=validate();builds=[b for c in CONFIG for b in build(c)]
 (OUT/'builds.json').write_text(json.dumps(builds,indent=2)+'\n')
 rows=['# Character creation and advancement runs','', 'Nine actual working-catalog routes, each at levels 1, 3, 7. All catalog entries','are provisional; these validate purchase legality, not optimal play or balance.','The snapshots retain full ordered ledgers in `builds.json`. Traits are first two','listed for each ancestry. No automatic travel supplies or potions are granted.','', '| Class | Level | HP | Speed | Bulk / capacity | Cards | Bank | Creation expiry L0/L1 |','|---|---:|---:|---:|---|---:|---:|---|']
 for b in builds:rows.append(f'| {b["class_name"]} | {b["level"]} | {b["hp"]} | {b["speed"]} | {b["bulk"]}/{b["capacity"]} | {len(b["cards"])} | {b["bank"]} | {b["expired"]} |')
 rows+=['','## Interpretation','','These are broad exploratory builds, not prescribed class builds. Later utility','purchases intentionally explore cross-class access. Banked DP is retained rather','than inventing filler purchases. Summon/control cards are not automatically','purchased because the first combat experiment excludes those layers.','']
 arrays=[a for a in itertools.product(range(-2,3),repeat=6) if sum(a)==3]
 rows+=['| Class | Legal attribute arrays |','|---|---:|']
 for cl,c in CLASSES.items():rows.append(f'| {cl} | {sum(all(a[ATTR.index(k)]>=0 for k in c["req"]) for a in arrays)} |')
 rows+=['','Attribute-array counts are combinatorial availability, not predictions of player','preferences. The mental DP adjustment is not changed by class selection.','']
 (OUT/'creation.md').write_text('\n'.join(rows))
 print(json.dumps(dict(builds=len(builds),invalid_operations_rejected=checks,legal_attribute_arrays=len(arrays))))
if __name__=='__main__':main()
