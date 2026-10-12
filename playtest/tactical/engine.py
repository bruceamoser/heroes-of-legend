"""Small declared-board experiment, not a full HOL/VTT engine."""
import sys,json,copy,heapq,re
from pathlib import Path
from collections import Counter
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tests'))
from combat import roll,seed,fixture,hurt_amount,mean_damage
from catalog import CARDS
from mechanics import HEALING,healing_amount,can_pay,decay,actions,tether,wound_tables,wound_effects

def distance(a,b):return max(abs(a[0]-b[0]),abs(a[1]-b[1]))
def direction(a,b):return tuple((y>x)-(y<x) for x,y in zip(a,b))
class Board:
 def __init__(self,layout='open'):
  self.w=10;self.h=7;self.walls={(4,y) for y in range(7) if y!=3} if layout=='door' else set()
  self.difficult={(x,3) for x in range(3,7)} if layout=='rough' else set()
 def valid(self,p):return 0<=p[0]<self.w and 0<=p[1]<self.h and p not in self.walls
 def line(self,a,b):
  # Sample the center-to-center segment; this is not exact supercover geometry.
  n=max(abs(a[0]-b[0]),abs(a[1]-b[1]))*4
  if not n:return True
  return all((int(a[0]+(b[0]-a[0])*i/n+.5),int(a[1]+(b[1]-a[1])*i/n+.5)) not in self.walls for i in range(n+1))
 def neighbors(self,p):
  for dx in (-1,0,1):
   for dy in (-1,0,1):
    q=(p[0]+dx,p[1]+dy)
    if (dx or dy) and self.valid(q) and (not dx or not dy or self.valid((p[0]+dx,p[1])) and self.valid((p[0],p[1]+dy))):yield q
 def path(self,start,goal,occupied):
  heap=[(0,start)];cost={start:0};prev={}
  while heap:
   c,p=heapq.heappop(heap)
   if c!=cost[p]:continue
   if goal(p) and (p==start or p not in occupied):
    out=[]
    while p!=start:out.append(p);p=prev[p]
    return list(reversed(out))
   for q in self.neighbors(p):
    if q in occupied and not occupied[q]:continue
    step=2 if q in self.difficult or q in occupied else 1
    if c+step<cost.get(q,10**9):cost[q]=c+step;prev[q]=p;heapq.heappush(heap,(c+step,q))
  return None

def actor(b,pos,i,side='pc'):
 return dict(id=i,side=side,b=b,pos=pos,hp=b['hp'],grit=b.get('grit',0),scars=0,death=0,stable=False,terminal=False,states={},injuries=[],prone=False,main=True,m=True,r=True,defend=False,shield=False,held=[],ground={},move=0,ammo=3 if 'ammo' in b.get('gear',[]) else 0,bottle=0,contribution=0)
def held_hands(a):return sum(2 if x=='ranged' or x=='twohanded' else 1 for x in a['held'])
def spend_m(a):
 if a['m']:a['m']=False;return True
 if a['main']:a['main']=False;return True
 return False

class Encounter:
 def __init__(self,s,rng,party=None):
  self.s=s;self.rng=rng;self.board=Board(s.get('board','open'));self.stats=Counter();self.round=0
  starts=[(3,2),(3,4),(1,2),(1,4)];builds=copy.deepcopy(fixture(s.get('level',1)))
  if s.get('summons'):
   b=builds[2];assert 'potions' in b['cards'] and b['ranks'].get('Summon',0)>=1
   b['cards'].remove('potions');b['cards'].append('summon') # Equal-DP level-1 substitution, no item grants.
  if s.get('signature'):
   cls,index=s['signature'];b=next(b for b in builds if b['class_name']==cls)
   b['cards']=[c for c in b['cards'] if not c.startswith('sig_'+cls.lower()+'_1_')]+[f'sig_{cls.lower()}_1_{index}']
  self.pcs=party or [actor(b,starts[i],i) for i,b in enumerate(builds)]
  for i,a in enumerate(self.pcs):
   a.update(pos=starts[i],states={},prone=False,main=True,m=True,r=True,defend=False,shield=False,ground={})
   gear=a['b']['gear'];weapon='ranged' if 'ranged' in gear else 'melee' if 'melee' in gear else None
   if s.get('twohanded') and weapon=='melee':weapon='twohanded'
   a['held']=([weapon] if weapon else [])+(['shield'] if 'shield' in gear and weapon not in ('ranged','twohanded') else [])
   if s.get('hand_policy')=='prepared':a['held']=['melee'] if 'melee' in gear else []
   if party is None:a['bottle']=4 if s.get('potions') else 0
  enemy_starts=[(6,1),(6,2),(6,4),(6,5)]
  self.enemies=[actor(dict(hp=s.get('ehp',14),speed=6,resistance=1,attrs={'Agility':0},gear=[],cards=[]),p,100+i,'npc') for i,p in enumerate(enemy_starts)]
  self.summons=[];self.first=sum(rng.randint(1,6) for _ in range(3))>=12
 def alive(self,a):return not a['terminal'] and (a['side']=='pc' or a['hp']>0)
 def everyone(self):return [a for a in self.pcs+self.enemies+self.summons if self.alive(a)]
 def occupied(self,a):return {b['pos']:b['prone'] for b in self.everyone() if b is not a}
 def state(self,a,key):return a['states'].get(key,0)+max([w['lasting'].get(key,0) for w in a['injuries'] if not w['treated']]+[0])
 def banes(self,a,kind):return self.state(a,kind)+self.state(a,'Frightened')+self.state(a,'Poisoned')
 def sig(self,a,index):return bool(self.s.get('signatures')) and f'sig_{a["b"].get("class_name","").lower()}_1_{index}' in a['b']['cards']
 def usable(self,a):return self.alive(a) and a['hp']>0 and not self.state(a,'Paralyzed') and self.state(a,'Dazed')<3
 def expire_tethers(self):
  for a in self.summons:
   if self.alive(a) and (not self.alive(a['controller']) or not tether(a['pos'],a['controller']['pos'])):a['terminal']=True;self.stats['tether_losses']+=1
 def hurt(self,a,n,kind='physical'):
  if not self.alive(a):return
  self.stats['damage_taken' if a['side']=='pc' else 'damage_dealt']+=n
  if a['hp']>0:
   a['hp']=max(0,a['hp']-n)
   if a['hp']==0:
    if a['side']!='pc':a['terminal']=True;return
    a.update(death=0,stable=False,prone=True);self.wound(a,kind)
  else:
   if a['stable']:a['stable']=False;self.wound(a,kind)
   a['death']+=1
   if a['death']>=3:a['terminal']=True
 def wound(self,a,kind):
  ds=sorted(self.rng.randint(1,6) for _ in range(min(5,3+a['scars'])))[-3:];code=100*ds[0]+10*ds[1]+ds[2]
  a['scars']+=1;self.stats['wounds']+=1
  if code==666:a['terminal']=True;return
  if not self.s.get('wounds'):return
  table='Elemental' if kind in ('fire','cold','lightning') else 'Mental' if kind=='mental' else 'Life/Necrotic' if kind=='life' else 'Radiant' if kind=='radiant' else 'Physical'
  w=dict(wound_tables()[table][code]);w['source']=kind;w['table']=table;e=wound_effects(w,kind);w['lasting']=e['lasting'];a['injuries'].append(w)
  for k,v in e['temporary'].items():a['states'][k]=a['states'].get(k,0)+v
  if e['prone']:a['prone']=True
  match=re.search(r'(Push|push|Pull) (\d)',w['effect'])
  if match:
   attacker=getattr(self,'last_attacker',None)
   if attacker:
    d=direction(attacker['pos'],a['pos']);d=tuple(-x for x in d) if match[1]=='Pull' else d
    self.push(a,d,int(match[2]))
 def push(self,a,d,budget):
  if d==(0,0):return
  while budget>0 and self.alive(a):
   q=tuple(x+y for x,y in zip(a['pos'],d))
   if not self.board.valid(q) or d[0] and d[1] and (not self.board.valid((a['pos'][0]+d[0],a['pos'][1])) or not self.board.valid((a['pos'][0],a['pos'][1]+d[1]))):
    self.hurt(a,hurt_amount({'physical':budget+1},{'physical':a['b'].get('resistance',0)}));self.stats['wall_collisions']+=1;break
   if q in self.occupied(a):
    # Group footprint/bends remain unresolved: never invent a separation rule.
    self.stats['unresolved_group_collisions']+=1;break
   a['pos']=q;budget=max(0,budget-(2 if q in self.board.difficult else 1));self.stats['forced_squares']+=1;self.expire_tethers()
 def move(self,a,goal,free=0):
  path=self.board.path(a['pos'],goal,self.occupied(a))
  if path is None:self.stats['blocked_paths']+=1;return False
  is_free=free>0
  if a['prone'] and not is_free:
   if a['move']<2:return False
   a['move']-=2;a['prone']=False;self.stats['stand_cost']+=2
  for step_index,q in enumerate(path):
   cost=2 if q in self.board.difficult or q in self.occupied(a) else 1
   # Enter a prone-occupied square only with enough budget to reach a free exit.
   if q in self.occupied(a):
    exit_cost=0
    for after in path[step_index+1:]:
     exit_cost+=2 if after in self.board.difficult or after in self.occupied(a) else 1
     if after not in self.occupied(a):break
    available=free if is_free else a['move']+(self.speed(a) if a['m'] else 0)
    if available<cost+exit_cost:break
   if is_free:
    if free<cost:break
    free-=cost
   else:
    if a['move']<cost:
     if a['m']:a['m']=False;a['move']+=self.speed(a);self.stats['maneuver_movement']+=1
     else:break
    if a['move']<cost:break
    if self.s.get('opportunity') and a['side']=='pc' and not a.get('disengaged'):
     threats=[e for e in self.enemies if self.alive(e) and e['r'] and distance(a['pos'],e['pos'])<=1 and distance(q,e['pos'])>1]
     if threats and a['m']:a['m']=False;a['disengaged']=True;self.stats['disengages']+=1
     else:
      for e in threats:
       e['r']=False;self.npc_attack(e,a,[2,3,5]);self.stats['opportunities']+=1
       if not self.usable(a):return False
    if self.s.get('opportunity') and a['side']=='npc' and not a.get('disengaged'):
     threats=[p for p in self.pcs if self.usable(p) and p['r'] and any(x in p['held'] for x in ('melee','twohanded')) and distance(a['pos'],p['pos'])<=1 and distance(q,p['pos'])>1]
     if threats and a['m']:a['m']=False;a['disengaged']=True;self.stats['enemy_disengages']+=1
     else:
      for p in threats:
       p['r']=False;t,_,_=roll(self.rng,p['b']['attrs']['Brawn'],-self.banes(p,'physical'))
       self.hurt(a,hurt_amount({'physical':[2,3,5][t]},{'physical':1}));self.stats['player_opportunities']+=1
       if not self.alive(a):return False
    a['move']-=cost
   a['pos']=q;self.stats['moved_squares']+=1;self.expire_tethers()
   if not self.alive(a):break
  return goal(a['pos']) and a['pos'] not in self.occupied(a)
 def speed(self,a):return max(0,a['b']['speed']-self.state(a,'movement')-self.state(a,'Slowed')-(1 if a['bottle'] and a['b'].get('bulk',0)+1>a['b'].get('capacity',999) else 0))
 def free_hand(self,a,for_spell=False):
  if self.s.get('hand_policy')=='ignore':return True
  if held_hands(a)<2:return True
  policy=self.s.get('hand_policy','drop_shield')
  if policy=='stow':
   if for_spell and not a['m']:return False
   if not spend_m(a):return False
   item='shield' if 'shield' in a['held'] else a['held'][0]
   a['held'].remove(item);a['shield']=False;self.stats['stows']+=1
  else:
   item='shield' if policy=='drop_shield' and 'shield' in a['held'] else next((x for x in a['held'] if x!='shield'),a['held'][0])
   a['held'].remove(item);a['ground'][item]=a['pos']
   if item=='shield':a['shield']=False
   self.stats['drops']+=1
  return True
 def draw(self,a,item):
  if item in a['held']:return True
  needed=held_hands(a)+(2 if item in ('ranged','twohanded') else 1)
  if needed>2 or self.s.get('hand_policy')=='prepared' and needed>1:return False
  if item in a['ground']:
   if a['ground'][item]!=a['pos'] or not spend_m(a):return False
   del a['ground'][item];self.stats['pickups']+=1
  elif item=='shield':
   if not spend_m(a):return False
  a['held'].append(item);return True
 def in_range(self,a,b,n):return distance(a['pos'],b['pos'])<=n and self.board.line(a['pos'],b['pos'])
 def healing_choice(self,a,b):
  choices=[CARDS[id] for id in a['b']['cards'] if id in ('heal','adept_heal','master_heal') and can_pay(a['hp'],CARDS[id]['hp_cost'])]
  if not choices:return None
  if self.s.get('healing_choice')=='adaptive':
   missing=b['b']['hp']-b['hp']
   # Expected effective party HP gain, cost included; no prediction of dice.
   from combat import probabilities
   return max(choices,key=lambda c:sum(pr*min(missing+(c['hp_cost'] if a is b else 0),healing_amount(c['healing'][t])) for (t,_,_),pr in probabilities(a['b']['attrs']['Reason']))-c['hp_cost'])
  if self.s.get('healing_choice')=='highest':return max(choices,key=lambda c:c['level'])
  return next((c for c in choices if c['level']==1),choices[0])
 def heal(self,a,b,c):
  if not a['main'] or not can_pay(a['hp'],c['hp_cost']):return False
  if not self.free_hand(a,True) or not a['main']:return False
  if self.s.get('opportunity'):
   for e in self.enemies:
    if self.alive(e) and e['r'] and self.in_range(e,a,1):
     e['r']=False;self.npc_attack(e,a,[2,3,5]);self.stats['opportunities']+=1
     if not self.usable(a):return False
  if not can_pay(a['hp'],c['hp_cost']):return False
  a['main']=False;a['hp']-=c['hp_cost'];t,_,_=roll(self.rng,a['b']['attrs'][c['attribute']],-self.banes(a,'mental'))
  n=healing_amount(c['healing'][t]);old=b['hp'];b['hp']=min(b['b']['hp'],b['hp']+n);b['death']=0;b['stable']=False
  self.stats['heals']+=1;self.stats['healed_hp']+=b['hp']-old;self.stats['healing_cost']+=c['hp_cost'];self.stats['heal_tier_'+str(c['level'])]+=1
  if self.sig(a,0) and a['b']['class_name']=='Shepherd' and t==2:b['states']['Poisoned']=max(0,b['states'].get('Poisoned',0)-1)
  return True
 def potion(self,a):
  if not a['bottle'] or a['hp']>a['b']['hp']/2:return False
  if not self.free_hand(a) or not spend_m(a):return False
  old=a['hp'];a['hp']=min(a['b']['hp'],a['hp']+6);self.stats['potions']+=1;self.stats['healed_hp']+=a['hp']-old
  if self.rng.randint(1,a['bottle'])==1:a['bottle']=0;self.stats['empty_bottles']+=1
  return True
 def npc_attack(self,e,p,profile=None):
  if not self.alive(p):return
  self.last_attacker=e
  protector=self.pcs[0]
  if p is not protector and self.usable(protector) and protector['r'] and self.sig(protector,2) and self.in_range(protector,p,1) and self.in_range(e,protector,1) and protector['hp']>p['hp']:
   protector['r']=False;p=protector;self.stats['interposes']+=1
  if p['r'] and 'shield' in p['held'] and self.usable(p):p['r']=False;p['shield']=True
  sheltered=any(self.usable(q) and self.sig(q,1) and q['b'].get('class_name')=='Protector' and q['defend'] and q.get('shelter')==p['id'] for q in self.pcs)
  net=int(p['defend'])+int(p['shield'] and 'shield' in p['held'])+int(sheltered)-self.banes(p,'physical')-(3 if p['hp']==0 or self.state(p,'Paralyzed') else 0)-(3 if self.state(p,'Blinded') else 0)
  t,_,_=roll(self.rng,p['b']['attrs']['Agility'],net)
  kind=self.s.get('enemy_type','physical');damage=(profile or [5,6,8])[2-t]
  self.hurt(p,hurt_amount({kind:damage},{'physical':p['b'].get('resistance',0)}),kind);self.stats['enemy_attacks']+=1
  if self.s.get('enemy_push') and t==0:self.push(p,direction(e['pos'],p['pos']),1)
  if self.sig(p,0) and p['b'].get('class_name')=='Protector' and p.get('hold_round')!=self.round:
   allies=[q for q in self.pcs if q is not p and self.alive(q) and self.in_range(p,q,1)]
   if allies:
    q=min(allies,key=lambda q:q['hp']);p['hold_round']=self.round
    healer=self.pcs[3];self.move(q,lambda x:distance(x,healer['pos'])<distance(q['pos'],healer['pos']),free=1)
 def attacks(self,a):
  out=[]
  for id in a['b']['cards']:
   c=CARDS[id]
   if 'damage' not in c or id in ('hands','fan','daze'):continue
   kind='fire' if 'Magic' in c['types'] else 'physical';item='ranged' if 'ammo' in c['gear'] else ('twohanded' if self.s.get('twohanded') else 'melee') if 'melee' in c['gear'] else None
   if item=='ranged' and not a['ammo']:continue
   range_=8 if item=='ranged' else 6 if kind=='fire' else 1
   if self.sig(a,0) and a['b']['class_name']=='Arcanist' and kind=='fire':range_+=1
   out.append((mean_damage(c['damage'],a['b']['attrs'][c['attribute']],res=1 if kind=='physical' else 0),id,c,item,range_,kind))
  out.append((1.,'unarmed',dict(damage=[1,2,4],attribute='Brawn'),None,1,'physical'))
  return sorted(out,key=lambda x:x[0],reverse=True)
 def attack(self,a):
  if not a['main'] or self.state(a,'Blinded'):return False
  enemies=[e for e in self.enemies if self.alive(e)]
  if not enemies:return False
  for _,id,c,item,range_,kind in self.attacks(a):
   targets=sorted(enemies,key=lambda e:(not self.in_range(a,e,range_),e['hp'],distance(a['pos'],e['pos'])))
   target=targets[0]
   if not self.in_range(a,target,range_):self.move(a,lambda p:distance(p,target['pos'])<=range_ and self.board.line(p,target['pos']))
   if not self.usable(a) or not a['main']:return False
   if not self.in_range(a,target,range_):continue
   if item and not self.draw(a,item):continue
   if not a['main']:return False
   if kind=='fire' and self.s.get('opportunity'):
    for e in self.enemies:
     if self.alive(e) and e['r'] and self.in_range(e,a,1):
      e['r']=False;self.npc_attack(e,a,[2,3,5]);self.stats['opportunities']+=1
      if not self.usable(a):a['main']=False;return False
   a['main']=False;t,_,_=roll(self.rng,a['b']['attrs'][c['attribute']],-self.banes(a,'physical' if kind=='physical' else 'mental'))
   self.hurt(target,hurt_amount({kind:c['damage'][t]},{'physical':1}),kind);self.stats['attacks']+=1
   if item=='ranged':
    if self.rng.randint(1,[0,4,6,8][a['ammo']])==1:a['ammo']-=1
   if self.s.get('riders') and t==2 and id in ('strike','adept_strike','master_strike','adept_fire','master_fire','adept_shot','master_shot') and self.alive(target):self.push(target,direction(a['pos'],target['pos']),1)
   if self.sig(a,1) and a['b']['class_name']=='Blade' and kind=='physical' and range_==1 and t==2 and self.alive(target):self.push(target,direction(a['pos'],target['pos']),1)
   if self.sig(a,0) and a['b']['class_name']=='Blade' and range_==1 or self.sig(a,1) and a['b']['class_name']=='Arcanist' and kind=='fire':
    old=distance(a['pos'],target['pos']);self.move(a,lambda p:distance(p,target['pos'])>old,free=1)
   return True
  return False
 def pc_turn(self,a):
  a.update(main=True,m=True,r=True,defend=False,shield=False,disengaged=False,move=self.speed(a))
  if a['hp']==0:
   if a['stable']:return self.end(a)
   if a['grit']:a['grit']-=1;a['hp']=a['b']['hp'];a['death']=0;self.stats['grit']+=1
   else:
    t,c,f=roll(self.rng,a['b']['attrs']['Fortitude'],-self.banes(a,'physical'))
    if c:a['hp']=1;a['death']=0
    elif t==2:a['stable']=True;a['death']=0
    elif t==0:a['death']+=2 if f else 1
    if a['death']>=3:a['terminal']=True
    if a['hp']==0:return self.end(a)
  n=actions(self.state(a,'Dazed'),self.state(a,'Paralyzed'));a['main']=n>=1;a['m']=n>=2;a['r']=n>=3
  if not n:self.stats['disabled_turns']+=1;return self.end(a)
  self.potion(a)
  can_heal=self.s.get('healing','one')=='all' or self.s.get('healing','one')=='one' and a['id']==3
  if can_heal and a['main'] and 'heal' in a['b']['cards']:
   needy=sorted([p for p in self.pcs if self.alive(p) and p['hp']<=p['b']['hp']/2],key=lambda p:p['hp']/p['b']['hp'])
   if needy:
    target=needy[0];c=self.healing_choice(a,target);range_=4 if a['b']['class_name']=='Arcanist' and self.sig(a,0) else 3
    if c:
     self.move(a,lambda p:distance(p,target['pos'])<=range_ and self.board.line(p,target['pos']))
     if self.in_range(a,target,range_) and self.usable(a):self.heal(a,target,c)
     else:self.stats['unreachable_heals']+=1
  if self.s.get('summons') and a['id']==2 and a['main']:self.summon_turn(a)
  self.attack(a)
  if self.usable(a):
   dying=[p for p in self.pcs if p['hp']==0 and not p['stable'] and self.alive(p) and self.in_range(a,p,1)]
   if dying and spend_m(a):dying[0]['stable']=True;dying[0]['death']=0;self.stats['stabilizes']+=1
   if a['m'] and 'shield' in a['b']['gear'] and 'shield' not in a['held'] and held_hands(a)<2:self.draw(a,'shield')
   if spend_m(a):
    a['defend']=True
    if self.sig(a,1) and a['b']['class_name']=='Protector':
     allies=[p for p in self.pcs if p is not a and self.alive(p) and self.in_range(a,p,1)]
     a['shelter']=min(allies,key=lambda p:p['hp'])['id'] if allies else None
    if self.sig(a,2) and a['b']['class_name']=='Shepherd':
     allies=[p for p in self.pcs if p is not a and self.alive(p) and self.in_range(a,p,1)]
     if allies:
      p=min(allies,key=lambda p:p['hp']);old=distance(p['pos'],a['pos']);self.move(p,lambda q:distance(q,a['pos'])>old,free=1)
  self.end(a)
 def end(self,a):
  ticks={k:self.state(a,k) for k in ('Bleeding','Burning','Freezing')}
  for k,x in ticks.items():
   if x and self.alive(a):self.hurt(a,x,{'Bleeding':'physical','Burning':'fire','Freezing':'cold'}[k])
  decay(a['states'])
 def summon_turn(self,a):
  existing=[q for q in self.summons if self.alive(q) and q['controller'] is a]
  if existing and not self.s.get('summon_replace'):
   q=existing[0];a['main']=False
  else:
   places=[p for p in self.board.neighbors(a['pos']) if p not in self.occupied(a)]
   if not places:return
   q=actor(dict(hp=6,speed=5,resistance=0,attrs={},gear=[],cards=[]),max(places,key=lambda p:p[0]),200+len(self.summons),'summon');q['controller']=a
   self.summons.append(q);a['main']=False;self.stats['summons']+=1
  # Main command: Main attack and Maneuver, convertible to one movement allowance.
  q.update(move=5,m=False,main=True)
  targets=[e for e in self.enemies if self.alive(e)]
  if targets:
   e=min(targets,key=lambda e:distance(e['pos'],q['pos']));self.move(q,lambda p:distance(p,e['pos'])<=1)
   if self.alive(q) and self.in_range(q,e,1):
    t,_,_=roll(self.rng,a['b']['attrs']['Knowledge']);self.hurt(e,hurt_amount({'physical':[3,4,6][t]},{'physical':1}));self.stats['summon_attacks']+=1
  self.expire_tethers()
 def npc_turn(self,e):
  e.update(r=True,move=6,m=True,main=True,disengaged=False)
  targets=[p for p in self.pcs+self.summons if self.alive(p) and p['hp']>0]
  if not targets:targets=[p for p in self.pcs if self.alive(p)]
  if not targets:return
  # Prefer attackable targets, otherwise shortest reachable approach; HP breaks ties.
  choices=[]
  for p in targets:
   path=self.board.path(e['pos'],lambda q:distance(q,p['pos'])<=1 and self.board.line(q,p['pos']),self.occupied(e))
   if path is not None:choices.append((len(path),p['hp'],p['id'],p))
  if not choices:self.stats['enemy_blocked']+=1;return
  p=min(choices,key=lambda c:c[:3])[3];self.move(e,lambda q:distance(q,p['pos'])<=1 and self.board.line(q,p['pos']))
  if self.in_range(e,p,1):
   if p['side']=='summon':self.hurt(p,6);self.stats['summon_hits']+=1
   else:self.npc_attack(e,p)
 def run(self):
  for rnd in range(1,41):
   self.round=rnd;pd=set();ed=set();side=self.first
   while True:
    if not any(self.alive(e) for e in self.enemies):
     self.stats['win']=1;self.stats['rounds']=rnd
     # Preserve death rolls after combat rather than grant automatic rescue.
     self.cleanup();return self.stats,self.pcs
    if not any(self.alive(p) for p in self.pcs):self.stats['loss']=1;self.stats['rounds']=rnd;return self.stats,self.pcs
    pa=[p for p in self.pcs if self.alive(p) and p['id'] not in pd];ea=[e for e in self.enemies if self.alive(e) and e['id'] not in ed]
    if not pa and not ea:break
    if side and pa or not ea:
     p=min(pa,key=lambda p:(not (p['id']==3 and any(q['hp']<=q['b']['hp']/2 for q in self.pcs)),p['hp'],p['id']))
     pd.add(p['id']);self.pc_turn(p);side=False
    else:e=ea[0];ed.add(e['id']);self.npc_turn(e);side=True
    self.expire_tethers()
    positions=[a['pos'] for a in self.everyone()]
    assert len(positions)==len(set(positions)),('overlap',positions)
  self.stats['timeout']=1;self.stats['rounds']=40;return self.stats,self.pcs
 def cleanup(self):
  # With no enemies, existing assistance can reach patients; no instantaneous
  # treatment of lasting wounds. Bounded recovery resolves ticks/death/Grit.
  for _ in range(20):
   live=[p for p in self.pcs if self.alive(p)]
   if not live:self.stats['win']=0;self.stats['loss']=1;return
   for p in live:
    if any(self.usable(q) for q in live):
     for k in ('Bleeding','Burning','Freezing'):p['states'][k]=0
   dying=[p for p in live if p['hp']==0 and not p['stable']]
   if not dying:break
   for p in dying:
    # In this safe phase help is assumed to arrive before next death choice if
    # an upright helper exists; report this optimistic rescue convention.
    if any(self.usable(q) for q in live if q is not p):p['stable']=True;p['death']=0
    else:self.pc_turn(p)
  for p in self.pcs:
   if self.alive(p):p['hp']=p['b']['hp'];p['states']={};p['death']=0;p['stable']=False

def run_scenario(s,n):
 rng=seed('tactical-v1'+json.dumps(s,sort_keys=True));total=Counter()
 for _ in range(n):
  enc=Encounter(s,rng);m,party=enc.run();total.update(m)
  total['any_wound']+=int(m['wounds']>0);total['any_terminal']+=int(any(p['terminal'] for p in party))
 return dict(scenario=s,trials=n,**{k:v/n for k,v in total.items()})
