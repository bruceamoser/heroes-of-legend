"""Targeted v0.2 experiments: one changed feature at a time, plus wound overlays."""
import itertools,json,copy
from collections import Counter
from catalog import ROOT,CARDS
from combat import run,battle,new_party,fixture,seed,roll
from mechanics import treat,wound_tables
OUT=ROOT/'results'
def scenarios():
 base=dict(level=1,count=4,ehp=14,eres=1,damage=[5,6,8],profile='new',target='spread',policy='none',group='revision')
 for policy,life_res in itertools.product(['none','one','all'],[0,1,2,3]):yield dict(base,policy=policy,pc_life_res=life_res,case='life_resistance')
 for profile,res,only,policy in itertools.product([[2,3,5],[3,4,6]],[1,3],[False,True],['none','one']):yield dict(base,basic_profile=profile,eres=res,basic_only=only,policy=policy,case='basic_damage')
 for amount,policy in itertools.product([6,10,16],['none','one']):yield dict(base,potions=True,potion_healing=amount,policy=policy,case='potions')
 for level,tier,policy in itertools.product([3,7],[1,3,7],['one']):
  if tier<=level:yield dict(base,level=level,healing_tier=tier,policy=policy,case='learned_healing_tier')
 for enemy_tier in [1,3,7]:yield dict(base,count=1,ehp=48,enemy_healers=1,enemy_threshold=.75,enemy_healing_tier=enemy_tier,policy='one',case='enemy_tier')
 for kind,policy in itertools.product(['physical','fire','cold','mental','radiant','life'],['none','one']):
  for active in [False,True]:yield dict(base,enemy_type=kind,policy=policy,active_wounds=active,case='wound_overlay')
 for res in [0,1,2,3]:yield dict(base,burn=True,pc_fire_res=res,policy='one',case='burn_decay')

def wound_campaigns(n=500):
 rows=[]
 for kind,treatment in itertools.product(['physical','mental','fire'],[False,True]):
  s=dict(count=4,ehp=14,eres=1,damage=[5,6,8],policy='one',target='spread',active_wounds=True,enemy_type=kind)
  rng=seed('v0.2 wound campaign'+json.dumps(s,sort_keys=True)+str(treatment));totals=[Counter() for _ in range(10)]
  for _ in range(n):
   party=new_party(fixture(),s)
   for day in range(10):
    m,party=battle(s,rng,party);t=totals[day];t.update(m);t['reached']+=1;t['full_party']+=int(m['win'] and not m['any_terminal'])
    # Explicit assumption: a safe day's downtime after each encounter; only
    # actually learned treatment capabilities, once per wound across all healers.
    if treatment and m['win'] and not m['any_terminal']:
     for pc in party:
      for w in pc['injuries']:
       if w['treated'] or w['rv'] is None:continue
       capable=[(q,c) for q in party if not q['terminal'] and q['hp']>0 for id in q['build']['cards'] for c in [CARDS[id]] if c.get('treatment')==w['remedy'].split(';')[0]]
       if capable:
        q,c=max(capable,key=lambda qc:qc[0]['build']['attrs'][qc[1]['attribute']])
        tier,_,_=roll(rng,q['build']['attrs'][c['attribute']]);t['treatments']+=1
        if treat(w,c['treatment'],day,tier+1):t['relieved']+=1
    t['grit_left']+=sum(p['grit'] for p in party if not p['terminal']);t['scars']+=sum(p['wounds'] for p in party)
    t['untreated']+=sum(not w['treated'] and bool(w['lasting']) for p in party for w in p['injuries'])
    if not m['win'] or m['any_terminal']:break
  for day,t in enumerate(totals):
   rows.append(dict(source=kind,treatment=treatment,encounter=day+1,sequences=n,reached=t['reached'],full_party_completion=t['full_party']/n,treatment_attempts=t['treatments'],relieved=t['relieved'],mean_grit=t['grit_left']/t['reached'] if t['reached'] else None,mean_scars=t['scars']/t['reached'] if t['reached'] else None,mean_untreated=t['untreated']/t['reached'] if t['reached'] else None))
 return rows
if __name__=='__main__':
 ss=list(scenarios());rows=[]
 for i,s in enumerate(ss):
  rows.append(run(s,3000))
  if (i+1)%10==0:print(f'Revised scenarios {i+1}/{len(ss)}',flush=True)
 (OUT/'revision.json').write_text(json.dumps(rows,indent=2)+'\n')
 rows=wound_campaigns();(OUT/'wound-campaigns.json').write_text(json.dumps(rows,indent=2)+'\n')
 print(f'{len(ss)*3000} isolated encounters; {sum(r["reached"] for r in rows)} wound-overlay campaign encounters',flush=True)
