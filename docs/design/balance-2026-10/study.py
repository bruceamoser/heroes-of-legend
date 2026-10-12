#!/usr/bin/env python3
"""HOL design experiments, not a complete rules engine. Python standard library only.

Run: python3 docs/design/balance-2026-10/study.py --trials 2000
Read assumptions.md before interpreting outputs. No canonical rules are modified.
"""
import argparse
import csv
import hashlib
import itertools
import json
import math
import random
from bisect import bisect
from collections import Counter
from dataclasses import asdict, dataclass
from functools import lru_cache
from pathlib import Path

OUT = Path(__file__).parent / "outputs"
LADDER = (0, 4, 6, 8, 10, 12, 20)


@lru_cache(None)
def distribution(attribute=0, net=0):
    """Exact W/S/St and natural retained triple probabilities, before riders."""
    net = max(-3, min(3, net))
    count = 3 + abs(net)
    outcomes = Counter()
    for dice in itertools.combinations_with_replacement(range(1, 7), count):
        multiplicity = math.factorial(count)
        for n in Counter(dice).values():
            multiplicity //= math.factorial(n)
        kept = dice[-3:] if net >= 0 else dice[:3]
        critical, fumble = kept == (6, 6, 6), kept == (1, 1, 1)
        total = sum(kept) + attribute
        tier = 0 if fumble else 2 if critical else (0 if total <= 8 else 1 if total <= 14 else 2)
        outcomes[(tier, critical, fumble)] += multiplicity / 6 ** count
    return tuple(sorted(outcomes.items()))


@lru_cache(None)
def sampler(attribute, net):
    keys, cumulative, p = [], [], 0.0
    for key, prob in distribution(attribute, net):
        keys.append(key)
        p += prob
        cumulative.append(p)
    cumulative[-1] = 1.0
    return keys, cumulative


def roll(rng, attribute=0, net=0):
    keys, cumulative = sampler(attribute, max(-3, min(3, net)))
    return keys[bisect(cumulative, rng.random())]


def tier_probs(attribute, net):
    p = [0.0] * 3
    for (tier, _, _), probability in distribution(attribute, net):
        p[tier] += probability
    return p


def damage(parts, resistances):
    return max(1, sum(max(0, amount - resistances.get(kind, 0)) for kind, amount in parts.items()))


def write_csv(name, rows):
    with (OUT / name).open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]), lineterminator="\n")
        w.writeheader()
        w.writerows(rows)


def exact_tables():
    dice_rows, damage_rows = [], []
    for attribute in range(-2, 3):
        for net in range(-3, 4):
            p = tier_probs(attribute, net)
            crit = sum(v for (_, c, _), v in distribution(attribute, net) if c)
            fumble = sum(v for (_, _, f), v in distribution(attribute, net) if f)
            dice_rows.append(dict(attribute=attribute, net_boons=net, weak=p[0], standard=p[1], strong=p[2], critical=crit, fumble=fumble, mean_progress=sum((i+1)*v for i,v in enumerate(p))))
            for name, packet in [("basic", (1,2,4)), ("novice", (2,4,6))]:
                for resistance in range(7):
                    damage_rows.append(dict(attribute=attribute, net_boons=net, attack=name, resistance=resistance,
                        pc_attack_mean=sum(p[i]*max(1, packet[i]-resistance) for i in range(3)),
                        npc_attack_mean=sum(p[i]*max(1, packet[2-i]-resistance) for i in range(3))))
    write_csv("dice.csv", dice_rows)
    write_csv("damage.csv", damage_rows)
    inventory = []
    for sides in LADDER[1:]:
        index = LADDER.index(sides)
        state = {index: 1.0}
        cdf, percentiles = 0.0, {}
        for use in range(1, 2001):
            nxt = Counter()
            for k, p in state.items():
                if k == 0:
                    nxt[0] += p
                else:
                    nxt[k-1] += p/LADDER[k]
                    nxt[k] += p*(1-1/LADDER[k])
            state = nxt
            cdf = state[0]
            for q in (0.1, 0.5, 0.9, 0.95):
                if cdf >= q and str(q) not in percentiles:
                    percentiles[str(q)] = use
            if use in (4,6,10,20):
                inventory.append(dict(start_die=sides, uses=use, exhausted_probability=cdf,
                    mean_total_uses=sum(LADDER[1:index+1]), **{f"p{int(q*100)}_uses":percentiles.get(str(q), "") for q in (0.1,0.5,0.9,0.95)}))
        for row in inventory:
            if row["start_die"] == sides:
                row.update({f"p{int(q*100)}_uses":percentiles[str(q)] for q in (0.1,0.5,0.9,0.95)})
    write_csv("inventory.csv", inventory)
    wounds = []
    for n in range(3,7):
        death = sum(math.comb(n,k)*(1/6)**k*(5/6)**(n-k) for k in range(3,n+1))
        wounds.append(dict(dice=n,last_words_probability=death))
    write_csv("wounds.csv", wounds)
    survival = 1.0
    campaigns = []
    for n in range(1,31):
        survival *= 1-wounds[min(n-1,2)]["last_words_probability"]
        campaigns.append(dict(wounds_received=n,terminal_wound_probability=1-survival))
    write_csv("wound_lifetime.csv", campaigns)
    groups = []
    for n in range(1,9):
        for attr in (0,2):
            p = {0:1.0}
            for _ in range(n):
                nxt = Counter()
                for total,v in p.items():
                    for i,q in enumerate(tier_probs(attr,0),1):
                        nxt[total+i] += v*q
                p = nxt
            for target in (n,2*n,2*n+1,3*n):
                groups.append(dict(participants=n,attribute=attr,target=target,success=sum(v for k,v in p.items() if k>=target)))
    write_csv("groups.csv",groups)


@dataclass(frozen=True)
class Scenario:
    name: str
    party_size: int = 4
    hp: int = 20
    pc_resistance: int = 2
    attack_attribute: int = 1
    defense_attribute: int = 0
    healer_attribute: int = 1
    basic_users: int = 0
    enemy_count: int = 4
    enemy_hp: int = 12
    enemy_resistance: int = 1
    enemy_damage: tuple = (2,4,6)
    enemy_actions: int = 1
    enemy_offense_banes: int = 0
    enemy_defense_banes: int = 0
    policy: str = "attack"  # attack, healer, all_heal, potion
    potion_die: int = 4
    threshold: float = 0.5
    defend: bool = True
    shield: bool = False
    enemy_target: str = "focus"  # focus, spread, finish
    player_target: str = "focus"
    turn_selection: str = "urgent"
    support: str = "adjacent"  # self restricts all healing and disables ally stabilization
    npc_healers: int = 0  # last N creatures; hypothetical explicit support ability
    npc_heal_fraction: float = 1.0
    hunt_healers: bool = False
    initial_wounds: int = 0
    initial_grit: int = 2
    round_cap: int = 40


def make_party(s):
    return [dict(hp=s.hp, grit=s.initial_grit, wounds=s.initial_wounds, death=0,
        stable=False, terminal=False, defend=False, shield=False, reaction=True,
        bottle=LADDER.index(s.potion_die)) for _ in range(s.party_size)]


def battle(s, rng, pcs=None):
    pcs = pcs if pcs is not None else make_party(s)
    for p in pcs:
        p.update(defend=False,shield=False,reaction=True)
    enemies = [s.enemy_hp]*s.enemy_count
    m = Counter(rounds=0, attacks=0, enemy_attacks=0, spell_heals=0, potions=0,
        restored_hp=0, downs=0, wounds=0, grit=0, terminal=0, stabilizes=0, enemy_heals=0,
        cleanup_rounds=0, death_rolls=0)
    players_first = sum(rng.randint(1,6) for _ in range(3)) >= 12

    def terminal(p):
        p.update(terminal=True,hp=0)
        m["terminal"] += 1

    def wound(p):
        p["wounds"] += 1
        m["wounds"] += 1
        # New wound does not add a die to its own roll; third wound onward is 5d6.
        n = min(5, 2+p["wounds"])
        if sum(rng.randint(1,6)==6 for _ in range(n)) >= 3:
            terminal(p)

    def hurt(p, amount):
        if p["hp"] > 0:
            p["hp"] = max(0,p["hp"]-amount)
            if p["hp"] == 0:
                p.update(stable=False,death=0)
                m["downs"] += 1
                wound(p)
        else:
            if p["stable"]:
                p["stable"] = False
                wound(p)
            p["death"] += 1
            if p["death"] >= 3 and not p["terminal"]:
                terminal(p)

    def heal(p, amount):
        old = p["hp"]
        p["hp"] = min(s.hp, old+amount)
        p.update(stable=False,death=0)
        m["restored_hp"] += p["hp"]-old

    def pc_turn(index):
        p = pcs[index]
        if p["terminal"]:
            return
        p.update(defend=False,shield=False,reaction=True)
        if p["hp"] == 0:
            if p["stable"]:
                return
            if p["grit"]:
                p["grit"] -= 1
                m["grit"] += 1
                heal(p,s.hp)
            else:
                m["death_rolls"] += 1
                tier, crit, fumble = roll(rng, s.defense_attribute, 0)
                # Proxy: Fortitude uses defense_attribute here; separated in documented limitations.
                if crit:
                    heal(p,1)
                elif tier == 2:
                    p.update(stable=True,death=0)
                elif tier == 0:
                    p["death"] += 2 if fumble else 1
                    if p["death"] >= 3:
                        terminal(p)
                if p["hp"] == 0:
                    return
        maneuver = True
        if s.policy == "potion" and p["bottle"]:
            targets = [j for j,q in enumerate(pcs) if (s.support=="adjacent" or j==index) and not q["terminal"] and q["hp"] <= s.hp*s.threshold
                and (j==index or q["hp"]==0 or q["reaction"])]
            if targets:
                target = min(targets,key=lambda j:pcs[j]["hp"])
                if target != index and pcs[target]["hp"] > 0:
                    pcs[target]["reaction"] = False
                heal(pcs[target],s.hp)
                m["potions"] += 1
                if rng.randint(1,LADDER[p["bottle"]])==1:
                    p["bottle"] -= 1
                maneuver = False
        may_heal = s.policy == "all_heal" or (s.policy == "healer" and index == 0)
        targets = [q for j,q in enumerate(pcs) if (s.support=="adjacent" or j==index) and not q["terminal"] and q["hp"] <= s.hp*s.threshold]
        if may_heal and targets:
            target = min(targets,key=lambda q:q["hp"])
            tier,_,_ = roll(rng,s.healer_attribute,0)
            heal(target,math.ceil(s.hp/2) if tier==0 else s.hp)
            m["spell_heals"] += 1
        else:
            alive = [j for j,h in enumerate(enemies) if h>0]
            if alive:
                healer_targets=[j for j in alive if j>=s.enemy_count-s.npc_healers]
                if s.hunt_healers and healer_targets:
                    alive=healer_targets
                target = min(alive,key=lambda j:enemies[j]) if s.player_target=="focus" else rng.choice(alive)
                tier,_,_ = roll(rng,s.attack_attribute,-s.enemy_defense_banes)
                packet = (1,2,4) if index < s.basic_users else (2,4,6)
                enemies[target] -= max(1,packet[tier]-s.enemy_resistance)
                m["attacks"] += 1
            elif s.support=="adjacent":
                # With no enemy left, an unused Main converts into another
                # Maneuver for explicit stabilization; it is not automatic cleanup.
                needing_help=[q for q in pcs if not q["terminal"] and q["hp"]==0 and not q["stable"]]
                if needing_help:
                    needing_help[0].update(stable=True,death=0)
                    m["stabilizes"]+=1
        # Universal stabilization consumes a Maneuver, never wakes the target.
        dying = [q for q in pcs if not q["terminal"] and q["hp"]==0 and not q["stable"]]
        if maneuver and dying and s.support=="adjacent":
            dying[0].update(stable=True,death=0)
            m["stabilizes"] += 1
            maneuver = False
        if maneuver and s.defend:
            p["defend"] = True

    def npc_turn(index):
        if enemies[index] <= 0:
            return
        if index>=s.enemy_count-s.npc_healers:
            injured=[j for j,h in enumerate(enemies) if 0<h<=s.enemy_hp*0.5]
            if injured:
                j=min(injured,key=lambda k:enemies[k])
                enemies[j]=min(s.enemy_hp,enemies[j]+math.ceil(s.enemy_hp*s.npc_heal_fraction))
                m["enemy_heals"]+=1
                return
        for _ in range(s.enemy_actions):
            alive = [p for p in pcs if not p["terminal"]]
            if not alive:
                return
            upright = [p for p in alive if p["hp"]>0]
            choices = alive if s.enemy_target=="finish" else upright or alive
            # Randomize equal-HP ties: otherwise identical PCs make the index-0
            # healer the default tank in every trial, biasing reach sensitivity.
            if s.enemy_target=="spread":
                p=rng.choice(choices)
            else:
                lowest=min(q["hp"] for q in choices)
                p=rng.choice([q for q in choices if q["hp"]==lowest])
            if s.shield and p["reaction"] and p["hp"]>0:
                p.update(shield=True,reaction=False)
            net = int(p["defend"])+int(p["shield"])-s.enemy_offense_banes
            if p["hp"]==0:
                net -= 3
            tier,_,_ = roll(rng,s.defense_attribute,net)
            hurt(p,max(1,s.enemy_damage[2-tier]-s.pc_resistance))
            m["enemy_attacks"] += 1

    outcome = "timeout"
    enemy_defeat_round = 0
    for round_no in range(1,s.round_cap+1):
        m["rounds"] = round_no
        pc_done, npc_done = set(), set()
        side = 0 if players_first else 1
        while True:
            if all(h<=0 for h in enemies):
                if not enemy_defeat_round:
                    enemy_defeat_round=round_no
                dying=any(not p["terminal"] and p["hp"]==0 and not p["stable"] for p in pcs)
                if not dying:
                    outcome = "win"
                    break
            if all(p["terminal"] for p in pcs):
                outcome = "loss"
                break
            pa = [i for i,p in enumerate(pcs) if i not in pc_done and not p["terminal"]]
            na = [i for i,h in enumerate(enemies) if i not in npc_done and h>0]
            if not pa and not na:
                break
            if (side==0 and pa) or not na:
                if s.turn_selection=="fixed":
                    i = pa[0]
                else:
                    # A ready healer can rescue before a dying ally chooses Grit.
                    healers = [i for i in pa if pcs[i]["hp"]>0 and
                        (s.policy=="all_heal" or (s.policy=="healer" and i==0) or
                        (s.policy=="potion" and pcs[i]["bottle"]>0))]
                    urgent = any(not p["terminal"] and p["hp"]<=s.hp*s.threshold for p in pcs)
                    helpers=[j for j in pa if pcs[j]["hp"]>0]
                    if enemy_defeat_round and helpers and s.support=="adjacent":
                        i=helpers[0]
                    else:
                        i = healers[0] if urgent and healers else min(pa,key=lambda j:pcs[j]["hp"])
                pc_done.add(i)
                pc_turn(i)
                side = 1
            else:
                ready_healers=[j for j in na if j>=s.enemy_count-s.npc_healers]
                urgent=any(0<h<=s.enemy_hp*0.5 for h in enemies)
                i = ready_healers[0] if ready_healers and urgent else na[0]
                npc_done.add(i)
                npc_turn(i)
                side = 0
        if outcome != "timeout":
            break
    m["win"] = outcome=="win"
    m["loss"] = outcome=="loss"
    m["timeout"] = outcome=="timeout"
    m["any_wound"] = m["wounds"]>0
    m["any_terminal"] = m["terminal"]>0
    m["players_first"] = players_first
    m["living"] = sum(not p["terminal"] for p in pcs)
    # Dying has explicitly resolved in turn order before victory; stable PCs may take a breath.
    # Preserve fight duration separately from additional urgent cleanup rounds.
    if enemy_defeat_round:
        m["cleanup_rounds"]=m["rounds"]-enemy_defeat_round
        m["rounds"]=enemy_defeat_round
    if outcome=="win":
        for p in pcs:
            if not p["terminal"]:
                p.update(hp=s.hp,stable=False,death=0)
    return m, pcs


def scenarios():
    from dataclasses import replace
    base = Scenario("reference")
    yield base
    # Broad factorial grid; intended to expose interactions, not crown one optimized party.
    for hp,res,policy,target in itertools.product((8,12,16,20,24),(0,1,2),("attack","healer","all_heal","potion"),("focus","spread")):
        yield replace(base,name=f"grid_h{hp}_r{res}_{policy}_{target}",enemy_hp=hp,enemy_resistance=res,policy=policy,enemy_target=target)
    for size,ehp in ((1,48),(2,24),(4,12),(8,6),(12,4)):
        for policy in ("attack","healer","potion"):
            yield replace(base,name=f"layout_{size}x{ehp}_{policy}",enemy_count=size,enemy_hp=ehp,policy=policy)
    for actions in (1,2,3,4):
        for policy in ("attack","healer","potion"):
            yield replace(base,name=f"solo_a{actions}_{policy}",enemy_count=1,enemy_hp=48,enemy_actions=actions,policy=policy)
    for r,shield,defend in itertools.product((0,1,2,3),(False,True),(False,True)):
        yield replace(base,name=f"defense_r{r}_shield{int(shield)}_defend{int(defend)}",pc_resistance=r,shield=shield,defend=defend)
    for bane,packet,policy in itertools.product((0,1,2,3),((1,2,4),(2,4,6),(3,5,7),(4,6,8)),("attack","healer","potion")):
        yield replace(base,name=f"threat_b{bane}_d{packet[1]}_{policy}",enemy_offense_banes=bane,enemy_damage=packet,policy=policy)
    for attr,bane in itertools.product((-2,0,2),(0,1,2,3)):
        yield replace(base,name=f"accuracy_a{attr}_b{bane}",attack_attribute=attr,enemy_defense_banes=bane)
    for basics,policy in itertools.product((0,2,4),("attack","healer","potion")):
        yield replace(base,name=f"composition_basic{basics}_{policy}",basic_users=basics,policy=policy)
    for hp in (12,16,20,24,28):
        for policy in ("attack","healer","potion"):
            yield replace(base,name=f"hp_{hp}_{policy}",hp=hp,policy=policy)
    for n in (2,3,4,5,6,8):
        for policy in ("attack","healer","potion"):
            yield replace(base,name=f"party_{n}_{policy}",party_size=n,enemy_count=n,policy=policy)
    for threshold,policy in itertools.product((0.25,0.5,0.75),("healer","all_heal","potion")):
        yield replace(base,name=f"timing_{policy}_{threshold}",threshold=threshold,policy=policy)
    for mode,policy in itertools.product(("fixed","urgent"),("attack","healer","all_heal","potion")):
        yield replace(base,name=f"order_{mode}_{policy}",turn_selection=mode,policy=policy)
    for target,policy in itertools.product(("focus","spread","finish"),("attack","healer","potion")):
        yield replace(base,name=f"target_{target}_{policy}",enemy_target=target,policy=policy)
    for policy in ("attack","healer","potion"):
        yield replace(base,name=f"player_spread_{policy}",player_target="spread",policy=policy)
    for d in (4,6,8):
        yield replace(base,name=f"supply_d{d}",policy="potion",potion_die=d)


def seeded(name):
    return random.Random(int.from_bytes(hashlib.sha256(name.encode()).digest()[:8],"big"))


def run_scenario(s,n):
    rng = seeded(s.name)
    total = Counter()
    win_rounds, all_rounds = [], []
    for _ in range(n):
        m,_ = battle(s,rng)
        total.update(m)
        all_rounds.append(m["rounds"])
        if m["win"]:
            win_rounds.append(m["rounds"])
    row = {"scenario":s.name,"trials":n,**{k:v/n for k,v in total.items()}}
    row["win_rounds_mean"] = sum(win_rounds)/len(win_rounds) if win_rounds else ""
    for label,data in (("win",win_rounds),("all",all_rounds)):
        data.sort()
        for q in (0.1,0.5,0.9):
            row[f"{label}_rounds_p{int(q*100)}"] = data[min(len(data)-1,int(len(data)*q))] if data else ""
    row["win_mc_se"] = math.sqrt(row["win"]*(1-row["win"])/n)
    return row


def campaign_runs(n):
    from dataclasses import replace
    rows=[]
    for policy,target in itertools.product(("attack","healer","potion"),("focus","spread")):
        s=Scenario(f"campaign_{policy}_{target}",policy=policy,enemy_target=target)
        rng=seeded(s.name)
        for refill in (False,True) if policy=="potion" else (False,):
            tallies=[Counter() for _ in range(10)]
            for _ in range(n):
                party=make_party(s)
                for encounter in range(10):
                    if refill:
                        for p in party:
                            p["bottle"]=LADDER.index(s.potion_die)
                    m,party=battle(s,rng,party)
                    tallies[encounter].update(m)
                    tallies[encounter]["reached"]+=1
                    tallies[encounter]["full_party"]+=m["living"]==s.party_size and m["win"]
                    tallies[encounter]["grit_remaining"]+=sum(p["grit"] for p in party)
                    tallies[encounter]["wounds_carried"]+=sum(p["wounds"] for p in party)
                    if not m["win"] or m["living"]<s.party_size:
                        break
            for i,t in enumerate(tallies,1):
                reach=t["reached"]
                rows.append(dict(policy=policy,target=target,resupply=refill,encounter=i,full_party_completion=t["full_party"]/n,
                    reached=reach/n,mean_grit_remaining_among_reached=t["grit_remaining"]/reach if reach else 0,
                    mean_wounds_among_reached=t["wounds_carried"]/reach if reach else 0))
    write_csv("campaigns.csv",rows)


def validate():
    checks=0
    def check(x):
        nonlocal checks
        assert x
        checks+=1
    for a in range(-4,5):
        for b in range(-3,4):
            check(abs(sum(v for _,v in distribution(a,b))-1)<1e-10)
    check(all(abs(a-b)<1e-10 for a,b in zip(tier_probs(0,0),(56/216,140/216,20/216))))
    # Independent ordered enumeration catches multiplicity/keep-direction errors.
    for net in (-2,-1,0,1,2):
        counts=Counter()
        for dice in itertools.product(range(1,7),repeat=3+abs(net)):
            kept=sorted(dice)[-3:] if net>=0 else sorted(dice)[:3]
            counts[sum(kept)]+=1
        for attr in (-2,0,2):
            brute=[sum(n for total,n in counts.items() if (0 if total+attr<=8 else 1 if total+attr<=14 else 2)==tier)/6**(3+abs(net)) for tier in range(3)]
            check(all(abs(a-b)<1e-10 for a,b in zip(brute,tier_probs(attr,net))))
    check(damage({"physical":2,"fire":1},{"physical":2,"fire":1})==1)
    check(damage({"physical":2,"fire":1},{"physical":2})==1)
    check(damage({"physical":2,"fire":1},{"physical":1})==2)
    for seed in range(100):
        m,pcs=battle(Scenario("check"),random.Random(seed))
        check(m["win"]+m["loss"]+m["timeout"]==1)
        check(m["grit"]<=8)
        check(all(0<=p["hp"]<=20 and 0<=p["grit"]<=2 for p in pcs))
        check(m["attacks"]+m["spell_heals"]<=4*m["rounds"])
        check(m["potions"]<=4*m["rounds"])
        check(m["enemy_attacks"]<=4*m["rounds"])
    # Seed repeatability and a guaranteed minimum-damage case.
    check(battle(Scenario("repeat"),random.Random(9))[0]==battle(Scenario("repeat"),random.Random(9))[0])
    tiny=Scenario("tiny",enemy_count=1,enemy_hp=1,enemy_damage=(1,1,1),hp=100)
    check(all(battle(tiny,random.Random(i))[0]["rounds"]==1 for i in range(30)))
    # Killing the last enemy cannot silently clear a dying ally's death marks.
    cleanup=Scenario("cleanup",enemy_count=1,enemy_hp=1,enemy_damage=(1,1,1),turn_selection="fixed",initial_grit=0)
    deaths=[]
    for seed in range(30):
        party=make_party(cleanup)
        for p in party[1:]:p.update(hp=0,death=2,stable=False)
        m,_=battle(cleanup,random.Random(seed),party)
        deaths.append(m["terminal"])
    check(any(deaths))
    return checks


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--trials",type=int,default=2000)
    args=parser.parse_args()
    OUT.mkdir(exist_ok=True)
    checks=validate()
    exact_tables()
    configs=list(scenarios())
    (OUT/"scenarios.json").write_text(json.dumps([asdict(s) for s in configs],indent=2)+"\n")
    rows=[]
    for i,s in enumerate(configs,1):
        rows.append(run_scenario(s,args.trials))
        if i%40==0:
            print(f"Completed {i}/{len(configs)} scenarios",flush=True)
    write_csv("combat.csv",rows)
    campaign_runs(args.trials)
    (OUT/"validation.json").write_text(json.dumps(dict(checks_passed=checks,scenarios=len(configs),trials_per_scenario=args.trials,
        single_encounter_trials=len(configs)*args.trials,campaigns=8*args.trials,seed="SHA256 scenario name, first 8 bytes, big endian",
        python_standard_library_only=True),indent=2)+"\n")
    print(f"Done: {checks} checks, {len(configs)*args.trials} isolated encounters plus campaigns.",flush=True)


if __name__=="__main__":
    main()
