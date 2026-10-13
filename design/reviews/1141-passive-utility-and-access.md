# What can our heroes do between battles?

Survey for [issue #1141](https://github.com/bruceamoser/heroes-of-legend/issues/1141),
October 13, 2026. Source: the fresh catalog at commit `9b5eb4c`.
These are findings and recommendations for Bruce’s review, not changes to requirements.
No legacy cards, combat simulations or published-book rules were used as catalog evidence.

Bruce’s concern is substantially right. We have a useful foundation for adventures
outside combat, but far fewer ways to grow into an extraordinary explorer, negotiator,
infiltrator or craftsperson than an extraordinary fighter. Shared passive development
is especially thin. Discipline advancement exists, but hybrid requirements do not.
The evidence does **not** establish that level-1 characters own too many abilities.
It shows a broad, uneven shopping list and a progression structure that needs attention.

## The count, and what it means

The 304 cards comprise 205 shared purchases, 81 class signatures and 18 universal
cards. The 20 ancestry traits are separate. Cultures, backgrounds and fantasy paths
point to cards; they do not multiply the number of distinct abilities.

I read the effects and assigned each shared card to one of three editorial groups:

- **Noncombat-first:** its principal printed job is exploration, social interaction,
  investigation, crafting or lasting wound treatment. Combat applications remain possible.
- **Dual-use:** an explicit capability has a clear adventure use as well as a tactical
  one: crossing a gap, making an illusion, moving an object, tracking with a hound,
  or assisting a general roll. No attack is needed to obtain that benefit.
- **Combat, immediate recovery or limited utility:** attacks, defenses, combat riders,
  temporary condition recovery, survival improvements, and cards whose text does not
  establish a distinct exploration benefit. This is not a claim that imaginative
  players could never use them outside battle.

These judgments are inspectable in the [205-card ledger](1141-card-survey.csv).
Counts are not measurements of usefulness or balance. For example, six separate
wound-treatment permissions add six cards but do not create six different adventuring roles.
A no-roll Main Action is not a Passive ability.

| Shared catalog | Novice / level 1 | Adept / level 3 | Master / level 7 | Total |
|---|---:|---:|---:|---:|
| Noncombat-first | 29 | 10 | 6 | 45 |
| Explicit dual-use | 12 | 10 | 10 | 32 |
| Combat, recovery or limited utility | 47 | 41 | 40 | 128 |
| All shared cards | 88 | 61 | 56 | 205 |
| Passive action, overlapping the rows above | 5 | 1 | 1 | 7 |

Noncombat-first abilities are **22%** of shared cards; including the dual-use group
brings that to **38%**. More tellingly, noncombat-first falls from **33% of Novice**
to **11% of Master**. This is an editorial imbalance, not a proposed quota.

The generous dual-use count includes short-range teleports and tool-carrying summons.
Those are useful, but they do not necessarily sustain a wilderness expedition or a
social adventure. Conversely, I did not count the scent in Borrow the Beast’s opening
line as a tracking power: its rules explicitly use the printed capabilities, which
supply a combat form. Veiled Crossing’s benefit largely concerns provoking; the
text does not clearly improve ordinary concealment. Borrow the Shadow lacks an
explicit movement distance/effect. Those should be clarified before counting them
as substantial utility options.

## Passive development is the clearest shortage

The seven shared Passive cards are:

| Card | Level | What it buys |
|---|---:|---|
| [Conditioned Body](../cards/conditioned-body.md) | 1 | One maximum HP, limited per level |
| [Ordinary Recipe Study](../cards/ordinary-recipe-study.md) | 1 | Two ordinary recipes |
| [Pack with Purpose](../cards/pack-with-purpose.md) | 1 | Stowing during a weapon change for an attack |
| [Take Them Alive](../cards/take-them-alive.md) | 1 | A nonlethal finishing attack |
| [Wear Medium Armor](../cards/wear-medium-armor.md) | 1 | Armor training and resistance |
| [Wear Heavy Armor](../cards/wear-heavy-armor.md) | 3 | Armor training and resistance |
| [One More Dawn](../cards/one-more-dawn.md) | 7 | One additional Grit on acquisition |

Only Recipe Study primarily develops an out-of-combat specialty. There is no shared
Adept or Master passive for being an expert climber, guide, negotiator, observer or
infiltrator. A player wanting to become recognizably better at a craft of adventuring
has few enduring choices to buy.

There are another **30 Passive class signatures**. Some are valuable exceptions:
Intellect’s Make the Connection and Test the Hypothesis, Odd’s Sideways Thinking,
Shadow’s Soft Landing, and Unbalanced’s Crush the Barrier. Three classes also have
passive Aid extensions. These are class-exclusive choices, not a substitute for a
shared catalog. Most remaining signatures reward combat actions.

Ancestry supplies more of the missing feel: An Honest Maker’s Hand recognizes ordinary
workmanship, A Foot in Two Worlds grants languages, Footfall on the Leaves changes
travel through undergrowth, and Second Breakfast helps supplies last. These are good
models of concise, flavorful benefits. Characters choose only two ancestry traits;
ancestry should not be the sole route to a useful lifelong specialty.

**Recommendation:** add shared passives that establish expertise in a concrete
situation, improve what an outcome gives you, or let you help companions. Prefer
“you can secure a line while climbing” or “recognize a familiar forgery technique”
to permanent universal Boons. Avoid reintroducing skill modifiers, mandatory rolls
for ordinary activities, or automatic access to clues that are not present.

## Where the adventure coverage is strong and thin

| Activity | Existing foothold | What is missing or underwhelming |
|---|---|---|
| Climbing | Sure Ascent; catching a falling friend | One dedicated climbing card. No developed expert and master identity for carrying gear, rigging routes or bringing the party after you. |
| Swimming | Expert River Crossing; The Otter’s Bargain; Carry Them to Shore | A credible rescue path. Underwater exploration and operating below the surface remain thin; Otter explicitly supplies no air. |
| Jumping and traversal | Running Vault; Traverse the Impossible; Swing into Trouble; several magical crossings | Better coverage than climbing. More progression is distance or tactical safety than a new adventure capability. |
| Hiding and infiltration | Universal Hide; distraction, illusion, voice, lock and teleport cards | Plenty of tactical slipping away; less sustained shadowing, camouflage, escape from custody, disguises and party infiltration. Ordinary disguise expertise first appears at Master. |
| Travel | Keep Your Bearings; four environment-specific Forage cards; trail reading; Guide the Crossing | Useful basics. Campcraft, shelter, weather judgment, riding, boats and leading a difficult expedition lack comparable developed choices. Do not add exhaustion or routine travel checks to make these useful. |
| Social | Conversation, hospitality, appeal, storytelling, reputation and Turn the Crowd | Repeated progress/information patterns. Bargaining, mediation, intimidation, etiquette, contacts and deliberate deception need stronger identities. Hostile situations and opposing interests deserve attention without compulsory mind control. |
| Investigation and knowledge | Notice the Human Detail; Read the Remains; identification, divination, translation, reconstruction | A good foundation. Broader scholarly specialties, information networks and meaningful master discoveries remain thin. Ordinary clue discovery must stay free of unnecessary rolls. |
| Craft and treatment | Recipes, salvage, brewing, derivation, six treatment permissions, prosthetic fitting | Substantial nominal coverage. Recipe availability controls real usefulness, and Medicine has only one Adept and one Master shared card. More treatment names alone will not create a satisfying career. |
| Magical utility | Light, voices, flat illusion, ice bridge, object movement, small-opening passage, helpers | Promising. Many magical fantasies still culminate in damage, defense or a short move. Communication, sensing, shelters and useful transformations need attention on their own merits. |

Three examples make the progression problem tangible:

- [Borrowed Identity](../cards/borrowed-identity.md) costs 8 DP, needs Subterfuge 3
  and level 7, but still describes a prepared mundane disguise with 1/2/3 progress.
  A convincing impersonator needs an earlier entry and a more remarkable Master promise.
- [Guide the Crossing](../cards/guide-the-crossing.md) needs Wilderness 3 and level 7.
  Its Strong result adds a Boon for one traveler. It does not yet read like the guide
  who can bring a company through a place others would never attempt.
- [The Otter’s Bargain](../cards/the-otter-s-bargain.md) is a stronger model of identity:
  one simple transformation changes how you travel through water for the scene.
  The benefit is easy to imagine and to use.

Some lower-level specialists also need checking against the agreed “better at every
outcome” principle. For example, Hold a Conversation’s Weak result is only ordinary
progress; it does not state the additional benefit that makes the specialist better.
We should repair this through useful outcomes, not more restrictive permission to talk.

## Discipline gates: progression exists, combinations do not

| Shared tier | No discipline | One discipline | Multiple disciplines |
|---|---:|---:|---:|
| Novice | 7 | 81 | 0 |
| Adept | 0 | 61 | 0 |
| Master | 1 | 55 | 0 |

**197 of 205 shared cards require exactly one discipline.** Every discipline-gated
Novice requires rank 1, every Adept rank 2, every Master rank 3. Recipe Study also
requires a compatible crafting card; that is a practical permission requirement,
not a second discipline.

The seven discipline-free Novice cards are Catch a Falling Friend, Conditioned Body,
Hold a Conversation, Keep Your Bearings, Notice the Human Detail, Pack with Purpose
and Tell a Worthy Story. One More Dawn is the eighth discipline-free shared card,
at Master. That is only **3.9%** of shared cards.
“No discipline” is not the main source of broad access. Universal cards are deliberately
free, and signatures deliberately use class and level instead of disciplines; neither
should be included as evidence of an accidental missing gate.

The concern about absent hybrid development is completely supported. A sword-and-flame
technique currently asks for Flame alone. A life-oriented craft does not ask for Life.
That makes the discipline investment less expressive than the character fantasy.
It does **not** mean rank-3 requirements are missing: 55 Master cards already use them.

### What a rank actually opens

Each cell counts shared cards at that tier, before paying for the cards themselves.
Higher ranks retain earlier access. Recipe Study also needs crafting permission.

| Discipline | Novice | Adept | Master |
|---|---:|---:|---:|
| Armor | 3 | 3 | 2 |
| Arms | 5 | 4 | 4 |
| Athletics | 5 | 3 | 2 |
| Calling | 5 | 4 | 4 |
| Craft | 5 | 3 | 3 |
| Flame | 6 | 6 | 5 |
| Frost | 1 | 2 | 1 |
| Guard | 2 | 2 | 2 |
| Influence | 5 | 4 | 4 |
| Life | 4 | 3 | 3 |
| Marksmanship | 2 | 2 | 2 |
| Medicine | 8 | 1 | 1 |
| Mind | 5 | 4 | 4 |
| Radiance | 3 | 2 | 2 |
| Scholarship | 6 | 5 | 4 |
| Storm | 3 | 4 | 3 |
| Subterfuge | 5 | 4 | 5 |
| Wilderness | 8 | 5 | 4 |

One rank of Medicine opens eight possible purchases; one rank of Frost opens one.
That is a larger demonstrated inequality than the number of discipline-free abilities.
It is not an eightfold power comparison: treatment permissions and combat spells serve
different needs. It does mean some rank choices have much more visible value, and
Medicine’s higher ranks offer a particularly narrow next step.

### Starting access versus starting ownership

The reproduction script enumerates **472,320** printed culture/background/class-rank
combinations: 36 culture pairs, 64 background pairs, and each class’s legal pairs.
These are combinations, not a probability distribution of likely characters.

This is a **grant-only access snapshot**: count eligible Novice shared cards, remove
the origin cards already granted, and do not yet spend either stage’s DP. It isolates
what the starting grants unlock. A completed level-1 sheet also has its level-0 purchases,
which reduce the unowned list; later discipline purchases may expand it again.
It is not an enumeration of every affordable finished build or an upper bound after purchases.

| Class | Remaining eligible shared cards from grants alone |
|---|---:|
| Arcanist | 9–33 |
| Blade | 12–31 |
| Intellect | 15–33 |
| Leader | 12–32 |
| Odd | 8–33 |
| Protector | 10–32 |
| Shadow | 12–31 |
| Shepherd | 12–33 |
| Unbalanced | 11–31 |

All these origin/rank combinations can meet their class minimums: for example,
Brawn 1, Fortitude 1, Agility 0, Guile 0, Knowledge 1, Reason 0 totals +3 and meets
every class’s minimums. The script respects Recipe Study’s additional permission.
It emits the exact choices witnessing each minimum and maximum.

A concrete Arcanist example shows why “33 options” does not mean “33 abilities”:

1. Cloister Valleys grants Medicine 1 and Treat Mental Trauma; Beast-Reared grants
   Wilderness 1 and Borrow the Beast. With the attributes above, level 0 has 11 DP.
2. Spend 10 on five eligible cards: Treat Bone, Treat Soft Tissue, Forage Woodland,
   Guide a Frightened Animal and Keep Your Bearings. The remaining 1 DP expires.
3. Choose Flame 1 and Scholarship 1 from Arcanist, plus its free signature. Four
   distinct disciplines now open 35 Novice shared cards in total: seven ungated,
   eight Medicine, eight Wilderness, six Flame and six Scholarship.
4. Two were origin grants and five were bought at level 0, so **28 remain unowned**.
   The fresh 11 DP buys five more 2-DP cards if spent on cards alone. For example,
   Cinder Cast, Speak with the Hearth, Identify an Enchantment, Read the Remains
   and Anatomy of an Opening. Again 1 expires. No rank purchases or duplicate bonuses
   are assumed in this example.

The result is **12 owned shared cards plus the signature**, in addition to universals
and ancestry traits. That is a substantial starting character, as intended. We still
need play feedback on the decision load; these counts do not prove excess power.
Other attribute allocations, duplicate compensation and discipline purchases change
what is affordable. Across legal attributes, the base pool is 7–16 DP per stage
before duplicate compensation; it is not universally 11.

## How I would revise the design next

First, write the missing adventure careers: the expedition guide, mountaineer,
water explorer, infiltrator, negotiator, investigator and practical craftsperson.
For each, describe what makes a Novice useful, an Adept sought after, and a Master
legendary. Give each both active choices and enduring expertise, with enough options
to express different approaches. Keep progress where it fits, but let higher tiers
change the situations a character can handle or the companions they can bring along.

Second, give discipline requirements two legitimate routes:

| Kind of development | Candidate requirement pattern | Purpose |
|---|---|---|
| Ordinary entry | None or A1 | Accessible fundamentals and an immediate specialty |
| Hybrid entry | A1 + B1 | A technique whose identity really draws on both fields |
| Adept specialist | A2 | Deeper expertise without forcing an unrelated investment |
| Adept hybrid | A2 + B1, or A1 + B1 for a suitably modest effect | Deliberate combination, priced by its actual benefit |
| Master specialist / ultimate | A3 | The payoff for deep commitment to one discipline |
| Master hybrid | A2 + B2 or A3 + B1 | A distinct achievement combining fields |

These patterns are proposals, not mandatory formulas or card chains. Keep meaningful
single-discipline paths and powerful rank-3 destinations. Do not make every ultimate
buy a second discipline merely to satisfy a progression diagram.

Good candidates to discuss include **Ember Along the Edge** drawing on Arms + Flame,
and a magical healer-crafter drawing on Craft + Life. By contrast, brewing an ordinary
herbal remedy should not require Life simply because it restores HP. A mountaineer’s
Athletics 3 ultimate should work without compulsory magic. Prerequisites must describe
what the character has learned, rather than impose arbitrary taxes.

Mixed requirements do not automatically slow level-1 access. Characters can begin
with four distinct rank-1 disciplines. A1+B1 can therefore be satisfied entirely by
grants. If B1 must be bought, its current price is 1/2/3/4 DP by affinity; if already
owned, the marginal cost is zero. Compare that with raising an existing A1 to A2 at
2/4/6/8 DP. We must evaluate **actual acquisition paths**, not assume that two names
on a card make it harder to learn.

Third, audit origins and suggested starting lists against any approved new requirements.
A granted card must still come with everything needed to learn it. Requiring two ranks
for an origin card cannot silently break the one-discipline paired origin structure;
choose another appropriate entry card or explicitly review the grant design.
Preserve sequential rank purchases, fixed card prices, no prerequisite ability chains,
and class-and-level-only signatures.

Finally, repeat this survey on the revised catalog and walk through sample purchases
at levels 1, 3 and 7. Measure both the choices newly opened and the DP left to buy them.
Only then judge whether creation DP or discipline prices need changing. At present,
I recommend changing **coverage, utility ambition and prerequisite composition first**.

## Reproducing and interpreting this review

Run `python3 design/reviews/survey_1141.py` from the repository root. It reads the
current Markdown and the [classification ledger](1141-card-survey.csv), verifies the
ledger’s IDs/tier/action/requirements, and prints counts plus access witnesses as JSON.
The ledger is an editorial snapshot: body edits require rereading the classification;
metadata checks cannot detect changes in the meaning of prose. Signature and ancestry
observations above came from direct reading, outside the shared-card classification.

This is a catalog review, not a character-power test, usage study or combat simulation.
No card text, costs, requirements, origins or agreed rules were changed for this survey.
