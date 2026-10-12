#!/usr/bin/env python3
"""Investigate the surprising solo-healing/attack-timing discontinuity."""
import json,random
from combat import run,battle
from catalog import ROOT
OUT=ROOT/'results'
if __name__=='__main__':
 rows=[];traces=[]
 for level in [1,3,7]:
  for threshold in [.25,.5,.75,.9]:
   s=dict(level=level,composition='mixed',count=1,ehp=48,eres=1,damage=[4,5,7],profile='new',target='focus',policy='one',enemy_healers=1,enemy_threshold=threshold,group='healing_timing')
   rows.append(run(s,3000))
   if threshold==.5:
    trace=[];m,_=battle(s,random.Random(12),trace=trace);traces.append(dict(scenario=s,seed=12,result=dict(m),turns=trace))
 (OUT/'healing-timing.json').write_text(json.dumps(rows,indent=2)+'\n')
 (OUT/'boss-traces.json').write_text(json.dumps(traces,indent=2)+'\n')
 print(f'{len(rows)*3000} timing encounters; {len(traces)} saved turn traces',flush=True)
