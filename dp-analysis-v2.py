"""DP Economy v2 — Corrected attributes + Discipline purchases."""
LEVELS=10; ADEPT=3; MASTER=7; HP_BASE=10; STARTING_GENERAL=3
SKILL_COST={1:1,2:2,3:3}; ABILITY_COST={1:1,2:2,3:4}; DISC_COST=1

def dp_avail(lvl,budget):
    if lvl==1: return budget*2
    return budget*2+budget*(lvl-1)

def spent(plan,upto):
    t=0
    for it in plan:
        for i,ti in enumerate(it.get("tiers",[])):
            if ti>0 and it["levels"][i]<=upto:
                ct=ABILITY_COST if it["type"]=="ability" else SKILL_COST
                t+=ct.get(ti,0)
        if it["type"]=="discipline" and it.get("level",99)<=upto:
            t+=DISC_COST
    return t

def fmt(a):
    return ", ".join(f"{k} {v:+d}" for k,v in a.items())

chars=[
{"name":"Borin — Dwarf Fighter (Sword & Board)",
 "concept":"Walking fortress. Shield up, never goes down.",
 "attrs":{"Brawn":+2,"Fortitude":+2,"Agility":0,"Guile":-1,"Knowledge":-1,"Reason":-1},
 "cdiscs":["Blade","Armor","Protection"],"adiscs":["Earth"],"bdiscs":["Heavy Weapon"],
 "plan":[
  {"type":"discipline","name":"Armor (2nd)","level":3},
  {"type":"skill","name":"Melee (Blade)","tiers":[1,2,3],"levels":[1,3,7]},
  {"type":"skill","name":"Athletics","tiers":[1,2,3],"levels":[1,4,9]},
  {"type":"skill","name":"Endurance","tiers":[1,2],"levels":[1,5]},
  {"type":"skill","name":"Intimidation","tiers":[1],"levels":[1]},
  {"type":"ability","name":"Shield Block","tiers":[1,2],"levels":[1,5]},
  {"type":"ability","name":"Power Attack","tiers":[1,2,3],"levels":[2,4,8]},
  {"type":"ability","name":"Second Wind","tiers":[1],"levels":[2]},
  {"type":"ability","name":"Iron Will","tiers":[1],"levels":[6]},
  {"type":"ability","name":"Bulwark Stance","tiers":[1,2],"levels":[7,9]},
 ]},
{"name":"Kara — Human Fighter (Great Weapon)",
 "concept":"One big weapon. Charges in, cleaves through.",
 "attrs":{"Brawn":+2,"Fortitude":+1,"Agility":+1,"Guile":-1,"Knowledge":-1,"Reason":0},
 "cdiscs":["Blade","Heavy Weapon","Armor"],"adiscs":["General"],"bdiscs":["Axe"],
 "plan":[
  {"type":"discipline","name":"Heavy Wpn (2nd)","level":2},
  {"type":"skill","name":"Melee (Heavy Wpn)","tiers":[1,2,3],"levels":[1,3,7]},
  {"type":"skill","name":"Athletics","tiers":[1,2],"levels":[1,4]},
  {"type":"skill","name":"Intimidation","tiers":[1,2],"levels":[1,5]},
  {"type":"ability","name":"Cleave","tiers":[1,2,3],"levels":[1,4,8]},
  {"type":"ability","name":"Mighty Blow","tiers":[1,2],"levels":[3,6]},
  {"type":"ability","name":"Battle Cry","tiers":[1],"levels":[3]},
  {"type":"ability","name":"Juggernaut","tiers":[1,2],"levels":[7,10]},
 ]},
{"name":"Lyra — Halfling Thief (Infiltrator)",
 "concept":"Never seen. Never caught. Locks are suggestions.",
 "attrs":{"Brawn":-1,"Fortitude":0,"Agility":+2,"Guile":+2,"Knowledge":-1,"Reason":0},
 "cdiscs":["Guile","Stealth","Archery"],"adiscs":["Guile"],"bdiscs":["Stealth"],
 "plan":[
  {"type":"discipline","name":"Stealth (2nd)","level":4},
  {"type":"discipline","name":"Acrobatics","level":6},
  {"type":"skill","name":"Stealth","tiers":[1,2,3],"levels":[1,3,7]},
  {"type":"skill","name":"Lockpicking","tiers":[1,2],"levels":[1,5]},
  {"type":"skill","name":"Perception","tiers":[1,2,3],"levels":[1,5,9]},
  {"type":"skill","name":"Acrobatics","tiers":[1,2],"levels":[0,6]},
  {"type":"ability","name":"Sneak Attack","tiers":[1,2,3],"levels":[1,4,8]},
  {"type":"ability","name":"Evasion","tiers":[1,2],"levels":[3,7]},
  {"type":"ability","name":"Pickpocket","tiers":[1],"levels":[2]},
  {"type":"ability","name":"Shadow Step","tiers":[1,2],"levels":[5,9]},
 ]},
{"name":"Vex — Elf Thief (Swashbuckler)",
 "concept":"Rapier and a smirk. Dueling as performance art.",
 "attrs":{"Brawn":0,"Fortitude":-1,"Agility":+2,"Guile":+2,"Knowledge":0,"Reason":-1},
 "cdiscs":["Blade","Guile","Acrobatics"],"adiscs":["Wind"],"bdiscs":["Charm"],
 "plan":[
  {"type":"discipline","name":"Blade (2nd)","level":3},
  {"type":"skill","name":"Melee (Blade)","tiers":[1,2,3],"levels":[1,3,7]},
  {"type":"skill","name":"Acrobatics","tiers":[1,2,3],"levels":[1,5,9]},
  {"type":"skill","name":"Charm","tiers":[1,2],"levels":[1,4]},
  {"type":"skill","name":"Perception","tiers":[1],"levels":[2]},
  {"type":"ability","name":"Riposte","tiers":[1,2,3],"levels":[1,4,8]},
  {"type":"ability","name":"Dazzling Flourish","tiers":[1,2],"levels":[3,7]},
  {"type":"ability","name":"Duelist Stance","tiers":[1],"levels":[2]},
  {"type":"ability","name":"Disarming Strike","tiers":[1,2],"levels":[5,9]},
 ]},
{"name":"Thalia — High Elf Wizard (Evoker)",
 "concept":"Fire solves most problems. For the rest: more fire.",
 "attrs":{"Brawn":-2,"Fortitude":0,"Agility":0,"Guile":0,"Knowledge":+2,"Reason":+2},
 "cdiscs":["Fire","Energy","Knowledge"],"adiscs":["Fire"],"bdiscs":["Knowledge"],
 "plan":[
  {"type":"discipline","name":"Fire (3rd)","level":5},
  {"type":"discipline","name":"Energy (2nd)","level":3},
  {"type":"discipline","name":"Energy (3rd)","level":7},
  {"type":"skill","name":"Arcana","tiers":[1,2,3],"levels":[1,3,7]},
  {"type":"skill","name":"Fire Magic","tiers":[1,2,3],"levels":[1,5,9]},
  {"type":"skill","name":"Investigation","tiers":[1,2],"levels":[1,4]},
  {"type":"skill","name":"Perception","tiers":[1],"levels":[2]},
  {"type":"ability","name":"Firebolt (N)","tiers":[1],"levels":[1]},
  {"type":"ability","name":"Fireball (A)","tiers":[2],"levels":[3]},
  {"type":"ability","name":"Volcanic Eruption (M)","tiers":[3],"levels":[7]},
  {"type":"ability","name":"Magic Missile (N)","tiers":[1],"levels":[1]},
  {"type":"ability","name":"Lightning Bolt (A)","tiers":[2],"levels":[4]},
  {"type":"ability","name":"Chain Lightning (M)","tiers":[3],"levels":[8]},
  {"type":"ability","name":"Mage Armor (N)","tiers":[1],"levels":[2]},
  {"type":"ability","name":"Counterspell (A)","tiers":[2],"levels":[6]},
 ]},
{"name":"Pip — Gnome Wizard (Controller)",
 "concept":"The battlefield is a chessboard. Pip moves the pieces.",
 "attrs":{"Brawn":-2,"Fortitude":-1,"Agility":+1,"Guile":0,"Knowledge":+2,"Reason":+2},
 "cdiscs":["Wind","Water","Knowledge"],"adiscs":["Energy"],"bdiscs":["Knowledge"],
 "plan":[
  {"type":"discipline","name":"Wind (2nd)","level":3},
  {"type":"discipline","name":"Wind (3rd)","level":6},
  {"type":"discipline","name":"Water (2nd)","level":4},
  {"type":"discipline","name":"Water (3rd)","level":7},
  {"type":"skill","name":"Arcana","tiers":[1,2,3],"levels":[1,3,7]},
  {"type":"skill","name":"Wind Magic","tiers":[1,2,3],"levels":[1,5,9]},
  {"type":"skill","name":"Water Magic","tiers":[1,2],"levels":[2,5]},
  {"type":"skill","name":"Investigation","tiers":[1],"levels":[1]},
  {"type":"ability","name":"Gust (N)","tiers":[1],"levels":[1]},
  {"type":"ability","name":"Wind Wall (A)","tiers":[2],"levels":[3]},
  {"type":"ability","name":"Cyclone (M)","tiers":[3],"levels":[7]},
  {"type":"ability","name":"Frost Ray (N)","tiers":[1],"levels":[1]},
  {"type":"ability","name":"Ice Storm (A)","tiers":[2],"levels":[4]},
  {"type":"ability","name":"Blizzard (M)","tiers":[3],"levels":[8]},
  {"type":"ability","name":"Fog Cloud (N)","tiers":[1],"levels":[2]},
  {"type":"ability","name":"Fly (A)","tiers":[2],"levels":[6]},
 ]},
]

print("HEROES OF LEGEND -- DP ECONOMY v2 (Disciplines cost 1 DP each)")
print("="*72)
print(f"Adept@L{ADEPT} Master@L{MASTER} | HP={HP_BASE}+Fort+Know | +Fort/lvl")
print(f"Skills: N=1 A=2 M=3 | Abilities: N=1 A=2 M=4 | Disciplines: 1 DP")
print(f"Double DP at L1")
print()

for c in chars:
    a=c['attrs']; hp1=HP_BASE+a['Fortitude']+a['Knowledge']
    hp10=hp1+max(1,a['Fortitude'])*9
    discs=set(c['cdiscs']+c['adiscs']+c['bdiscs'])
    db=[it for it in c['plan'] if it['type']=='discipline']
    s10=spent(c['plan'],10)
    
    print(f"  {c['name']}")
    print(f"  {c['concept']}")
    print(f"  ATTR: {fmt(a)}")
    print(f"  HP: {hp1} L1 -> {hp10} L10 | Start Discs: {', '.join(sorted(discs))} +{STARTING_GENERAL} Gen")
    if db:
        names = ', '.join(f"{d['name']} @L{d['level']}" for d in db)
        print(f"  DP Disc Buys: {names}")
    print(f"  {'Lvl':<6} {'Avail':>7} {'Spend':>7} {'Total':>7}  Purchases")
    for lvl in [1,2,3,4,5,6,7,8,9,10]:
        a8=dp_avail(lvl,8); dl=spent(c['plan'],lvl)-spent(c['plan'],lvl-1); st=spent(c['plan'],lvl)
        buys=[]
        for it in c['plan']:
            if it['type']=='discipline' and it.get('level')==lvl:
                buys.append(f"DISC:{it['name']}")
            else:
                for i,ti in enumerate(it.get('tiers',[])):
                    if ti>0 and it['levels'][i]==lvl:
                        buys.append(f"{it['name']} T{ti}")
        bs = ', '.join(buys) if buys else '--'
        print(f"  L{lvl:<5} {a8:>7} {dl:>7} {st:>7}  {bs}")
    pct = s10/88*100
    print(f"  TOTAL: {s10}/88 DP ({pct:.0f}%) {'**TIGHT**' if s10>70 else 'comfortable'}\n")

print("="*72)
print("BUDGET SUMMARY (all 6 characters at level 10)")
for budget in [8,12,14,16]:
    td=dp_avail(10,budget); spends=[spent(c['plan'],10) for c in chars]
    under=sum(1 for s in spends if s>td); avg=sum(s/td*100 for s in spends)/len(spends)
    print(f"  Budget {budget:>2}: {td:>4} DP | spend {min(spends)}-{max(spends)} | {avg:.0f}% used | {'UNDERFUNDED' if under else 'OK'}")

print()
print("Discipline purchases create meaningful DP tension at budget 8.")
print("At budget 12+, Discipline costs become trivial (3-4 DP out of 132+).")
print("RECOMMENDATION: 8 DP/level.")
