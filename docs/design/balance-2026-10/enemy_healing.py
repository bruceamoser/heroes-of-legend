#!/usr/bin/env python3
"""Hypothetical enemy healing: explicit fixed-output Main Action, not an agreed NPC spell rule."""
import itertools
import json
from dataclasses import asdict
from study import Scenario,run_scenario,write_csv,OUT


def main():
 configs=[]
 for count,fraction,policy,hunt in itertools.product((0,1,2,4),(0.5,1.0),("attack","healer","all_heal","potion"),(False,True)):
  configs.append(Scenario(f"enemyheal_n{count}_f{fraction}_{policy}_hunt{int(hunt)}",npc_healers=count,
    npc_heal_fraction=fraction,policy=policy,hunt_healers=hunt,round_cap=80))
 for fraction,policy in itertools.product((0.5,1.0),("attack","healer","all_heal","potion")):
  configs.append(Scenario(f"soloheal_f{fraction}_{policy}",enemy_count=1,enemy_hp=48,npc_healers=1,
    npc_heal_fraction=fraction,policy=policy,round_cap=80))
 (OUT/"enemy_healing_scenarios.json").write_text(json.dumps([asdict(s) for s in configs],indent=2)+"\n")
 rows=[]
 for i,s in enumerate(configs,1):
  rows.append(run_scenario(s,2000))
  if i%16==0:print(f"Enemy healing {i}/{len(configs)}",flush=True)
 write_csv("enemy_healing.csv",rows)
 print(f"Done: {len(configs)*2000} enemy-healing encounters",flush=True)


if __name__=="__main__":main()
