"""Reproducible bounded mapped comparisons; results kept separate from v0.2."""
import json,itertools,hashlib,time,copy
from concurrent.futures import ProcessPoolExecutor
import multiprocessing
from collections import Counter
from pathlib import Path
from engine import *
from mechanics import treat,grapple_attack_net
OUT=Path(__file__).parent/'results';OUT.mkdir(exist_ok=True)
def scenarios():
 base=dict(board='open',hand_policy='drop_shield',healing='one',potions=False)
 for board,hand,potions,healing in itertools.product(['open','door'],['ignore','drop_shield','drop_weapon','stow','prepared'],[False,True],['none','one']):
  yield dict(base,board=board,hand_policy=hand,potions=potions,healing=healing,group='hands')
 for board,hand in itertools.product(['open','door'],['drop_weapon','stow']):yield dict(base,board=board,hand_policy=hand,potions=True,twohanded=True,group='twohanded')
 for board,layer in itertools.product(['open','door'],['opportunity','riders','enemy_push','wounds']):yield dict(base,board=board,**{layer:True},group='layer',layer=layer)
 for board in ['open','door','rough']:yield dict(base,board=board,group='mapped_baseline')
 for board in ['open','door']:
  yield dict(base,board=board,signatures=True,group='signature_default')
  for cl,index in itertools.product(['Protector','Blade','Arcanist','Shepherd'],range(3)):
   yield dict(base,board=board,signatures=True,signature=[cl,index],group='signature')
 for board,replace in itertools.product(['open','door'],[False,True]):yield dict(base,board=board,summons=True,summon_replace=replace,group='summons')
 for board,level,choice in itertools.product(['open','door'],[3,7],['novice','highest','adaptive']):yield dict(base,board=board,level=level,healing_choice=choice,group='healing_choice')

def campaigns(n=150):
 rows=[]
 for board,active,treatment in itertools.product(['open','door'],[False,True],[False,True]):
  if treatment and not active:continue
  s=dict(board=board,hand_policy='drop_shield',healing='one',wounds=active)
  rng=seed('mapped-campaign'+json.dumps(s,sort_keys=True)+str(treatment));totals=[Counter() for _ in range(5)]
  for _ in range(n):
   party=None
   for day in range(5):
    enc=Encounter(s,rng,party);m,party=enc.run();t=totals[day];t.update(m);t['reached']+=1
    complete=m['win'] and not any(p['terminal'] for p in party);t['complete']+=int(complete)
    if complete and treatment:
     for a in party:
      for w in a['injuries']:
       if w['treated'] or not w['rv']:continue
       capable=[(b,CARDS[c]) for b in party for c in b['b']['cards'] if CARDS[c].get('treatment')==w['remedy'].split(';')[0]]
       if capable:
        b,c=max(capable,key=lambda v:v[0]['b']['attrs'][v[1]['attribute']]);tier,_,_=roll(rng,b['b']['attrs'][c['attribute']],-enc.banes(b,'mental'))
        t['treatments']+=1
        if treat(w,c['treatment'],day,tier+1):t['relieved']+=1
    t['scars']+=sum(p['scars'] for p in party);t['grit_left']+=sum(p['grit'] for p in party)
    if not complete:break
  for day,t in enumerate(totals):rows.append(dict(board=board,wounds=active,treatment=treatment,encounter=day+1,sequences=n,reached=t['reached'],completion=t['complete']/n,scars=t['scars']/t['reached'] if t['reached'] else None,grit_left=t['grit_left']/t['reached'] if t['reached'] else None,treatments=t['treatments'],relieved=t['relieved'],unresolved_group_collisions=t['unresolved_group_collisions']))
 return rows

def isolated(s):return run_scenario(s,500)

if __name__=='__main__':
 rows=[];ss=list(scenarios())
 with ProcessPoolExecutor(max_workers=4,mp_context=multiprocessing.get_context("fork")) as pool:
  for i,row in enumerate(pool.map(isolated,ss)):
   rows.append(row)
   if (i+1)%10==0:print(f'Mapped comparisons {i+1}/{len(ss)}',flush=True)
 (OUT/'encounters.json').write_text(json.dumps(rows,indent=2)+'\n')
 cc=campaigns();(OUT/'campaigns.json').write_text(json.dumps(cc,indent=2)+'\n')
 local=[]
 for rating in range(4):local.append(dict(grapple_rating=rating,net_attack_boons=grapple_attack_net(rating),basic_mean_damage_vs_res2=mean_damage([2,3,5],0,grapple_attack_net(rating),2)))
 (OUT/'grapple-vulnerability.json').write_text(json.dumps(local,indent=2)+'\n')
 print(f'{len(ss)*500} mapped encounters; {sum(r["reached"] for r in cc)} campaign encounters',flush=True)
