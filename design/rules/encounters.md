# Encounter budgets and CV calibration

**Agreed targets:** four player characters are the reference party; typical combat
about 4 rounds, hard about 6, extreme about 10. Typical reasonably prepared parties
should have roughly a 20–30% chance of at least one new wound without a healer,
5–15% with one. These are feel targets, not mandatory outcomes for every battle.

## Proposed budget procedure

Define B(L) as the calibrated standard encounter budget for four characters of
level L. For N characters of the same level:

**Budget = B(L) × N / 4 × difficulty multiplier.**

Proposed multipliers: easy 0.75, standard 1.00, hard 1.50, extreme 2.00. Round the
final budget to a convenient whole CV. These multipliers are starting fixtures,
not verified mappings to encounter duration. An extreme encounter must not simply
be declared a ten-round fight because its budget doubled.

For mixed levels, use **sum(B(character level) / 4)**, then multiply by difficulty.
This preserves each character’s calibrated contribution rather than rounding the
party’s average level. Budget is the sum of participating enemies’ CV. Waves and
reinforcements count; terrain and mission objectives require separate review.

**Arithmetic example only:** if future calibration establishes B(1)=40, three
level-1 characters receive a standard budget of 30; five receive 50. A hard fight
for five would be 75. Forty is a demonstration input, not an assigned level-1 budget.

## Proposed creature estimate, followed by testing

Start with **CV estimate = sqrt(E × O) × U**, normalized so a chosen reference
creature has the desired reference CV.

- E = expected attacks needed to defeat it using the reference party’s actual
  attack outcomes, hit effects, resistances and relevant control. Do not divide HP
  by a single raw damage number that ignores minimum damage.
- O = expected effective HP damage per round against that party, counting actual
  targets, action economy and healing. Use recorded outcome probabilities and
  attack/defense attributes, not an assumed universal success rate.
- U = an explicit provisional adjustment for disabling effects, movement, unusual
  senses, reach, summoning or other advantages not represented by E and O. Start
  at 1 for an ordinary damage-only creature; document every other value.

This is a seed metric, not a final algorithm. Zero-damage controllers cannot receive
zero CV: evaluate their contribution in a mixed encounter instead of applying this
formula blindly. Healing loops, area attacks and incapacitation can make the simple
estimate unreliable. Record uncertainty rather than publishing false precision.

## Calibration sequence for the bestiary

1. Build a few ordinary melee/ranged creatures with full printed attack and defense
   attributes, HP, resistances, Stability, actions and outcomes.
2. Test actual level-1 parties with documented supplies and healing access.
3. Fit B(1) and creature CV to duration, wound incidence, defeat risk and action loss.
4. Test 3-, 4- and 5-character parties and easy/hard/extreme multipliers. Include
   open and obstructed terrain; party-size scaling may need an enemy-count warning.
5. Add control, healing and summons one feature at a time; refine U or replace the
   seed metric if it fails. Then repeat at levels 3 and 7 and intermediate levels.

Until those tests exist, CV and B(L) remain uncalibrated. The procedure is ready to
support bestiary development; numerical encounter guarantees are not.
