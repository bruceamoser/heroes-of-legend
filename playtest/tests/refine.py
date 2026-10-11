#!/usr/bin/env python3
"""Larger-sample paired refinements and finite-resource sequences."""
import itertools,json
from collections import Counter
from combat import run,battle,new_party,fixture,seed
from catalog import ROOT
OUT=ROOT/'results'
def scenarios():
 base=dict(level=1,composition='mixed',count=4,ehp=12,eres=1,damage=[4,5,7],profile='new',target='spread',policy='none',group='refinement')
 for hp,dmg,policy,threshold in itertools.product([12,14,16],[[4,5,7],[5,6,8],[6,7,9]],['none','one'],[.25,.5]):
  if policy=='none' and threshold==.25:continue
  yield dict(base,ehp=hp,damage=dmg,policy=policy,threshold=threshold)
 for focus,policy in itertools.product([.25,.5,.75],['none','one']):yield dict(base,target='mixed',focus_chance=focus,policy=policy)
 for level,policy in itertools.product([1,3,7],['none','one','all']):yield dict(base,level=level,ehp=16,damage=[5,6,8],policy=policy,group='healer_access')
 for hp,actions,policy in itertools.product([24,48],[1,2,4],['none','one']):yield dict(base,count=1,ehp=hp,actions=actions,policy=policy,group='solo')

def campaigns(n=1000):
 rows=[]
 for policy,potions,resupply in [('none',False,False),('one',False,False),('none',True,False),('none',True,True)]:
  s=dict(level=1,count=4,ehp=14,eres=1,damage=[5,6,8],profile='new',target='spread',policy=policy,potions=potions)
  rng=seed(json.dumps(s,sort_keys=True)+str(resupply));totals=[Counter() for _ in range(10)]
  for _ in range(n):
   party=new_party(fixture(),s)
   for i in range(10):
    if resupply:
     for p in party:p['bottle']=4
    m,party=battle(s,rng,party);t=totals[i];t.update(m);t['reached']+=1;t['full_party']+=int(m['win'] and not m['any_terminal']);t['grit_left']+=sum(p['grit'] for p in party if not p['terminal']);t['scars']+=sum(p['wounds'] for p in party)
    if not m['win'] or m['any_terminal']:break
  for i,t in enumerate(totals):rows.append(dict(policy=policy,potions=potions,resupply=resupply,encounter=i+1,sequences=n,reached=t['reached'],full_party_completion=t['full_party']/n,mean_grit_remaining=t['grit_left']/t['reached'] if t['reached'] else None,mean_scars=t['scars']/t['reached'] if t['reached'] else None))
 return rows
if __name__=='__main__':
 rows=[];ss=list(scenarios())
 for i,s in enumerate(ss):
  rows.append(run(s,3000))
  if (i+1)%20==0:print(f'refinement {i+1}/{len(ss)}',flush=True)
 (OUT/'refinement.json').write_text(json.dumps(rows,indent=2)+'\n')
 cc=campaigns();(OUT/'campaigns.json').write_text(json.dumps(cc,indent=2)+'\n')
 print(f'{len(ss)*3000} refinement encounters; {sum(x["reached"] for x in cc)} campaign encounters',flush=True)
