"""Command line interface: run, audit, validate, explain, replay."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from .bestiary import parse_bestiary
from .cards import CardBook
from .reports import (
    format_report, parse_events_mode, run_all, run_one, study_healers, study_layers,
    summarize, write_outputs,
)
from .rules import Rules, default_paths, rules as default_rules
from .runfile import describe, load, validate


def _load_runfile(path):
    return load(path)


def _dump_characters(run_name, party_chars):
    outdir = Path(__file__).resolve().parents[1] / "characters" / str(run_name)
    outdir.mkdir(parents=True, exist_ok=True)
    for char in party_chars:
        path = outdir / f"{char.id}.json"
        path.write_text(json.dumps(char.as_dict(), indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return outdir


def cmd_audit(args):
    audit_rules = Rules(args.citations, args.chapters)
    ok, failures = audit_rules.audit()
    print(f"citations: {len(audit_rules.entries)} checked against {audit_rules.chapters_dir}")
    if ok:
        print("audit: PASS - every cited line still carries its value")
        return 0
    print(f"audit: FAIL - {len(failures)} citation(s) drifted")
    for failure in failures:
        print(f"  {failure['id']} [{failure['source']}]")
        if "expected" in failure:
            print(f"    expected: {failure['expected']}")
            print(f"    actual:   {failure['actual']}")
        else:
            print(f"    {failure['error']}")
    return 1


def cmd_validate(args):
    data = _load_runfile(args.runfile)
    problems = validate(data)
    if not problems:
        print(f"validate: OK - {args.runfile}")
        return 0
    print(f"validate: FAIL - {len(problems)} problem(s)")
    for problem in problems:
        print(f"  - {problem}")
    return 1


def cmd_explain(args):
    data = _load_runfile(args.runfile)
    problems = validate(data)
    if problems:
        print("run file is invalid; fix these first:", file=sys.stderr)
        for problem in problems:
            print(f"  - {problem}", file=sys.stderr)
        return 1
    from .characters import build_party
    chars = build_party(data.get("party") or [])
    _dump_characters(data["run"]["name"], chars)
    print(json.dumps(describe(data), indent=2, sort_keys=True))
    return 0


def cmd_run(args):
    data = _load_runfile(args.runfile)
    problems = validate(data)
    if problems:
        print("run file is invalid:", file=sys.stderr)
        for problem in problems:
            print(f"  - {problem}", file=sys.stderr)
        return 2
    engine_rules = default_rules()
    cardbook = CardBook(engine_rules)
    run = data["run"]

    if args.replay is not None:
        index = int(args.replay)
        from .characters import build_party
        party_chars = build_party(data.get("party") or [])
        _dump_characters(run["name"], party_chars)
        result = run_one(data, index, engine_rules, cardbook, party_chars, record_events=True,
                         script=run.get("dice_script"))
        print(json.dumps({k: v for k, v in result.items() if k != "events"}, indent=2, sort_keys=True))
        for event in result.get("events") or []:
            print(json.dumps(event, sort_keys=True))
        return 0

    iterations = int(args.iterations) if args.iterations else None
    if args.events:
        run["events"] = args.events
    results, party_chars = run_all(data, engine_rules, cardbook, iterations=iterations)
    summary = summarize(data, results)
    event_mode = parse_events_mode(run.get("events", "first:100"))
    char_dir = _dump_characters(run["name"], party_chars)
    study = data.get("study") or {}
    if study.get("layers"):
        study_iterations = int(study.get("iterations", min(int(run["iterations"]), 1000)))
        summary["layer_study"] = study_layers(data, engine_rules, cardbook, study_iterations)
    if study.get("healers"):
        study_iterations = int(study.get("iterations", min(int(run["iterations"]), 1000)))
        summary["healer_study"] = study_healers(data, engine_rules, cardbook, study_iterations)
    outdir = Path(args.out) if args.out else Path(__file__).resolve().parents[1] / "reports" / str(run["name"])
    paths = write_outputs(outdir, summary, results, event_mode)
    print(format_report(summary))
    print("")
    print("wrote:")
    for kind, path in paths.items():
        print(f"  {kind}: {path}")
    print(f"  characters: {char_dir}")
    return 0


def build_parser():
    parser = argparse.ArgumentParser(prog="hol-engine", description="Heroes of Legend combat engine")
    sub = parser.add_subparsers(dest="command", required=True)

    audit = sub.add_parser("audit", help="verify every citation against the chapters")
    audit.add_argument("--citations", default=None)
    audit.add_argument("--chapters", default=None)
    audit.set_defaults(func=cmd_audit)

    validate_parser = sub.add_parser("validate", help="check a run file without running it")
    validate_parser.add_argument("runfile")
    validate_parser.set_defaults(func=cmd_validate)

    explain = sub.add_parser("explain", help="print the constructed characters and creatures")
    explain.add_argument("runfile")
    explain.set_defaults(func=cmd_explain)

    run = sub.add_parser("run", help="execute a run and write reports")
    run.add_argument("runfile")
    run.add_argument("--out", default=None, help="output directory")
    run.add_argument("--iterations", type=int, default=None, help="override run.iterations")
    run.add_argument("--events", default=None, help="all | none | first:N")
    run.add_argument("--replay", type=int, default=None, help="re-run combat N and print its event log")
    run.set_defaults(func=cmd_run)
    return parser


def main(argv=None):
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        return args.func(args)
    except Exception as exc:  # fail loudly, not quietly
        print(f"hol-engine: error: {exc}", file=sys.stderr)
        if __debug__ and "HOL_DEBUG" in __import__("os").environ:
            raise
        return 3


if __name__ == "__main__":
    sys.exit(main())
