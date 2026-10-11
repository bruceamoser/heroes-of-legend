#!/usr/bin/env python3
"""Additional duration anchors and alternating-turn grappling experiments."""
import itertools,json
from collections import Counter
from combat import run,roll,seed
from catalog import ROOT
OUT=ROOT/'results'
def grapple_trial(rng,grapplers,attacker,defender,first):
 contribution=[0]*grapplers;force=0
 for rnd in range(1,4):
  # One target turn per round, alternated with first grappler; remaining side acts.
  order=['target']+list(range(grapplers)) if first=='target' else [0,'target']+list(range(1,grapplers))
  for actor in order:
   if sum(contribution)>=3:return rnd,force
   if actor=='target':
    if sum(contribution):
     t,_,_=roll(rng,defender);remove=t+1;force+=1
     for i in range(grapplers):
      n=min(remove,contribution[i]);contribution[i]-=n;remove-=n
   else:
    # Retain Main among own contribution's remaining categories.
    if contribution[actor]<3:
     t,_,_=roll(rng,attacker);contribution[actor]+=t+1
   if sum(contribution)>=3:return rnd,force
 return 0,force
if __name__=='__main__':
 rows=[]
 for level,hp,res,policy in itertools.product([1,3,7],[24,32,40,48,56],[1,3],['none','one']):
  s=dict(level=level,composition='mixed',count=4,ehp=hp,eres=res,damage=[4,5,7],profile='new',target='focus',policy=policy,group='duration_anchor')
  rows.append(run(s,1000))
 for level,hp,policy in itertools.product([1,3,7],[24,48,80],['none','one']):
  rows.append(run(dict(level=level,composition='mixed',count=1,ehp=hp,eres=1,damage=[4,5,7],profile='new',target='focus',policy=policy,enemy_healers=1,group='solo_healing'),1000))
 for level,fire_res,policy in itertools.product([1,3,7],[0,2,4,6],['none','one']):
  rows.append(run(dict(level=level,composition='mixed',count=4,ehp=16,eres=3,fire_res=fire_res,damage=[4,5,7],profile='new',target='spread',policy=policy,group='typed_resistance'),1000))
 (OUT/'advanced.json').write_text(json.dumps(rows,indent=2)+'\n')
 gr=[]
 for attackers,attack,defense,first in itertools.product([1,2,3],[0,2],[0,2],['target','grapplers']):
  rng=seed(f'grapple{attackers}{attack}{defense}{first}');n=10000;c=Counter();forces=0
  for _ in range(n):
   rnd,force=grapple_trial(rng,attackers,attack,defense,first);c[rnd]+=1;forces+=force
  gr.append(dict(grapplers=attackers,attack_attribute=attack,force_attribute=defense,first=first,trials=n,restrained_round1=c[1]/n,restrained_by_round3=1-c[0]/n,force_actions=forces/n))
 (OUT/'grappling.json').write_text(json.dumps(gr,indent=2)+'\n')
 print(f'{len(rows)*1000} encounters; {len(gr)*10000} local grappling trials',flush=True)
