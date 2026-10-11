#!/usr/bin/env python3
"""Bounded encounter experiments. No claim of a complete tactical engine."""
import argparse,csv,hashlib,itertools,json,math,random
from collections import Counter
from functools import lru_cache
from bisect import bisect
from pathlib import Path
from catalog import ROOT,CARDS
OUT=ROOT/'results'
@lru_cache(None)
def probabilities(attr=0,net=0):
 net=max(-3,min(3,net));n=3+abs(net);dist=Counter()
 for ds in itertools.combinations_with_replacement(range(1,7),n):
  multiplicity=math.factorial(n)
  for c in Counter(ds).values():multiplicity//=math.factorial(c)
  keep=ds[-3:] if net>=0 else ds[:3];crit=keep==(6,6,6);fumble=keep==(1,1,1);v=sum(keep)+attr
  tier=0 if fumble else 2 if crit else 0 if v<=8 else 1 if v<=14 else 2
  dist[(tier,crit,fumble)]+=multiplicity/6**n
 return tuple(sorted(dist.items()))
@lru_cache(None)
def sampler(attr,net):
 keys=[];c=[];v=0
 for k,p in probabilities(attr,net):keys.append(k);v+=p;c.append(v)
 c[-1]=1.;return keys,c
def roll(rng,attr=0,net=0):
 keys,c=sampler(attr,max(-3,min(3,net)));return keys[bisect(c,rng.random())]
def hurt_amount(packet,res):return max(1,sum(max(0,v-res.get(k,0)) for k,v in packet.items()))
def mean_damage(profile,attr=0,net=0,res=0,defense=False):return sum(p*max(1,profile[2-t if defense else t]-res) for (t,_,_),p in probabilities(attr,net))
def seed(name):return random.Random(int.from_bytes(hashlib.sha256(name.encode()).digest()[:8],'big'))
@lru_cache(None)
def fixture(level=1,composition='mixed'):
 builds=json.loads((OUT/'builds.json').read_text())
 names=['Protector','Blade','Arcanist','Shepherd'] if composition=='mixed' else ['Leader','Unbalanced','Shadow','Intellect']
 return [b for name in names for b in builds if b['level']==level and b['class_name']==name]
ATTACK_CACHE={}
def best_attack(b,enemy_res,profile='new',fire_res=0,ammo=True):
 key=(b['class_name'],b['level'],enemy_res,profile,fire_res,ammo)
 if key in ATTACK_CACHE:return ATTACK_CACHE[key]
 choices=[]
 for id in b['cards']:
  c=CARDS[id]
  if 'damage' not in c or id in ['hands','daze','fan'] or 'ammo' in c['gear'] and not ammo:continue
  d=c['damage'];kind='fire' if 'Magic' in c['types'] else 'physical';res=enemy_res if kind=='physical' else fire_res
  if profile=='old':d=[2,4,6] if c['level']==1 else d
  if profile=='flat':d=[4,4,6] if c['level']==1 else d
  if profile=='high':d=[5,6,8] if c['level']==1 else d
  attr=b['attrs'][c['attribute']];choices.append((mean_damage(d,attr,res=res),id,d,kind,attr))
 # All builds have an ordinary weapon; no assumed basic item grant.
 if 'melee' in b['gear']:choices.append((mean_damage([2,3,5],b['attrs']['Brawn'],res=enemy_res),'basic',[2,3,5],'physical',b['attrs']['Brawn']))
 assert choices,'no eligible attack'
 ATTACK_CACHE[key]=max(choices)
 return ATTACK_CACHE[key]
def new_party(builds,s):
 return [dict(build=b,hp=b['hp'],grit=b['grit'],wounds=0,death=0,stable=False,terminal=False,defend=False,shield=False,reaction=True,bottle=4 if s.get('potions') else 0,ammo=3 if 'ammo' in b['gear'] else 0,burning=0) for b in builds]
def battle(s,rng,party=None,trace=None):
 builds=fixture(s.get('level',1),s.get('composition','mixed'));pcs=party or new_party(builds,s)
 for p in pcs:p.update(defend=False,shield=False,reaction=True,burning=0)
 enemy=[dict(hp=s['ehp'],reaction=True) for _ in range(s['count'])]
 m=Counter();first=sum(rng.randint(1,6) for _ in range(3))>=12;defeat=0
 def terminal(p):
  if not p['terminal']:p.update(terminal=True,hp=0);m['terminal']+=1
 def wound(p):
  p['wounds']+=1;m['wounds']+=1
  if sum(rng.randint(1,6)==6 for _ in range(min(5,2+p['wounds'])))>=3:terminal(p)
 def hurt(p,n):
  if p['terminal']:return
  if p['hp']>0:
   p['hp']=max(0,p['hp']-n)
   if p['hp']==0:p.update(stable=False,death=0);wound(p)
  else:
   if p['stable']:p['stable']=False;wound(p)
   p['death']+=1
   if p['death']>=3:terminal(p)
 def heal(p,n):
  if p['terminal']:return
  old=p['hp'];p.update(hp=min(p['build']['hp'],old+n),death=0,stable=False);m['healed_hp']+=p['hp']-old
 def candidates(i):return [p for j,p in enumerate(pcs) if not p['terminal'] and p['hp']<=p['build']['hp']*s.get('threshold',.5) and (s.get('reach','all')=='all' or i==j)]
 def is_healer(i):return s['policy']=='all' and 'heal' in pcs[i]['build']['cards'] or s['policy']=='one' and i==3 and 'heal' in pcs[i]['build']['cards']
 def incoming(p,profile=None):
  profile=profile or s['damage']
  if p['reaction'] and 'shield' in p['build']['gear'] and p['hp']>0 and s.get('shields',True):p.update(reaction=False,shield=True)
  net=int(p['defend'])+int(p['shield'])-s.get('banes',0)-(3 if p['hp']==0 else 0)
  t,crit,fumble=roll(rng,p['build']['attrs'][s.get('defattr','Agility')],net)
  amt=hurt_amount({'physical':profile[2-t]},{'physical':p['build']['resistance']});hurt(p,amt);m['incoming_hp']+=amt
  return 2-t
 def provoke(i):
  if not s.get('oa'):return False
  # Contact is a controlled scenario assumption, not a simulated map.
  if s.get('contact','all')=='none':return False
  living=[e for e in enemy if e['hp']>0 and e['reaction']]
  if not living:return False
  e=living[0];e['reaction']=False;t=incoming(pcs[i],[2,3,5]);m['opportunities']+=1
  return pcs[i]['hp']==0 or s['oa']=='strong_interrupt' and t==2
 def pc_actions(i):
  p=pcs[i];b=p['build'];p.update(defend=False,shield=False,reaction=True)
  if p['hp']==0:
   if p['stable']:return
   if p['grit']:
    p['grit']-=1;m['grit']+=1;heal(p,b['hp'])
   else:
    t,c,f=roll(rng,b['attrs']['Fortitude'])
    if c:heal(p,1)
    elif t==2:p.update(stable=True,death=0)
    elif t==0:
     p['death']+=2 if f else 1
     if p['death']>=3:terminal(p)
    if p['hp']==0:return
  maneuver=True
  targets=candidates(i)
  if p['bottle'] and targets:
   possible=[q for q in targets if q is p or q['hp']==0 or q['reaction']]
   if possible:
    q=min(possible,key=lambda q:q['hp']/q['build']['hp'])
    if q is not p and q['hp']>0:q['reaction']=False
    heal(q,q['build']['hp']);m['potions']+=1;maneuver=False
    if rng.randint(1,p['bottle'])==1:p['bottle']=0
  targets=candidates(i)
  if is_healer(i) and targets:
   if provoke(i):m['interrupted']+=1
   else:
    q=min(targets,key=lambda q:q['hp']/q['build']['hp']);t,c,f=roll(rng,b['attrs']['Reason'])
    heal(q,math.ceil(q['build']['hp']/2) if t==0 else q['build']['hp']);m['heals']+=1
    if t==2:q['burning']=max(0,q['burning']-1)
  else:
   alive=[j for j,e in enumerate(enemy) if e['hp']>0]
   if alive:
    target=min(alive,key=lambda j:enemy[j]['hp'])
    _,id,profile,kind,attr=best_attack(b,s['eres'],s.get('profile','new'),s.get('fire_res',0),bool(p['ammo']))
    interrupted=kind=='fire' and provoke(i)
    if interrupted:m['interrupted']+=1
    else:
     t,c,f=roll(rng,attr,-s.get('enemy_defense',0));enemy[target]['hp']-=hurt_amount({kind:profile[t]},{'physical':s['eres'],'fire':s.get('fire_res',0)});m['attacks']+=1
     if id in CARDS and 'ammo' in CARDS[id]['gear']:
      if rng.randint(1,[0,4,6,8][p['ammo']])==1:p['ammo']-=1
      m['ammo_checks']+=1
  if p['hp']<=0:return
  if not any(e['hp']>0 for e in enemy) and s.get('reach','all')=='all':
   needy=[q for q in pcs if q['hp']==0 and not q['stable'] and not q['terminal']]
   # If the Main killed the final enemy it was already spent.
   if 'alive' in locals() and not alive:
    if needy:needy[0].update(stable=True,death=0);m['stabilize']+=1
  dying=[q for q in pcs if q['hp']==0 and not q['stable'] and not q['terminal']]
  if maneuver and dying and s.get('reach','all')=='all':dying[0].update(stable=True,death=0);maneuver=False;m['stabilize']+=1
  if maneuver and s.get('defend',True):p['defend']=True
 def pc_turn(i):
  pc_actions(i)
  p=pcs[i]
  if p['burning'] and not p['terminal']:
   hurt(p,p['burning']);m['burn_ticks']+=1
 def npc_turn(j):
  e=enemy[j];e['reaction']=True
  if j>=s['count']-s.get('enemy_healers',0):
   wounded=[q for q in enemy if 0<q['hp']<=s['ehp']*s.get('enemy_threshold',.5)]
   if wounded:
    q=min(wounded,key=lambda q:q['hp']);t,_,_=roll(rng,1)
    q['hp']=min(s['ehp'],q['hp']+(math.ceil(s['ehp']/2) if t==0 else s['ehp']));m['enemy_heals']+=1
    # Strong ends Burning 1, but no NPC burning source in these fixtures.
    return
  upright=[p for p in pcs if not p['terminal'] and p['hp']>0];alive=upright or [p for p in pcs if not p['terminal']]
  if not alive:return
  if s.get('target','focus')=='spread' or s.get('target')=='mixed' and rng.random()>=s.get('focus_chance',.5):p=rng.choice(alive)
  elif s.get('target')=='front':p=next((q for q in pcs[:2] if q in alive),rng.choice(alive))
  else:
   low=min(p['hp'] for p in alive);p=rng.choice([p for p in alive if p['hp']==low])
  for _ in range(s.get('actions',1)):
   t=incoming(p);m['enemy_attacks']+=1
   if s.get('burn') and t>=1 and p['hp']>0:p['burning']+=1 if t==1 else 2
   if p['terminal']:break
 for rnd in range(1,s.get('cap',40)+1):
  m['rounds']=rnd;pd=set();ed=set();side=first
  while True:
   if all(e['hp']<=0 for e in enemy):
    if not defeat:defeat=rnd
    # Routine ongoing-condition cleanup needs a conscious helper.
    if any(p['hp']>0 and not p['terminal'] for p in pcs) and s.get('reach','all')=='all':
     for p in pcs:p['burning']=0
    if not any(p['hp']==0 and not p['stable'] and not p['terminal'] for p in pcs):m['win']=int(any(not p['terminal'] for p in pcs));m['loss']=1-m['win'];break
   if all(p['terminal'] for p in pcs):m['loss']=1;break
   pa=[i for i,p in enumerate(pcs) if i not in pd and not p['terminal']];ea=[j for j,e in enumerate(enemy) if j not in ed and e['hp']>0]
   if not pa and not ea:break
   before=([p['hp'] for p in pcs],[e['hp'] for e in enemy],m.copy()) if trace is not None else None
   if side and pa or not ea:
    helpers=[i for i in pa if pcs[i]['hp']>0 and (is_healer(i) or pcs[i]['bottle']) and candidates(i)]
    i=helpers[0] if helpers else min(pa,key=lambda i:pcs[i]['hp']);pd.add(i);pc_turn(i);side=False;actor=f'PC {i} {pcs[i]["build"]["class_name"]}'
   else:
    ehelpers=[j for j in ea if j>=s['count']-s.get('enemy_healers',0) and any(0<e['hp']<=s['ehp']*s.get('enemy_threshold',.5) for e in enemy)]
    j=ehelpers[0] if ehelpers else ea[0];ed.add(j);npc_turn(j);side=True;actor=f'NPC {j}'
   if trace is not None:trace.append(dict(round=rnd,actor=actor,pc_hp_before=before[0],enemy_hp_before=before[1],pc_hp_after=[p['hp'] for p in pcs],enemy_hp_after=[e['hp'] for e in enemy],attacks=m['attacks']-before[2]['attacks'],pc_heals=m['heals']-before[2]['heals'],enemy_heals=m['enemy_heals']-before[2]['enemy_heals']))
  if m['win'] or m['loss']:break
 if m['win']:
  m['cleanup_rounds']=m['rounds']-defeat;m['rounds']=defeat
  for p in pcs:
   if not p['terminal']:p.update(hp=p['build']['hp'],death=0,stable=False,burning=0)
 if not m['win'] and not m['loss']:m['timeout']=1
 m['any_wound']=int(m['wounds']>0);m['any_terminal']=int(m['terminal']>0)
 return m,pcs

def scenarios():
 base=dict(level=1,composition='mixed',count=4,ehp=12,eres=1,damage=[4,5,7],profile='new',target='focus',policy='none')
 for hp,dmg,profile,policy,target in itertools.product([8,12,16],[ [3,4,6],[4,5,7],[5,6,8],[6,7,9]],['old','new','flat','high'],['none','one'],['focus','spread']):
  yield dict(base,ehp=hp,damage=dmg,profile=profile,policy=policy,target=target,group='damage')
 # Body count/HP distribution, no control: action economy and targetable HP.
 for n,hp,policy in itertools.product([2,3,4,6,8],[8,12,16],['none','one']):yield dict(base,count=n,ehp=hp,policy=policy,group='bodies')
 for lvl,comp,hp,res,policy in itertools.product([3,7],['mixed','alternate'],[12,20,28],[1,3],['none','one']):yield dict(base,level=lvl,composition=comp,ehp=hp,eres=res,policy=policy,group='progression')
 for layer,policy in itertools.product(['shield_off','defend_off','front','self_heal','potions','oa_damage','oa_interrupt','burn','enemy1','enemy2','bane1','bane2'],['none','one']):
  d=dict(base,policy=policy,group='layer',layer=layer)
  if layer=='shield_off':d['shields']=False
  elif layer=='defend_off':d['defend']=False
  elif layer=='front':d['target']='front'
  elif layer=='self_heal':d['reach']='self'
  elif layer=='potions':d['potions']=True
  elif layer=='oa_damage':d['oa']='damage'
  elif layer=='oa_interrupt':d['oa']='strong_interrupt'
  elif layer=='burn':d['burn']=True
  elif layer.startswith('enemy'):d['enemy_healers']=int(layer[-1])
  elif layer.startswith('bane'):d['banes']=int(layer[-1])
  yield d

def run(s,n):
 name=json.dumps(s,sort_keys=True);rng=seed(name);total=Counter();wins=[]
 for _ in range(n):
  m,_=battle(s,rng);total.update(m)
  if m['win']:wins.append(m['rounds'])
 row=dict(id=hashlib.sha256(name.encode()).hexdigest()[:12],trials=n,scenario=dict(s),**s)
 for k in ['win','loss','timeout','rounds','any_wound','wounds','any_terminal','grit','heals','healed_hp','potions','attacks','enemy_attacks','opportunities','interrupted','enemy_heals','burn_ticks']:row['potions_used' if k=='potions' else k]=total[k]/n
 row['win_rounds']=sum(wins)/len(wins) if wins else None
 return row

def validate():
 checks=0
 for attr in range(-2,3):
  for net in range(-3,4):
   assert abs(sum(p for _,p in probabilities(attr,net))-1)<1e-10;checks+=1
 assert abs(dict(probabilities(0,0))[(2,True,False)]-1/216)<1e-12
 assert hurt_amount({'physical':3,'fire':1},{'physical':4})==1
 assert hurt_amount({'physical':3,'fire':3},{'physical':4,'fire':4})==1
 assert mean_damage([2,3,5],2,res=3)>1
 # Independent brute-force dice oracle, including negative and positive net.
 for attr,net in [(0,0),(2,1),(-2,-1)]:
  counter=Counter()
  for ds in itertools.product(range(1,7),repeat=3+abs(net)):
   kept=sorted(ds)[-3:] if net>=0 else sorted(ds)[:3];v=sum(kept)+attr
   t=0 if kept==[1,1,1] else 2 if kept==[6,6,6] else 0 if v<=8 else 1 if v<=14 else 2
   counter[t]+=1/6**(3+abs(net))
  for t in range(3):assert abs(counter[t]-sum(p for (tier,_,_),p in probabilities(attr,net) if tier==t))<1e-10
  checks+=1
 # No incoming action with 1 HP enemies killed in player's first four turns can
 # magically grant resource consumption; every outcome must terminate consistently.
 for policy in ['none','one','all']:
  s=dict(count=4,ehp=12,eres=1,damage=[4,5,7],policy=policy)
  for n in range(25):
   m,p=battle(s,random.Random(n));assert m['win']+m['loss']+m['timeout']==1
   assert all(q['grit']>=0 and q['wounds']>=0 for q in p);checks+=1
 return checks+4

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--trials',type=int,default=1000);args=ap.parse_args()
 checks=validate();ss=list(scenarios());rows=[]
 for i,s in enumerate(ss):
  rows.append(run(s,args.trials))
  if (i+1)%50==0:print(f'{i+1}/{len(ss)} scenarios',flush=True)
 (OUT/'combat.json').write_text(json.dumps(rows,indent=2)+'\n')
 (OUT/'combat-validation.json').write_text(json.dumps(dict(checks=checks,scenarios=len(ss),trials_each=args.trials,encounters=len(ss)*args.trials),indent=2)+'\n')
 print(f'Validated {checks} checks; {len(ss)*args.trials} encounters',flush=True)
if __name__=='__main__':main()
