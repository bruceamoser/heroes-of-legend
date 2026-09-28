"""Minimal YAML subset parser (standard library only).

Supports the subset used by the engine's run files and citations file:

  key: value
  key:
    nested: value
  list:
    - scalar
    - key: value
      other: [a, b]
  inline lists [a, b, c]
  inline maps {a: 1, b: "two"}
  comments with #
  quoted strings, integers, floats, booleans, null

It is deliberately small: the engine ships with no third-party
dependencies, and the run-file schema is fixed.
"""

from __future__ import annotations


class YamlMiniError(ValueError):
    pass


def _strip_comment(line: str) -> str:
    out = []
    quote = None
    i = 0
    while i < len(line):
        ch = line[i]
        if quote:
            out.append(ch)
            if ch == "\\" and quote == '"' and i + 1 < len(line):
                out.append(line[i + 1])
                i += 2
                continue
            if ch == quote:
                quote = None
        else:
            if ch in "\"'":
                quote = ch
                out.append(ch)
            elif ch == "#":
                break
            else:
                out.append(ch)
        i += 1
    return "".join(out).rstrip()


def _split_top(text: str, sep: str = ",") -> list[str]:
    parts = []
    depth = 0
    quote = None
    current = []
    i = 0
    while i < len(text):
        ch = text[i]
        if quote:
            current.append(ch)
            if ch == "\\" and quote == '"' and i + 1 < len(text):
                current.append(text[i + 1])
                i += 2
                continue
            if ch == quote:
                quote = None
        elif ch in "\"'":
            quote = ch
            current.append(ch)
        elif ch in "[{(":
            depth += 1
            current.append(ch)
        elif ch in "]})":
            depth -= 1
            current.append(ch)
        elif ch == sep and depth == 0:
            parts.append("".join(current).strip())
            current = []
        else:
            current.append(ch)
        i += 1
    tail = "".join(current).strip()
    if tail:
        parts.append(tail)
    return parts


def _find_colon(text: str) -> int:
    depth = 0
    quote = None
    for i, ch in enumerate(text):
        if quote:
            if ch == quote:
                quote = None
            continue
        if ch in "\"'":
            quote = ch
        elif ch in "[{":
            depth += 1
        elif ch in "]}":
            depth -= 1
        elif ch == ":" and depth == 0:
            return i
    return -1


def parse_scalar(text: str):
    text = text.strip()
    if text == "" or text == "~" or text.lower() == "null":
        return None
    if text.startswith("[") and text.endswith("]"):
        inner = text[1:-1].strip()
        if not inner:
            return []
        return [parse_scalar(p) for p in _split_top(inner)]
    if text.startswith("{") and text.endswith("}"):
        inner = text[1:-1].strip()
        if not inner:
            return {}
        result = {}
        for part in _split_top(inner):
            idx = _find_colon(part)
            if idx < 0:
                raise YamlMiniError(f"bad inline map entry: {part!r}")
            key = part[:idx].strip().strip("\"'")
            result[key] = parse_scalar(part[idx + 1:])
        return result
    if len(text) >= 2 and text[0] == text[-1] and text[0] in "\"'":
        body = text[1:-1]
        if text[0] == '"':
            body = (
                body.replace("\\n", "\n")
                .replace("\\t", "\t")
                .replace('\\"', '"')
                .replace("\\\\", "\\")
            )
        return body
    low = text.lower()
    if low in ("true", "yes", "on"):
        return True
    if low in ("false", "no", "off"):
        return False
    try:
        return int(text)
    except ValueError:
        pass
    try:
        return float(text)
    except ValueError:
        pass
    return text


class _Parser:
    def __init__(self, text: str):
        self.lines: list[tuple[int, str, int]] = []
        for number, raw in enumerate(text.splitlines(), start=1):
            stripped = _strip_comment(raw)
            if not stripped.strip():
                continue
            indent = len(stripped) - len(stripped.lstrip(" "))
            if "\t" in stripped[:indent]:
                raise YamlMiniError(f"line {number}: tabs are not allowed in indentation")
            self.lines.append((indent, stripped.strip(), number))
        self.pos = 0

    def peek(self):
        if self.pos >= len(self.lines):
            return None
        return self.lines[self.pos]

    def parse(self):
        if not self.lines:
            return {}
        indent = self.lines[0][0]
        value = self.parse_block(indent)
        if self.pos != len(self.lines):
            _, content, number = self.lines[self.pos]
            raise YamlMiniError(f"line {number}: unexpected content {content!r}")
        return value

    def parse_block(self, indent: int):
        line = self.peek()
        if line is None:
            return None
        current_indent, content, _ = line
        if current_indent < indent:
            return None
        if content.startswith("- "):
            return self.parse_list(current_indent)
        if content == "-":
            return self.parse_list(current_indent)
        return self.parse_map(current_indent)

    def parse_list(self, indent: int):
        items = []
        while True:
            line = self.peek()
            if line is None:
                break
            current_indent, content, number = line
            if current_indent != indent or not content.startswith("-"):
                break
            rest = content[1:].strip()
            self.pos += 1
            if rest == "":
                child = self.parse_block(indent + 1)
                items.append(child)
                continue
            idx = _find_colon(rest)
            if idx > 0 and not rest.startswith(("[", "{", "\"", "'")):
                key = rest[:idx].strip().strip("\"'")
                value_text = rest[idx + 1:].strip()
                mapping = {}
                if value_text == "":
                    child = self.parse_block(indent + 1)
                    mapping[key] = child
                else:
                    mapping[key] = parse_scalar(value_text)
                # continuation keys of this list item's mapping
                while True:
                    nxt = self.peek()
                    if nxt is None:
                        break
                    ni, nc, _ = nxt
                    if ni <= indent or nc.startswith("-"):
                        break
                    self.pos += 1
                    cidx = _find_colon(nc)
                    if cidx <= 0:
                        raise YamlMiniError(f"line {_}: bad mapping entry {nc!r}")
                    ckey = nc[:cidx].strip().strip("\"'")
                    cval = nc[cidx + 1:].strip()
                    if cval == "":
                        child = self.parse_block(ni + 1)
                        mapping[ckey] = child
                    else:
                        mapping[ckey] = parse_scalar(cval)
                items.append(mapping)
            else:
                items.append(parse_scalar(rest))
        return items

    def parse_map(self, indent: int):
        result = {}
        while True:
            line = self.peek()
            if line is None:
                break
            current_indent, content, number = line
            if current_indent < indent:
                break
            if current_indent > indent:
                raise YamlMiniError(f"line {number}: unexpected indentation")
            if content.startswith("-"):
                break
            idx = _find_colon(content)
            if idx <= 0:
                raise YamlMiniError(f"line {number}: expected key: value, got {content!r}")
            key = content[:idx].strip().strip("\"'")
            value_text = content[idx + 1:].strip()
            self.pos += 1
            if value_text == "":
                nxt = self.peek()
                if nxt is not None and nxt[0] > current_indent:
                    result[key] = self.parse_block(nxt[0])
                elif nxt is not None and nxt[0] == current_indent and nxt[1].startswith("-"):
                    result[key] = self.parse_list(current_indent)
                else:
                    result[key] = None
            else:
                result[key] = parse_scalar(value_text)
        return result


def loads(text: str):
    return _Parser(text).parse()


def load(path) -> object:
    with open(path, "r", encoding="utf-8") as handle:
        return loads(handle.read())
