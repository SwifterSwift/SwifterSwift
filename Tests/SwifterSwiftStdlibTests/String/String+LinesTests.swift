// String+LinesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringLinesTests {
    @Test(arguments: [
        ("Hello\ntest", ["Hello", "test"]),
        ("one\r\ntwo\r\nthree", ["one", "two", "three"]),
        ("one\rtwo", ["one", "two"]),
        ("one\n\nthree", ["one", "", "three"]),
        ("one\n", ["one"]),
        ("one\n\n", ["one", ""]),
        ("\none", ["", "one"]),
        ("\n", [""]),
        ("single line", ["single line"]),
        ("a\u{2028}b\u{2029}c\u{85}d", ["a", "b", "c", "d"]),
        ("a\u{0B}b\u{0C}c", ["a", "b", "c"]),
        ("  indented\n\ttabbed  ", ["  indented", "\ttabbed  "]),
        ("👋🏽\ne\u{301}", ["👋🏽", "e\u{301}"])
    ])
    func splitsIntoLines(_ string: String, _ expected: [String]) {
        #expect(string.lines() == expected)
    }

    @Test
    func returnsNoLinesForEmptyString() {
        #expect("".lines().isEmpty)
    }

    @Test
    func treatsCarriageReturnLineFeedAsOneLineBreak() {
        #expect("a\r\n\r\nb".lines() == ["a", "", "b"])
    }
}
