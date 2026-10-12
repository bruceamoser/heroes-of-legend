"""Shared revised test mechanics; isolated from policy and encounter geometry."""
import re
from pathlib import Path
from functools import lru_cache
from collections import Counter

HEALING={1:([3,6,9],1),3:([5,10,15],3),7:([8,16,24],7)}
def resistance(value): return max(0,min(3,value))
def healing_amount(n,res=0): return max(1,n-resistance(res))
def can_pay(hp,cost): return hp>cost
def decay(states):
 for name in list(states):states[name]=max(0,states[name]-1)
def actions(dazed=0,paralyzed=0):return 0 if paralyzed else max(0,3-dazed)
def tether(controller,summon):return max(abs(controller[0]-summon[0]),abs(controller[1]-summon[1]))<=6

@lru_cache(None)
def wound_tables():
 text=(Path(__file__).resolve().parents[1]/'wounds.md').read_text();tables={}
 for name in ['Physical','Elemental','Mental','Radiant','Life/Necrotic']:
  part=text.split('\n## '+name+'\n',1)[1].split('\n## ',1)[0];rows={}
  for line in part.splitlines():
   if not re.match(r'\| \d{3} \|',line) or line.count('|')!=6:continue
   code,injury,effect,remedy,rv=[x.strip() for x in line.split('|')[1:-1]]
   rows[int(code)]=dict(code=int(code),injury=injury,effect=effect,remedy=remedy,rv=int(rv) if rv.isdigit() else None,progress=0,treated=False,last_day=None)
  tables[name]=rows
 return tables

def wound_effects(wound,kind='physical'):
 text=wound['effect'];temp=Counter();lasting={};prone='Prone' in text
 for name,rating,star in re.findall(r'(Burning/Freezing|Bleeding|Burning|Freezing|Dazed|Paralyzed|Frightened|Blinded|Deafened) ([1-9])(\*?)',text):
  if name=='Burning/Freezing':name='Freezing' if kind=='cold' else 'Burning'
  (lasting if star else temp)[name]=int(rating)
 for category in ['physical','mental']:
  m=re.search(r'(\d) Banes? to '+category+' activities',text)
  if m:lasting[category]=int(m[1])
 m=re.search(r'−(\d) movement',text)
 if m:lasting['movement']=int(m[1])
 return dict(temporary=dict(temp),lasting=lasting,prone=prone)

def treat(wound,capability,day,progress):
 assert progress in (1,2,3)
 assert wound['rv'] is not None and not wound['treated'],'not a treatable active wound'
 assert wound['remedy'].split(';')[0]==capability,'wrong treatment capability'
 assert wound['last_day']!=day,'only one treatment attempt per wound per day'
 wound['last_day']=day;wound['progress']+=progress
 wound['treated']=wound['progress']>=wound['rv']
 return wound['treated']

def reduce_condition(states,name):
 assert name in ('Bleeding','Burning','Freezing'),'specific remedy required'
 states[name]=max(0,states.get(name,0)-1)

def grapple_attack_net(rating,boons=0,banes=0):
 return max(-3,min(3,rating+boons-banes))
