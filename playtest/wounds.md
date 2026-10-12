# Wound tables

Designer-reviewed working entries consolidated from the design discussion in issue
#1125. These replace the compact placeholder table. They have not been balance
simulated. Numerical fixtures and their comparative balance remain subject to tests.

## Procedure and notation

Use the wound roll in [recovery](recovery.md): retain the highest three dice, sort
lowest to highest, and read the result. There are 56 possible entries per table:
21 in the 100 band, 15 in 200, 10 in 300, 6 in 400, 3 in 500, and only **666** in 600.

Select the damage type that dealt the most damage **after resistance**; the player
chooses on a tie. Physical includes sonic and force. Fire, Cold, and Lightning use
Elemental; Mental, Radiant, and Life/Necrotic each have their own table. This shared
Elemental table does not merge the individual elemental resistances. An eventual
rule is still needed if minimum total damage applies after every component was
reduced to zero; this pass does not silently assign the wound's damage type.

If the body part is absent or the injury does not apply, move down to the next
valid listed result until an applicable entry is reached (for example 116 → 122).
Every table ends in 666, Last Words. Players choose source-appropriate descriptions
with the DA; existing choices of comparable injury remain subject to applicability.

**Immediate consequences** happen once: push, pull, and knockdown are not recurring
wound effects. Use existing forced movement, terrain, and collision rules. The DA
chooses a direction consistent with the injury. A push followed by Prone can be
described as a throw; no separate airborne throw mechanic is introduced here.

**Temporary conditions** use [conditions](conditions.md): resolve end-of-turn effects,
then decrease by 1. No entry uses a separate short-duration Dazed or Paralyzed rule.
**An asterisk prevents automatic decay**. Blinded and Deafened have one effect;
their numbers measure duration, not severity. Lasting movement penalties and Banes
remain until their printed remedy, rather than decaying as if they were conditions.
The DA decides when a Bane to physical or mental activities applies.

**Treatment:** one attempt per wound per day, even with several healers. Weak /
Standard / Strong adds **1/2/3** cumulative progress. Meet or exceed the Recovery
Value (RV) to remove the listed lasting effect. Progress remains with the wound.
A dash means no treatment track, not an automatic healing roll. Temporary conditions
end by decay or their normal remedies; treatment does not itself extinguish or
staunch them. One treatment track resolves the listed treatable effects of one wound.

Example: Physical 333 applies Bleeding 1 and a lasting Bane. Bleeding can decay or
be reduced by an appropriate Main Action; it does not recur because the wound
remains. Soft Tissue treatment reaching RV 3 removes the Bane. The scar still counts.

All wounds leave scars that permanently count toward future wound rolls. Cosmetic
wounds need no treatment. Where treatment softens a socially significant scar, it
removes **both** the intimidation Boon and persuasion Bane, not just the drawback.
Rest alternatives must be printed explicitly; the earlier lengthy recovery drafts
were superseded and are not universal rest timers.

## Severity and required treatment cards

| Band | Guideline | RV for treatable effects |
|---|---|---|
| 100 | Mostly cosmetic/social; occasional minor condition or −1 movement near upper end | 1–2; none for cosmetic-only entries |
| 200 | Individual conditions, 1 Bane, or −1/−2 movement | 2–3 |
| 300 | Combinations; stronger conditions | 3–5 |
| 400 | Severe conditions, 2 Banes, or movement penalties up to −3 | 5–7 |
| 500 | Devastating combinations, movement penalties up to −4, or permanent losses | 7–9 when treatable |
| 666 | Last Words | No ordinary treatment |

Required capabilities to create in the rebuilt card catalog: **Soft Tissue
Treatment, Bone Treatment, Elemental Wound Treatment, Mental Wound Treatment,
Radiant Wound Treatment, Life Wound Treatment**. These are broad capabilities,
not a separate ability for each injury. Their DP, discipline, and attribute details
remain catalog work. Existing generic treatment prototypes are not certification
that these six capabilities have been implemented.

Treatment cannot regrow a lost body part. An artificial limb or explicitly
restorative ability specifies what it remedies. Scars remain even after functional
recovery. Physical wounds leave minor scars in 100–200, moderate scars in 300–400,
and major scars in 500. Mental scars do not dictate personality, allegiance, or
choices. Elemental scars are visibly more pronounced, including at low severity.

**Open test concerns:** wounds usually occur while Dying, so immediate Dazed or
Paralyzed may matter most after prompt healing. Burning/Freezing are resistible;
Bleeding is not. Frightened depends on a perceptible source. These differences need
testing, not an assumption that equal ratings create equal danger.


## Physical

Physical includes sonic and force injuries. Broad activity Banes replace the earlier limb-, Force-, and attribute-specific penalties.


### Physical: 100 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 111 | Face: split eyebrow; small break in eyebrow | None | — | — |
| 112 | Ear: nicked edge; small notch | None | — | — |
| 113 | Arm: shallow cut; thin upper-arm scar | None | — | — |
| 114 | Hand: cut knuckles; small scars | None | — | — |
| 115 | Torso: glancing cut; thin rib scar | None | — | — |
| 116 | Leg: scraped shin; scarred patch | None | — | — |
| 122 | Head: shallow scalp cut; break in hair growth | None | — | — |
| 123 | Face: split lip; fine scar | None | — | — |
| 124 | Shoulder: glancing cut; short scar | None | — | — |
| 125 | Forearm: abrasion; scarred patch | None | — | — |
| 126 | Foot: shallow cut; thin scar | None | — | — |
| 133 | Face: jagged cheek scar | 1 Boon to intimidate; 1 Bane to persuade when visible scar influences interaction | Soft Tissue; removes both modifiers | 2 |
| 134 | Torso: shallow chest cut; visible scar | None | — | — |
| 135 | Leg: superficial injury; mild limp | No movement penalty | Soft Tissue; removes limp | 2 |
| 136 | Foot: superficial injury; uneven gait | No movement penalty | Soft Tissue; restores gait | 1 |
| 144 | Hand: shallow cut; obvious scar | None | — | — |
| 145 | Arm: shallow cut; broad scar | None | — | — |
| 146 | Face: jagged brow scar | 1 Boon to intimidate; 1 Bane to persuade when visible scar influences interaction | Soft Tissue; removes both modifiers | 2 |
| 155 | Leg: superficial knee injury; mild limp | No movement penalty | Soft Tissue; removes limp | 2 |
| 156 | Scalp: ragged cut; scar and missing hair | Bleeding 1 | Normal condition removal | — |
| 166 | Foot: painful heel injury; small scar and limp | −1 movement | Soft Tissue; removes movement penalty and limp | 2 |

### Physical: 200 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 222 | Head: scalp cut | Bleeding 1 | Normal condition removal | — |
| 223 | Arm: strained shoulder | 1 Bane to physical activities | Soft Tissue | 2 |
| 224 | Hand: split palm | Bleeding 1 | Normal condition removal | — |
| 225 | Torso: heavy chest blow | Push 1 square; 1 Bane to physical activities | Soft Tissue; removes Bane | 3 |
| 226 | Leg: injured knee | Prone; −1 movement | Soft Tissue; removes movement penalty | 3 |
| 233 | Face: cut brow | Blinded 1 | Decay | — |
| 234 | Arm: forearm injury | 1 Bane to physical activities | Soft Tissue | 3 |
| 235 | Hand: fractured finger | 1 Bane to physical activities | Bone | 3 |
| 236 | Back: wrenched back | Pull 1 square; 1 Bane to physical activities | Soft Tissue; removes Bane | 2 |
| 244 | Torso: deep flank cut | Bleeding 1 | Normal condition removal | — |
| 245 | Leg: calf injury | −1 movement | Soft Tissue | 2 |
| 246 | Foot: fractured toe | −1 movement | Bone | 3 |
| 255 | Head: glancing injury | Dazed 1 | Decay | — |
| 256 | Leg: badly sprained knee | −2 movement | Soft Tissue | 3 |
| 266 | Foot: badly sprained ankle | Prone; −2 movement | Soft Tissue; removes movement penalty | 3 |

### Physical: 300 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 333 | Arm: deep shoulder wound | Bleeding 1; 1 Bane to physical activities | Soft Tissue; removes Bane | 3 |
| 334 | Hand: deep wound | Bleeding 1; 1 Bane to physical activities | Soft Tissue; removes Bane | 3 |
| 335 | Torso: heavy abdominal injury | Push 2 squares; Prone; 1 Bane to physical activities | Soft Tissue; removes Bane | 4 |
| 336 | Leg: deep thigh wound | Bleeding 1; −1 movement | Soft Tissue; removes movement penalty | 3 |
| 344 | Head: torn scalp | Bleeding 2 | Normal condition removal | — |
| 345 | Back: torn muscles | Pull 2 squares; Prone; −1 movement | Soft Tissue; removes movement penalty | 4 |
| 346 | Leg: torn knee ligaments | −2 movement; 1 Bane to physical activities | Soft Tissue; removes both penalties | 5 |
| 355 | Head: heavy injury | Dazed 1; 1 Bane to physical activities | Soft Tissue; removes Bane | 4 |
| 356 | Foot: deep heel wound | Bleeding 1; −2 movement | Soft Tissue; removes movement penalty | 4 |
| 366 | Eye: injury | Blinded 1* | Soft Tissue; restores sight | 5 |

### Physical: 400 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 444 | Torso: deep tearing wound | Bleeding 2 | Normal condition removal | — |
| 445 | Arm: severely torn shoulder | Pull 2 squares; 2 Banes to physical activities | Soft Tissue; removes Banes | 5 |
| 446 | Hand: crushed hand | 2 Banes to physical activities | Bone | 6 |
| 455 | Leg: broken lower leg | Prone; −3 movement | Bone; removes movement penalty | 6 |
| 456 | Head: severe injury | Dazed 2; Prone | Decay; stand normally | — |
| 466 | Torso: broken ribs | Push 3 squares; Prone; 2 Banes to physical activities | Bone; removes Banes | 7 |

### Physical: 500 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 555 | Torso: extensive chest injury | Bleeding 3; push 2 squares; 2 Banes to physical activities | Soft Tissue; removes Banes | 7 |
| 556 | Leg: shattered knee | Prone; −4 movement; 2 Banes to physical activities | Bone; removes movement penalty and Banes | 9 |
| 566 | Leg: loss of leg | Bleeding 3; Prone; −4 movement | Artificial leg may mitigate movement; no regrowth; stop Bleeding normally | — |

### Physical: 600 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 666 | Last Words | Speech only; death at end of second following turn | No ordinary healing, treatment, potions, or Grit | — |

## Elemental

Every entry leaves a permanent visible scar, even when its only effect is temporary.
Burning/Freezing means Burning for Fire or Lightning and Freezing for Cold.
Burning still deals Fire damage; Freezing deals Cold damage. The wound source does
not change a condition's damage type. Elemental 556 converts the earlier single-turn
Paralysis to **Paralyzed 1** under the shared decay rule.

| Band | Ordinary clothing consequence |
|---|---|
| 100–200 | Scorched, split, or discolored around the injury |
| 300 | Clothing covering the injured area is ruined |
| 400 | Extensive clothing loss around the injured area |
| 500 | Most clothing covering the affected body region is destroyed |

Armor and special equipment are only destroyed by explicit wording. Treatment and
ending a condition do not restore clothing. Fire, frost, and electrical injury
supply different scar descriptions without changing the entry's mechanical effects.


### Elemental: 100 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 111 | Scalp: scarring and permanent hair loss | None | — | — |
| 112 | Ear: uneven scarred edge | None | — | — |
| 113 | Arm: branching or mottled discoloration | None | — | — |
| 114 | Hand: contrasting scar patches | None | — | — |
| 115 | Torso: broad discolored patch | None | — | — |
| 116 | Leg: scar streaks along shin | None | — | — |
| 122 | Face: scarred brow and missing eyebrow hair | None | — | — |
| 123 | Neck: visible band of scarring | None | — | — |
| 124 | Shoulder: broad uneven scar | None | — | — |
| 125 | Forearm: prominent branching scars | None | — | — |
| 126 | Foot: mottled scarred skin | None | — | — |
| 133 | Face: conspicuous cheek scar | 1 Boon to intimidate; 1 Bane to persuade when scar influences interaction | Elemental; removes both modifiers | 2 |
| 134 | Torso: extensive superficial discoloration | None | — | — |
| 135 | Leg: scar tissue and mild limp | No movement penalty | Elemental; removes limp | 2 |
| 136 | Foot: tender scars and uneven gait | No movement penalty | Elemental; restores gait | 1 |
| 144 | Hand: obvious finger and palm scars | None | — | — |
| 145 | Arm: raised or sunken scar tissue | None | — | — |
| 146 | Face: prominent brow and temple scars | 1 Boon to intimidate; 1 Bane to persuade when scar influences interaction | Elemental; removes both modifiers | 2 |
| 155 | Leg: knee scars and mild limp | No movement penalty | Elemental; removes limp | 2 |
| 156 | Scalp: fresh injury and permanent hair loss | Burning/Freezing 1 | Normal condition removal | — |
| 166 | Foot: painful heel injury | −1 movement | Elemental; removes penalty | 2 |

### Elemental: 200 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 222 | Head: damaged scalp | Burning/Freezing 1 | Normal condition removal | — |
| 223 | Arm: deep shoulder injury | 1 Bane to physical activities | Elemental | 2 |
| 224 | Hand: damaged palm | Burning/Freezing 1 | Normal condition removal | — |
| 225 | Torso: elemental impact | Push 1 square; 1 Bane to physical activities | Elemental; removes Bane | 3 |
| 226 | Leg: damaged knee tissue | Prone; −1 movement | Elemental; removes movement penalty | 3 |
| 233 | Eyes: flash injury | Blinded 1 | Decay | — |
| 234 | Arm: damaged forearm | 1 Bane to physical activities | Elemental | 3 |
| 235 | Hand: injured fingers | 1 Bane to physical activities | Elemental | 3 |
| 236 | Back: painful injury | 1 Bane to physical activities | Elemental | 2 |
| 244 | Torso: deep flank injury | Burning/Freezing 1 | Normal condition removal | — |
| 245 | Leg: damaged calf | −1 movement | Elemental | 2 |
| 246 | Foot: damaged sole | −1 movement | Elemental | 3 |
| 255 | Head: elemental shock | Dazed 1 | Decay | — |
| 256 | Leg: extensive knee injury | −2 movement | Elemental | 3 |
| 266 | Foot: extensive ankle injury | Prone; −2 movement | Elemental; removes movement penalty | 3 |

### Elemental: 300 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 333 | Arm: deep shoulder damage | Burning/Freezing 1; 1 Bane to physical activities | Elemental; removes Bane | 3 |
| 334 | Hand: extensive damage | Burning/Freezing 1; 1 Bane to physical activities | Elemental; removes Bane | 3 |
| 335 | Torso: elemental blast | Push 2 squares; Prone; 1 Bane to physical activities | Elemental; removes Bane | 4 |
| 336 | Leg: deep thigh injury | Burning/Freezing 1; −1 movement | Elemental; removes movement penalty | 3 |
| 344 | Head: extensive scalp injury | Burning/Freezing 2 | Normal condition removal | — |
| 345 | Back: extensive injury | Prone; −1 movement; 1 Bane to physical activities | Elemental; removes movement penalty and Bane | 4 |
| 346 | Leg: deep knee injury | −2 movement; 1 Bane to physical activities | Elemental; removes both penalties | 5 |
| 355 | Ears: surrounding tissue injury | Deafened 1; 1 Bane to physical activities | Elemental; removes Bane | 4 |
| 356 | Foot: deep heel injury | Burning/Freezing 1; −2 movement | Elemental; removes movement penalty | 4 |
| 366 | Eyes: damaged tissue | Blinded 1* | Elemental; restores sight | 5 |

### Elemental: 400 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 444 | Torso: severe flank injury | Burning/Freezing 2 | Normal condition removal | — |
| 445 | Arm: deep shoulder destruction | Push 2 squares; 2 Banes to physical activities | Elemental; removes Banes | 5 |
| 446 | Hand: severe damage | 2 Banes to physical activities | Elemental | 6 |
| 455 | Leg: deep lower-leg injury | Prone; −3 movement | Elemental; removes movement penalty | 6 |
| 456 | Head: severe elemental shock | Dazed 2; Prone | Decay; stand normally | — |
| 466 | Torso: severe chest injury | Burning/Freezing 2; 2 Banes to physical activities | Elemental; removes Banes | 7 |

### Elemental: 500 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 555 | Torso: extensive chest destruction | Burning/Freezing 3; push 2 squares; 2 Banes to physical activities | Elemental; removes Banes | 7 |
| 556 | Leg: devastating injury | Paralyzed 1; Prone; −4 movement | Elemental; removes movement penalty | 9 |
| 566 | Leg: irrecoverable destruction | Burning/Freezing 3; Prone; −4 movement | Artificial leg may mitigate movement; no regrowth; end condition normally | — |

### Elemental: 600 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 666 | Last Words | Speech only; death at end of second following turn | No ordinary healing, treatment, potions, or Grit | — |

## Mental

Every result leaves a mental scar even after temporary effects clear. The player
chooses its expression; no personality, allegiance, or behavior is imposed.
Frightened uses the creature or phenomenon responsible as its source and now decays
normally; it no longer has the earlier until-safely-away duration. Later reminders
do not automatically reapply it. Mental sensory wounds need not injure eyes or ears.


### Mental: 100 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 111 | Vivid dreams recalling the event | None | — | — |
| 112 | Unease around an associated sound | None | — | — |
| 113 | Small gap in memory of the event | None | — | — |
| 114 | Comforting ritual | No required action | — | — |
| 115 | Hesitation discussing the event | None | — | — |
| 116 | Intense manner discussing danger | None | — | — |
| 122 | A familiar smell recalls the event | None | — | — |
| 123 | Preference for sitting near an exit | No required positioning | — | — |
| 124 | Occasional repeated phrase | None | — | — |
| 125 | A particular place feels unfamiliar | None | — | — |
| 126 | A keepsake acquires significance | No required possession | — | — |
| 133 | Unsettling stare when discussing similar dangers | 1 Boon to intimidate; 1 Bane to persuade when it influences interaction | Mental; removes both modifiers | 2 |
| 134 | Changed taste associated with the event | None | — | — |
| 135 | Tremor when recalling the event | No physical penalty | Mental; alleviates tremor | 2 |
| 136 | Occasional catch in the voice | No speech penalty | Mental; alleviates it | 1 |
| 144 | Difficulty recalling an unimportant detail | None | — | — |
| 145 | Momentary mental disconnection | Dazed 1 | Decay | — |
| 146 | Unusually cold manner discussing the event | 1 Boon to intimidate; 1 Bane to persuade when it influences interaction | Mental; removes both modifiers | 2 |
| 155 | Sudden confusion | Dazed 1 | Decay | — |
| 156 | Overwhelming alarm | Frightened 1 | Decay | — |
| 166 | Interrupted awareness | Dazed 1 | Decay | — |

### Mental: 200 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 222 | Sudden terror | Frightened 1 | Decay | — |
| 223 | Scattered thoughts | Dazed 1 | Decay | — |
| 224 | Overwhelming alarm | Frightened 1 | Decay | — |
| 225 | Interrupted concentration | Dazed 1 | Decay | — |
| 226 | Distorted sense of distance | −1 movement | Mental | 3 |
| 233 | Phantom darkness | Blinded 1 | Decay | — |
| 234 | Broken train of thought | Dazed 1 | Decay | — |
| 235 | Fragmented recall | 1 Bane to mental activities | Mental | 3 |
| 236 | Confused sequencing | Dazed 1 | Decay | — |
| 244 | Fear of the injury's source | Frightened 1 | Decay | — |
| 245 | Disrupted coordination | −1 movement | Mental | 2 |
| 246 | Interrupted hearing | Deafened 1 | Decay | — |
| 255 | Disorientation | Dazed 1 | Decay | — |
| 256 | Disturbed bodily awareness | −2 movement | Mental | 3 |
| 266 | Sudden loss of balance | Prone; Dazed 1 | Stand normally; decay | — |

### Mental: 300 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 333 | Fear disrupting thought | Frightened 1; Dazed 1 | Decay | — |
| 334 | Sensory interruption | Blinded 1; Deafened 1 | Decay | — |
| 335 | Violent disorientation | Dazed 2; Prone | Decay; stand normally | — |
| 336 | Fear disrupting coordination | Frightened 1; −1 movement | Mental; removes movement penalty | 3 |
| 344 | Intense terror | Frightened 2 | Decay | — |
| 345 | Fragmented concentration | Dazed 1; 1 Bane to mental activities | Mental; removes Bane | 4 |
| 346 | Interrupted bodily control | Paralyzed 1 | Decay | — |
| 355 | Mental overload | Dazed 2 | Decay | — |
| 356 | Disrupted movement | Dazed 1; −2 movement | Mental; removes movement penalty | 4 |
| 366 | Persistent hearing disruption | Deafened 1* | Mental; restores hearing | 5 |

### Mental: 400 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 444 | Consuming fear and confusion | Frightened 2; Dazed 1 | Decay | — |
| 445 | Severely fragmented thought | Dazed 2; 2 Banes to mental activities | Mental; removes Banes | 5 |
| 446 | Severe sensory interruption | Blinded 2; Deafened 2 | Decay | — |
| 455 | Interrupted bodily control | Paralyzed 2 | Decay | — |
| 456 | Mental shutdown | Dazed 3; Prone | Decay; stand normally | — |
| 466 | Persistent visual disruption | Blinded 1* | Mental; restores sight | 7 |

### Mental: 500 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 555 | Overwhelming terror and fractured thought | Frightened 3; Dazed 3 | Decay | — |
| 556 | Complete interruption of bodily control | Paralyzed 3; Prone | Decay; stand normally | — |
| 566 | Profound sensory disruption | Dazed 3; Blinded 1*; Deafened 1* | Mental; one track removes both starred conditions | 9 |

### Mental: 600 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 666 | Last Words | Speech only; death at end of second following turn | No ordinary healing, treatment, potions, or Grit | — |

## Radiant

All entries leave visible scars: pale patches, bleached hair, branching marks,
or faintly luminous-looking scars. Appearance grants no illumination or other benefit.
Burning caused by Radiant wounds still deals Fire damage. The initial Radiant event
and later Burning use their respective resistances. Ordinary treatment can restore
sight at 466, but cannot restore destroyed eyes at 566.


### Radiant: 100 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 111 | Brow: pale streak | None | — | — |
| 112 | Ear: bleached rim | None | — | — |
| 113 | Arm: branching pale marks | None | — | — |
| 114 | Hand: discolored fingertips | None | — | — |
| 115 | Torso: sunburst-shaped mark | None | — | — |
| 116 | Leg: pale shin streak | None | — | — |
| 122 | Scalp: permanently white hair patch | None | — | — |
| 123 | Face: pale cheek mark | None | — | — |
| 124 | Shoulder: discolored ring | None | — | — |
| 125 | Forearm: bright-looking fine scars | None | — | — |
| 126 | Foot: mottled discoloration | None | — | — |
| 133 | Face: conspicuous branching scar | 1 Boon to intimidate; 1 Bane to persuade when scar influences interaction | Radiant; removes both modifiers | 2 |
| 134 | Torso: broad bleached patch | None | — | — |
| 135 | Leg: tender scar and mild limp | No movement penalty | Radiant; removes limp | 2 |
| 136 | Foot: sensitive scar and uneven gait | No movement penalty | Radiant; restores gait | 1 |
| 144 | Hand: prominent palm mark | None | — | — |
| 145 | Arm: broad pale scar | None | — | — |
| 146 | Face: stark eye-area discoloration | 1 Boon to intimidate; 1 Bane to persuade when it influences interaction | Radiant; removes both modifiers | 2 |
| 155 | Scalp: scarring and permanent hair loss | None | — | — |
| 156 | Eyes: searing afterimage and pale surrounding marks | Blinded 1 | Decay | — |
| 166 | Foot: painful radiant injury | −1 movement | Radiant | 2 |

### Radiant: 200 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 222 | Eyes: searing flash injury | Blinded 1 | Decay | — |
| 223 | Arm: deep shoulder injury | 1 Bane to physical activities | Radiant | 2 |
| 224 | Hand: searing palm injury | Burning 1 | Normal condition removal | — |
| 225 | Torso: radiant impact | Push 1 square; 1 Bane to physical activities | Radiant; removes Bane | 3 |
| 226 | Leg: damaged knee tissue | Prone; −1 movement | Radiant; removes movement penalty | 3 |
| 233 | Eyes: overwhelming afterimages | Blinded 1 | Decay | — |
| 234 | Arm: deep forearm injury | 1 Bane to physical activities | Radiant | 3 |
| 235 | Hand: damaged fingers | 1 Bane to physical activities | Radiant | 3 |
| 236 | Head: sensory overload | Dazed 1 | Decay | — |
| 244 | Torso: searing flank injury | Burning 1 | Normal condition removal | — |
| 245 | Leg: damaged calf tissue | −1 movement | Radiant | 2 |
| 246 | Ears: disrupted hearing | Deafened 1 | Decay | — |
| 255 | Head: overwhelming exposure | Dazed 1 | Decay | — |
| 256 | Leg: extensive knee injury | −2 movement | Radiant | 3 |
| 266 | Eyes: lingering visual interruption | Blinded 2 | Decay | — |

### Radiant: 300 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 333 | Arm: deep radiant wound | Burning 1; 1 Bane to physical activities | Radiant; removes Bane | 3 |
| 334 | Head: sensory overload | Blinded 1; Dazed 1 | Decay | — |
| 335 | Torso: violent radiant impact | Push 2 squares; Prone; 1 Bane to physical activities | Radiant; removes Bane | 4 |
| 336 | Leg: deep thigh injury | Burning 1; −1 movement | Radiant; removes movement penalty | 3 |
| 344 | Eyes: prolonged afterimages | Blinded 2 | Decay | — |
| 345 | Back: extensive tissue injury | −1 movement; 1 Bane to physical activities | Radiant; removes both penalties | 4 |
| 346 | Leg: deep knee injury | −2 movement; 1 Bane to physical activities | Radiant; removes both penalties | 5 |
| 355 | Head: overwhelming light | Dazed 2 | Decay | — |
| 356 | Foot: deep heel injury | Burning 1; −2 movement | Radiant; removes movement penalty | 4 |
| 366 | Ears: lasting sensory damage | Deafened 1* | Radiant; restores hearing | 5 |

### Radiant: 400 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 444 | Torso: deep searing injury | Burning 2 | Normal condition removal | — |
| 445 | Arm: severe shoulder damage | Push 2 squares; 2 Banes to physical activities | Radiant; removes Banes | 5 |
| 446 | Head: severe sensory overload | Blinded 2; Dazed 2 | Decay | — |
| 455 | Leg: deep lower-leg injury | Prone; −3 movement | Radiant; removes movement penalty | 6 |
| 456 | Head: radiant shock | Dazed 3 | Decay | — |
| 466 | Eyes: lasting visual damage | Blinded 1* | Radiant; restores sight | 7 |

### Radiant: 500 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 555 | Torso: extensive searing destruction | Burning 3; 2 Banes to physical activities | Radiant; removes Banes | 7 |
| 556 | Body: overwhelming radiant shock | Paralyzed 2; Prone; −3 movement | Radiant; removes movement penalty | 9 |
| 566 | Eyes: destruction of sight | Dazed 2; Blinded 1* | Replacement or explicitly restorative ability; ordinary treatment cannot restore eyes | — |

### Radiant: 600 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 666 | Last Words | Speech only; death at end of second following turn | No ordinary healing, treatment, potions, or Grit | — |

## Life/Necrotic

All entries leave scars such as withered tissue, discoloration, or lost hair.
There is no new life-drain condition or permanent attribute, maximum HP, or Grit
reduction. Casting costs cannot cause wounds: payment must leave the caster above
0 HP. Life damage entering Dying uses the normal wound procedure.


### Life/Necrotic: 100 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 111 | Face: small pallid patch | None | — | — |
| 112 | Ear: darkened edge | None | — | — |
| 113 | Arm: dark branching marks | None | — | — |
| 114 | Hand: discolored nails | None | — | — |
| 115 | Torso: sunken scar tissue | None | — | — |
| 116 | Leg: mottled shin skin | None | — | — |
| 122 | Scalp: lost or whitened hair | None | — | — |
| 123 | Face: hollowed cheek scar | None | — | — |
| 124 | Shoulder: prematurely aged skin | None | — | — |
| 125 | Forearm: dark veins around scar | None | — | — |
| 126 | Foot: discolored skin | None | — | — |
| 133 | Face: conspicuous withered scar | 1 Boon to intimidate; 1 Bane to persuade when it influences interaction | Life; removes both modifiers | 2 |
| 134 | Torso: altered skin texture | None | — | — |
| 135 | Leg: mild limp | No movement penalty | Life; removes limp | 2 |
| 136 | Foot: uneven gait | No movement penalty | Life; restores gait | 1 |
| 144 | Hand: withered appearance | No loss of function | — | — |
| 145 | Arm: visible tissue loss beneath scar | No loss of function | — | — |
| 146 | Face: stark eye-area discoloration | 1 Boon to intimidate; 1 Bane to persuade when it influences interaction | Life; removes both modifiers | 2 |
| 155 | Leg: localized wasting | No movement penalty | — | — |
| 156 | Body: momentary vitality loss | Dazed 1 | Decay | — |
| 166 | Foot: weakened heel | −1 movement | Life | 2 |

### Life/Necrotic: 200 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 222 | Head: sudden draining shock | Dazed 1 | Decay | — |
| 223 | Arm: weakened shoulder | 1 Bane to physical activities | Life | 2 |
| 224 | Hand: drained tissue | 1 Bane to physical activities | Life | 2 |
| 225 | Torso: loss of bodily strength | 1 Bane to physical activities | Life | 3 |
| 226 | Leg: weakened knee | Prone; −1 movement | Life; removes movement penalty | 3 |
| 233 | Eyes: loss of visual function | Blinded 1 | Decay | — |
| 234 | Arm: weakened forearm | 1 Bane to physical activities | Life | 3 |
| 235 | Hand: stiffened fingers | 1 Bane to physical activities | Life | 3 |
| 236 | Head: disrupted awareness | Dazed 1 | Decay | — |
| 244 | Torso: draining spasm | Dazed 1 | Decay | — |
| 245 | Leg: weakened calf | −1 movement | Life | 2 |
| 246 | Foot: weakened sole | −1 movement | Life | 3 |
| 255 | Body: sudden weakness | Prone | Stand normally | — |
| 256 | Leg: extensive knee weakness | −2 movement | Life | 3 |
| 266 | Foot: extensive ankle weakness | −2 movement | Life | 3 |

### Life/Necrotic: 300 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 333 | Arm: deep vitality loss | Dazed 1; 1 Bane to physical activities | Life; removes Bane | 3 |
| 334 | Hand: withered tissue | 1 Bane to physical activities | Life | 3 |
| 335 | Torso: draining collapse | Dazed 1; Prone; 1 Bane to physical activities | Life; removes Bane | 4 |
| 336 | Leg: weakened thigh | Dazed 1; −1 movement | Life; removes movement penalty | 3 |
| 344 | Body: interrupted bodily control | Paralyzed 1 | Decay | — |
| 345 | Back: wasting muscles | −1 movement; 1 Bane to physical activities | Life; removes both penalties | 4 |
| 346 | Leg: deep strength loss | −2 movement; 1 Bane to physical activities | Life; removes both penalties | 5 |
| 355 | Head: severe draining shock | Dazed 2 | Decay | — |
| 356 | Foot: wasted heel tissue | −2 movement | Life | 4 |
| 366 | Ears: lasting sensory impairment | Deafened 1* | Life; restores hearing | 5 |

### Life/Necrotic: 400 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 444 | Body: severe interruption of vitality | Paralyzed 2 | Decay | — |
| 445 | Arm: severely withered shoulder | 2 Banes to physical activities | Life | 5 |
| 446 | Hand: deep tissue wasting | 2 Banes to physical activities | Life | 6 |
| 455 | Leg: severe strength loss | Prone; −3 movement | Life; removes movement penalty | 6 |
| 456 | Head: profound draining shock | Dazed 3 | Decay | — |
| 466 | Eyes: persistent visual impairment | Blinded 1* | Life; restores sight | 7 |

### Life/Necrotic: 500 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 555 | Torso: extensive tissue wasting | Dazed 2; 2 Banes to physical activities | Life; removes Banes | 7 |
| 556 | Body: near-total bodily interruption | Paralyzed 3; Prone; −4 movement | Life; removes movement penalty | 9 |
| 566 | Leg: irrecoverably withered leg | Prone; −4 movement | Artificial leg or explicitly restorative ability; ordinary treatment cannot restore leg | — |

### Life/Necrotic: 600 band

| Roll | Injury / lasting mark | Effect | Treatment / remedy | RV |
|---|---|---|---|---:|
| 666 | Last Words | Speech only; death at end of second following turn | No ordinary healing, treatment, potions, or Grit | — |
