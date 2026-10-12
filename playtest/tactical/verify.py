"""Validate provenance, accounting, and representative deterministic replays."""
import hashlib,json
from pathlib import Path
from engine import run_scenario
ROOT=Path(__file__).resolve().parent;PLAY=ROOT.parent;OUT=ROOT/'results'
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 m=json.loads((OUT/'manifest.json').read_text())
 for p,h in m['source_sha256'].items():assert digest(PLAY/p)==h,p
 for p,h in m['output_sha256'].items():assert digest(OUT/p)==h,p
 assert digest(PLAY/'history/v0.2.tar.gz')==m['historical_v02_sha256']
 rows=json.loads((OUT/'encounters.json').read_text());campaign=json.loads((OUT/'campaigns.json').read_text())
 assert len(rows)==m['configurations']==97
 assert sum(r['trials'] for r in rows)==m['isolated_encounters']==48500
 for r in rows:
  assert r['trials']==500
  assert abs(sum(r.get(k,0) for k in ('win','loss','timeout'))-1)<1e-9
  assert 0<=r.get('any_wound',0)<=1
  assert 0<=r.get('any_terminal',0)<=1
 assert len(campaign)==30
 assert sum(r['reached'] for r in campaign)==m['campaign_encounters']
 assert sum(r['sequences'] for r in campaign if r['encounter']==1)==m['campaign_sequences']==900
 assert m['total_encounters']==m['campaign_encounters']+m['isolated_encounters']
 for r in campaign:
  assert 0<=r['completion']<=r['reached']/r['sequences']<=1
 seen=set();replayed=[]
 for r in rows:
  s=r['scenario'];key=(s['group'],s['board'])
  if key in seen:continue
  seen.add(key)
  assert run_scenario(s,r['trials'])==r,s
  replayed.append(s)
 result=dict(status='passed',configurations=len(rows),encounters=m['total_encounters'],source_hashes=len(m['source_sha256']),output_hashes=len(m['output_sha256']),deterministic_replays=len(replayed),replayed_scenarios=replayed)
 (OUT/'verification.json').write_text(json.dumps(result,indent=2)+'\n')
 print({k:v for k,v in result.items() if k!='replayed_scenarios'})
if __name__=='__main__':main()
