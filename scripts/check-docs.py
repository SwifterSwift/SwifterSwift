#!/usr/bin/env python3
"""Checks that every public extension member has a documentation comment in the SwifterSwift format.

Usage: check-docs.py [files...]   (default: every extension source under Sources/, run from the repository root)

For each public member (property, method, initializer or subscript), the doc comment must:

1. exist, directly above the member and its attributes;
2. start with a one-line summary, `/// SwifterSwift: <Summary>.`, followed by a blank `///` line or nothing;
3. include an example in a fenced ```swift code block;
4. document every named parameter with `- Parameter <name>:` or a `- Parameters:` list, and no others;
5. have `- Returns:` exactly when a method or subscript returns a value;
6. have `- Throws:` when the member is declared `throws`.
"""

import re
import sys
from pathlib import Path

MEMBER = re.compile(
    r"^    (?:@[A-Za-z_]+(?:\([^)]*\))?\s+)*"
    r"(?:(?:public|open|static|class|final|mutating|nonmutating|convenience|override|required|nonisolated)\s+)*"
    r"(?P<kind>func|var|init[?!]?|subscript)\b"
)
ATTRIBUTE_LINE = re.compile(r"^\s*@[A-Za-z_]+(?:\(.*\))?\s*$")


def is_arrow(text, index):
    """Whether the `>` at `index` is part of a `->` arrow rather than a closing generic bracket."""
    return text[index] == ">" and index > 0 and text[index - 1] == "-"


def find_matching(text, start, open_char, close_char):
    """Returns the index of the bracket that closes the one at `start`."""
    depth = 0
    for index in range(start, len(text)):
        if text[index] == open_char:
            depth += 1
        elif text[index] == close_char and not is_arrow(text, index):
            depth -= 1
            if depth == 0:
                return index
    return -1


def split_top_level(text):
    """Splits a parameter list on commas that aren't nested in brackets."""
    parts, depth, current = [], 0, ""
    for index, char in enumerate(text):
        if char in "([<":
            depth += 1
        elif char in ")]>" and not is_arrow(text, index):
            depth -= 1
        if char == "," and depth == 0:
            parts.append(current)
            current = ""
        else:
            current += char
    if current.strip():
        parts.append(current)
    return parts


def parameter_names(parameters):
    """Returns the internal names of the parameters in a parameter list."""
    names = []
    for parameter in split_top_level(parameters):
        head = parameter.split(":", 1)[0].split()
        if not head:
            continue
        name = head[-1]
        if name != "_":
            names.append(name)
    return names


def signature_of(lines, start):
    """Joins the declaration starting at `start` up to the opening brace of its body."""
    signature = ""
    for line in lines[start:start + 40]:
        code = line.split("//", 1)[0]
        signature += " " + code.strip()
        if "{" in code:
            break
    return signature.split("{", 1)[0].strip()


def analyze(kind, signature):
    """Returns (parameters, returns a value, throws) for a member signature."""
    if kind == "var":
        return [], False, False
    open_paren = signature.find("(", signature.find(kind))
    generic = signature.find("<", signature.find(kind))
    if 0 <= generic < open_paren:
        close_generic = find_matching(signature, generic, "<", ">")
        open_paren = signature.find("(", close_generic)
    close_paren = find_matching(signature, open_paren, "(", ")")
    if open_paren < 0 or close_paren < 0:
        return [], False, False
    names = parameter_names(signature[open_paren + 1:close_paren])
    tail = signature[close_paren + 1:].split(" where ", 1)[0]
    throws = re.search(r"\bthrows\b", tail) is not None
    returns = False
    if kind in ("func", "subscript"):
        arrow = tail.find("->")
        if arrow >= 0:
            return_type = tail[arrow + 2:].strip()
            returns = return_type not in ("Void", "()")
    return names, returns, throws


def doc_comment_above(lines, index):
    """Returns the `///` lines directly above the member at `index`, skipping attribute lines."""
    cursor = index - 1
    while cursor >= 0 and ATTRIBUTE_LINE.match(lines[cursor]):
        cursor -= 1
    end = cursor
    while cursor >= 0 and lines[cursor].strip().startswith("///"):
        cursor -= 1
    return [line.strip() for line in lines[cursor + 1:end + 1]]


def documented_parameters(doc):
    names, in_list = [], False
    for line in doc:
        text = line[3:]
        single = re.match(r"^ - Parameter (\S+):", text)
        if single:
            names.append(single.group(1))
            in_list = False
        elif re.match(r"^ - Parameters:\s*$", text):
            in_list = True
        elif in_list and re.match(r"^\s{3,}- (\S+):", text):
            names.append(re.match(r"^\s{3,}- (\S+):", text).group(1))
        elif re.match(r"^ - ", text):
            in_list = False
    return names


def check_member(path, number, kind, signature, doc):
    problems = []
    where = f"{path}:{number}"
    if not doc:
        return [f"{where}: missing documentation comment"]
    summary = doc[0][3:].strip()
    if not summary.startswith("SwifterSwift: ") or len(summary) <= len("SwifterSwift: "):
        problems.append(f"{where}: summary must start with 'SwifterSwift: ' followed by text")
    elif not summary.endswith("."):
        problems.append(f"{where}: summary must be one sentence ending with a period")
    if len(doc) > 1 and doc[1] != "///":
        problems.append(f"{where}: summary must fit on one line, followed by a blank '///' line")
    fence_open = [i for i, line in enumerate(doc) if line == "/// ```swift"]
    if not fence_open or not any(line == "/// ```" for line in doc[fence_open[0] + 1:]):
        problems.append(f"{where}: missing a fenced ```swift example")
    names, returns, throws = analyze(kind, signature)
    documented = documented_parameters(doc)
    for name in names:
        if name not in documented:
            problems.append(f"{where}: parameter '{name}' isn't documented")
    for name in documented:
        if name not in names:
            problems.append(f"{where}: documents '{name}', which isn't a parameter")
    has_returns = any(line.startswith("/// - Returns:") for line in doc)
    if returns and not has_returns:
        problems.append(f"{where}: missing '- Returns:'")
    if not returns and has_returns and kind in ("func", "subscript"):
        problems.append(f"{where}: has '- Returns:' but returns nothing")
    if throws and not any(line.startswith("/// - Throws:") for line in doc):
        problems.append(f"{where}: missing '- Throws:'")
    return problems


def check_file(path):
    lines = path.read_text(encoding="utf-8").splitlines()
    problems = []
    for index, line in enumerate(lines):
        match = MEMBER.match(line)
        if not match:
            continue
        kind = match.group("kind").rstrip("?!")
        signature = signature_of(lines, index)
        problems += check_member(path, index + 1, kind, signature, doc_comment_above(lines, index))
    return problems


def main():
    if len(sys.argv) > 1:
        paths = [Path(argument) for argument in sys.argv[1:] if argument.endswith(".swift")]
    else:
        paths = sorted(p for p in Path("Sources").rglob("*.swift") if p.parts[1] != "SwifterSwift")
    problems = []
    for path in paths:
        if path.exists():
            problems += check_file(path)
    for problem in problems:
        print(f"✗ {problem}")
    print(f"documentation: {len(paths)} files checked, {len(problems)} problems")
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
