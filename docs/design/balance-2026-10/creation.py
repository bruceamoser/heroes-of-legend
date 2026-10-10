#!/usr/bin/env python3
"""Illustrative creation ledgers. Names/requirements below are test fixtures, not catalog edits."""
import itertools
import json
from pathlib import Path
from study import write_csv

OUT=Path(__file__).parent/"outputs"
COSTS={"home":(1,2,4),"adjacent":(2,4,8),"foreign":(3,6,12),"opposed":(4,8,16)}
# Single-rank examples deliberately do not pretend to settle final card requirements.
CARDS={
 "Medium Armor Training":("Armor",["armor"]),
 "Shield Training":("Protection",["shield"]),
 "Melee Technique":("Blades",["melee weapon"]),
 "Ranged Technique":("Archery",["ranged weapon","ammunition"]),
 "Unarmed Technique":("Unarmed",[]),
 "Fire Attack":("Fire",[]),
 "Healing Spell":("Life",[]),
 "Summon Ally":("Summon",[]),
 "Grapple":("Unarmed",[]),
 "Forage Forest":("Lore",[]),
 "Craft Mundane":("Lore",["tools"]),
 "Derive Mundane Recipe":("Lore",[]),
 "Identify Potions":("Lore",[]),
 "Identify Magic":("Energy",[]),
 "Stealth Expertise":("Stealth",[]),
 "Lock Expertise":("Sleight",["tools"]),
 "Social Expertise":(None,[]),
 "Climbing Expertise":(None,[]),
 "Swimming Expertise":(None,[]),
 "Observation Expertise":(None,[]),
 "Endurance Expertise":(None,[]),
 "First Aid Expertise":(None,[]),
 "Escape Expertise":(None,[]),
 "Navigation Expertise":(None,[]),
 "Wilderness Shelter":(None,[]),
 "Animal Care":(None,[]),
}


def card(name): return ("card",name)
def disc(name,category="home"): return ("discipline",name,category)
UTILITY=["Climbing Expertise","Swimming Expertise","Observation Expertise","Social Expertise","Endurance Expertise"]


def fixtures():
 return [
  dict(name="Protector with broad utility",class_name="Protector",attrs=[2,2,0,-1,0,0],pairs=[("Armor","Medium Armor Training"),("Lore","Forage Forest")],class_discs=["Blades","Protection"],zero=[card(x) for x in UTILITY],one=[card(x) for x in ["Melee Technique","Shield Training","Craft Mundane","Derive Mundane Recipe","Identify Potions"]]),
  dict(name="Fragile Arcanist",class_name="Arcanist",attrs=[-2,-1,2,1,2,1],pairs=[("Fire","Fire Attack"),("Lore","Forage Forest")],class_discs=["Energy","Life"],zero=[card(x) for x in ["Craft Mundane","Derive Mundane Recipe","Identify Potions","Observation Expertise","Social Expertise"]],one=[card(x) for x in ["Healing Spell","Identify Magic","Climbing Expertise","Swimming Expertise","Escape Expertise"]]),
  dict(name="Shepherd healer",class_name="Shepherd",attrs=[0,1,1,-1,0,2],pairs=[("Life","Healing Spell"),("Protection","Shield Training")],class_discs=["Armor","Animal"],zero=[card(x) for x in UTILITY],one=[disc("Lore","adjacent"),card("Forage Forest"),card("Identify Potions"),card("Medium Armor Training"),card("Navigation Expertise")]),
  dict(name="Shadow specialist",class_name="Shadow",attrs=[0,0,2,2,-1,0],pairs=[("Stealth","Stealth Expertise"),("Sleight","Lock Expertise")],class_discs=["Blades","Archery"],zero=[card(x) for x in UTILITY],one=[card(x) for x in ["Melee Technique","Ranged Technique","Escape Expertise","Navigation Expertise","First Aid Expertise"]]),
  dict(name="Odd generalist",class_name="Odd",attrs=[1,0,1,0,1,0],pairs=[("Lore","Forage Forest"),("Unarmed","Unarmed Technique")],class_discs=["Life","Fire"],zero=[card(x) for x in ["Craft Mundane","Derive Mundane Recipe","Identify Potions","Social Expertise","Observation Expertise"]],one=[disc("Armor","adjacent"),card("Medium Armor Training"),card("Healing Spell"),card("Fire Attack"),card("Grapple")]),
  dict(name="Protector buys opposed healing",class_name="Protector",attrs=[2,1,0,-1,0,1],pairs=[("Armor","Medium Armor Training"),("Blades","Melee Technique")],class_discs=["Protection","Unarmed"],zero=[card(x) for x in UTILITY],one=[disc("Life","opposed"),card("Healing Spell"),card("Shield Training"),card("Grapple")]),
  dict(name="Protector gets healing from background",class_name="Protector",attrs=[2,1,0,-1,0,1],pairs=[("Life","Healing Spell"),("Blades","Melee Technique")],class_discs=["Protection","Armor"],zero=[card(x) for x in UTILITY],one=[card(x) for x in ["Medium Armor Training","Shield Training","First Aid Expertise","Escape Expertise","Navigation Expertise"]]),
  dict(name="Summoner with utility",class_name="Arcanist",attrs=[-1,0,1,0,2,1],pairs=[("Summon","Summon Ally"),("Lore","Forage Forest")],class_discs=["Energy","Fire"],zero=[card(x) for x in ["Craft Mundane","Derive Mundane Recipe","Identify Potions","Climbing Expertise","Observation Expertise"]],one=[card(x) for x in ["Fire Attack","Identify Magic","Swimming Expertise","Social Expertise","First Aid Expertise"]]),
  dict(name="Duplicate package stress test",class_name="Intellect",attrs=[0,0,0,1,2,0],pairs=[("Lore","Forage Forest"),("Lore","Forage Forest")],class_discs=["Lore","Armor"],zero=[card(x) for x in UTILITY+["Craft Mundane"]],one=[disc("Blades","home"),card("Melee Technique"),card("Medium Armor Training"),card("Derive Mundane Recipe"),card("Identify Potions"),card("First Aid Expertise")]),
  dict(name="Low Brawn ranger",class_name="Blade",attrs=[-2,0,2,1,1,1],pairs=[("Archery","Ranged Technique"),("Lore","Forage Forest")],class_discs=["Armor","Stealth"],zero=[card(x) for x in ["Craft Mundane","Derive Mundane Recipe","Identify Potions","Climbing Expertise","Observation Expertise"]],one=[card(x) for x in ["Medium Armor Training","Stealth Expertise","Navigation Expertise","Animal Care","Wilderness Shelter"]]),
 ]


def create(f):
 attrs=f["attrs"]
 assert sum(attrs)==3 and all(-2<=a<=2 for a in attrs)
 ranks={}; learned=set(); gear=set(); ledger=[]; duplicates=[0,0]; remaining=[0,0]
 def grant_d(name,stage):
  if name in ranks: duplicates[stage]+=1
  else: ranks[name]=1
 def grant_c(name,stage):
  req,items=CARDS[name]
  assert req is None or ranks.get(req,0)>=1,(f["name"],name,"unsupported grant")
  if name in learned: duplicates[stage]+=1
  else:
   learned.add(name); gear.update(items)
 for d,c in f["pairs"]:
  grant_d(d,0); grant_c(c,0)
 for stage,key in enumerate(("zero","one")):
  if stage==1:
   for d in f["class_discs"]: grant_d(d,1)
   learned.add("Class Signature")
  funds=10+duplicates[stage]
  for purchase in f[key]:
   kind,name,*rest=purchase
   if kind=="discipline":
    assert stage==1,"Level 0 cannot purchase disciplines"
    old=ranks.get(name,0)
    assert old<3
    cost=COSTS[rest[0]][old]
    ranks[name]=old+1
   else:
    assert name not in learned
    req,items=CARDS[name]
    assert req is None or ranks.get(req,0)>=1,(f["name"],name,"missing prerequisite")
    learned.add(name); gear.update(items); cost=2
   funds-=cost
   assert funds>=0,(f["name"],"overspent")
   ledger.append(dict(stage=stage,purchase=name,kind=kind,cost=cost,remaining=funds))
  remaining[stage]=funds
 # One physical weapon can support multiple compatible cards. Exact grant counts need final cards.
 carried=sorted(gear)+["food","light","rope","healing potion"]
 capacity=10+3*attrs[0]
 bulk=len(carried)
 return dict(**f,disciplines=ranks,learned_cards=sorted(learned),universal_cards=11,
  selected_ancestry_traits=2,duplicate_dp=duplicates,expired_dp=remaining,ledger=ledger,
  physical_inventory=carried,bulk=bulk,capacity=capacity,encumbrance=max(0,bulk-capacity),
  assumed_ancestry_speed=6,speed=max(0,6+attrs[2]-max(0,bulk-capacity)),
  hp_expression=f"base + ancestry + class + ({attrs[1]}) + trait/card increases",
  note="All cards, grants, and discipline affinities in this fixture are illustrative; four travel supplies are assumed acquisitions, not automatic grants.")


def main():
 OUT.mkdir(exist_ok=True)
 builds=[create(f) for f in fixtures()]
 from copy import deepcopy
 invalid=[]
 f=deepcopy(fixtures()[0]);f['attrs'][0]=1;invalid.append(f)
 f=deepcopy(fixtures()[0]);f['zero'].append(disc('Fire'));invalid.append(f)
 f=deepcopy(fixtures()[0]);f['zero'].append(card('First Aid Expertise'));invalid.append(f)
 f=deepcopy(fixtures()[0]);f['zero'][1]=f['zero'][0];invalid.append(f)
 f=deepcopy(fixtures()[0]);f['pairs'][0]=('Fire','Melee Technique');invalid.append(f)
 for f in invalid:
  try:create(f)
  except AssertionError:pass
  else:raise AssertionError('Invalid build was accepted')
 (OUT/"characters.json").write_text(json.dumps(builds,indent=2)+"\n")
 write_csv("characters.csv",[dict(name=b["name"],class_name=b["class_name"],attributes="/".join(map(str,b["attrs"])),
  disciplines=len(b["disciplines"]),learned_cards=len(b["learned_cards"]),universal_cards=11,
  duplicate_dp0=b["duplicate_dp"][0],duplicate_dp1=b["duplicate_dp"][1],expired_dp0=b["expired_dp"][0],expired_dp1=b["expired_dp"][1],
  capacity=b["capacity"],bulk=b["bulk"],encumbrance=b["encumbrance"],speed=b["speed"]) for b in builds])
 progress=[]; cumulative=20
 for level in range(1,11):
  award=10 if level==1 else 8+level
  if level>1:cumulative+=award
  progress.append(dict(level=level,award=award,cumulative_purchased_dp=cumulative,
   maximum_novice_cards_from_award=award//2,maximum_adept_cards_from_award=award//4 if level>=3 else 0,
   maximum_master_cards_from_award=award//8 if level>=7 else 0,
   grit_granted_to_date=2+(level>=3)+(level>=7),signature_cards_granted=1+(level>=3)+(level>=7)))
 write_csv("progression.csv",progress)
 paths=[]
 for category,costs in COSTS.items():
  for rank in (1,2,3):
   for owned in (0,1):
    if owned>rank:continue
    paths.append(dict(category=category,target_rank=rank,starting_rank=owned,
      discipline_cost=sum(costs[owned:rank]),one_card_total=sum(costs[owned:rank])+(2,4,8)[rank-1]))
 write_csv("training_paths.csv",paths)
 arrays=[a for a in itertools.product(range(-2,3),repeat=6) if sum(a)==3]
 counts={"valid_labeled_attribute_arrays":len(arrays),"with_at_least_one_minus_two":sum(-2 in a for a in arrays),
  "with_four_plus_twos":sum(a.count(2)==4 for a in arrays),"ledgers_validated":len(builds),"invalid_builds_rejected":len(invalid),
  "attribute_order":["Brawn","Fortitude","Agility","Guile","Knowledge","Reason"]}
 (OUT/"creation_validation.json").write_text(json.dumps(counts,indent=2)+"\n")
 print(json.dumps(counts))


if __name__=="__main__":main()
