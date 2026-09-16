# Council Request — Does equipment-as-flavour serve the goals?

**Status:** open, for the HOL council
**Raised by:** Bruce Moser, 2026-09-15
**Supersedes in scope:** the equipment purge (#554) two-pass plan. That plan is mechanically sound
but rests on a doctrine this request puts back on the table.

---

## 1. The goal, as stated

> "The goal is a rich character development process and a simple but strategic combat mechanic.
> Our decision to make weapons flavor may not be satisfying the need or the goal."

Two goals, and a suspicion about one doctrine. Both goals are the fixed reference for everything
below. A solution that serves one and quietly costs the other is not a solution.

## 2. Why this is being asked now

Purging the named-equipment catalog forced the first measurement of what equipment actually *does*
mechanically. The doctrine says **"discipline is permission, equipment is possession, cards are
damage."** The measurement says that for weapons, the middle term is doing almost no work.

## 3. The current state, measured

| Quantity | Measured | How counted |
|---|---|---|
| Standalone cards | **188** | `*Disciplines:*` fields, all chapters |
| Gated by a Discipline rank | 141 | |
| Gated `None` | 45 | the ungated floor layer |
| Cards carrying a `Kit:` field | **64** | law 4 selective retrofit |
| — gated on a **spellcasting focus** | **52** | `focus:arcane` 32 · `focus:holy` 18 · `focus:primal` 2 |
| — gated on a **weapon or shield** | **10** | `weapon:two-hand` 3 · `weapon:ranged` 3 · `weapon:one-hand` 2 · `weapon:unarmed` 1 · `shield` 1 |
| Disciplines | 24 in 9 categories | |
| Combat round resources | Action 1 · Movement 1 · Maneuver 1 · Reaction 1/round · Free | `13:33-40` |
| Damage | **no damage roll** — the attack tier IS the damage | `08:214` |
| Damage bands | Novice `4/6/8` · Adept `5/8/11` · Master `7/10/14` | `08:205-217` |
| DR | armour light 1 / medium 2 / heavy 3, **plus** card DR | `16`, author ruling |
| Kit | 6 points · 4 identity lines · 16 utility tags | `15:19-158` |
| Development | 32 DP by L10 · 3 Discipline ranks (L3/L6/L9) · 2 attribute bumps (L4/L8) | `18:36-63` |

### The finding this request turns on

The `Kit:` gate is the **only** mechanism by which a weapon changes what a character can *do*.
It is used **ten times in 188 cards**.

**Eighty-one percent of all kit gates are spellcasting foci.** A caster's choice of focus gates 52
cards; a warrior's choice of weapon gates 10. The mechanism built to make equipment matter is
overwhelmingly serving the magic system, not the weapon system.

So what does "which weapon?" currently decide?

1. Brawn vs Agility on melee damage, if the weapon is Finesse — `15:200`
2. Whether an off-hand weapon is legal, if it is Light — `13:270-292`
3. Whether a Maneuver is spent, if it is Loading — `15:218`
4. Up to ten specific cards, via the `Kit:` field

That is the complete mechanical content of the weapon decision. Everything else is fiction.
The question is whether four consequences, one of which is a single point of damage attribute,
constitutes a *pillar* of character development or a *tactical* axis in combat.

## 4. The locked laws any solution must respect

These are not up for renegotiation. A solution that breaks one is rejected on its face.

1. **No damage roll.** The attack roll's tier (Weak/Standard/Strong) IS the damage — `08:214`.
2. **The damage bands are the spine**, and the **DR invariant** binds: three distinct tiers survive
   flat subtraction only while `DR <= the band's Weak value` (Novice 2 · Adept 6 · Master 9). Above
   it the tiers collapse and the defense roll — the game's only damage-resolution mechanic — is
   switched off. Because the defense roll IS the damage, a collapsed band is a **broken mechanic**,
   not a weak tier.
3. **A static gear number can never scale across the bands.** Gear access is level-independent, so a
   value calibrated for one band is handed to a level-1 character and broken there. The corollary is
   the architecturally load-bearing one: **card gates ARE level gates.** This is the general form of
   both the weapons-as-flavour and armour-as-flavour rulings. Any proposal that puts a scaling number
   back on a gear table must explain how it dodges this law.
4. **Kits never add numbers.** The single exception is the DR a Covering buys (light 1 / medium 2 /
   heavy 3), which prices itself at one kit point per point of DR.
5. **No currency.** Nothing is bought, in any solution. Capability is earned, granted or taken.
6. **Soft permission.** A missing tool is a Bane, or an expensive alternative. Blocked is not a design.
7. **Five activation classes**: Action · Maneuver · Reaction · Ritual · Passive. Every card names one.
8. **Every card names exactly one gate** (Discipline rank / Class / Ancestry / Tradition / None).

## 5. What the council is asked to produce

**Q1 — Diagnosis.** Does the current state satisfy each stated goal? Answer the two goals
*separately*, each with measured evidence. The likely answer is that they fail differently, and the
difference matters: a fix that serves combat strategy may be irrelevant to development richness.

**Q2 — The fork.** Name the single architectural question everything turns on. State it as a binary
choice with the consequence of each branch, not as a survey.

**Q3 — Exactly two solutions.** Propose **two architecturally distinct** answers. Not two settings of
one dial. The test: if a reader could implement solution A *and then* solution B as an incremental
patch to it, they are not distinct — B must be a different architecture, requiring A to be undone.

Each solution must state, explicitly:

1. **What a weapon IS**, mechanically, in one sentence.
2. **What drives damage**, and how it stays band-consistent under law 2 and law 3.
3. **Where tactical choice comes from** in a single combat round.
4. **Where development choice comes from** across ten levels.
5. **The fate of the seven weapon properties** (Finesse · Reach · Thrown · Light · Loading ·
   Two-Handed · Versatile), noting that consumers exist for all but Versatile.
6. **The fate of the named-equipment purge** — does the doctrine survive, and if not, what reverses?
7. **Blast radius** — chapters, tables, cards to author or rewrite, and an estimate of scale.
8. **Its own strongest counter-argument.** Each solution must name the failure mode that would kill
   it. A solution with no stated risk is an advertisement, not a proposal.

## 6. Out of scope — do not spend a lens on these

- Re-litigating the damage-band numbers or the no-damage-roll spine.
- Proposing an opposed roll for defence. That model is explicitly rejected: the actor rolls, the
  opposition's attribute becomes a **Challenge** (a modifier to the actor's roll).
- Reintroducing currency, prices, or purchased gear.
- The 20 general talents' gating and the discipline balance pass — those follow this decision.
- The Armament pricing fork from r-001. It is downstream of Q2.

## 7. Constraint on this request itself

The previous council run (#554) had a **scope defect**: nine source files were supplied for
questions that were book-wide, and three separate conclusions were false negatives caused by it —
"Lyra is invented", "Light has no consumer", and a ruling condition asserting no card field exists
when the `Kit:` field is documented at `19:557` and carried by 64 cards. **Every "nothing exists
that…" conclusion in this run must be instrumented, not asserted.** Scope by question, not by file.
