# Signature development plan — rewrite #299 / #301

> Signature composition is superseded by [independent signature choices (#1354)](independent-signatures-1354.md). Earlier foundation bundling and line replacement are historical, not current rules.

> Implementation update, November 16: the approved nonmagical costs are **1/2/2/3/4/4/5 DP** (21 total). Current canonical sources implement this rewrite; any earlier candidate below records design analysis.

Design review, November 15, 2026. This is a concrete candidate design, not an approved catalog replacement. It changes no cards. Bruce's authorized direction is class-defining signatures with development at levels 3 and 7, while preserving one free signature choice at each of levels 1, 3 and 7. No DP is granted or charged by this plan.

## Sources and boundaries

Read all 90 authored [signature cards](../cards/), [class introductions](../classes/), [learning](../rules/learning.md), [magic](../rules/magic.md) and [recovery](../rules/recovery.md), alongside the published Workshop [signature review](https://github.com/bruceamoser/heroes-of-legend-foundry/blob/main/Build-Offs/class-signature-review.md). Issue [#299](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/299) supersedes the book's staged creation, flat discipline entry, paid intersections and 1-SP sustain remnants. Follow-through is [#301](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/301); discipline destinations below belong to [#302](https://github.com/bruceamoser/heroes-of-legend-foundry/issues/302).

Use the existing roll, current death procedure, one sustained spell, Maneuver/0-SP upkeep, highest matching resistance and attack minimum. All numbers below are candidate mechanics requiring comparative review; nothing changes encounter budgets. Unarmed development belongs in a shared discipline, not a mandatory class signature. Animal shape belongs primarily to Shepherd here, while Warden develops hunting, beasts and paired weapons. Magic books retain utility and combat breadth; signatures do not grant entire books.

## Selection and display contract

Offer three named signature lines per class. At level 1 choose one foundation. At levels 3 and 7, choose either the development of a known line or a self-contained signature from another line appropriate to that milestone. Show these as **Develop [name]** and **Learn [name]**, with the full resulting mechanic visible. A higher entry supplies any indispensable activation rule, never an unusable reference to an unlearned card.

Recommended implementation of late entry: each milestone card states a complete current version. A new level-3 or level-7 selection supplies that version's foundation and named milestone benefit, but does not silently supply a different earlier milestone's extra action. Deepening preserves earlier benefits actually learned. Example: learning Deathless Rage at 7 includes Go Berserk's activation and the approved reprieve; Pain Feeds the Fire belongs only to a character who selected that level-3 development. This preserves the value of deepening and avoids paying three grants for one functional identity. It also avoids three grants being hidden inside one late selection.

One line appears once on the sheet, with its learned developments under inline details. The audit trail records the three milestone selections independently; the character's DP ledger is untouched. Players retain the existing right to switch signatures. Switching one selection does not automatically choose or grant replacement developments in its dependent milestone slots; show and resolve those affected selections together. There are no additional level gates.

## Shared precision rules for the candidates

- **Ordinary** signatures use normal ability/equipment rules. **Spell** signatures use casting, free-hand, opportunity attack, cancellation, target defenses and printed SP rules. **Spell shaping** modifies an existing casting, is not a second spell, and inherits that casting's costs and interruption. **Magical weapon modifiers** apply to the stated weapon attack, require its normal equipment and action, and are not separate castings; their attack is magical for explicit targeting/immunity tests. Magical flavor alone never changes a classification.
- Every new standalone magical active effect below is a **Spell** unless explicitly described as a modifier or a bound item. Existing magical effects carried into a line get the same label. A spell can cost 0 SP. Ritual means magical casting with a stated time; ordinary investigation and treatment show their actual time instead.
- A **bound item** is an ongoing magical effect with its stated cancellation target and remedy. It does not use sustain. Its owner and slot remain recorded even when it is lent, dispelled, sold or lost; ending/replacing the bond is the only way to free that slot. Ordinary crafting retains its own costs and work.
- Every attack uses one printed attribute, individual resistance and the 1-damage floor after immunity. Reductions to non-attack damage can reach 0. An added damage amount belongs to the original attack, not a second minimum-damage event. Bonuses from a signature modify a learned attack only when explicitly stated; they do not copy that learned attack's effects onto a Basic attack.
- Granted attacks cannot chain further granted attacks. A signature granting a Reaction still uses the ordinary Reaction budget unless it explicitly adds one. Once/scene abilities refresh only when the DA identifies a genuinely new scene, not through leaving initiative and returning.
- A reroll replaces the original roll before any damage, progress or conditions resolve; keep the new result. Boons/Banes use the normal three-die cap. An enemy attack Bane becomes the equivalent Boon on a player's defense.
- Held spell targets use #299's Main Action escape and player-facing attribute procedure. Magical holding does not invoke physical Grappled 3's no-self-release rule. Each spell block must print casting, maintenance-resistance and escape attributes when relevant.

## Thirty signature lines

Each row gives a foundation, a level-3 development and a level-7 development. “Keep” means the named source mechanic, subject to the explicit corrections here. Unmentioned source features are not automatically acquired. New mechanics are proposals. Durations measured in rounds expire at the stated turn boundary; scene effects end at scene end.

### Arcanist

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| Bent Trajectory — the spell shaper | Spell shaping. Keep the visible origin within 6 squares; measure range from caster, cover/path from origin. Target location must be known. Applies to one spell attack per turn, without an extra action. | Create a Window: Reaction at the start of one willing ally’s turn, two visible empty squares within 6; one passage costing 1 movement or one attack through them. Spell, 0 SP, expires at ally turn end. No extra attack. | Choose the Edge: Reaction with a single-target instantaneous rolled spell; two distinct targets, separate rolls, pay once, 2 defense Banes until next turn. Once per scene. Sustained or fixed ongoing spells are outside this version, avoiding duplicated control and item production. |
| Study the Pattern — the magical scholar | Maneuver, Reason, known ongoing magic within 5: learn 1/2/3 facts chosen from purpose, remaining duration and source category. Once/effect/scene; no automatic true names, exact hidden origin or curse remedy. Gain one-use Boon when applying a learned fact this scene. Spell, 0 SP. | Reading the Weave: after studying an effect, your next cancellation roll against it this scene gains 1 Boon; you can identify whether a specific remedy exists and what sort of evidence is needed to discover it. Does not supply the remedy or cancellation ability. | Open the Circle: keep Maneuver ward, allies within 2, spell-defense Boon and Stability 2 until next turn. Spell, 0 SP. In addition, you can share the facts you actually learned; no unseen-effect omniscience. |
| Deliberate Spark — the volatile mage | Keep 0-SP Maneuver flare, corner of own square, push all nearby creatures including self 2; collisions normal. Spell with explicit exception: its casting does not provoke. Once/turn. | Arcane Deflection: Reaction declared before spell defense, once per scene. Resolve defense to identify incoming damage, prevent that spell event’s damage to you, then push affected corner-adjacent creatures min(3, resolved damage before reductions). Conditions still apply. This prevention is explicit, not resistance below minimum. | Folded Aegis: Main, 0-SP Spell, once per safe overnight rest, fixed 2 hours. Physical/fire/cold resistance 3, highest-source cap. Visible conjured armor, no training requirement. This is deliberately a high-milestone defense, not ordinary armor progression. |

### Blade

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| Reckless Charge — the relentless fighter | Maneuver, move 2 toward visible enemy, Basic Melee with weapon, defense Bane until next turn; once per scene. Remove extra 1/2/3 damage: its defining reward is an extra attack and movement, not a superior replacement for paid Arms attacks. | Press On: once per use of Reckless Charge, move another 1 after the Basic attack without provoking. May instead use that signature twice/scene; this is a fixed added use, not a refresh on kills. | Relentless Pursuit: keep Reaction pursuit/basic attack and Slowed 1/2/3, once per scene. Requires reachable endpoint and melee weapon; ordinary movement barriers apply. |
| Measured Guard — the duelist | Keep Reaction before adjacent attack defense, 1 Boon, Strong grants Basic Melee counter after resolution. Requires weapon; counter cannot trigger another granted attack. | Return Stroke: Measured Guard now counters on Standard or Strong, still one Reaction and one Basic attack. This upgrades the trigger rather than adding a competing button. | Twitch Reflexes: one additional Reaction each round, usable only for Measured Guard or an opportunity attack; never twice against the same triggering attack. Other reactions retain one ordinary budget. |
| Cleave — the close-quarters fighter | Keep Main/Brawn, all adjacent creatures including allies: 1 physical damage, push 0/1/2. Weapon required. This is crowd displacement rather than a stronger Sweeping Blade. | Not So Fast: Reaction when enemy enters weapon reach voluntarily, Basic Melee; movement stops on Standard/Strong until next turn. Once/round. Weak still damages but does not lock movement. | Dance Through Steel: keep Main/Agility, up to three enemies, 4/4/6 physical and safe step 0/1/2. Once per scene; paid Arms multiattack remains the repeatable practice. |

### Intellect

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| Spot the Leverage — the analyst | Keep Maneuver information and one-use party Boon against one visible creature/obstacle within 5, once/target/scene. Only observable defense/weakness and objective information, not hidden personal history. | Diagnose the Failure: Reaction to ally’s Weak attack or objective roll within 5, before effects, reroll with 1 Boon and keep it. Once per scene. Requires communicating an applicable correction. | Test the Hypothesis: one minute of ordinary planning, evidence required; DA states known truth, uncertainty and one risk. Up to three allies and self get 2 Boons on one directly relevant roll this scene. One active plan; new evidence required to repeat. |
| Make It Last — the enchanter | Ritual 1 hour, 1 SP, tools and one owned ordinary item within reach. Bind one item indefinitely. Choose one fixed property: lamp gives controllable ordinary torchlight; tool returns to your empty hand by Maneuver within 3 and clear path; shield lets bearer use Reaction once per scene to reduce one attack’s damage by 1, respecting minimum. One active bond total, no market-value multiplication. Cancellation target 3; ended magic needs fresh ritual/SP. | Two active bonds, different items; add weapon option: once per scene bearer declares before a weapon attack to convert its physical damage to fire or cold. Damage number and learned effects unchanged. The entire attack converts, not extra damage. Bound magic is dispellable, ordinary item remains. | Three active bonds; one may be a masterwork: wearer uses Reaction once per safe overnight rest to gain 2 Boons before one defense roll. Use tracked by bound item and owner, not renewed by lending/rebinding. No item grants armor training, spell repertoire, SP or extra actions. |
| Angle of Attack — the calculating combatant | Maneuver study one visible foe within 5; until next turn your next legal weapon attack against it may use Knowledge in place of its normal attribute. Uses that attack’s printed damage/effects. Once/turn, not a free 3/5/7 attack. Learned weapon techniques stay valuable. | Predict the Motion: while that study is active, Knowledge may replace Brawn/Agility for defenses against that foe only. Other enemies retain normal defenses. | Shatter the Guard: once per scene when your studied weapon attack resolves, reduce one of that target’s existing resistances by 1 for scene, minimum 0. Each target can suffer this once from this named effect; immunity unchanged. No additional 5/7/9 attack. |

### Leader

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| Follow My Signal — the inspirational leader | Keep universal Aid applying to two perceiving allies within 3; each gets normal one-use Boon to declared task. May be spoken, signed or musical. No roll bonus from merely possessing an instrument. | Press the Opening: Maneuver, one ally within 4 makes Basic Melee or Ranged; once per scene, weapon/range normal. Strong may push 1 for melee only. No free movement, leaving Intellect’s planned movement separate. | Coordinated Rush: Main, two allies within 4 each move 3 safely then Basic Melee/Ranged; once per scene, sequential, no attack chains. This is one order, not two complete turns. |
| Lead the Way — the field commander | Keep Maneuver linked movement, allies within 3 follow same legal path up to 2; ordinary opportunity rules. No free teleport across your path. | Lead by Example: Main/Guile weapon attack 2/4/6, fixed additive outcomes: Standard allies within 5 may step 1 safely; Strong also grants those allies a one-use attack Boon against target until next turn. Remove per-hit menu and Dazed choice. | Watch the Rear: keep Reaction before ally defense within 5, 2 Boons then safe move 3 if able. Once/round and normal Reaction budget. |
| Stand Together — the rallying leader | Maneuver, self and adjacent ally gain 1 defense Boon while adjacent until next turn; once per scene one of these defenses may instead receive 2. Avoid sustained 2-Boons blanket superiority over paid Guard. | Blow the Horn: keep Maneuver/Guile fear/daze bands to hearing enemies within 5, once per scene. Normal player defense conversion; hearing and immunity matter. | Refuse the Rout: keep Maneuver four recipients, ordinary fear/daze reduction 2, next-defense Boon and safe step 1. Once per scene. Gives recovery rather than a second healing pool. |

### Odd

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| The Bargain — the pact-bound | At selection name patron/compact together; patron fiction cannot remove player agency. Learn a 0-SP Main/Reason Spell, Pact Bolt: visible target within 8, force 2/3/5. Once per scene before its roll accept 1 defense Bane until next turn for 1 attack Boon. No extra patron currency or SP restoration. | Pact’s Claim: on Standard/Strong Pact Bolt, choose before rolling to forgo 1 damage to apply Slowed 1/2 respectively. Weak remains original damage. This declared mode is a casting choice, not an accumulating after-roll menu. | The Price Deferred: once per safe overnight rest, Reaction when you would receive third death failure: delay death until next turn using Not Quite Yet’s approved stabilization/healing/Grit window. Self-only for this line; no restored Grit or deleted consequences. |
| Borrowed Tongue — the spirit medium | Keep heard-language speech/understanding for scene, Maneuver, 0-SP Spell. No literacy/obedience. Spirit invitation is consensual fictional identity. | Out of Body: keep body vulnerable, one-turn projection and legal Manifest restrictions. Spell, 0 SP, once per scene. Replace “mundane” immunity with: ordinary attacks cannot target spirit; spells and attacks explicitly tagged magical can. Body remains a legal target. Damage to either is shared. | Borrowed Life: Main, 0-SP Spell, scene; choose one named tool practice or one noncombat objective approach, gain 3 Boons for it. Once per safe overnight rest. Does not grant weapon training, learned abilities, extra attacks or a universal “magic” skill. |
| Use Their Voice — the uncanny trickster | Keep 0-SP Maneuver Spell: ally within 5 moves 2 safely and gets next-attack Boon against a hearing enemy. Once per scene; target turns but does not lose an action or become controlled. | A Door Where There Wasn’t: Maneuver Spell, 1 SP, once per scene; self+carried gear through nonmagical barrier at reach, maximum 1 square thick, visible safe far destination. Closes on passage or next turn. No general teleport through unknown barriers. | The Unseen Procession: keep spectral Main Spell, 0 SP, once per scene, 5-square group step/defense and enemy next-attack Bane, expire end of next own turn. Two equivalent protections against same attack use strongest named benefit, not double counting. |

### Protector

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| Step Between — the bodyguard | Keep adjacent swap Reaction before single-target attack roll; legal squares, target becomes self. Ordinary. | Over My Body: retain approved once per scene 3-square intervention, movement 2 squares, triggering fatal damage or 0 HP/two failures, take damage and stay 1 HP. Do not reopen this approved reprieve. | Take the Wound: keep range 5 Reaction fatal-event redirection, own resistance once, attached conditions transfer; once per scene. On same event choose one intervention, never chain protectors indefinitely. |
| Healing Hands — the sworn guardian | Maneuver/Reason Spell, 1 SP, free hand touching self or living recipient: heal 3/5/7; ordinary Life resistance and death clearing. Once per scene: the short-reach emergency touch leaves your Main Action available, distinguishing it from Shepherd’s repeatable ranged Main Action healing. | Restoring Hands: same action/cost/limit; also reduce one temporary Bleeding, Burning or Freezing by 1. No starred-condition cure. Explicit improvement, not another heal button. | Sheltering Hands: after healing, recipient gets 2 Boons to its next defense before your next turn. Once per safe overnight rest may also stabilize a second adjacent Dying ally as part of same action. No extra HP pool. |
| Oathstrike — the avenging guardian | Magical weapon-attack modifier (not a separate casting): on one melee weapon attack on your turn, declare and pay 1 SP before rolling, once per turn. Add radiant 1/2/3 to that attack, apply resistance per component and minimum once. Requires enemy damaged an ally since end of your last turn; ordinary weapon attack/equipment retained. | Oathstrike additionally pushes target 1 on Standard/Strong directly away from chosen harmed ally (define line from ally); on Strong Dazed 1. Stability/collision normal. No added attack. | Radiant Threshold: keep Main/Reason line length 3/5/7, radiant 1/2/3, chosen allies exempt, fixed until next turn; Spell 2 SP, once per scene. One active line, each creature damaged at most once per round; zone damage after creation follows non-attack floor rules. |

### Shadow

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| Blade in the Back — the opportunist | Keep conditional Main/Agility melee 3/4/6 and Bleeding 0/1/2, unnoticed or ally adjacent. Must wield melee weapon; this is a particular signature attack, not every attack upgraded. | Hamstring: after Blade in the Back, add Slowed 1 on Standard/Strong and Dazed 1 on Strong; additive fixed improvement instead of a second competing attack. | The Half-Second: keep Reaction weapon interruption 3/5/7 with Standard/Strong cancel and Strong Dazed 1; once per scene, legal reach/range, before action costs/effects resolve except committed action itself. No interrupting another interrupt. |
| Fade Behind — the infiltrator | Keep Disengage+ordinary Hide attempt with 1 Boon as Maneuver, cover/obscurement required. Ordinary, no automatic invisibility. | Silent Work: when hidden, your ordinary/learned lock or trap work remains quiet; completing it leaves no obvious traces. Uses selected technique’s progress/time and tools, not free superior 2/3/5 Main progress. | One with the Dark: keep once per scene Main concealment in dim/dark,3 Boons to remain concealed, ends attacking/revealed/bright. Plausible route still required. |
| Fast Talk — the social rogue | Keep Maneuver/Guile objective 2/3/5 toward one listener within 5, meaningful new argument and DA-set feasible concession. Once per exchange, no repeated same argument. | Read the Room: keep Maneuver/Guile intent+social Boons 0/1/2, once/creature/scene. Not thought control or an infallible lie detector. | The Cutting Word: keep Maneuver/Guile Dazed 1 /Dazed 1+Frightened 1 /Dazed 2+Frightened 1+reaction restriction; once per scene, visible or hearing target within 10. Ordinary social pressure with normal condition immunity. |

### Shepherd

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| Mend — the healer | Keep Main/Reason, 1 SP, free hand, range 3, healing 3/6/9 and Strong stand. Spell; normal Life resistance and Dying rules. | Triage: keep 2-SP Main, one recipient 6/11/16 or two recipients 4/7/10 within 3. Keep Mend available for 1 SP, presenting target count and cost together. | The Shepherd's Call: Ritual 10 minutes, 0 SP, three willing recipients, once per safe overnight rest. First fall stays at 1 HP; unused sigils expire at dawn. A recipient has at most one sigil. |
| Steady Voice — the keeper of the flock | Keep ordinary Maneuver/Guile fear or daze care within 3. Its unused resistance Boon expires at the start of your next turn. | The Fold: Main/Reason Spell, 0 SP, 3×3 area within 5; ally Boon. Sustained, Maneuver and 0 SP, maximum 1 minute. Uses the sole sustained-spell allowance. | The Shared Cup: keep Main Spell, 0 SP; two willing creatures within 5 transfer up to 6 HP. Donor stays positive; ignore Life resistance on this conserved transfer. Once per turn. No conversion to SP. |
| Borrowed Shape — the beast-form guardian | Main Spell, 1 SP, once per scene, fixed 10 minutes. Familiar Small/Medium ground-beast appearance. Keep own HP, attributes, conditions, resources and Speed. Natural Main/Brawn attack 2/3/5 physical. Gear melds; cannot use it or cast, and speech becomes animal calls. Return by Maneuver or automatically at 0 HP; no HP reset. Melded armor supplies no resistance; form grants physical resistance 1. | At transformation choose swim at Speed with water breathing, climb at Speed, or ground movement with one tracking-by-scent Boon. Changing adaptation requires another casting; still one casting per scene. | Choose a Large ground form with natural attack 3/4/6 and Strong push 1, or Small flying form with fly Speed and the basic 2/3/5 attack. Keep the same HP and form resistance. No imported monster actions or CV profiles. |

### Unbalanced

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| Go Berserk — the berserker | Keep ordinary Maneuver rage once per scene, attack Boon and defense Bane, physical resistance 1 using highest source. Ends at will, scene end, unconsciousness or Dying. | Pain Feeds the Fire: hostile damage during rage grants one Boon to next attack before end of next turn, normal cap. Self, allied and deliberately inflicted hazard damage does not generate this benefit. Late entry includes rage activation. | Deathless Rage: retain approved stay-at-1 reprieve, healing deadline and further-damage exposure. Late entry includes rage activation; Pain Feeds the Fire belongs only to a character who selected it at 3. |
| Charge — the living battering ram | Keep Main/Brawn straight approach of at least 2, damage 2/3/5, push 1/2/3, Prone on Standard/Strong. Ordinary opportunity attacks; movement spends remaining Speed, not an extra full movement allowance. | Rampage: keep once-per-scene Main plus movement, path damage 2 and push 1, endpoint attack 3/4/6 with Prone on Standard/Strong. Each creature takes path damage once; endpoint attack is a separate event. | Earthbreaker: keep once-per-scene Main/Brawn radius 2, damage 2/4/6, push 1/2/3, Prone on Standard/Strong, Dazed 1 on Strong. Objects take double under ordinary object rules. |
| Grab and Hurl — the mighty wrestler | Keep Main/Brawn, adjacent target your size or smaller, free hand. Weak Grappled 1; Standard throw 2 and Prone; Strong throw 3, Prone and 2 physical. Normal collisions. A control-only Weak is not damaging and adds no minimum damage. | Over the Top: keep Maneuver willing-ally throw 4 and granted Basic Melee with a Boon, but once per scene. Legal empty landing and size limits; no granted-attack chains. | The Cannonball: keep Main/Brawn approach 2+, target damage 4/8/12, self damage 3/2/1 and printed Prone/Dazed tradeoffs, once per scene. Self damage is self-inflicted non-attack damage (not an HP payment), may reach 0 after resistance, and cannot feed rage Boons. |

### Warden

| Line | Foundation — level 1 | Development — level 3 | Development — level 7 |
|---|---|---|---|
| Steady Aim — the hunter | Keep Maneuver aim Boon and partial-cover exception until movement; ranged weapon/ammunition. Ends on a new target or scene end. Target must still be perceivable to attack. | Volley: keep ranged Main, one least-favorable roll over a 2×2 area, physical 1/2/3, all creatures including allies, individual resistance. Paid Marksmanship supplies other targeting and damage options. | Mark the Quarry: keep once-per-day Basic Ranged plus day-long mark, party 2 Boons and cover/Hide effects while visible. Remove hit check; immunity does not prevent marking. Proposed counterplay: cleaning physical glow takes 1 minute; covering the mark suspends visual benefits. |
| Beast Speech — the wild companion | Keep Maneuver Spell, 0 SP, scene animal communication and interaction Boon. Animal motives remain independent. A willing companion comes through the fiction, not an unpriced combat profile. | Wild Partnership: once per scene, Maneuver, a willing beast within 6 moves up to its Speed and performs one ordinary nonattack task such as fetch, track or carry. No additional beast turn; DA controls it outside commands. | Call the Wild: Main Spell, 2 SP, once per scene, one specifically authored level-7 companion profile, replacing open CV selection. No arrival attack. Once per turn command within 6: Main grants one Main and movement; Maneuver grants one Maneuver and movement. Real beast can heal and does not vanish when uncommanded. Only one beast may be your active companion through this signature; calling another releases the previous one from this command relationship to ordinary DA control, not disappearance. Profile is a follow-up dependency, not permission to change encounter budgets. |
| Twin Strike — the woodland skirmisher | Keep Main/Agility, two light weapons, two 1/2/3 attacks, defense Boon until next turn. Individual resistance; both hands occupied. | Through Bramble: after Twin Strike, step 1 without provoking or spending movement, once per turn. Damage unchanged; paid weapon paths retain their own attacks. | Death from the Blind Spot: keep once-per-scene Main plus movement, safe approach up to 6, Agility 6/9/12 and printed control against a tracked or previously damaged target this scene. Requires legal adjacency and weapon. No hit-check wording. |

## Migration ledger: all 90 current stable IDs

**Retain** preserves the core mechanic while locating it in a line; shared timing/classification clarifications still apply. **Revise** changes its effect or limit and needs visible design review. **Rehome** preserves a useful concept for a specific paid destination, subject to #302's complete branch budget; it does not mean automatically grant it there. No current ID is silently reused for an unrelated power, deleted, or automatically converted in saved characters. No candidate is classified Retire: all displaced concepts have a plausible destination, but #302 may retire an exact duplicate rather than publish two competing copies. Retired records would remain in migration history, not the playable catalog.

### Arcanist source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-arcanist-bent-trajectory` — [Bent Trajectory](../cards/signature-arcanist-bent-trajectory.md) | Retain | Bent Trajectory foundation; positioning identity without another attack. |
| `signature-arcanist-deliberate-spark` — [Deliberate Spark](../cards/signature-arcanist-deliberate-spark.md) | Revise | Deliberate Spark foundation; explicitly Spell with a casting-opportunity exception. |
| `signature-arcanist-study-the-pattern` — [Study the Pattern](../cards/signature-arcanist-study-the-pattern.md) | Revise | Study the Pattern foundation; facts/progress boundary protects paid divination. |
| `signature-arcanist-cast-and-scatter` — [Siphon Cast](../signature-development.json) | Rehome | Force movement book or level-7 movement mastery candidate; preserve risk/vanish fiction, avoid an unrelated fourth signature line. |
| `signature-arcanist-leave-a-window` — [Create a Window](../cards/signature-arcanist-leave-a-window.md) | Retain | Bent Trajectory level 3; party extension of positional casting. |
| `signature-arcanist-arcane-deflection` — [Arcane Deflection](../cards/signature-arcanist-arcane-deflection.md) | Revise | Deliberate Spark level 3; resolved damage reference, capped push, once per scene. |
| `signature-arcanist-fold-the-distance` — [Folded Aegis](../cards/signature-arcanist-fold-the-distance.md) | Retain | Deliberate Spark level 7; explicit spell classification and daily rest definition. |
| `signature-arcanist-choose-the-edge` — [Choose the Edge](../cards/signature-arcanist-choose-the-edge.md) | Revise | Bent Trajectory level 7; instantaneous-only, once per scene prevents duplicated maintained control. |
| `signature-arcanist-open-the-circle` — [Open the Circle](../cards/signature-arcanist-open-the-circle.md) | Retain | Study the Pattern level 7; group response to magical threats. |

### Blade source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-blade-cut-and-turn` — [Reckless Charge](../cards/signature-blade-cut-and-turn.md) | Revise | Reckless Charge foundation; once per scene, remove extra damage to protect paid attack investment. |
| `signature-blade-pressure-point` — [Cleave](../cards/signature-blade-pressure-point.md) | Retain | Cleave foundation; crowd displacement and ally risk distinguish it from Sweeping Blade. |
| `signature-blade-measured-guard` — [Measured Guard](../cards/signature-blade-measured-guard.md) | Retain | Measured Guard foundation, explicit weapon requirement. |
| `signature-blade-sweeping-entry` — [Twitch Reflexes](../cards/signature-blade-sweeping-entry.md) | Revise | Measured Guard level 7; extra Reaction restricted to guard/opportunity attacks. |
| `signature-blade-return-stroke` — [Return Stroke](../cards/signature-blade-return-stroke.md) | Revise | Measured Guard level 3; broaden same counter trigger rather than duplicate button. |
| `signature-blade-fell-the-balance` — [Not So Fast](../cards/signature-blade-fell-the-balance.md) | Revise | Cleave level 3; stopping movement requires Standard/Strong. |
| `signature-blade-dance-through-steel` — [Dance Through Steel](../cards/signature-blade-dance-through-steel.md) | Revise | Cleave level 7; burst once per scene preserves repeatable paid multiattack. |
| `signature-blade-relentless-pursuit` — [Relentless Pursuit](../cards/signature-blade-relentless-pursuit.md) | Revise | Reckless Charge level 7; once per scene, same pursuit identity. |
| `signature-blade-perfect-placement` — [Get Out of Here](../signature-development.json) | Rehome | Athletics throwing/wrestling advanced tail, with free-hand/size/collision rules; generic strength belongs beyond Blade. |

### Intellect source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-intellect-spot-the-leverage` — [Spot the Leverage](../cards/signature-intellect-spot-the-leverage.md) | Retain | Analyst foundation; observable information and party application. |
| `signature-intellect-make-the-connection` — [Make the Connection](../signature-development.json) | Rehome | Scholarship investigation tail; one-minute evidence procedure, not magical omniscience. |
| `signature-intellect-prepared-explanation` — [Angle of Attack](../cards/signature-intellect-prepared-explanation.md) | Revise | Angle of Attack foundation; Knowledge substitution with study cost instead of superior free damage. |
| `signature-intellect-a-better-angle` — [A Better Angle](../signature-development.json) | Rehome | Scholarship tactical-reaction tail; reduce to movement or require a limited advanced command to avoid eclipsing Leader. |
| `signature-intellect-diagnose-the-failure` — [Diagnose the Failure](../cards/signature-intellect-diagnose-the-failure.md) | Revise | Analyst level 3; once per scene, replacement reroll before effects. |
| `signature-intellect-predict-the-motion` — [Predict the Motion](../cards/signature-intellect-predict-the-motion.md) | Revise | Angle of Attack level 3; only the studied foe, retaining physical attribute value. |
| `signature-intellect-a-route-for-everyone` — [A Route for Everyone](../signature-development.json) | Rehome | Athletics/Scholarship group-route advanced tail, choose one canonical home in #302. |
| `signature-intellect-test-the-hypothesis` — [Test the Hypothesis](../cards/signature-intellect-test-the-hypothesis.md) | Retain | Analyst level 7; evidence, time and one active plan. |
| `signature-intellect-expose-the-mechanism` — [Shatter the Guard](../cards/signature-intellect-expose-the-mechanism.md) | Revise | Angle of Attack level 7; resistance break modifies learned weapon attack, no new superior damage button. |

### Leader source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-leader-follow-my-signal` — [Follow My Signal](../cards/signature-leader-follow-my-signal.md) | Retain | Inspiration foundation; works for musical or nonmusical leader. |
| `signature-leader-lead-the-step` — [Lead the Way](../cards/signature-leader-lead-the-step.md) | Retain | Field commander foundation; movement without replacing companion decisions. |
| `signature-leader-stand-together` — [Stand Together](../cards/signature-leader-stand-together.md) | Revise | Rally foundation; baseline one defense Boon, limited second Boon. |
| `signature-leader-press-the-opening` — [Press the Opening](../cards/signature-leader-press-the-opening.md) | Revise | Inspiration level 3; ranged option and once-per-scene command. |
| `signature-leader-orderly-withdrawal` — [Lead by Example](../cards/signature-leader-orderly-withdrawal.md) | Revise | Field commander level 3; fixed additive outcomes remove per-hit menu. |
| `signature-leader-hold-your-nerve` — [Blow the Horn](../cards/signature-leader-hold-your-nerve.md) | Retain | Rally level 3; once-per-scene group pressure. |
| `signature-leader-coordinated-rush` — [Coordinated Rush](../cards/signature-leader-coordinated-rush.md) | Revise | Inspiration level 7; ranged option, once per scene, no attack chains. |
| `signature-leader-refuse-the-rout` — [Refuse the Rout](../cards/signature-leader-refuse-the-rout.md) | Retain | Rally level 7; condition recovery, not HP pool. |
| `signature-leader-watch-the-rear` — [Watch the Rear](../cards/signature-leader-watch-the-rear.md) | Retain | Field commander level 7; reactive support and reposition. |

### Odd source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-odd-sideways-thinking` — [Borrowed Tongue](../cards/signature-odd-sideways-thinking.md) | Retain | Medium foundation; spell classification and heard-language boundary. |
| `signature-odd-useful-interruption` — [Use Their Voice](../cards/signature-odd-useful-interruption.md) | Revise | Trickster foundation; once-per-scene ally movement avoids at-will order superiority. |
| `signature-odd-always-a-way-around` — [Pocket Sand](../signature-development.json) | Rehome | Subterfuge Reaction path; preserve grit/blind trick, fix player-defense perspective. |
| `signature-odd-unlikely-assistant` — [Foul Wind](../signature-development.json) | Rehome | Life/poison spellbook candidate, not a foundational pact or spirit identity. |
| `signature-odd-change-the-question` — [A Door Where There Wasn’t](../cards/signature-odd-change-the-question.md) | Revise | Trickster level 3; thickness, visible destination, SP and frequency explicit. |
| `signature-odd-wrong-place-for-that` — [Out of Body](../cards/signature-odd-wrong-place-for-that.md) | Revise | Medium level 3; magical-targeting definition and once-per-scene limit. |
| `signature-odd-strange-but-effective` — [Borrowed Life](../cards/signature-odd-strange-but-effective.md) | Revise | Medium level 7; bounded noncombat expertise rather than blanket weapon/magic competence. |
| `signature-odd-an-unexpected-exit` — [The Unseen Procession](../cards/signature-odd-an-unexpected-exit.md) | Revise | Trickster level 7; explicit expiry and no double application of equivalent defense modifiers. |
| `signature-odd-one-last-remark` — [Not Quite Yet](../signature-development.json) | Revise | Pact level 7 candidate becomes self-only deferred price; retain original ally-saving concept as a Life advanced spell candidate, do not silently remap existing characters. |

### Protector source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-protector-set-your-feet` — [In the Gap](../signature-development.json) | Rehome | Guard Maneuver path; frontage is a broadly useful tank practice. |
| `signature-protector-between-them` — [Step Between](../cards/signature-protector-between-them.md) | Retain | Bodyguard foundation; legal swap before roll. |
| `signature-protector-close-the-gap` — [Hand on the Collar](../signature-development.json) | Rehome | Guard rescue Maneuver path; shared protective movement. |
| `signature-protector-break-their-advance` — [Break the Charge](../signature-development.json) | Rehome | Guard Reaction advanced tail; preserve charge interception with explicit reach/equipment. |
| `signature-protector-shelter-the-fallen` — [Over My Body](../cards/signature-protector-shelter-the-fallen.md) | Retain | Bodyguard level 3; approved death intervention preserved. |
| `signature-protector-make-a-refuge` — [Make a Refuge](../signature-development.json) | Rehome | Guard advanced group shelter; does not occupy healing/smite signature line. |
| `signature-protector-unbroken-passage` — [The Long Road](../signature-development.json) | Rehome | Guard rescue mastery candidate; group escape and carrying Dying ally. |
| `signature-protector-defiant-rescue` — [Take the Wound](../cards/signature-protector-defiant-rescue.md) | Retain | Bodyguard level 7; no chained redirection. |
| `signature-protector-drive-back-the-circle` — [Radiant Threshold](../cards/signature-protector-drive-back-the-circle.md) | Revise | Oathstrike level 7; Spell, fixed duration, SP and per-round zone limit. |

### Shadow source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-shadow-soft-landing` — [Blade in the Back](../cards/signature-shadow-soft-landing.md) | Retain | Opportunist foundation; conditional signature attack. |
| `signature-shadow-fade-behind` — [Fade Behind](../cards/signature-shadow-fade-behind.md) | Retain | Infiltrator foundation; ordinary hiding remains meaningful. |
| `signature-shadow-turn-their-eye` — [Fast Talk](../cards/signature-shadow-turn-their-eye.md) | Retain | Social rogue foundation; objective rules and new contribution required. |
| `signature-shadow-strike-and-vanish` — [Hamstring](../cards/signature-shadow-strike-and-vanish.md) | Revise | Opportunist level 3 becomes additive control on Blade in the Back; remove redundant second attack. |
| `signature-shadow-open-the-way` — [Open the Way](../cards/signature-shadow-open-the-way.md) | Revise | Infiltrator level 3 adds quiet/traceless work to ordinary or learned progress; no superior free lockpicking. |
| `signature-shadow-pass-the-guard` — [Read the Room](../cards/signature-shadow-pass-the-guard.md) | Retain | Social rogue level 3; intent not compulsion. |
| `signature-shadow-exploit-confusion` — [The Half-Second](../cards/signature-shadow-exploit-confusion.md) | Revise | Opportunist level 7; once per scene and interruption timing explicit. |
| `signature-shadow-unseen-passage` — [One with the Dark](../cards/signature-shadow-unseen-passage.md) | Retain | Infiltrator level 7; light and plausible concealment limits. |
| `signature-shadow-leave-no-pursuit` — [The Cutting Word](../cards/signature-shadow-leave-no-pursuit.md) | Retain | Social rogue level 7; once per scene and normal condition immunity. |

### Shepherd source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-shepherd-gentle-return` — [Mend](../cards/signature-shepherd-gentle-return.md) | Retain | Healer foundation; repeatable SP-priced healing identity. |
| `signature-shepherd-ease-the-burden` — [Steady Voice](../cards/signature-shepherd-ease-the-burden.md) | Retain | Keeper foundation; explicit expiry for unused Boon. |
| `signature-shepherd-hear-me-still` — [Come Back](../signature-development.json) | Rehome | Medicine Reaction path; rescue movement and stabilization available across classes. |
| `signature-shepherd-careful-transfer` — [Triage](../cards/signature-shepherd-careful-transfer.md) | Retain | Healer level 3; same healing interface, explicit SP/recipient choice. |
| `signature-shepherd-quiet-the-tremor` — [Mend the Wound](../signature-development.json) | Rehome | Medicine treatment tail; shared first-aid allowance and ten-minute time. |
| `signature-shepherd-bring-them-near` — [The Fold](../cards/signature-shepherd-bring-them-near.md) | Revise | Keeper level 3; occupies sustained-spell slot, Maneuver/0 SP, one-minute ceiling. |
| `signature-shepherd-restore-composure` — [The Shared Cup](../cards/signature-shepherd-restore-composure.md) | Retain | Keeper level 7; conserved transfer prevents healing multiplication. |
| `signature-shepherd-a-hand-in-darkness` — [The Shepherd's Call](../cards/signature-shepherd-a-hand-in-darkness.md) | Retain | Healer level 7; Ritual label and no repeated sigil stacking. |
| `signature-shepherd-shared-resolve` — [Not My Flock](../signature-development.json) | Rehome | Life or Wards advanced retaliation spell; enemy target and immunity/escape rules retained in destination review. |

### Unbalanced source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-unbalanced-shoulder-through` — [Charge](../cards/signature-unbalanced-shoulder-through.md) | Revise | Charge foundation; clarify movement consumption rather than extra full Speed. |
| `signature-unbalanced-wild-approach` — [Go Berserk](../cards/signature-unbalanced-wild-approach.md) | Revise | Rage foundation; explicitly physical resistance, highest source. |
| `signature-unbalanced-laugh-at-the-fall` — [Grab and Hurl](../cards/signature-unbalanced-laugh-at-the-fall.md) | Retain | Wrestler foundation; clarify free hand and control-only Weak. |
| `signature-unbalanced-crush-the-barrier` — [Rampage](../cards/signature-unbalanced-crush-the-barrier.md) | Retain | Charge level 3; once-per-creature path effect. |
| `signature-unbalanced-raging-recoil` — [Pain Feeds the Fire](../cards/signature-unbalanced-raging-recoil.md) | Revise | Rage level 3; self-contained late entry, excludes voluntary damage farming. |
| `signature-unbalanced-fling-the-captive` — [Over the Top](../cards/signature-unbalanced-fling-the-captive.md) | Revise | Wrestler level 3; once per scene, no free-attack chains. |
| `signature-unbalanced-scatter-the-line` — [Earthbreaker](../cards/signature-unbalanced-scatter-the-line.md) | Retain | Charge level 7; normal object and collision rules. |
| `signature-unbalanced-break-their-grip` — [Deathless Rage](../cards/signature-unbalanced-break-their-grip.md) | Retain | Rage level 7; approved mechanic plus explicit prerequisite foundation in late-entry version. |
| `signature-unbalanced-crash-down` — [The Cannonball](../cards/signature-unbalanced-crash-down.md) | Revise | Wrestler level 7; once per scene and self-damage classification. |

### Warden source dispositions

| Stable ID / current name | Disposition | Destination / reason |
|---|---|---|
| `signature-warden-keep-the-quarry-close` — [Steady Aim](../cards/signature-warden-keep-the-quarry-close.md) | Retain | Hunter foundation; aim ends on scene/new target. |
| `signature-warden-read-the-passing` — [Beast Speech](../cards/signature-warden-read-the-passing.md) | Retain | Companion foundation; ordinary animal agency. |
| `signature-warden-follow-my-footsteps` — [Twin Strike](../cards/signature-warden-follow-my-footsteps.md) | Retain | Skirmisher foundation; two weapons and individual resistance. |
| `signature-warden-stay-on-the-scent` — [Volley](../cards/signature-warden-stay-on-the-scent.md) | Retain | Hunter level 3; all creatures in area and one worst-modifier roll. |
| `signature-warden-through-bramble-and-stone` — [Entangling Growth](../signature-development.json) | Rehome | Life plant-control book; explicit spell defenses and held-target escape. |
| `signature-warden-a-watchful-rest` — [The Green Spear](../signature-development.json) | Rehome | Elements earth/wood spell candidate; SP and damage compared to other learned attacks. |
| `signature-warden-turn-the-hunt` — [Mark the Quarry](../cards/signature-warden-turn-the-hunt.md) | Revise | Hunter level 7; remove hit check, visible removable-mark counterplay proposed. |
| `signature-warden-bring-them-through` — [Call the Wild](../cards/signature-warden-bring-them-through.md) | Revise | Companion level 7; replace open monster CV choice with authored command-compatible profile. |
| `signature-warden-know-what-you-hunt` — [Death from the Blind Spot](../cards/signature-warden-know-what-you-hunt.md) | Retain | Skirmisher level 7; tracked/damaged target wording replaces hit terminology. |

## Decisions and implementation dependencies

1. Confirm the late-entry contract before authoring selectors. The three-grant total is fixed; bundling the indispensable foundation is a proposal to make a new milestone signature usable. An alternative requiring an earlier signature would narrow the user's promised breadth choice and must be explicitly discussed.
2. Approve the five new foundations: Protector Healing Hands/Oathstrike, Shepherd Borrowed Shape, Intellect Make It Last, and Odd The Bargain. Each needs a new stable ID, rather than renaming an unrelated old ID. Other new upgrade IDs include Reading the Weave, Press On, Restoring/Sheltering Hands, Shape of the Wild/Great Shape, Pact's Claim, Wild Partnership and Through Bramble.
3. Warden's companion profile needs a bounded player-facing profile and welfare/arrival fiction before its card is usable. Do not substitute a monster CV budget. Ordinary living beasts remain independent characters; command rules grant activity rather than mind control.
4. Every rehomed entry needs one chosen canonical destination and an exact position among the seven purchases; these are candidates for the discipline author, not extra purchases added on top. Preserve ordinary unarmed play and place its substantial progression in the shared discipline work.
5. Review spellbook overlap before final numbers: shape should offer early identity but paid transformation books should retain longer duration, forms, travel and repertoire; enchantment signatures offer bounded personal items while paid creation provides projects and broader properties; pact blast offers one identity attack while books supply utility and alternative damage/control. Protector healing is emergency touch, Shepherd healing is sustained party care, and Life remains accessible to all.
6. Preserve equipment reality. Weapon signatures need the actual weapon; armor supplies its own physical resistance; a form's melded armor does not also stack with form resistance. Existing signature equipment grants stay recorded where the card actually grants them. A requirement is not permission to conjure inventory.
7. Test level 1/3/7 selections as three deepened lines, three different lines, and 1→3 then new line at 7. Verify maximum three milestone grants, no DP change, no dead dependent choice, one sustain slot, no multiplied item/rest resources, no HP resets on form changes and no granted-attack chains. Test at least one melee, ranged, spell and social/exploration build per relevant class.
8. Compare full turns and full scenes against paid branch counterparts. In particular test Blade burst attack economy, Intellect's attribute concentration, Shepherd healing efficiency, Protector mixed weapon magic, Warden double attacks against resistance, and level-7 defensive stacking. Numerical review is not a claim of final balance. The proposed once-per-scene limits and damage reductions are candidates, not automatic fixes: specifically compare whether Reckless Charge still feels defining and whether Healing Hands is worthwhile beside ordinary healing spells. A signature must retain greater defining value than an ordinary learned ability.

No books, web data, saved characters or native Foundry implementation are changed by this planning document. Source and Workshop changes must share stable IDs, selected milestone records, complete resulting descriptions, action/SP classification and the migration ledger.
