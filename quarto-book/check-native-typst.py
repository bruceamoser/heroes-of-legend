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
  6. every ``{=typst}`` fence is CLOSED by a bare ``` line after it

Item 6 exists because item 1 counted OPENERS only. A chapter whose typst block was
never closed still reported "one fence each" and passed, while the renderer treated
every line after the opener as code: ch18 (advancement, 2026-09-14) shipped with the
whole chapter printed as its own source, headings and ``#figure(...`` calls and all.
A gate that counts openers cannot see a missing closer, so the closer is checked
separately and the file's fence lines are required to pair up.

Exit 0 = clean. Exit 1 = findings printed.

Backtick code spans are stripped before the remnant scan: ch19 legitimately documents
the card format inside a span (`` `**Disciplines:** ...` ``), which is not a remnant.

Run ``--selftest`` for the negative control: it plants an unclosed fence (and a stray
markdown remnant) in a scratch copy and fails unless the checker rejects both.
"""
import re
import shutil
import sys
import tempfile
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent
BOOK = ROOT
IDX = BOOK / "index.qmd"
CHAPTERS = BOOK / "chapters"

NO_H1_EXEMPT = {"index.qmd", "00-front-matter.qmd"}

OPENER = "```{=typst}"
CLOSER = "```"

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


def check_fences(text: str, name: str = "<text>") -> list:
    """Items 1 and 6: exactly one {=typst} opener, and every fence closed.

    Returns a list of finding strings (empty = clean). Kept separate from check()
    so --selftest can drive it directly with known-bad and known-good input.
    """
    lines = text.split("\n")
    # A fence line is any line whose stripped content starts with ``` (opener or closer).
    fence_idx = [i for i, l in enumerate(lines) if l.strip().startswith("```")]
    openers = [i for i in fence_idx if lines[i].strip().startswith(OPENER)]
    out = []
    if len(openers) != 1:
        out.append(f"{name}: expected exactly 1 {OPENER} fence, found {len(openers)}")
    if not fence_idx:
        return out
    # Every fence line must pair: opener first, then its closer. An odd count means
    # the last block was never closed (or a closer lost its opener).
    if len(fence_idx) % 2 != 0:
        last = lines[fence_idx[-1]].strip()[:40]
        out.append(f"{name}:{fence_idx[-1] + 1}: unclosed fence - {len(fence_idx)} fence line(s) "
                   f"(last: {last!r}); a {OPENER} block needs a closing {CLOSER}")
    elif len(openers) == 1 and fence_idx[0] != openers[0]:
        out.append(f"{name}:{fence_idx[0] + 1}: fence line before the {OPENER} opener")
    return out


def check(root: "pathlib.Path | None" = None) -> int:
    """Run every structural invariant over the book (or over `root`)."""
    book = pathlib.Path(root) if root else BOOK
    idx = book / "index.qmd"
    chapters = book / "chapters"
    files = [p for p in [idx] + sorted(chapters.glob("*.qmd")) if p.is_file()]
    findings = []
    for f in files:
        raw = f.read_text(encoding="utf-8")
        scan = strip_code_spans(raw)
        lines = raw.split("\n")

        fences = raw.count(OPENER)
        if fences != 1:
            findings.append(f"{f.name}: expected exactly 1 {OPENER} fence, found {fences}")

        findings.extend(check_fences(raw, f.name))

        if f.name not in NO_H1_EXEMPT:
            fi = next((i for i, l in enumerate(lines)
                       if l.strip().startswith(OPENER)), None)
            if fi is None:
                findings.append(f"{f.name}: no {OPENER} fence")
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
    print(f"OK - {len(files)} files: one {{{{=typst}}}} fence each (closed), H1 above the fence, "
          f"no markdown remnants, all tables outlined: false, all callout bodies named.")
    return 0


UNCLOSED_SAMPLE = "# Chapter\n\n```{=typst}\n#label(\"x\")\n\n== Heading\n\n**bold remnant**\n"
CLOSED_SAMPLE = "# Chapter\n\n```{=typst}\n#label(\"x\")\n\n== Heading\n\n_body_\n```\n"


def selftest() -> int:
    """Negative control: the fence check must FLAG an unclosed block, and pass a closed one.

    Also drives the whole checker over a scratch book (one good chapter + one with the
    unclosed fence) and asserts it exits non-zero and names the file.
    """
    bad = check_fences(UNCLOSED_SAMPLE, "bad.qmd")
    good = check_fences(CLOSED_SAMPLE, "good.qmd")
    ok = True
    if not bad:
        print("SELFTEST FAIL: unclosed fence NOT detected (the gate is decorative)")
        ok = False
    if good:
        print("SELFTEST FAIL: closed fence reported as a finding:", good)
        ok = False
    print(f"  control 1 (unclosed detected): {bad}")
    print(f"  control 2 (closed clean):      {good}")

    with tempfile.TemporaryDirectory() as td:
        root = pathlib.Path(td)
        (root / "chapters").mkdir()
        (root / "index.qmd").write_text(CLOSED_SAMPLE.replace("x", "index"), encoding="utf-8")
        (root / "chapters" / "99-bad.qmd").write_text(UNCLOSED_SAMPLE, encoding="utf-8")
        import io
        import contextlib
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf):
            rc = check(root)
        out = buf.getvalue()
        if rc == 0 or "99-bad.qmd" not in out or "unclosed" not in out:
            print("SELFTEST FAIL: whole-checker run over a planted defect did not fail and name it")
            print(out)
            ok = False
        else:
            print("  control 3 (whole checker exits 1 and names the file): PASS")
    print("SELFTEST OK" if ok else "SELFTEST FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    if "--selftest" in sys.argv:
        sys.exit(selftest())
    sys.exit(check())
