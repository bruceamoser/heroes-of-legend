#!/usr/bin/env python3
"""Exact supporting checks for healing, death, progress, and mitigation."""
from functools import lru_cache
from study import distribution,tier_probs,write_csv,OUT,damage


def main():
 OUT.mkdir(exist_ok=True)
 rows=[]
 for attr in range(-2,3):
  for net in range(-3,4):
   p=tier_probs(attr,net)
   d=distribution(attr,net)
   f=sum(q for (_,_,fumble),q in d if fumble)
   weak=p[0]-f
   @lru_cache(None)
   def death(mark):
    if mark>=3:return 1.0
    return (weak*death(mark+1)+f*death(mark+2))/(1-p[1])
   @lru_cache(None)
   def turns(mark):
    if mark>=3:return 0.0
    return (1+weak*turns(mark+1)+f*turns(mark+2))/(1-p[1])
   for hp in (12,20,28):
    rows.append(dict(attribute=attr,net_boons=net,max_hp=hp,
       raw_spell_healing=sum(p[i]*((hp+1)//2 if i==0 else hp) for i in range(3)),
       terminal_without_help_or_grit=death(0),mean_death_rolls_to_resolution=turns(0)))
 write_csv("healing_death.csv",rows)
 progress=[]
 for attr in (-2,0,2):
  for net in (-3,0,3):
   p=tier_probs(attr,net)
   expected=[0.0]
   for t in range(1,1001):
    expected.append(1+sum(p[i]*expected[max(0,t-i-1)] for i in range(3)))
   for t in (3,6,10,30,100,365,1000):
    progress.append(dict(attribute=attr,net_boons=net,target=t,mean_attempts=expected[t],
      minimum_attempts=(t+2)//3,maximum_attempts_without_complications=t))
 write_csv("progress_tasks.csv",progress)
 mixed=[]
 for resistance in range(7):
  for attr in (0,2):
   p=tier_probs(attr,0)
   basic=sum(p[i]*damage({"physical":d},{"physical":resistance}) for i,d in enumerate((1,2,4)))
   flame=sum(p[i]*damage({"physical":d,"fire":1},{"physical":resistance}) for i,d in enumerate((1,2,4)))
   mixed.append(dict(attribute=attr,physical_resistance=resistance,basic_mean=basic,flaming_basic_mean=flame,ratio=flame/basic))
 write_csv("mixed_damage.csv",mixed)
 control=[]
 for attr in (-2,0,2):
  for net in (-3,0,3):
   p=tier_probs(attr,net)
   control.append(dict(attribute=attr,net_boons=net,one_grappler_restrains=p[2],
       two_grapplers_restrain=1-p[0]**2,three_grapplers_restrain=1.0,
       expected_grapple_rating=sum((i+1)*q for i,q in enumerate(p))))
 write_csv("grapple.csv",control)
 # Independent closed form: discard Standard self-loops; next outcomes have
 # probabilities 55/76 ordinary Weak, 1/76 fumble, 20/76 stabilization.
 from fractions import Fraction as F
 closed=F(55,76)*(F(55,76)*F(56,76)+F(1,76))+F(1,76)*F(56,76)
 assert abs(next(r for r in rows if r['attribute']==0 and r['net_boons']==0)['terminal_without_help_or_grit']-float(closed))<1e-12
 assert all(0<=r['terminal_without_help_or_grit']<=1 for r in rows)
 assert all(r['minimum_attempts']<=r['mean_attempts']<=r['maximum_attempts_without_complications']+1e-8 for r in progress)
 print("Exact supporting tables written.")


if __name__=="__main__":main()
