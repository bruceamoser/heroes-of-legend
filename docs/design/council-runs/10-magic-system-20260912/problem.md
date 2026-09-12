# Problem: Council review of Chapter 10, Magic System (quarto-book/chapters/10-magic-system.qmd)

You are the hol-rulebook council. Audit this chapter as a publishable unit of the Heroes of Legend
TTRPG rulebook and produce a tiered disposition plan. Do NOT fix anything; file findings only.
One topic: **t-01, "Is Chapter 10 publishable as-is? If not, what is the tiered disposition plan?"**
Refute means it is not publishable as written (state the defect and the minimal fix). Support means
you checked it and found it publishable. Do not invent defects to look thorough: a chapter with few
real problems is a GOOD outcome, and the spine being clean is a finding worth stating with evidence.

## Scope
The registered source `10-magic-system` (the chapter's .qmd, 138 lines, a single `{=typst}` fence).
This chapter is the **framework chapter for magic**: it is the source of record for the always-fires
rule, the one-roll casting model, the tier-to-cost/effect-row table, the Adept/Master level gates,
Discipline prerequisites for spells, cantrips as a category, the arcane-versus-divine tradition
split, the three limitation rules (per-encounter, per-session, concentration), and one worked
example. It is NOT the spell list: the actual spell cards live in ch11 (arcane) and ch12 (divine),
and their names, damage rows, Discipline counts and Keywords are canon there.

Because it is a framework chapter, its blast radius is cross-chapter: anything it asserts about
tiering, gates, prerequisites, wildcards, cantrips, or the tradition split must agree with the
chapters that implement it. Cross-check only against the authoritative chapters: attributes ch03,
disciplines/taxonomy/rank costs/prereq shapes/damage budget ch08, the arcane spell cards and
cantrips ch11, the divine spell cards and cantrips ch12, class discipline pools and signatures ch05
(and the ch02 templates), the Odd's wildcard signature ch05:287 / ch02:301 / ch21:81, core
resolution and the tier bands ch06, combat, conditions and resistance math ch13, equipment ch15,
armor ch16, advancement and the DP economy ch18, GM guidance and the card-format examples ch19,
the bestiary's NPC spell notes ch20, and the glossary ch21.

## Locked conventions the chapter must satisfy (cite the violated convention in every finding)
- **Damage budget is FLAT, keyed to tier.** Novice 2/4/6, Adept 6/9/12, Master 9/15/21 on
  Weak/Standard/Strong. No damage dice anywhere. Every damaging or healing number this chapter
  prints, including inside a worked example, must land on the row for the card's rank. A rider or
  a centre bonus that lands OFF the row (for example a Strong-row number appearing as a bonus on an
  Adept card) is a defect: riders must sum to the row, or gate on the WEAK result so base plus rider
  equals a row, or be a damage TIER bump phrased "+1 damage tier".
- **One-roll principle:** the casting roll IS the effect roll. The 3d6 roll plus attribute plus
  skill maps directly onto Weak (1-8) / Standard (9-14) / Strong (15-18+). No separate casting
  check, no spell-failure roll, no concentration roll that replaces the outcome mapping. Recompute
  every worked roll: attribute plus skill plus dice must produce the tier the example claims.
- **Card costs are flat 2/4/8 DP at Novice/Adept/Master for every class.** Gates: Adept at Level 3,
  Master at Level 7. No class varies them and no spell card varies them.
- **Prerequisite shapes:** a spell card's tier equals the number of Discipline ranks it requires.
  Novice = 1 rank, Adept = EXACTLY 2 ranks (2 different or 2 same), Master = EXACTLY 3 ranks (3
  different, 2+1, or 3 same). No single Discipline may exceed rank 3. A Master card may never be a
  single rank. Wildcards: the Odd's *Eccentric Spellcasting* lets exactly two chosen abilities
  (one arcane, one divine) ignore Discipline prerequisites, level gates still applying. Any blanket
  claim in this chapter that no wildcard or substitution exists contradicts a shipped class
  signature and is a defect.
- **Tier-to-effect consistency:** a card bought at Novice rank uses the Novice row; the same card
  bought up to Adept rank uses 6/9/12; at Master rank, 9/15/21. Whatever this chapter's table and
  prose say the row is must match what the actual add-on lines in ch11/ch12 print.
- **Leveled condition vocabulary.** Conditions use the leveled form (Burning 3, Slowed 5, Dazed 1,
  Asleep 2, Frozen X) as ch13's condition table defines them, or the exact binary name (Prone,
  Frightened, Restrained, Blinded, Dazed, Hidden). Bespoke paraphrases ("takes ongoing fire damage",
  "half Speed", "slowed for 1 round" with no level) are defects. Resistance and vulnerability
  resolve as half and double (ch13).
- **ZERO numeric roll modifiers (Boon/Bane law).** A situational bonus or penalty to a ROLL is Boon
  or Bane, never +N or -N. Numbers are reserved for damage, HP, DR, DP, ranges and durations, plus
  three named exceptions: attributes and skill tiers (Novice +1, Adept +2, Master +3), the DA's
  difficulty dial, and a Challenge penalty. Boons and Banes cancel one for one; the potence ladder
  is Boon/Bane 1 = 4d6 keep three, 2 = 5d6, 3 = 6d6, capped at three.
- **Zero em-dashes in book text (style law, book-wide).** Also zero en-dashes used as dashes.
- **Cross-references:** every @sec-* / @tbl-* / @fig-* token must resolve to a real label, and no
  typed period may follow a cross-reference. A bare `@` in prose is a build breaker.
- **Typst conventions (MIGRATION-SPEC):** exactly one `{=typst}` fence per file with the `# H1` line
  kept above it; callout bodies in the NAMED `body: [...]` form (the positional form is silently
  dropped by the theme and the build still passes); every `#table(` carries `outlined: false`;
  `#label("sec-...")` on the line after its heading. Every `#pagebreak()` must not leave an orphan
  blank page or strand a heading at a page foot.
- **Book-wide conventions that are NOT defects (do not re-flag these):** the `_Figure N.M: Title_`
  placeholder caption where N carries the book's global figure offset (ch08 prints 10.1, ch09 11.1,
  ch10 12.1, ch11 13.1) and is followed by `_Placeholder for final art._`; the absence of a Duration
  header field on card stat blocks; the DA / GM vocabulary split; the intentionally duplicated class
  starting-Discipline listing in ch05 and ch08.
- **Phantom cards and canon:** any spell or ability this chapter names must exist under exactly that
  name in ch11 or ch12, and any number it prints for that card must match the card. A worked example
  is a claim about the printed card, so it must be recomputed against the card, not against memory.
- **Scope-adjacent:** a defect whose only fix site is a DIFFERENT chapter (a stale reference in
  ch08, a wrong pointer in ch19) is still a finding, but label it clearly as routed out so it is not
  implemented inside this chapter's micro-PR.

## Findings format (one finding per member this round)
Each finding must be decision-oriented and carry, in the argument: the broken value with
[10-magic-system:LINE], the expected or correct value, the violated convention, and the minimal fix.
Cite cross-chapter canon lines where the expected value is canon-determined (ch08 for the budget,
ladder, rank costs and prereq shapes; ch11/ch12 for the card text; ch05/ch02/ch21 for the Odd's
signature; ch13 for conditions and resistance). Recompute every number you check: a roll, a tier,
a cost, a Discipline count and a damage row must all agree with each other and with the chapters
that implement them. Verify a card name in another chapter before asserting a phantom. A finding
that cannot state the broken value and the expected value is not a finding. Do NOT invent defects
to look thorough.

## Wall discipline (mandatory)
Paraphrase in `argument` and `evidence[].claim`; keep verbatim text ONLY in
`evidence[].quote_or_excerpt` (<= ~12 words). Never copy 10 or more consecutive words from this
problem statement or from the source chapter into `argument` or `claim`.
