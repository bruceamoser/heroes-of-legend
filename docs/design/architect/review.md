# The State of the Game

**Date:** 2026-09-28 (cycle 84) · **Book source:** `33cd88d` (25 chapters, 88,671 words, 407 pages at the last build)
**Previous review:** 2026-09-27, `f64c94f` (cycle 54), corrected in place at cycle 58 and cycle 73.
**What changed in the GAME since that review**, in the order a player meets it. The equipment layer was rebuilt: no object in the book carries a damage-reduction number any more, and the armor a hero wears is a card that arrives with the Armor ranks the class granted (`16:35-100`), with one suit written to grant no DR at all and a Boon on staying unseen instead. A shield stopped being a number and became a reaction: Shield Block grants a Boon on the Defense Roll, Boon 1 at Novice through Boon 3 at Master (`16:112-118`). Health points moved onto the class attribute, `10 + Fortitude + the class's Health attribute`. The Standard encounter was printed at `1.25 x party level` per hero and spelled out as five creatures for a party of four (`19:57`, `19:59`), and the six build templates were each given an attack card, which moved the party's measured output from 13.71 to 23.84 a round (105% of the benchmark, `party-dpr.py`). Wounds became uncapped, so the dice end a hero and no count does (`13:395-403`). The campaign clock reached the page: `19:55` now prints what each rung costs in Wounds as well as in staying power, and `18:23` prints the hero's share. Three healing lanes exist, the Cast and Duration fields landed on spells, five amplifier cards got a real rung ladder, and the two class signatures that stated no effect now grant the printed card they were named after.

## 1. What this game is

Three lines. A fantasy adventure game that deletes the to-hit roll: you always connect, and your 3d6 roll decides how badly. No spell slots, no mana, no misses, and the dice never leave the players' hands, including when the monster attacks them. Surviving costs a scar, a scar is permanent, and enough of them end the hero rather than the campaign.

Chapter 1 makes five promises (`01:75-79`): no d20, attacks always hit, magic always fires, no class restrictions, armor reduces damage rather than making you hard to hit. All five are kept, and the fifth is now the strongest version of itself in the book. The armor chapter opens by saying that hits happen and armor is what you were wearing and what you have been through (`16:13`), then hands the whole question to a card that names its weight class and its DR (`16:37`). The promise is not a slogan any more, it is a structure: nothing you can hold has a number on it.

## 2. The moment-to-moment

One Action, movement, one Maneuver, one Reaction. Nothing misses, so every exchange advances the fight and no turn is a null turn. Measured on the book's own worked round (W-003): ten dice rolls plus initiative for seven turns and zero wasted turns. The party rolls everything, including the defense against every attack aimed at them, which is why being attacked is the most engaged a player gets rather than the least.

The decision that carries the round is the Maneuver. `13:86`, *Playing Your Turn Well*, tells the player in six bullets to bank it for Defend instead of spending it on movement they did not need, that cover is free and turns into a Boon on their own roll, and that an unspent Reaction is a turn they paid for and did not use. Book-wide there are 36 Novice class options: 4 cost a full Action, 11 cost a Maneuver, 21 are triggered riders (`class-shelf-cost-census.py`). The Leader remains the only class whose entire Novice shelf is priced in Maneuvers.

Where tension lives: at 0 HP you take a Wound and roll on the D666 table, then choose whether to spend a Grit and keep fighting (`13:357`, `13:403`). Falling is a decision and a story, not an exit. What is gone is the count that used to end a career: nothing retires a hero except the death roll, and every mark carried makes that roll worse.

## 3. The arc

A Novice hero has 11 to 15 HP, DR 1 to 3, and a class signature. At Master they have the same HP range, DR 3 to 6, three more Discipline ranks, a Grit pool of four and a damage row of 7/10/14 against the Novice 4/6/8. The ladder is flat in the places a player expects growth and steep in the places they do not: HP and printed damage rows move through DR, which is the tier's own ceiling (`16:27`), and the class's own armor story is now a card they are handed rather than a purchase they can get wrong.

The arc reads best at the middle. An even fight at the printed field clears in 3.16 rounds at Novice and the party's pool lasts 5.09, which is the window the pacing law asks for (`rounds-to-resolve.py`). At Adept the same field clears in 2.66 and at Master in 2.34, against pools of 5.16 and 5.06. Read honestly, that instrument is a lower bound on rounds, so it cannot prove the fight is too short on its own. What it does prove is the direction: the top of the ladder is shorter and safer than the bottom, and the tier's monster DR (0.67, 2.40, 4.67 across the bands) does not keep pace with the jump from the Novice row to the Master row.

The career clock is now printed rather than implied, and it is the best thing the book did this month. `19:55` prices every rung in Wounds and `18:23` says a Standard fight costs a hero about a third of one, which is what the instruments read (`career-clock.py`: Easy 0.19, Standard 0.32, Hard 1.46, Deadly 3.34 per hero, mid-read). A table that runs Standard every session reaches the death roll in about twelve fights; one that makes Easy its common fight gets one long career instead of several short ones. The book says which dial it is and tells the DA to say which campaign they are running.

## 4. The fantasies

Nine classes, and eight of the nine arrive. *Shadow* is the sneakiest thing in the book and its shelf is built from being unseen (*Vanish*, *Sap*, *Slip Away*). *Intellect* makes information the resource: *Assess*, *Deduce*, *Anticipate*, *Master Strategist*. *Unbalanced* prints its own price (backlash and all) in its own cost table and delivers on turn one. *Odd* is the wildcard, priced Adjacent across the board, with abilities that are jokes that work. *Blade*, *Arcanist* and *Protector* each do exactly what the label says, and the Protector is the only class whose fantasy is a number, which is now a card they are handed at level 1 with the ranks they already have. *Leader* commands from the Maneuver slot, which is the class's whole identity in one sentence.

The weakest is the **Shepherd**, and the weakness is the fantasy rather than the shelf. The class that reads as a healer gains Protection and Animal, and its divine energy is about half a hit's worth: the printed heals return 2 to 6 HP and its damage line reaches 6 to 11, against monsters dealing 6 to 11. It answers the undead (its signature now grants *Turn Unholy*) and it does not answer a fight. A player who picks it for "divine guide" and finds a class whose best turn is a 4-HP heal is running a different character than the cover promised. That is playable and it is coherent with the threshold law, which says the healer's Action buys the moment rather than the arithmetic. It is worth knowing before a new player picks it.

## 5. Magic, monsters, and the GM's seat

**Casting** is in the best shape it has been: cantrips at will and free, cards that always fire, the Cast and Duration fields fielded, three lanes with their own focus items, and one written rule where there used to be three (Concentration). Nothing is ever wasted and a caster's Strong rate runs about twice a Brawn +1 martial's off the same floor. The playtest sessions (W-004, W-011) found one class of defect and it is now closed: a caster's own signature was the one of nine with no effect at all.

**Monsters** are runnable. Every block states what it can do rather than what it wants, and the frame says so out loud (`20:32`), so 41 of 49 blocks leaving target choice to the DA is a stated design position rather than an oversight. Played block by block against a party of the intended level, all 49 stay defeatable and keep their three tiers distinct (`da-walkthrough.py`, PASS).

**The GM's seat** is the strongest chapter in the book and the one that changed most this week. It carries the encounter frame with its own arithmetic, the day's cost at each rung, the solo-boss guidance, the healer's threshold advice with the numbers that produced it (`19:63`: a heal at half HP costs the party +0.53 rounds, one held to a third costs +0.08), an on-the-fly difficulty section, morale guidance, a corruption track, a faction system, and three linked scenes that teach the rules in layers.

## 6. Cohesion and flavour

The book is coherent in a way it was not a week ago, because the object layer stopped competing with the card layer. What a player writes on their sheet is now a list of cards and the ranks behind them, and the two reference sheets reflect it (`22:251`, `22:383`).

Beside **5e** it is faster and more legible: no to-hit roll, no damage dice, no HP inflation, one Action, and being attacked is the player's roll rather than a passive number. It gives up tactical granularity: no grid rules, few conditions, and a Maneuver currency most characters spend on the same two or three options. Beside **Draw Steel** it lacks a drama engine and the hero-versus-minion asymmetry, and its fights run shorter: 3.2 rounds at Novice against Draw Steel's 5 to 6. What it has that neither does: the DA never rolling, an always-hit flat spine, and a survival track that ends a hero by the dice rather than by a count.

## 7. What is genuinely good

**1. The reversed Defense Roll.** The party rolls everything, so no turn is passive and the tension stays on the players' side of the screen. Both times the book got the sign wrong it broke fights rather than just reading oddly, which is how you know how much it carries.

**2. Grit, the Wound Table, and the dice ending a hero.** Falling is a decision. Measured against the book's own failure condition, no hero is dropped while holding Grit, and the whole tax of a sustained wound is about 0.3 rounds. Uncapping wounds closed the last hole in it: nothing ends a hero but the roll.

**3. The armor-as-card rebuild.** The book's last object with a number on it is gone, and the flavour shelf got a home it could not have before: Black Leather grants no DR and gives a Boon on staying hidden, which is a suit a point-value table could never print. This is the cleanest statement of the book's own law (*equipment is possession, cards are damage*) and it cost no hero a point of DR.

**4. The healing law's shape.** "The healer's Action answers the moment, not the arithmetic" is enforced by the arithmetic rather than the flavour, and it deleted the last place in the book where a higher tier printed a bigger number for the same effect.

**5. The encounter frame and the clock.** The DA's chapter states drain as a fraction of a real pool and now prices the rungs in the currency that does not come back.

## 8. What is weakest, ordered by the harm it does at a table

**1. The book gives the DA two answers to the same prep question.** `19:57` prints Standard at `1.25 x party level` per hero and `19:59` says plainly what that buys: "five Challenge 1 creatures (budget 1.25 x 1 x 4 = 5)... one and a quarter creatures per hero: five for a party of four, at every tier". The bestiary's own table (`20:650`) and the reference sheet's mirror (`22:339`) print `1.5 x 3 x 4 = 18` and work the example as six creatures. One cell, two chapters, both directions printed. The field is the one number a DA computes every session, and the party's whole resource day is measured against it.

**2. The top of the monster ladder is a speed bump, and the book's own creature rule says it should not be.** `20:659` sizes a creature's HP per attacker, "one per hero for a creature that fights the party alone", and the sampler one chapter earlier uses it: Kelvath prints HP 32 for four attackers (`19:339`). The bestiary's own bosses print the group rate: Young Dragon (Challenge 6) 10 HP, Death Knight (Challenge 8) 11 HP, Ancient Dragon (Challenge 12) 11 HP with DR 6 (`20:435`). With Challenge capped at −6 and the Master row at 7/10/14, a Challenge 12 dragon dies to about two Strong hits from one hero. The same drift shows in their offense: the Archmage (Challenge 6) attacks at 4/6/8, the Novice row, where the book's own template says Challenge 3 to 6 deals 5/8/11 (`20:668`). A table that plays to level 10 meets its dragons as a speed bump.

**3. The first session's printed builds teach waste.** Gorma the Protector takes Melee from her dwarf ancestry and Melee again from her Mountain culture, and spends 1 DP on Shields rank 1 that her class hands her free (`02:582`, `02:592`, `02:596`); the chapter's own warning calls a second grant of the same Discipline explicit waste (`08:99`). The quick-build path tells an experienced player to spend every point, then lists 2 to 3 skills and 1 ability (6 to 8 DP) against a stated background pool of `8 + Knowledge + Fortitude` (8 to 12) and 12 class DP (`02:30`, `02:32`). New players copy the templates first, and what they copy is a build that leaves points on the floor.

**4. The DA is told to roll dice in a game whose rules say the DA never does.** `13:118`: "The DA never touches the dice in Heroes of Legend. This is not a suggestion. It is the rules." The bestiary's trait table tells the DA to roll 1d6 for Recharge at the start of the monster's turn (`20:28`) and the glossary repeats it in the DA's own name (`21:237`). Recharge fires in most rounds of most fights, so this is the contradiction a table meets soonest and oftenest. The cheap fix is the player rolling it, which is what `13:21` already says happens for initiative.

**5. The defense roll's Boons now pool from three common sources and only the three-step ceiling bounds them.** Shield Block scales to Boon 3 at Master (`16:114`), Boons net step for step (`06:59-63`), and Defend and cover are Boons on the same roll. One Reaction plus a Maneuver plus a wall of cover is Boon 3, six dice keeping the highest three, on the roll that decides damage. Nothing in the book prices that, and it is the same drift item 2 measures from the other end: the party's defense grew faster than the monsters' offense.

**6. Recurring is a keyword with numbers and no definition.** Six sites carry it (`12:143-147`, `12:189-193`) and the glossary promises that every mechanical term is defined in one place (`21:13`). A healer reading their own card has to guess whether "Recurring 3" repeats on their turn, on the target's, or at the start of the round.

**7. A maneuver's numbers do not scale with the tier that gates it.** `09:278` states the law: a maneuver's block is its Novice effect on the Novice row whatever Disciplines it requires. That is deliberate and the deepening lives in the riders. It is also why a Master maneuver costs 8 DP and prints the same 4/6/8 as a Novice one, which a player will read as a higher price for the same swing until they read the rider.

## 9. What is missing

Printed play still stops where the starter adventure stops, and the bestiary's top three Challenge bands are the emptiest shelf in the book: no Challenge 9, and the only Challenge 10, 12 and 8 are a lich, a dragon and a death knight built at the group rate. Nothing defines legendary actions, though the DA's chapter recommends them for a solo boss by name (`19:61`). The reference sheets cannot run a caster's turn: no spell list, no cantrip line, no Boon and Bane definition, and the damage table there still labels the bands by monster Challenge (`22:325`). And the book has no index, which matters most for the chapter players reach for mid-session.

## 10. The verdict

This is a better game than it was yesterday and a much better game than it was a week ago. The core promise holds, the round is interesting without being long, the survival track is the most distinctive thing the book does, and the equipment rebuild removed the last place where a player could get the fiction and the mechanic out of step. Its middle, levels 1 through 6, is finished enough to put in front of a table tomorrow.

Its top is not. The third act of the game as printed is a party of Master heroes clearing an even field in two and a half rounds while their pool lasts five, meeting bosses with the HP of a minion and the Challenge of a god. That is the next thing to build, and it needs no new rule: the book already prints how a creature is priced (`20:659`) and the book already prints what an even fight costs (`19:55`). The blocks and one table cell are what need to catch up.

**Order of work, from this review:** fix the Standard cell so the DA's two chapters agree (one number in `20:650` and its mirror at `22:339`); apply the book's own creature pricing to the Challenge 6 and up blocks, solo sizes included, and rebase their damage rows onto the sampler's own bands; correct the printed first-session builds so the templates and the quick-build path spend what they say they spend; make the Recharge die a player's roll; then define Recurring on the card that uses it.

## The record behind this review

Read for this review: the spine in full (`01`, `06`, `08`, `10`, `13`, `16`, `19`, `20`) plus `02`, `03`, `04`, `05`, `07`, `09`, `11`, `12`, `14`, `15`, `17`, `18`, `21`, `22`; the eleven walkthroughs W-001 to W-011 as the playtest record; the ledger and the assessment file.

Instruments run against `33cd88d` for this review, all with their selftests passing unless noted: `rounds-to-resolve.py` (PASS at the printed field; clear 3.16 / 2.66 / 2.34 rounds, drop 5.09 / 5.16 / 5.06, rung cost 50.7% / 41.3% / 36.5% of pool), `party-dpr.py` (23.84 a round, 105% of the benchmark, 3.17 rounds to clear the Novice field), `da-walkthrough.py` (49 of 49 blocks PASS, zero unreachable, zero collapsed triples), `bestiary-role-census.py` (45 of 49 blocks decide their own turn; 41 of 49 carry no party-facing priority cue), `class-shelf-cost-census.py` (36 Novice options: 4 Action, 11 Maneuver, 21 triggered), `card-vocabulary-census.py` (7 gate sites: six `Recurring`, one `Boon 2`), `heal-row-census.py` (0 cards on a retired row), `hp-formula-census.py`, `architect-content-census.py` (calibration PASS, 214 cards), `canon-index.py` (159 kB index built, every sampled row traceable), `tier-census.py`.

Claims from audit agents were re-derived against `origin/main` before use, and two were dropped as false: the twelve Adept and Master maneuvers that print 4/6/8 are obeying a printed law (`09:278`) rather than breaking the budget, and the prerequisite shapes on the card corpus are clean.
