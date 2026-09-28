# W-011 — Caster session, replayed at the live rules (Haldra Ironhymn, level 1 Shepherd)

Date: 2026-09-28. Cycle 79. Method: `references/architect-role.md` → walkthroughs 1/3 and 4
(first-session + round, casters only), played on the book alone. Source: `origin/main` at `6c70ea8`.
Prior transcripts: W-001..W-010.

## Why this walkthrough, and why the casters again

The last caster transcript (W-004, cycle 28) played Sera Ashvein and declared the caster loop clean.
Three things have moved under that transcript since, and they all move the *hero*, not the loop:

- **`#808`/`#809` rewrote the Health Points formula** — HP is now `10 + Fortitude + the class's Health
  attribute`, and the asymmetry W-004 was played against (an arcane caster drawing HP from its own
  casting stat while a divine caster's Reason contributed none) is exactly what the ruling removed.
  No transcript has been played against the new formula.
- **`#807` resized the Standard field** to 1.25 party level per hero, and **`#837`/`#840` made Wounds
  uncapped**, so the round a caster survives is not the round W-004 measured.
- **`#821` gave six previously attack-less templates a Novice attack card**, which changed what the
  non-caster half of the party is doing while the caster takes its Action.

So this is a *replay*, not a re-run: the same seat, the live rules. It is named W-011 to keep the
transcript series honest about what was played when.

## The heroes, rebuilt from the book

Both printed builds were rebuilt line by line and their pools re-derived independently of the printed
totals. Neither had a build question the book failed to answer.

| Field | Haldra Ironhymn (Shepherd) | Sera Ashvein (Arcanist) |
|---|---|---|
| Attributes | Reason +2, Fort +1, Guile +1, Brawn −1 | Knowledge +2, Reason +1 |
| Ancestry / culture | Dwarf (Melee, Sturdy +2 HP) / Hill (Shields, +1 Persuasion) | Human (any one, +1 DP) / Imperial (Energy, +1 Arcana) |
| HP, live formula | `10 + Fort 1 + Reason 2 + Sturdy 2` = **15** (`02:450`, `05:209`) | `10 + Fort 0 + Know 2` = **12** (`02:364`, `05:162`) |
| Casting | `3d6 + Reason + Religion` (`10:33`) | `3d6 + Knowledge + Arcana` (`10:33`) |
| Background pool | 9 = Medicine/Religion/Survival/Endurance (4×2) + Life r1 (1) | 11 = Craft/History/Alchemy/Nature/Lore (5×2) + Earth r1 (1) + Versatile 1 |
| Class pool | 12 = Armor r1 (4) + Mending Touch (2) + Sanctuary (2) + Religion r1 (1) + Holy Strike (2) + Plants r1 (1) | 12 = Melee r1 (4) + Ember Lance (2) + Burning Volley (2) + Arcane Feedback (2) + Perception (2) |
| Focus in kit | holy symbol | arcane focus, focus pouch |

**Every pool closes at its named total** (9/9 and 11/11 background, 12/12 class). All nine class HP
lines match `#808`'s map, including the Shepherd's move to Reason — the ruling is fully landed, and the
glossary (`21:73`) and the Derived Statistics table (`02:221`) both carry the new formula.

**The tier law holds across both spell chapters**, re-derived rather than trusted: of 52 divine cards,
13 Novice carry exactly 1 rank, 24 Adept exactly 2, 9 Master exactly 3, and 6 cantrips carry none; the
same shape holds across the 75 arcane cards (25/25/10/15). That is `10:63`'s rule, and nothing in
either chapter deviates.

## The session

**Scene 1 — the Shepherd's Action, round one.** Haldra's shelf at level 1 is four options, and the
turn prices them differently, which is the point of `#809`'s map landing:

| Option | Cost | What it buys her |
|---|---|---|
| `Mending Touch` (`12:95`) | Action + holy focus | target to half / to full / to full + riders |
| `Sanctuary` (`12:244`) | Action | condition removal, no HP |
| `Holy Strike` (`12:305`) | Action | 4/6/8 radiant, **+1 tier vs undead** on Strong |
| `Gentle Mend` (`05:604`) | Action, once per scene | 4 HP flat |

At `Reason +2` and `Religion +1` she casts at **+3**: Weak 4.6%, Standard 57.9%, Strong 37.5%. Her
heal is a threshold, so a Standard `Mending Touch` puts a 15-HP Protector back to full from anything
above 7 — the "healer's Action answers the moment" line earning its keep.

**Scene 2 — the anti-undead round.** This is where the session stopped being a transcript and became a
defect report. Haldra's signature is *Unholy Word*, and at the table it does nothing locatable — see
F-1 below. Running the same round through the *card* she could buy instead (`Turn Unholy`, `12:332`)
resolves cleanly: 30-ft cone, Morale Check on the book's own procedure (`13:318`, 3d6 no modifiers),
flee 1/2/3 turns, undead destroyed at 0 HP on a Strong. **The mechanic the class promises exists in the
book; the signature just never points at it.**

**Scene 3 — the Leader's round (the other seat at the table).** Running a Leader beside Haldra surfaced
F-2: `Lead by Example` fires on "a telling blow", a term the book never defines.

## Cleared, with the check that cleared it

Recorded so no later lens re-files them. Each was a live candidate on first read.

- **Class-ability heals are legal by law.** `Gentle Mend`'s flat "heals 4 HP" and `Bountiful Harvest`'s
  "allies inside heal 6 HP" look like they contradict the threshold model at `08:238-247`. They do not:
  the law's own *What this does not govern* clause exempts "a potion, a relic, a class ability, a
  talent or a weapon maneuver that restores HP". **Not a defect.**
- **Protection Value is defined.** `Bastion` and `Arcane Shield` grant "+1 to your Protection Value",
  a term absent from ch13 and ch16 — it is defined at `21:145` ("a temporary +1 bonus to your defense
  roll") and restated at `22:393`. **Not a defect.**
- **Duplicate starting grants are settled.** Sera takes Fire from both ancestry and class, and Energy
  from both class and culture; `08:99` rules the duplicate "explicit waste: no rank up, no extra
  Development Points", and row 76 landed that reading with the templates deliberately unchanged.
  **Known and ruled, not a finding.**
- **Morale Check is defined.** `Turn Unholy`, `Stalwart Resolve`, the Rot Treant and two bestiary
  traits all call for one; the procedure is `13:318` with a worked example at `13:533`, the glossary
  at `21:181` and the reference sheet at `22:133`. **Not a defect.**
- **Cantrips are free by law, not by omission.** `11:27` and `12:78` both grant them outright ("they
  don't cost anything to learn… every arcane caster knows all of these"), so the one-card law at
  `08:136` prices cards you *buy* and is not contradicted. **Not a defect.**
- **The damage cantrips sit deliberately below the Novice row.** `Frost Touch`, `Static Shock` and
  `Acid Splash` all print **1/3/5** against the Novice row's 4/6/8, and `Spark` deals none. That is the
  caster's at-will floor, comparable to the free Basic attack (`09:226`, 1/2/3, melee adds Brawn).
  **Not a defect.**
- **Both casters carry their focus in their printed loadout**, so no caster is silently downgraded on
  round one. **Not a defect.**

## The findings

### F-1 — the Shepherd's signature is the one of nine that states no effect

`05:211`: *"Signature, Unholy Word: Call down divine energy that ignores armor and affects only undead
creatures within your presence. Your faith burns what should not walk."*

There is no Action, no frequency, no magnitude, no roll and no range. "Within your presence" is a
distance in no table in the book, and "ignores armor" has no damage figure to ignore armor *off*. A
level-1 Shepherd's player cannot answer: what does it do, how often, and to whom within how far?

The other eight signatures all resolve. Five name a magnitude or a defined condition (`Bastion` +1 PV,
`Swift Blade` +1 tier once per scene, `Arcane Shield` +1 PV once per round, `Knowledge Is Power` a Boon,
`Edge of Chaos` +1 tier with a Backlash roll); two name a defined procedure (`Vanish` a Stealth check
with two outcomes, `Eccentric Spellcasting` a waiver with its limits stated). `Unholy Word` names none.

**Row 79 already touched this ability and fixed a different thing.** It renamed the signature from
"Turn Unholy" to "Unholy Word" to break a collision with the ch12 card, and it did so *preserving the
effect exactly as written* ("signature = ignores armor, affects only undead within your presence"). The
collision is gone and the gap is untouched, so this is a discovery, not a status update.

**Decided (architect, veto-revertible):** the signature grants the printed card it was named after —
*"You gain the **Turn Unholy** spell for free, and its 1 Religion requirement is waived. Your faith
burns what should not walk."* Basis, in order of weight: (1) the Blade's signature is verbatim this
shape — "You gain the Precision talent for free"; (2) the Odd's signature states its own prerequisite
waiver, so the convention exists; (3) `Turn Unholy` already prints the entire effect at `12:332-339`,
including the anti-undead rider, so **no number is invented and no rule is added**; (4) it makes row
79's collision structurally impossible rather than merely renamed, because the signature and the card
become one object. Reversal words: **"size it"** (write an in-place effect instead — that needs a
magnitude from Bruce) or **"drop it"** (remove the signature and rebalance the class as a shelf alone).

### F-2 — the Leader's signature fires on a term the book never defines

`05:356`: *"Signature, Lead by Example: When you land a telling blow on an enemy, grant one ally who
witnessed it a Boon on their next roll."*

**"Telling blow" occurs exactly twice in the book** — the signature and its own mirror — and is defined
nowhere. Every other trigger in the class layer is precise (`Swift Blade` names Dazed, Prone, or
unaware; `Arcane Feedback` names rolling Strong). A Leader's player has to guess what counts.

W-004 repaired this line once already (row 195, PR #714: the numeric `+2 bonus` became a Boon), and no
row ever reached the trigger.

**Decided (architect, veto-revertible):** the trigger becomes the book's own tier vocabulary —
*"When you land a **Strong** hit on an enemy, grant one ally who witnessed it a Boon on their next
roll."* Precedent in the same class layer: `Arcane Feedback` (`05:557`) triggers on "when you cast a
spell and roll Strong". Zero invention, no number moves. Reversal word: **"rarer"** (then "when you
reduce an enemy to 0 HP", which is equally defined and fires less often).

## The work order, and why it ships with #854 rather than beside it

Four sites, two files: `05:211` and `05:356` (the signatures), `02:437` and `02:477` (their mirrors in
the Shepherd and Leader templates). The class-overview table (`05:31`, `05:34`) prints signature
*names* only and needs no change. **No printed number moves anywhere.**

ch05 is already carrying a queued order — **#854**, the nine `*Starting Loadout:*` lines — and the two
must not run as separate agents in separate worktrees on one file, which collides at merge (the
same-file batching law). So this order is filed to be **dispatched in the same worktree and PR as
#854**, one branch closing both issues, rather than beside it.
