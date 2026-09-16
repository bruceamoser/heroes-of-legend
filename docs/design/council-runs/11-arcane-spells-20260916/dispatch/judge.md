# BLIND JUDGE — hol-rulebook council, chapter 11 (Arcane Spells)

You are the **blind judge** for a Synod council run. Read **exactly two files** and nothing else:

1. **Your role card:** `/home/bmoser/repos/synod/references/roles/judge.md`
2. **The brief:** `/home/bmoser/.hermes/councils/hol-rulebook/runs/20260916-2002/judge/brief.json`

## Blindness (do not break it)

The engine spent a whitelist assembling that brief so you see the arguments without their
authors. **Do NOT read any of these, and do not `ls` the directories they sit in:**

- `judge/speaker_map.json` — it sits in the SAME directory as your brief and maps the speakers back
  to their roles. One read destroys the blindness.
- `judge/rulings.json`, `judge/brief.rejected.json`
- `briefs/`, `findings/`, `sources/`, `ledger.jsonl`, `problem.md`

If the brief seems to point outside itself, rule on the arguments **as presented** anyway. You have
no source, no problem statement and no ledger, and you do not need them.

## Your task

The brief carries **two contested topics**: `t-01` and `t-03`. Rule on **each** of them. Two rounds
of deliberation are exhausted, so your ruling is the last word and it is binding.

Write your ruling file to:

```
/tmp/hol-council/judge-ruling.json
```

**The file must BE a JSON array**, with exactly one object per contested topic (so: 2 objects).

## The exact shape (this is the engine's contract — an extra or missing key fails the seal)

Each object carries **EXACTLY these five keys**, and nothing else:

| key | value |
|---|---|
| `topic` | `"t-01"` or `"t-03"` (the pattern is `^t-[0-9]{2,}$`) |
| `point_of_contention` | a sentence naming what the parties actually disagree about |
| `ruling` | a **directive sentence** (not a keyword): minimum 10 characters, and it should say what must be done |
| `reasoning` | your reasoning, weighing what stands against what was challenged and left undefended |
| `conditions` | an array of concrete, checkable conditions that implement the ruling (may be empty only if the ruling needs no conditions) |

**Do NOT emit** `id`, `binding`, `sealed_at`, `confidence`, `round`, `role` or `speaker`. The engine
assigns `id`, stamps `binding: true` and stamps `sealed_at` itself; any of those keys in your file
is rejected by `additionalProperties: false`.

**Emit no object for any other topic.** `t-02` is already terminal and `problem-scoping` cannot be
sealed.

## How to weigh the arguments

A finding whose load-bearing premise was attacked in the last allowed round and left undefended
loses. A finding that was challenged and **defended**, or that was never successfully attacked,
stands. You cannot investigate: you weigh what is on the page.

Two specific things are on the page and are yours to settle: whether `t-01`'s refutes still
describe the chapter as it now stands (several are recorded there as already implemented), and
whether `t-03`'s five supporting filings outweigh its two refutes.

## Validate before you report DONE

Run this and fix anything it reports:

```bash
python3 -c "
import json;d=json.load(open('/tmp/hol-council/judge-ruling.json'))
assert isinstance(d,list), 'file must BE an array'
assert len(d)==2, f'expected 2 rulings, got {len(d)}'
for r in d:
    assert set(r)=={'topic','point_of_contention','ruling','reasoning','conditions'}, set(r)
    assert r['topic'] in ('t-01','t-03'), r['topic']
    assert len(r['ruling'])>=10
print('OK: 2 rulings, exact key set, topics t-01/t-03')
"
```

## DONE line

The path you wrote, the two topics you ruled on, one line each summarising your ruling (quoted, not
paraphrased — the conditions are what gets implemented), and the output of the validation above.
