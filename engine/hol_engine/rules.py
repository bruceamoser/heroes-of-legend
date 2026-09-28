"""Rule constants, loaded from rules/citations.yaml, plus the --audit check.

The citation file is the single source for every constant the engine uses.
`audit()` re-reads the chapter files and verifies the text at each cited
line still contains the expected fragment.
"""

from __future__ import annotations

import glob
import os
from pathlib import Path

from .yamlmini import load as yaml_load


class CitationError(RuntimeError):
    pass


def default_paths():
    engine_dir = Path(__file__).resolve().parents[1]
    repo_root = engine_dir.parent
    return (
        engine_dir / "rules" / "citations.yaml",
        repo_root / "quarto-book" / "chapters",
    )


class Rules:
    def __init__(self, citations_path=None, chapters_dir=None):
        default_citations, default_chapters = default_paths()
        self.citations_path = Path(citations_path or default_citations)
        self.chapters_dir = Path(chapters_dir or default_chapters)
        data = yaml_load(str(self.citations_path))
        entries = data.get("citations") if isinstance(data, dict) else None
        if not isinstance(entries, list):
            raise CitationError(f"{self.citations_path}: missing top-level 'citations' list")
        self.entries = entries
        self.constants = {}
        for entry in entries:
            if not isinstance(entry, dict) or "id" not in entry:
                raise CitationError(f"bad citation entry: {entry!r}")
            cid = entry["id"]
            if cid in self.constants:
                raise CitationError(f"duplicate citation id {cid!r}")
            self.constants[cid] = entry.get("value")

    def get(self, cid):
        if cid not in self.constants:
            raise CitationError(f"unknown citation id {cid!r}")
        return self.constants[cid]

    def entry(self, cid):
        for entry in self.entries:
            if entry.get("id") == cid:
                return entry
        raise CitationError(f"unknown citation id {cid!r}")

    def chapter_path(self, number: str) -> Path | None:
        matches = sorted(glob.glob(str(self.chapters_dir / f"{number}-*.qmd")))
        if not matches:
            return None
        return Path(matches[0])

    def wound_rows(self):
        rows = []
        for entry in self.entries:
            cid = entry.get("id", "")
            if cid.startswith("wound-row-"):
                rows.append(entry.get("value"))
        return rows

    def audit(self):
        """Return (ok, failures). Each failure is a dict describing the drift."""
        failures = []
        for entry in self.entries:
            cid = entry.get("id", "<no id>")
            source = str(entry.get("source", ""))
            text = entry.get("text")
            if ":" not in source:
                failures.append({"id": cid, "source": source, "error": "source is not chapter:line"})
                continue
            chapter, _, line_text = source.partition(":")
            try:
                line_no = int(line_text)
            except ValueError:
                failures.append({"id": cid, "source": source, "error": "line is not a number"})
                continue
            path = self.chapter_path(chapter)
            if path is None:
                failures.append({"id": cid, "source": source, "error": f"no chapter file for {chapter}"})
                continue
            try:
                lines = path.read_text(encoding="utf-8").splitlines()
            except OSError as exc:
                failures.append({"id": cid, "source": source, "error": str(exc)})
                continue
            if line_no < 1 or line_no > len(lines):
                failures.append({"id": cid, "source": source, "error": f"line out of range (file has {len(lines)})"})
                continue
            actual = lines[line_no - 1].strip()
            if text is None:
                failures.append({"id": cid, "source": source, "error": "no 'text' field to verify"})
            elif text not in actual:
                failures.append({"id": cid, "source": source, "expected": text, "actual": actual})
        return (not failures), failures


_rules = None


def rules() -> Rules:
    global _rules
    if _rules is None:
        _rules = Rules()
    return _rules
