# Full catalog review: table play and VTT clarity

**October 13, 2026 — issues #1149, #1150 and #1151.** This is an editorial and
comparative design review of the fresh Markdown catalog, not a balance simulation,
live playtest, independent PR approval or claim that every option is ready.

All **455 records** were read in full: 223 shared abilities, 81 class signatures,
18 universal actions, 20 ancestry traits, four ancestry overviews, 50 origins,
nine classes, 18 disciplines, 22 equipment cards and ten recipes. No legacy cards
were consulted. Existing fresh foundations and the approved conversation decisions
were the comparison standard.

The per-record ledger records what was assessed and what remains problematic:

- [Shared abilities](1149-shared-review.md)
- [Universal actions and signatures](1150-action-signature-review.md)
- [Ancestry, origins, classes, disciplines, equipment and recipes](1151-option-review.md)

Each assessment considered fiction, resolution, practical value and VTT handling.
A revision is not a finding that a card is balanced. “Decision” means the review
found a question requiring design work; it does not mean the record was skipped.
The manifest fingerprints the exact reviewed text so later edits cannot quietly
inherit this review's coverage claim.

## What improved

The catalog has strong foundations for distinct characters: Knowledge melee,
Fortitude elemental strikes, nature forms with their own attacks rather than extra
HP pools, finite-cost healing, paired origins, and useful group travel expertise.
Push, pull, rescue and companion movement produce choices beyond raw damage.
Most such cards need only one roll or a simple no-roll action.

This revision makes the following concrete changes:

- Borrow Tomorrow’s Weather chooses smoke or ice before rolling and places up to
  3/5/7 connected squares, lasting until the end of the caster's next turn.
  Icebound Path, Briar Gate and Smoke in a Bottle use the same useful area scale.
  Their individual range, cover and supply distinctions remain. These companion
  revisions are proposed numbers, not newly approved balance targets.
- Let the Spark Decide and A Splendid Mistake also choose their type before rolling.
  The catalog no longer asks players or a VTT to inspect the smallest kept die for
  an unrelated secondary outcome. Their path description now matches.
- Catch the Spell and Unravel the Bolt grant two Boons to the existing defense,
  with a benefit on Strong defense. Their extra preliminary rolls are removed.
  Actual spell cancellation has not been defined by this edit.
- Signature target fields now name recipients and triggers instead of referring
  vaguely to text below. Level requirements now say **minimum**, not “level 3 only.”
  Delegated Basic Melee attacks identify the actual attack roll.
- Durations agree with continuing benefits. Full activity time has its own field
  on long activities. Crafting a supply and using it have separate instructions.
  Forms show their attack as a separate, explicit sub-action.
- Quiet Latch grants the tools it requires; Break the Charge names its weapon;
  All Voices as One no longer grants a needless weapon to the commander. Ordinary
  recipe permissions and compatible lists agree across cards and recipes.
- Several higher outcomes retain benefits previously lost on a better roll.
  Weak theft now makes progress rather than automatically completing the theft.
  Clearly supernatural effects are tagged Magic.
- Specific value repairs include Armored Recovery's protected step, more lasting
  Company of Reflections protection, useful Master shadow theft/clay passage,
  and simpler Protector Refuge/rescue action costs. These are draft revisions for
  Bruce to assess, not universal increases to damage or area.
- Ancestry trait narratives now more often show a stance, observation or action
  instead of a slogan. No ancestry bonuses or creation budgets were increased.

## Decisions the review cannot settle through copyediting

### 1. Shared rules still needed for standalone play

**Hidden, Invisible and sensory conditions:** several cards legitimately depend
on hiding, dimness, blindness, sleep or invisibility, but the fresh reference is
not yet complete. In particular, Unseen Passage uses Invisible without a defined
fresh rule. Determine hiding's action, roll and discovery procedure before automating
it. Do not import another game's observer-by-observer stealth.

**Reaction timing:** Opportunity Attack, Watch the Rear and Defiant Rescue need a
single interruption policy. Defiant Rescue currently sees lethal damage before
redirecting the attack, so whether the result transfers or is rerolled is material.
Do not implement an arbitrary extra defense roll in a VTT to fill that gap.

**Summons:** commands are defined; NPC attacks against summons, controller death
or incapacitation, and commandless bodies blocking squares are not fully resolved.
The three one-HP ancestors particularly deserve a blocking/spam test once resolved.

**Movement and control:** ordinary jump/swim/climb distances, prone movement,
adjacent pull geometry, collision-group footprints, same-grappler reapplication,
and midturn removal/application of action-limiting conditions need common rulings.
Hook and Drive is especially exposed: a target already adjacent has no closer free
square without entering the attacker's square. Specify a redirect or a step first;
do not claim the printed pull already solves that geometry.

**Hands and spell requirements:** record occupied hands, but decide how grip changes
work before VTT potion automation. Silence the Alarm blocks speech; which spells
require speech is not yet specified. Magic tagging alone cannot answer that. Many player-first attack cards also lack a printed NPC defense attribute. Choose these deliberately before giving those cards to creatures; a VTT must not guess every attack uses Agility.

**Healing used offensively:** several healing cards say “willing creature” while
also describing damage to creatures harmed by healing. Decide targeting and rolls
for an unwilling such creature consistently, including potions. The paid HP cost,
Life resistance and minimum-one rules remain intact.

### 2. Signature appeal needs a focused design pass

Examples still requiring stronger differentiation:

| Cards | Problem | Suggested direction, not implemented |
|---|---|---|
| Stand Together; Turn Their Eye; Useful Interruption | Little beyond universal Aid | Give a distinct team consequence or positioning benefit |
| Unlikely Assistant | Adept signature duplicates Novice ranged Aid | Let Odd assistance solve an unusual situation or help more effectively |
| Test the Hypothesis; Study the Pattern; Spot the Leverage | May reveal only information already owed, or nothing | Give a specific actionable discovery without inventing facts |
| Predict the Motion | Requires prior observation for an ordinary defensive Boon | Reward reading an opponent more than a generic protective reaction |
| Choose the Edge; Exploit Confusion; Strange but Effective | Narrow triggers or small Master payoff | Make the signature change a meaningful decision at that milestone |
| Restore Composure; Shared Resolve; Refuse the Rout | Expensive high-tier response to decaying conditions | Broader recovery leadership, while preserving HP payment and scars |
| A Route for Everyone; An Unexpected Exit; Leave No Pursuit | Modest movement compared with neighboring signatures | Differentiate party routing, escape and expedition utility |
| One Last Remark | Dramatic but rarely usable | Consider a generally useful role with a Last Words enhancement |

Do not approve whole classes by counting three choices per tier. A nominal choice
between one compelling ability and two weak abilities is not meaningful variety.

### 3. Shared-card value and duplication

Create a Distraction spends Main for support often achievable with Aid. Under Their
Guard avoids only one enemy for two squares, whereas universal Disengage protects
all voluntary movement that turn. Weight of Iron, No Footfall at All and A Ribcage
for a Shield have narrow benefits for their tier. Name the Reckoning's quarry mark
is inert without another purchase even though there is no formal prerequisite chain.

Trail Workshop and Make Something Useful largely duplicate permission, with the
latter adding salvage. Read the Maker's Hand overlaps that same salvage benefit.
Decide whether to combine these or make their benefits genuinely different. Repeated
social 1/2/3 cards also need distinct stakes and scale, not just different stories.

Still the Will and When the Stars Look Back offer very similar repeated disabling
but different damage; changing their printed attribute is not a complete explanation
for the difference. Do not tune paralysis before its turn timing is settled.

Basic Unarmed still deals only one through resistance 3 on Strong. Confirm whether
the earlier “basic attacks should yield two” goal includes unarmed attacks.

### 4. Crafting and entry-route issues

The d4 cap on Lesser Healing Bottle and Clearing Tonic means Weak, Standard and
Strong all create the same supply from out. The roll currently adds no production
variation there. Keep the approved low stock size, then decide whether these recipes
should be no-roll work or give useful outcome benefits other than more stock.
No new production rule was silently invented.

Enchanting Workshop has no special recipe demonstrating its promise. Fit a Replacement
is Master-only even for an ordinary prosthesis. Ordinary derivation's target 12 over
four-hour intervals needs reconciliation with the desired long reverse-engineering
horizon for powerful items. Camp Shelter's portable reward depends on the *finishing*
roll, which may encourage trying to manipulate completion; consider a simpler product
rule when the economy is reviewed.

Smoke/mixing starts grant recipes and tools, not ingredients. Wake the Iron Rune
requires armor but grants none; Ward Scribe and Deep Halls can therefore grant an
initially unusable card unless another choice supplies armor. Make that entry route
explicit rather than silently handing out free kits.

The Grass Sea culture's aquatic option and Messenger's lack of travel expertise
are legal but weaker thematic fits; replacing those pairs is an optional next design
change, not a prerequisite fix.

## Verification and practical limits

Read every record, compared related abilities and universal alternatives, inspected
all changed rule bodies, and checked examples for area placement, resistance,
healing, condition expiry, grants and action costs. Ran the existing Markdown audit,
regenerated navigation, and reproduced the current access survey after updating its
changed action metadata. Card counts, tier prices, discipline prerequisites, creation
budgets and the fourteen shared Passive abilities remain unchanged.

The review manifest verifies coverage and text identity only. Structural checks do
not prove enjoyable play, VTT automation or numerical balance. No new combat simulation,
book layout build or live VTT implementation was performed. The right next step is
to resolve the shared-rule blockers, revise the specifically weak choices, then play
several complete characters using these actual cards.


## Worked resolution checks

These are hand-worked rule checks, not simulation results.

- **Weather:** 3 + 4 + 5 + Guile 1 = 13, Standard. Place five connected squares,
  each within four squares of the caster; choose smoke before rolling. A bent line
  is legal if each new square shares an edge and remains visible. Mark expiry at
  the end of the caster's next turn. No die-face lookup or duration roll.
- **Countermagic:** Catch the Spell spends the Reaction before the ordinary defense.
  Its two Boons meet one incoming Bane, leaving one Boon under the normal rules.
  Roll that defense once. Only a Strong defense triggers the subsequent push.
- **Resistance:** Basic Melee Strong deals 5 physical minus resistance 3 = 2.
  Ember Along the Edge Standard deals 2 physical plus 1 fire. Against physical 3
  and fire 1, both components are absorbed; the whole damage event still deals 1,
  not one per component. Burning is applied separately.
- **Healing:** At 1 HP, the caster cannot pay a Novice spell's 1 HP and remain above
  zero. At 2 HP, payment leaves 1. Shared Breath Standard then restores 6 before
  the recipient's Life resistance; resistance 1 leaves 5, capped by missing HP.
  The caster's payment is never reduced by resistance.
- **Crafting:** From out, a Strong Travel Food attempt reaches d8 by three steps:
  d4, d6, d8. A Lesser Healing Bottle attempt stops at d4 even on Strong. That
  second example demonstrates the unresolved outcome-value issue, not a pass.
- **Refuge:** One Maneuver activates Defend and extends its Boon to one adjacent
  ally. It no longer requires Defend to have been activated with another Maneuver.
  An ally leaving adjacency loses that benefit; the caster's Defend remains.

## Subsequent signature revision

The [full signature review](1153-signature-review.md) supersedes this report’s
signature text and findings. This report and its fingerprints preserve the earlier
review baseline; they do not certify the later revisions.
