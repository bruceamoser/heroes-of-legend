#!/usr/bin/env python3
"""Native-Typst gate for the Heroes of Legend rulebook (issue #424, MIGRATION-SPEC).

Verifies the migration's structural invariants so a markdown remnant or a SPEC-trap
regression fails loudly instead of shipping:

  1. every .qmd body is exactly ONE ``{=typst}`` fence
  2. the ``# H1`` line is the first non-blank line above that fence
     (exempt: index.qmd and 00-front-matter.qmd, which carry no H1 of their own)
  3. no markdown remnants (bold, images, links, ::: divs, shortcodes, pipe tables)
  4. every #table( carries `outlined: false`
  5. every #callout( body is the NAMED `body: [ ... ]` form

Exit 0 = clean. Exit 1 = findings printed.

Backtick code spans are stripped before the remnant scan: ch19 legitimately documents
the card format inside a span (`` `**Disciplines:** ...` ``), which is not a remnant.
"""
import re
import sys
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent
BOOK = ROOT
IDX = BOOK / "index.qmd"
CHAPTERS = BOOK / "chapters"

NO_H1_EXEMPT = {"index.qmd", "00-front-matter.qmd"}

REMNANTS = [
    ("markdown bold **", re.compile(r"\*\*[^*\n]+\*\*")),
    ("markdown image ![]", re.compile(r"!\[[^\]]*\]\(")),
    ("markdown link []()", re.compile(r"(?<!!)\[[^\]\n]+\]\([^)\n]+\)")),
    ("div :::", re.compile(r"^\s*:::", re.M)),
    # Quarto ORCHESTRATION shortcodes are legitimate (`{{< include ... >}}`, `{{< meta date >}}`);
    # only CONTENT shortcodes (the old pagebreak/div ones) are migration remnants.
    ("content shortcode {{<", re.compile(r"\{\{<(?!\s*(?:include|meta)\b)")),
    ("md caption ': X {#", re.compile(r"^:\s+[A-Z][^\n]*\{#", re.M)),
    ("md pipe table", re.compile(r"^\|[^|\n]+\|[^|\n]+\|\s*$", re.M)),
]


def strip_code_spans(text: str) -> str:
    """Remove `...` spans (single-line pairing) so documented syntax is not flagged."""
    out = []
    for line in text.split("\n"):
        # remove an even number of backtick-delimited spans per line
        parts = line.split("`")
        keep = [parts[i] for i in range(0, len(parts), 2)]
        out.append("".join(keep))
    return "\n".join(out)


def check() -> int:
    files = [IDX] + sorted(CHAPTERS.glob("*.qmd"))
    findings = []
    for f in files:
        raw = f.read_text(encoding="utf-8")
        scan = strip_code_spans(raw)
        lines = raw.split("\n")

        fences = raw.count("```{=typst}")
        if fences != 1:
            findings.append(f"{f.name}: expected exactly 1 {{=typst}} fence, found {fences}")

        if f.name not in NO_H1_EXEMPT:
            fi = next((i for i, l in enumerate(lines)
                       if l.strip().startswith("```{=typst}")), None)
            if fi is None:
                findings.append(f"{f.name}: no {{=typst}} fence")
            else:
                pre = [l for l in lines[:fi] if l.strip()]
                if not pre or not pre[0].startswith("# "):
                    first = pre[0][:50] if pre else "<nothing>"
                    findings.append(f"{f.name}: H1 is not the first non-blank line above the fence ({first!r})")

        for label, pat in REMNANTS:
            for m in pat.finditer(scan):
                ln = scan[:m.start()].count("\n") + 1
                findings.append(f"{f.name}:{ln}: {label}: {m.group(0)[:60]!r}")

        tables = raw.count("#table(")
        outlined = raw.count("outlined: false")
        if tables != outlined:
            findings.append(f"{f.name}: {tables} #table( but {outlined} 'outlined: false'")

        for m in re.finditer(r"#callout\((?:(?!body:)[^)])*\)\s*\[", raw):
            ln = raw[:m.start()].count("\n") + 1
            findings.append(f"{f.name}:{ln}: callout body is POSITIONAL, must be named `body: [ ... ]`")

    if findings:
        print(f"FAIL - {len(findings)} finding(s):\n")
        for x in findings:
            print("  " + x)
        return 1
    print(f"OK - {len(files)} files: one {{{{=typst}}}} fence each, H1 above the fence, "
          f"no markdown remnants, all tables outlined: false, all callout bodies named.")
    return 0


if __name__ == "__main__":
    sys.exit(check())
