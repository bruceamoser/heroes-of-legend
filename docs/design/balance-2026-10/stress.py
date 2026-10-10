#!/usr/bin/env python3
"""Second pass: pressure thresholds and model sensitivities, not approved creatures."""
import itertools
import json
from dataclasses import asdict,replace
from study import Scenario,run_scenario,write_csv,OUT


def main():
 base=Scenario("stress",round_cap=80)
 configs=[]
 for n,hp,damage,policy in itertools.product((4,8,12),(12,20,28),((2,4,6),(4,6,8)),("attack","healer","all_heal","potion")):
  configs.append(replace(base,name=f"stress_n{n}_h{hp}_d{damage[1]}_{policy}",enemy_count=n,enemy_hp=hp,enemy_damage=damage,policy=policy))
 for n,policy,target in itertools.product((4,8),("attack","healer","all_heal","potion"),("focus","spread","finish")):
  configs.append(replace(base,name=f"denied_support_n{n}_{policy}_{target}",enemy_count=n,policy=policy,enemy_target=target,support="self"))
 for n,policy,wounds,grit in itertools.product((4,8),("attack","healer","potion"),(0,5),(0,2)):
  configs.append(replace(base,name=f"attrition_n{n}_{policy}_w{wounds}_g{grit}",enemy_count=n,policy=policy,initial_wounds=wounds,initial_grit=grit))
 for n,bane,policy in itertools.product((4,8),(1,2,3),("attack","healer","potion")):
  configs.append(replace(base,name=f"elite_n{n}_b{bane}_{policy}",enemy_count=n,enemy_hp=16,enemy_offense_banes=bane,enemy_defense_banes=bane,policy=policy))
 (OUT/"stress_scenarios.json").write_text(json.dumps([asdict(s) for s in configs],indent=2)+"\n")
 rows=[]
 for i,s in enumerate(configs,1):
  rows.append(run_scenario(s,2000))
  if i%30==0:print(f"Stress {i}/{len(configs)}",flush=True)
 write_csv("stress.csv",rows)
 print(f"Done: {len(configs)*2000} stress encounters",flush=True)


if __name__=="__main__":main()
