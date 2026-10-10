#!/usr/bin/env python3
"""Cross-check saved evidence, scenario coverage, and report links."""
import csv
import json
import math
import re
from pathlib import Path

ROOT=Path(__file__).parent
OUT=ROOT/"outputs"


def main():
 count=0
 for result,config in [("combat.csv","scenarios.json"),("stress.csv","stress_scenarios.json"),
                      ("calibration.csv","calibration_scenarios.json"),("enemy_healing.csv","enemy_healing_scenarios.json")]:
  inputs={s['name']:s for s in json.loads((OUT/config).read_text())}
  with (OUT/result).open() as f:rows=list(csv.DictReader(f))
  assert len(rows)==len(inputs)==len({r['scenario'] for r in rows})
  assert set(inputs)=={r['scenario'] for r in rows}
  for r in rows:
   s=inputs[r['scenario']]
   assert int(r['trials'])==2000
   assert abs(sum(float(r[x]) for x in ('win','loss','timeout'))-1)<1e-10
   assert all(0<=float(r[x])<=1 for x in ('win','loss','timeout','any_wound','any_terminal'))
   assert 1<=float(r['rounds'])<=s['round_cap']
   assert 0<=float(r['grit'])<=s['party_size']*s['initial_grit']
   assert 0<=float(r['living'])<=s['party_size']
   for value in r.values():
    if value and value!=r['scenario']:assert math.isfinite(float(value))
   count+=1
 # The illustrative solo's half-heal exceeds maximum direct damage per round.
 with (OUT/'enemy_healing.csv').open() as f:
  solo=[r for r in csv.DictReader(f) if r['scenario'].startswith('soloheal_')]
 assert len(solo)==8 and all(float(r['win'])==0 for r in solo)
 # Conservation and permission checks for creation ledgers.
 builds=json.loads((OUT/'characters.json').read_text())
 for b in builds:
  assert sum(b['attrs'])==3
  assert len(b['learned_cards'])==len(set(b['learned_cards']))
  for stage in (0,1):
   purchases=[p for p in b['ledger'] if p['stage']==stage]
   assert sum(p['cost'] for p in purchases)+b['expired_dp'][stage]==10+b['duplicate_dp'][stage]
  assert not any(p['kind']=='discipline' and p['stage']==0 for p in b['ledger'])
  assert b['bulk']==len(b['physical_inventory'])
  assert b['capacity']==10+3*b['attrs'][0]
 # Check local document links; no external calls or dependence on a renderer.
 links=0
 for doc in ROOT.glob('*.md'):
  for target in re.findall(r'\]\(([^)]+)\)',doc.read_text()):
   if '://' in target or target.startswith('#'):continue
   assert (doc.parent/target.split('#')[0]).exists(),(doc,target)
   links+=1
 print(f'Validated {count} scenario records, {len(builds)} creation ledgers, 8 solo bounds, and {links} local links.')


if __name__=='__main__':main()
