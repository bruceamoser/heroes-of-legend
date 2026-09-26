# Walkthrough W-001  -  first session (Playable)

**Instrument:** role card, walkthrough #1 (first-session). Build a level-1 hero using only the
book, then play one scene, logging every question the book does not answer, in the order a
player would hit it.
**Reference:** `origin/main@f33a51a` (cycle 2, 2026-09-26). Every number below was read from the
chapters at that commit, never recalled.
**Scope:** ch02 (creation path), ch05 (classes, loadouts, cost tables), ch06 (resolution),
ch07 (skills), ch08 (disciplines), ch09 (cards), ch13 (combat), ch15/16 (gear and armor),
ch20 (bestiary), ch21/22 (glossary, reference).
**Result:** the path works and resolves a scene end to end. It also produced four defects, two of
which were correctable the same day and two of which are rulings only Bruce can make.

---

## Part 1  -  Building a hero by following Steps 1 to 11

Hero built: **Bram Halvorsen, Human / Coastal / Blade**, deliberately a configuration the nine
printed templates do not cover (Human+Coastal rather than Elf+Twilight Elf).

| Step | What the book asks | What happened |
|---|---|---|
| 2 Attributes | six scores summing to exactly +3, each −2..+2 | Agility +2, Brawn +1, Guile +1, Knowledge −1, Fortitude 0, Reason 0 = +3. Clean; the rule states the sum and the cap. |
| 3 Ancestry | Human: any one Discipline, plus *Versatile* (+1 DP at Level 0) | Melee. Clean. |
| 4 Culture | Coastal: +1 to Athletics, Disciplines Two-Handed + Shields | **Q1 below.** |
| 5 Background DP | 8 + Knowledge + Fortitude | 8 − 1 + 1 (Versatile) = 8 DP. Clean; the formula and the trait both exist. |
| 6 Class | Blade grants Melee + Stealth, signature *Swift Blade* | Clean. |
| 7 Class DP | 8 DP, cards cost a flat 2/4/8 | Clean. |
| 8 Equipment | "Receive your class's starting loadout… record your armor's slot cost" (`02:210`) | **Q2 below** (the loadout is not paid for anywhere in this step). |
| 9 Derived | HP 10 + Fortitude + Knowledge; Grit 2; Initiative 3d6 + Agility; Movement 30; Carry 10 + Brawn×5, floor 5 | HP 9, Grit 2, Initiative 3d6+2, Movement 30 ft, Carry 15. All five formulas resolve from printed values. Clean. |

### Questions hit, in the order a player hits them

**Q1  -  Does a culture's +1 skill bonus stack with buying that skill's Novice rank?**
`04:112` is the only statement of the culture bonus: "Each culture grants a *+1 skill bonus* and
either two specific Disciplines…". `07` prices every skill at a flat 2/4/8 and defines Novice as
+1. Nothing anywhere states whether the two +1s are one bonus or two.
This is not a hypothetical: **all nine printed heroes spend 2 DP buying the exact skill their own
culture grants +1 in** (Makeva/Acrobatics, Sera/Arcana, Lirael/History, Haldra/Persuasion,
Marta/Athletics, Vaelith/Deception, Pip/Stealth, Gorma/Craft, Corwin/Survival)  -  18 DP of spend
book-wide. Three annotate the line "culture bonus already applied" (`02:458`, `02:533`, `02:573`)
and six say nothing or "favored". So either the book's own builds each wasted 2 DP (and a player
who follows them is taught to waste), or the annotation on those three lines is false.
**Class:** GAP, no printed answer. Escalated (ledger row 162).

**Q2  -  Where is the loadout's Discipline rank paid from?**
`02:208-210` (Step 8) hands over the loadout and says to record weapon properties, the armor's
slot cost, and DR. It never mentions the rank cost. `05:45` says the opposite of nothing:
"Ranks your class, ancestry, or culture already grant cost nothing, so the DP figure in a
loadout line is what its remaining ranks cost at your class's rates, **paid from the same
Development Points that buy your cards**." `15:82` repeats the gate ("a hero may use a piece of
gear only while holding the Discipline ranks that item requires"). `16:41-44` prints the armor
table with a *Requirement* column (light 1 Armor, medium 2, heavy 3).
So the canonical creation path never charges the spend that the gear chapters impose, and a
player who follows ch02 literally builds a hero who may not use the armor in his own loadout.
**Class:** defect (cross-chapter), with a design dependency (Part 2 and row 161).

**Q3  -  "your attack ability cards carry the Weak, Standard, and Strong damage values" (`02:210`)
 -  which cards?** A Blade at creation has bought skill ranks, not an attack card. The answer is the
Basic Attack cards (`09:196-245`: Basic Melee, Two-Handed, Archery, Thrown, Unarmed), reached by
hop: ch02 → ch15 → ch09. The chain resolves and every damage example in ch06/ch13 uses those
cards, so this costs a page-flip, not a gap. **Class:** ANSWERABLE, three hops. Not escalated.

**Q4  -  "Grit 2" implies being dropped and getting back up (`03:78`); where is that rule?**
Resolves in ch13's death-save table (row 27 of the ledger records its Critical/Fumble entry).
**Class:** ANSWERABLE. Not escalated.

**Resolved while writing, not a finding.** *Protection Value* appeared undefined in ch05's
signatures on first read; it is defined at `21:143` and `22:388` and was already adjudicated
(ledger row 63, implemented default 2026-09-01). Not re-filed.

---

## Part 2  -  The nine printed builds against the loadout cost model

`05:45` states the model, and the class loadout lines price it: the Protector's "Armor ranks 2 and
3 cost 6 DP at your Home rate" (`05:63`), the Blade's "the Armor rank costs 4 DP at your Foreign
rate" (`05:113`), the Shepherd's "Neither rank is a class grant; together they cost 7 DP"
(`05:208`), the Shadow's "Melee and Armor together cost 5 DP" (`05:466`).

Every printed hero's 8 class DP and its Background pool are already fully spent on cards and
skills. So any rank the loadout needs and the grants do not cover is an unfunded cost. Measured
per hero (grants from `02:288-290`, `02:335-348`, and each build's own Step 3/4/6 lines; Armor
rates from the nine class tables at `05:65-473`):

| Hero (class) | Loadout gear needing a rank | Covered by | Shortfall |
|---|---|---|---|
| Makeva (Odd) | leather armor (1 Armor) |  -  | 1 Armor rank = **2 DP** (Odd 2/4/8) |
| Sera (Arcanist) | dagger (1 Melee) |  -  | 1 Melee rank = **4 DP** (Arcanist 4/8/16) |
| Lirael (Intellect) | shortsword (1 Melee) | High Elf grant | none |
| Haldra (Shepherd) | leather armor (1 Armor) |  -  | 1 Armor rank = **4 DP** (Shepherd 4/8/16) |
| Marta (Leader) | leather armor (1 Armor) |  -  | 1 Armor rank = **2 DP** (Leader 2/4/8) |
| Vaelith (Blade) | leather armor (1 Armor) |  -  | 1 Armor rank = **4 DP** (Blade 4/8/16) |
| Pip (Shadow) | leather armor (1 Armor) |  -  | 1 Armor rank = **4 DP** (Shadow 4/8/16) |
| Gorma (Protector) | chain mail (3 Armor) | class grant = Armor 1 | ranks 2+3 = **6 DP** (Protector 1/2/4) |
| Corwin (Unbalanced) | spear (1 Two-Handed) | Nomadic grant | none |

**7 of 9 printed heroes are unfunded by 2 to 6 DP, totalling 26 DP of gear permission that no
ledger in the book pays and no grant supplies.** The consequence is not bookkeeping: under
`15:82` and `16:80` these heroes may not use the armor they are printed wearing, so their printed
DR and slot costs are wrong too.

The same defect has a second, independent carrier inside the gear chapter itself.
`16:104` states the premise: "Roric is building a dwarf Protector at Level 1. He has… **1 Armor
Discipline rank**." Sixty lines after the armor table prints Heavy = "3 Armor", `16:110` has him
take **chain mail** ("With chain mail his DR is 3"), and `16:118` builds the Shield Block example
on that DR. The nine-line deliberation at `16:106-112` weighs slots, donning time and ward-vs-steel
and never mentions the 6 DP the choice costs, which is the single largest factor in it.

Two clean builds out of nine says the model is understood, not unknown: Marta pays a weapon rank
in Background DP ("Melee Discipline, rank 2 (2 DP, Home), **the longsword needs two**, and she
carries it", `02:457`). The templates price the weapon they thought about and miss the armor.

**Class:** defect, with a design dependency. The direction is ruled (`#587`, parked 2026-09-15:
"a hero who wants to wear plate buys the Armor ranks that plate requires, at his class's rates"),
but the *cost* of that ruling is what the parked row names as its revival trigger  -  a Protector
who pays 6 of 8 DP for chain mail keeps one card. Escalated (ledger row 161, comment on #587).

---

## Part 3  -  Playing the scene

Played ch13's own worked combat round (`13:456-533`) against the printed stat blocks, then ran a
second scene with the party against two goblins (`20:152-164`) to test a Challenge the DA has to
look up unaided.

Resolved cleanly, no invention needed: the initiative order, the attack rolls (3d6 + attribute),
the tier-to-damage mapping off Basic Melee, DR subtraction, Shield Block's reaction ordering
(`16:130`: shield DR first, then armor DR, floor 1), the Morale Check, and the two-weapon off-hand
tier drop (`13:292`). The one-roll principle holds throughout: no second roll appears anywhere in
the round. Total table time claim ("about 8 minutes") is plausible for what is printed.

**Q5  -  What penalty does "Challenge ½" impose?**
The bestiary prints the minion tier as **Challenge ½** for 15 of its creatures (goblin, hobgoblin,
orc, bandit, cultist, guard, wolf, skeleton, zombie, stirge, and the rest: `20:36-373`), and the
glossary defines the tier (`21:231`) without ever giving it a number: "Creatures at Challenge ½…
are individually weak and meant to be fought in numbers."
The core rule states the conversion for integers only: "A monster's stat block prints this same
number as a positive rating, so the Challenge 3 knight imposes −3 on your roll" (`06:111`).
A DA running a goblin therefore has a stat block that names a rating and no rule that turns ½ into
a penalty on a 3d6 roll. Three printed examples do it, all of them as **−1**: the goblin fight in
ch06 (`06:144`), the cultist in ch13's worked round (`13:490`), and the goblin pair in ch16
(`16:122`, which calls it "Challenge 1" outright).
**Class:** GAP with a determinate answer. Fixed the same day from the book's own practice
(ledger row 163, PR below).

**Q6  -  "The cultists dealt 4 to Lyra" (`13:502`) contradicts the round it summarises.**
The same round resolves, at `13:492`: "Dark Bolt Standard damage: 6 necrotic… She takes 6 damage…
She drops to 4 HP." The end-of-round ledger then says the cultists dealt 4. Six is the damage; 4 is
her remaining HP, written into the damage slot. The other two entries in that same line are
correct (Knight 8 − 1 DR = 7 to Kael; party 1 + 1 = 2 to the Knight).
**Class:** defect, single correct outcome. Fixed the same day (ledger row 163).

**Q7  -  two details a reader has to reverse-engineer.** Minor, logged not escalated.
`13:292` adds **Agility** to a two-weapon damage total where every other example adds Brawn; the
permission is the Blade's free *Precision* talent ("You may use Agility for Brawn when
applicable", `09:45`), granted by *Swift Blade* (`05:103`), but the example never says so.
`13:466` gives Kael "a small buckler strapped to his left forearm" while stating two paragraphs
later that "with no Parry rank it adds no roll bonus"  -  a small shield takes 1 Shields (`16:82`)
and Kael holds none, which is the same gear-permission family as Part 2 rather than a new defect.

---

## Findings from W-001

| id | Where | Class | Disposition |
|---|---|---|---|
| W-1-01 | `02:288-629` (9 builds), `16:104-118` | defect + design dependency: 26 DP of loadout gear ranks unpaid; 7 of 9 builds wear gear they may not use | ledger row 161; #587 commented with the measurement |
| W-1-02 | `02` (all 9 builds), `04:112`, `07` | GAP, needs a ruling: culture +1 skill vs a purchased Novice rank | ledger row 162 |
| W-1-03 | `06:111`, `21:231` | GAP with a determinate answer: Challenge ½ has no printed penalty | fixed 2026-09-26 (ledger row 163) |
| W-1-04 | `13:502` | defect: round-summary damage total contradicts the round | fixed 2026-09-26 (ledger row 163) |
| W-1-05 | `13:292`, `13:466` | readability: an unstated Precision substitution; a shield without its rank | logged here, no filing (covered by row 161's family) |
| W-1-06 | `15:121`, `15:123`, `15:154`, `16:80`, `16:86`, `08:195`, `05:193`, `05:263` | defect: a weapon's and a shield's entry requirement are each printed two ways | ledger row 164 (needs one word) |
| W-1-07 | `08:195`, `21:27` | defect: a typed period after a sentence-final crossref doubled it in the render ("Chapter 18..") | fixed 2026-09-26 (ledger row 163); found by the render check, not the source read, and the live gate read 2 on a clean `main` |

**Answer to the instrument's question  -  can a new player build a hero and resolve a scene from
the book alone?** Yes for the scene; not yet for the hero. Every roll, tier, and damage number in
both scenes resolves from printed text with no invention, but a player building legally must
discover, unaided, that the creation path's Step 8 omits a spend the gear chapters impose, and
must decide unaided whether their culture's +1 skill and their 2 DP purchase are the same +1.
Both failures are in the economy layer that the 2026-09-16 armament collapse rewrote; the
nine printed builds predate it and were never re-validated against it.
