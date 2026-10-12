#!/usr/bin/env python3
"""Alternative legal spending plans show choices, not just one shopping algorithm."""
import json
from copy import deepcopy
from catalog import ROOT,CARDS
from builds import build,CONFIG,get_card,rank,category,COSTS,finalize,eligible
OUT=ROOT/'results'
def buy(b,id):
 if id in b['cards'] and not CARDS[id].get('repeat'):return
 for d,r in CARDS[id]['req'].items():
  while b['ranks'].get(d,0)<r:
   cost=COSTS[category(b['class_name'],d)][b['ranks'].get(d,0)]
   if b['pool']<cost+CARDS[id]['cost']:return
   rank(b,d)
 if eligible(b,id) and b['pool']>=CARDS[id]['cost']:get_card(b,id)
def main():
 craft=build(('Intellect','Human',[-1,0,0,0,2,2],'Frontier',0,'Apprentice',0,['Lore','Craft']))
 assert all(id in craft[0]['cards'] for id in ['forage','craft'])
 (OUT/'craft-route.json').write_text(json.dumps(craft,indent=2)+'\n')
 out=[]
 for cl,plan in [('Protector','durability'),('Blade','durability'),('Arcanist','specialist'),('Shepherd','support')]:
  base=build(next(c for c in CONFIG if c[0]==cl))[0]
  # Derived summary fields are recomputed, never treated as additional permanent bonuses.
  b={k:deepcopy(v) for k,v in base.items() if k not in ['hp','bulk','capacity','encumbrance','speed','resistance','bank']}
  for level in range(2,8):
   b['level']=level;b['pool']+=8+level;b['ledger'].append(dict(level=level,kind='award',id='level',cost=-(8+level),balance=b['pool']))
   if level in (3,7):b['grit']+=1;get_card(b,f'sig_{cl.lower()}_{level}_1',True)
   if plan=='durability':wanted=['hp','heavy','shield','adept_strike' if level<7 else 'master_strike']
   elif plan=='specialist':wanted=['adept_fire' if level<7 else 'master_fire','hands','summon','identify','grit']
   else:wanted=['physical','mental','expose','shield','hp','grit']
   for id in wanted:
    if CARDS[id]['level']<=level:buy(b,id)
   if level in (3,7):out.append(dict(plan=plan,**finalize(b)))
 (OUT/'variants.json').write_text(json.dumps(out,indent=2)+'\n')
 rows=['# Alternative advancement choices','','These share the validated level-1 starts, then spend differently. The durability','plans buy Toughened once per level from level 2, not retroactively at level 1.','All grants are counted as carried in this deliberately conservative inventory','audit; redundant medium armor can be left behind when heavy armor is acquired.','', '| Class | Plan | Level | HP | Resistance | Bank | Bulk / capacity |','|---|---|---:|---:|---:|---:|---|']
 for b in out:rows.append(f'| {b["class_name"]} | {b["plan"]} | {b["level"]} | {b["hp"]} | {b["resistance"]} | {b["bank"]} | {b["bulk"]}/{b["capacity"]} |')
 rows+=['','These eight additional snapshots validate spending trade-offs; they are not','included in the primary combat sweep. HP cards can be affordable at higher levels,','so the once-per-level restriction should be evaluated alongside the opportunity','cost of 2 DP. Specialized purchases can leave more banked DP in this small catalog.','']
 (OUT/'variants.md').write_text('\n'.join(rows));print(f'{len(out)} alternative advancement snapshots')
if __name__=='__main__':main()
