#!/usr/bin/env python3
"""Cross-file validation of the delivered specification and saved experiments."""
import argparse,hashlib,json,re,subprocess
from pathlib import Path
from catalog import ROOT,CAT,CARDS,CLASSES,render
from builds import validate,ITEM_BULK
OUT=ROOT/'results'
def load(p):return json.loads(p.read_text())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--replay',action='store_true');args=ap.parse_args()
 counts={};counts['invalid_build_checks']=validate()
 # Regeneration must be byte-identical to committed human-readable tables.
 names=['catalog.json','ancestry.md','culture-background.md','class.md','discipline.md','abilities.md']
 before={n:(ROOT/n).read_bytes() for n in names};render();assert all((ROOT/n).read_bytes()==b for n,b in before.items())
 counts['generated_files']=len(names)
 for cl in CLASSES:
  for lvl in (1,3,7):assert sum(c.get('class_only')==cl and c['level']==lvl for c in CARDS.values())==3
 counts['signature_choice_sets']=27
 builds=sum([load(OUT/n) for n in ['builds.json','variants.json','craft-route.json']],[])
 for b in builds:
  balance=0
  for entry in b['ledger']:
   balance-=entry['cost'];assert balance==entry['balance'],(b['class_name'],entry)
   assert balance>=0
  assert balance==b['bank']
  assert all(b['attrs'][a]>=0 for a in CLASSES[b['class_name']]['req'])
  assert sum(b['attrs'].values())==3
  assert len(b['gear'])==len(set(b['gear']))
  assert b['bulk']==sum(ITEM_BULK[x] for x in b['gear'])
  assert b['capacity']==10+3*b['attrs']['Brawn']
  assert b['encumbrance']==max(0,b['bulk']-b['capacity'])
  for id in b['cards']:
   c=CARDS[id];assert all(b['ranks'].get(d,0)>=r for d,r in c['req'].items())
   assert not c.get('class_only') or c['class_only']==b['class_name']
   assert c['level']<=b['level']
 counts['build_snapshots']=len(builds)
 scenarios=sum([load(OUT/n) for n in ['combat.json','refinement.json','advanced.json','healing-timing.json']],[])
 ids=[]
 for r in scenarios:
  assert r['trials']>0
  assert hashlib.sha256(json.dumps(r['scenario'],sort_keys=True).encode()).hexdigest()[:12]==r['id']
  assert all(r[k]==v for k,v in r['scenario'].items())
  assert abs(r['win']+r['loss']+r['timeout']-1)<1e-9
  assert 0<=r['any_wound']<=1 and 0<=r['any_terminal']<=1
  assert r['wounds']+1e-9>=r['any_wound']
  assert 1<=r['rounds']<=40
  ids.append(r['id'])
 counts['scenario_records']=len(scenarios)
 campaign=load(OUT/'campaigns.json');manifest=load(OUT/'manifest.json')
 assert manifest['isolated_encounters']==sum(r['trials'] for r in scenarios)
 assert manifest['total_encounters']==manifest['isolated_encounters']+sum(r['reached'] for r in campaign)
 assert manifest['build_snapshots']==len(builds)
 assert manifest['catalog_cards']==len(CARDS)
 counts['total_encounters']=manifest['total_encounters']
 for name,digest in manifest['input_sha256'].items():assert hashlib.sha256((ROOT/name).read_bytes()).hexdigest()==digest,('changed input',name)
 counts['input_hashes']=len(manifest['input_sha256'])
 if args.replay:
  from combat import run
  output={'id','trials','win','loss','timeout','rounds','any_wound','wounds','any_terminal','grit','heals','healed_hp','potions','attacks','enemy_attacks','opportunities','interrupted','enemy_heals','burn_ticks','win_rounds'}
  selected={}
  for r in scenarios:
   key=(r['group'],r.get('layer'),r.get('composition'))
   selected.setdefault(key,r)
  for r in selected.values():
   inputs=r['scenario']
   assert run(inputs,r['trials'])==r,('replay mismatch',r['id'])
  counts['deterministic_replays']=len(selected)

 links=0
 for p in ROOT.rglob('*.md'):
  for target in re.findall(r'\]\(([^)]+)\)',p.read_text()):
   if '://' in target or target.startswith('#'):continue
   path=target.split('#')[0];assert (p.parent/path).exists(),(p,target);links+=1
 counts['local_links']=links
 archive=load(ROOT/'legacy/manifest.json')
 for f in archive['files']:
  old=subprocess.check_output(['git','show',archive['commit']+':'+f['path']])
  assert hashlib.sha256(old).hexdigest()==f['sha256']
 counts['archived_chapters']=len(archive['files'])
 # Actual tabletop gates that the simplified encounter engine does not enforce
 # remain visibly declared exclusions in the test contract.
 contract=(ROOT/'tests/README.md').read_text()
 for term in ['no map','no signature','Active wound penalties','provisional','Strong-interrupt']:assert term in contract,term
 counts['model_limitations_checked']=5
 (OUT/'verification.json').write_text(json.dumps(counts,indent=2)+'\n');print(json.dumps(counts))
if __name__=='__main__':main()
