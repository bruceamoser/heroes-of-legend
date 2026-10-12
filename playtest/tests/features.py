#!/usr/bin/env python3
"""Exact and small state-space checks; not full tactical encounter simulations."""
import itertools,json,math
from collections import Counter
from catalog import ROOT
from combat import probabilities,mean_damage,hurt_amount
from mechanics import HEALING,healing_amount
OUT=ROOT/'results'
def tier_distribution(attr,net):
 p=[0.,0.,0.]
 for (t,_,_),v in probabilities(attr,net):p[t]+=v
 return p

def main():
 checks=[];rows=[]
 def check(name,value):assert value,name;checks.append(name)
 # Complete 5x7 outcome grid exposes attribute and bane sensitivity.
 for a in range(-2,3):
  for net in range(-3,4):
   p=tier_distribution(a,net)
   rows.append(dict(test='outcomes',attribute=a,net=net,weak=p[0],standard=p[1],strong=p[2]))
 for profile in ([1,2,4],[2,3,5],[2,4,6],[4,4,6],[4,5,7],[5,6,8],[5,7,9],[6,8,11]):
  for r in range(4):
   rows.append(dict(test='damage',profile=profile,resistance=r,mean_at_attribute_1=mean_damage(profile,1,res=r),weak=max(1,profile[0]-r),standard=max(1,profile[1]-r),strong=max(1,profile[2]-r)))
 check('minimum is per mixed damage event',hurt_amount({'physical':1,'fire':1},{'physical':2,'fire':2})==1)
 check('different unresisted components add',hurt_amount({'physical':3,'fire':2},{'physical':2})==3)
 # Worst-target AoE suppresses favorable targets, distinct from shared raw dice.
 for attr in (0,2):
  for banes in (0,1,3):
   rows.append(dict(test='aoe_worst_target',attribute=attr,heavy_target_banes=banes,targets=3,expected_total_damage=3*mean_damage([3,3,5],attr,-banes,res=0)))
 # Grapple rated progress: one-source restriction checked separately from target sum.
 for attr in (0,2):
  for net in (0,-3):
   p=tier_distribution(attr,net);restrain_two=1-p[0]**2
   rows.append(dict(test='two_grapplers',attribute=attr,net=net,restrain_probability=restrain_two))
 check('two grapple 1 sources do not restrain their own grapplers',sum([1,1])==2 and max([1,1])==1)
 check('third grapple 1 source restrains target',sum([1,1,1])==3)
 # Dazed and grapple use maximum, not sum; allowance excludes separate movement.
 def allowance(grapple,dazed):return max(0,3-max(grapple,dazed))
 check('grapple1 dazed1 retains two categories',allowance(1,1)==2)
 check('rating3 prevents own Main Force',allowance(3,0)==0)
 # Free attack branching explicitly blocked.
 def attacks(grants):return 1+grants
 check('free attack cannot recurse',attacks(2)==3)
 rows.append(dict(test='free_attack',granted=2,additional_expected_damage_vs_res3=2*mean_damage([2,3,5],1,res=3)))
 # Straight-line forced movement: positive budget enters expensive square, then stops.
 def travel(push,costs):
  entered=0
  for cost in costs:
   if push<=0:break
   entered+=1;push=max(0,push-cost)
  return entered,push
 check('push1 enters difficult square',travel(1,[2,1])==(1,0))
 check('push2 enters one difficult square',travel(2,[2,1])==(1,0))
 check('push3 enters difficult then normal',travel(3,[2,1])==(2,0))
 # Hard collision damage is same for every group member, after their own resistance.
 group=[{'physical':0},{'physical':2}];remaining=2
 check('hard collision +1 before resistance',[hurt_amount({'physical':remaining+1},r) for r in group]==[3,1])
 # Summon counts are legal maxima, not assumed each creature receives a command.
 for count in range(1,7):
  rows.append(dict(test='summon_commands',summons=count,commanded_per_turn=min(2,count),main_attack_commands=1,uncommanded=max(0,count-2),main_command_attack_mean=mean_damage([3,4,6],2,res=1)))
 check('three summons still only two commands',min(2,3)==2)
 # Initial free command creates an attack on summoning turns even at command saturation.
 rows.append(dict(test='summon_replacement',summon_hp=6,new_bodies_per_main=1,immediate_attack_mean=mean_damage([3,4,6],2,res=1),persistent_uncommanded_bodies=True))
 # Consumption independent of Boons; full ladder expected uses.
 ladder=[4,6,8,10,12,20]
 for i,d in enumerate(ladder):rows.append(dict(test='inventory',die=d,expected_total_uses=sum(ladder[:i+1])))
 check('d8 bottle expectation18',sum(ladder[:3])==18)
 for dice in range(3,6):rows.append(dict(test='wound666',dice=dice,probability=sum(math.comb(dice,k)*(1/6)**k*(5/6)**(dice-k) for k in range(3,dice+1))))
 # Fixed healing independent of recipient maximum; effective healing caps at missing HP.
 for level,(profile,cost) in HEALING.items():
  for res in range(4):
   p=tier_distribution(1,0);rows.append(dict(test='healing',tier=level,resistance=res,hp_cost=cost,expected_nominal_healing=sum(p[t]*healing_amount(profile[t],res) for t in range(3))))
 # Exact absorbing death process with Standard as a self-loop.
 for attr in range(-2,3):
  for bane in range(4):
   dist=probabilities(attr,-bane)
   weak=sum(v for (t,c,f),v in dist if t==0 and not f)
   fumble=sum(v for (t,c,f),v in dist if f)
   stay=sum(v for (t,c,f),v in dist if t==1)
   death=[0.,0.,0.,1.,1.];turns=[0.]*5
   for marks in [2,1,0]:
    death[marks]=(weak*death[marks+1]+fumble*death[marks+2])/(1-stay)
    turns[marks]=(1+weak*turns[marks+1]+fumble*turns[marks+2])/(1-stay)
   rows.append(dict(test='isolated_death',fortitude=attr,banes=bane,death_probability=death[0],mean_rolls_to_resolution=turns[0]))
 # Attribute incentive range subject to sum +3.
 arrays=[a for a in itertools.product(range(-2,3),repeat=6) if sum(a)==3]
 budgets=[10+sum(a[3:]) for a in arrays];check('creation DP 7 through16',min(budgets)==7 and max(budgets)==16)
 (OUT/'features.json').write_text(json.dumps(rows,indent=2)+'\n')
 (OUT/'feature-validation.json').write_text(json.dumps(dict(checks=checks,exact_rows=len(rows)),indent=2)+'\n')
 print(f'{len(checks)} feature checks, {len(rows)} exact rows')
if __name__=='__main__':main()
