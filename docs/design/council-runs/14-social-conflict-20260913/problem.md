# Problem: Council review of Chapter 14, Social Conflict (quarto-book/chapters/14-social-conflict.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the Heroes of Legend
TTRPG rulebook and produce a disposition plan. Do NOT fix anything; file findings only.

## Topics (use these exact ids in your finding's `topic` field)

The finding schema only accepts a topic id of the form `t-NN` (or the literal `problem-scoping`).
Pick the one your finding belongs to:

- **t-01** — Conformance. Does the chapter obey the locked conventions listed below? Cite the
  convention you believe is violated.
- **t-02** — Internal procedure consistency. Social skills, NPC attitudes, the extended-conflict
  procedure (stakes, round structure, the success table, the first-to-three rule, attitude shifts),
  criticals and fumbles, the worked example and its arithmetic, the Boon note, and the two callouts.
  Does the chapter contradict itself, leave a procedure incomplete, or state a rule twice in two ways?
- **t-03** — Cross-chapter canon. Where this chapter and another chapter state the same rule
  differently, one of them is wrong. Verify the chapter's dependencies: the opposed-rolls rule, the
  five social skills and their attributes, passive Insight, skill and ability tiers, the class roster,
  the Boon/Bane mechanic, and the condition vocabulary it borrows.

## Scope

The registered source `14-social-conflict`. This chapter owns the social-conflict procedure and the
NPC attitude ladder; the rest of the book defers to it for both.

Chapters that depend on it or that it depends on: ch05 (the class roster it name-checks in flavour),
ch06 (core resolution, success tiers, opposed rolls, Boon/Bane), ch07 (the skill table and the
definition of passive Insight), ch08 (disciplines), ch09 (talents, ability tiers), ch13 (the
condition table), ch19 (GM guidance), ch21 (glossary), ch22 (reference sheets).

## Specific claims worth testing

These are leads, not findings. Verify each against the files before you rely on it; some may be sound.

- **The five social skills.** The chapter lists Deception (Guile), Persuasion (Guile),
  Intimidation (Brawn), Insight (Reason) and Performance (Guile). Does that match the skill table,
  in name, attribute and count?
- **Passive Insight.** The chapter uses passive Insight as the *opposition number* for a social
  contest. The skill chapter defines passive Insight for a narrower purpose. Is using it as the
  contested value consistent, and is the worked example's mapping of a passive score onto the
  success tiers (9 reads as Standard, 7 reads as Weak) actually licensed anywhere?
- **Who is the defender?** The round structure says a full tie goes to the NPC *as* the defender.
  The core chapter defines the defender as the non-initiating party. Are these the same claim?
- **The success table against the first-to-three rule.** Reconcile the per-result successes with the
  win condition and with the attitude-shift sentence, and check the worked example's totals.
- **Arithmetic.** Recompute every roll in the worked example, including the modifier sums and the
  passive scores derived from Knowledge.
- **The class roster.** The flavour text name-checks several classes. Do they all exist?

## Already fixed in earlier passes. Do not re-report these.

This chapter has not had a council pass. The following items are repaired elsewhere and are NOT
defects to file: the condition vocabulary (ch13 owns it, including Hidden, Blinded, Grappled,
Restrained and the Escape action); plate DR and the cover tiers (ch13/ch16/ch22); dying, Death's
Door and the worsen state (ch13).

If you believe one of those repairs was itself wrong or incomplete, say so explicitly and give the
evidence; do not simply restate the original finding.

## Locked conventions the chapter must satisfy

- **Damage budget is FLAT.** Novice 2/4/6, Adept 6/9/12, Master 9/15/21 on Weak/Standard/Strong.
  No damage dice anywhere in the book; the only sanctioned dice are 3d6 one-roll checks, 4d6 for
  Boon/Bane (keep highest or lowest three) and explicit random-effect tables.
- **One-roll principle.** Effects resolve by tier without a second roll.
- **Numbers belong to damage; the situational layer is Boon/Bane (ruling #95).** Roll modifiers are
  never numeric. Attributes, skill tiers and difficulty numbers keep their numbers.
- **Boon/Bane ladder.** Boon 1 is 4d6 keep the highest three; Bane 1 is 4d6 keep the lowest three;
  double and triple steps exist and cancel one for one.
- **The rung escalation law.** A higher rung never loses an effect the rung below it promised.
  Deepening takes three sanctioned shapes: add, intensify, or tighten.
- **Zero flat +N damage riders (book-wide law).** The only sanctioned damage booster is the tier
  bump, phrased "+1 damage tier".
- **Weapons are flavour; cards carry the damage.**
- **Zero em-dashes in book source text.**
- **Card, condition and stat block names are unique book-wide.** A name that exists nowhere else is
  a phantom.
- **The chapter is written inside a Typst block**, so its formatting is Typst-native, not markdown:
  emphasis is `*italic*`, never `**bold**`. The native-Typst gate enforces this.

## Output

One finding each, on the topic above where your lens has the most to say. Findings are decision
inputs, not essays. Where you assert a defect, give the evidence that makes it checkable.
