#!/usr/bin/env python3
"""Fail CI when a public Swift API declaration lacks a doc comment.

Usage:
    python3 scripts/check-doc-coverage.py [Sources]

A declaration counts as public API when it is marked `public`/`open`, or
when it is a member of a `public extension` (members of a public extension
inherit that access level; members of a public type do not, so they are
only checked when marked public themselves). `private`, `fileprivate`
and `internal` declarations are never checked.

A declaration is documented when a `///` line or a `/** ... */` block
immediately precedes it. Attribute lines (`@available`, `@discardableResult`,
...) and preprocessor lines (`#if`, `#else`, `#endif`) between the doc
comment and the declaration do not break the attachment, because Swift
allows attributes between a doc comment and its declaration. A blank line,
a plain `//` comment, or any other code line does break it: a plain `//`
comment is not a doc comment, and a doc comment separated from its
declaration by a blank line is not attached to it in Swift.

Limitations, stated plainly so a future failure is diagnosable:
- Enum cases are not checked; only type, property, method, initializer,
  subscript and typealias declarations are.
- Brace counting strips string literals and `//` comments before counting,
  so a `{` or `}` inside a string or a comment cannot confuse extension
  tracking. String interpolation containing braces is not fully parsed;
  if a future file confuses the tracker, the reported line will show it.
- A declaration whose attributes and signature span lines in a way that
  puts the declaration keyword on a continuation line is not seen.
"""

import re
import sys
from pathlib import Path

MODIFIERS = (
    r"static|final|lazy|mutating|nonmutating|override|required|"
    r"convenience|indirect|isolated|nonisolated|distributed|async|"
    r"throws|rethrows|weak|unowned"
)
DECL_KEYWORDS = (
    r"func|var|let|class|struct|enum|protocol|typealias|init|"
    r"subscript|associatedtype"
)
DECL_RE = re.compile(
    r"^\s*(?:(public|open|internal|fileprivate|private)\s+)?"
    r"(?:(?:" + MODIFIERS + r")\s+)*"
    r"(?:@\w+(?:\([^)]*\))?\s+)*"
    r"(?:(?:" + MODIFIERS + r")\s+)*"
    r"(" + DECL_KEYWORDS + r")\b"
)
EXT_RE = re.compile(r"\b(public\s+)?extension\b")
STRING_RE = re.compile(r'"(?:\\.|[^"\\])*"')
COMMENT_RE = re.compile(r"//.*$")


def strip_for_braces(line):
    """Remove string literals and line comments for brace counting."""
    line = STRING_RE.sub('""', line)
    line = COMMENT_RE.sub("", line)
    return line


def check_file(path):
    """Return a list of (line_number, declaration) for undocumented decls."""
    lines = path.read_text(errors="ignore").splitlines()
    missing = []
    depth = 0
    # Stack of (depth_after_opening_brace, is_public) for extensions.
    ext_stack = []
    pending_doc = False
    in_doc_block = False
    # Paren depth of an open multi-line attribute block, e.g. @available(...
    # spanning several lines. Continuation lines of such a block do not
    # break a doc comment's attachment to the declaration that follows.
    attr_paren_depth = 0

    for index, raw_line in enumerate(lines):
        line = raw_line.strip()

        # Multi-line /** ... */ doc blocks.
        if in_doc_block:
            if line.endswith("*/"):
                pending_doc = True
                in_doc_block = False
            continue
        if line.startswith("/**"):
            if line.endswith("*/") and len(line) > 4:
                pending_doc = True
            else:
                in_doc_block = True
            continue
        if line.startswith("///"):
            pending_doc = True
            continue
        if line == "":
            pending_doc = False
            # Blank lines carry no braces in practice; still update depth.
            continue
        if attr_paren_depth > 0:
            attr_paren_depth += line.count("(") - line.count(")")
            continue
        if line.startswith("@"):
            attr_paren_depth = line.count("(") - line.count(")")
            if attr_paren_depth < 0:
                attr_paren_depth = 0
            # Attributes do not break a doc comment's attachment.
            continue
        if line.startswith("#"):
            # Preprocessor directives do not break a doc comment's
            # attachment to the declaration that follows them.
            continue

        brace_line = strip_for_braces(raw_line)
        opens = brace_line.count("{")
        closes = brace_line.count("}")
        ext_match = EXT_RE.search(raw_line)
        if ext_match and "{" in brace_line:
            ext_stack.append((depth + opens, bool(ext_match.group(1))))

        decl_match = DECL_RE.match(raw_line)
        if decl_match:
            access = decl_match.group(1)
            if access not in ("private", "fileprivate", "internal"):
                explicit_public = access in ("public", "open")
                in_public_ext = any(
                    is_public and depth in (open_depth - 1, open_depth)
                    for open_depth, is_public in ext_stack
                )
                if explicit_public or in_public_ext:
                    if not pending_doc:
                        missing.append((index + 1, line))
            pending_doc = False
        else:
            # Any other code line (a closing brace, a body statement, a
            # plain // comment, an import) breaks doc attachment.
            pending_doc = False

        depth += opens - closes
        ext_stack = [entry for entry in ext_stack if depth >= entry[0]]

    return missing


def main(argv):
    root = Path(argv[1] if len(argv) > 1 else "Sources")
    if not root.is_dir():
        print(f"check-doc-coverage: no such directory: {root}", file=sys.stderr)
        return 2
    files = sorted(root.rglob("*.swift"))
    total = 0
    missing = []
    for path in files:
        found = check_file(path)
        total += 1
        for line_number, declaration in found:
            missing.append(f"{path}:{line_number}: {declaration}")
    if missing:
        print("Undocumented public API declarations:")
        for entry in missing:
            print(f"  {entry}")
        print(
            f"check-doc-coverage: {len(missing)} undocumented "
            f"declaration(s) in {total} file(s); 100% coverage required."
        )
        return 1
    print(f"check-doc-coverage: 100% doc coverage ({total} file(s) checked).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
