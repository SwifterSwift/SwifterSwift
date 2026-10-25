"""Tests for scripts/check-doc-coverage.py.

Run from the repo root:
    python3 -m unittest discover -s scripts/tests -v
"""

import importlib.util
import tempfile
import unittest
from pathlib import Path

# The checker file uses a hyphenated name, so load it by path.
_CHECKER = Path(__file__).resolve().parents[1] / "check-doc-coverage.py"
_SPEC = importlib.util.spec_from_file_location("check_doc_coverage", _CHECKER)
_MODULE = importlib.util.module_from_spec(_SPEC)
_SPEC.loader.exec_module(_MODULE)
check_file = _MODULE.check_file


def check(source):
    with tempfile.TemporaryDirectory() as tmp:
        path = Path(tmp) / "Example.swift"
        path.write_text(source)
        return check_file(path)


class TestCheckDocCoverage(unittest.TestCase):
    def test_documented_public_func_passes(self):
        self.assertEqual(
            check("public extension Foo {\n    /// Does a thing.\n    func bar() {}\n}\n"),
            [],
        )

    def test_undocumented_public_func_fails(self):
        missing = check("public extension Foo {\n    func bar() {}\n}\n")
        self.assertEqual(len(missing), 1)
        self.assertEqual(missing[0][0], 2)

    def test_plain_comment_is_not_a_doc_comment(self):
        missing = check(
            "public extension Foo {\n    // Does a thing.\n    var height: Int { 0 }\n}\n"
        )
        self.assertEqual(len(missing), 1)

    def test_blank_line_breaks_doc_attachment(self):
        missing = check(
            "public extension Foo {\n    /// Does a thing.\n\n    func bar() {}\n}\n"
        )
        self.assertEqual(len(missing), 1)

    def test_multiline_available_block_keeps_doc(self):
        missing = check(
            "public extension Foo {\n"
            "    /// Does a thing.\n"
            "    @available(\n"
            "        *,\n"
            "        deprecated,\n"
            "        message: \"Use other() instead.\")\n"
            "    func bar() {}\n"
            "}\n"
        )
        self.assertEqual(missing, [])

    def test_private_member_in_public_extension_is_ignored(self):
        self.assertEqual(
            check("public extension Foo {\n    private var state: Int { 0 }\n}\n"),
            [],
        )

    def test_explicit_public_static_let(self):
        missing = check(
            "public extension Foo {\n"
            "    /// Top to bottom.\n"
            "    public static let top = 1\n"
            "    public static let bottom = 2\n"
            "}\n"
        )
        self.assertEqual(len(missing), 1)
        self.assertEqual(missing[0][0], 4)

    def test_member_of_public_type_without_public_is_ignored(self):
        self.assertEqual(
            check("/// A foo.\npublic struct Foo {\n    var bar: Int { 0 }\n}\n"),
            [],
        )

    def test_doc_block_style(self):
        self.assertEqual(
            check("public extension Foo {\n    /** Does a thing. */\n    func bar() {}\n}\n"),
            [],
        )

    def test_conditional_doc_survives_preprocessor_lines(self):
        missing = check(
            "public extension Foo {\n"
            "    /// Does a thing.\n"
            "    #if os(Linux)\n"
            "    func bar() {}\n"
            "    #endif\n"
            "}\n"
        )
        self.assertEqual(missing, [])


if __name__ == "__main__":
    unittest.main()
