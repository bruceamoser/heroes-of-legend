#!/usr/bin/env python3
"""Duration anchors, not difficulty ratings or approved monster statistics."""
import itertools
import json
from dataclasses import asdict
from study import Scenario,run_scenario,write_csv,OUT


def main():
 configs=[]
 for label,hp,packet in (("short",10,(2,4,6)),("medium",14,(3,5,7)),("long",24,(4,6,8))):
  for basics,policy,target in itertools.product((0,2),("attack","healer","potion"),("focus","spread")):
   configs.append(Scenario(f"anchor_{label}_basic{basics}_{policy}_{target}",enemy_hp=hp,enemy_damage=packet,
    basic_users=basics,policy=policy,enemy_target=target,round_cap=80))
 (OUT/"calibration_scenarios.json").write_text(json.dumps([asdict(s) for s in configs],indent=2)+"\n")
 write_csv("calibration.csv",[run_scenario(s,2000) for s in configs])
 print(f"Done: {len(configs)*2000} calibration encounters",flush=True)


if __name__=="__main__":main()
