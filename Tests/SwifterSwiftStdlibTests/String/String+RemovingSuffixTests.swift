// String+RemovingSuffixTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringRemovingSuffixTests {
    @Test(arguments: [
        ("photo.jpeg", ".jpeg", "photo"),
        ("Hello, World!", ", World!", "Hello"),
        ("Hello, World!", "Hello, World!", ""),
        ("aaa", "a", "aa"),
        ("café", "é", "caf"),
        ("cafe\u{301}", "\u{E9}", "caf"),
        ("thumbs 👍🏽", " 👍🏽", "thumbs")
    ])
    func removesSuffix(_ string: String, _ suffix: String, _ expected: String) {
        #expect(string.removingSuffix(suffix) == expected)
    }

    @Test(arguments: [
        ("photo.jpeg", ".png"),
        ("tick tock", "TOCK"),
        ("short", "longer than short"),
        ("", "a"),
        ("café", "e"),
        ("a\u{301}", "\u{301}"),
        ("👍🏽", "🏽")
    ])
    func returnsStringUnchangedWithoutSuffix(_ string: String, _ suffix: String) {
        #expect(string.removingSuffix(suffix) == string)
    }

    @Test(arguments: ["", "text"])
    func returnsStringUnchangedForEmptySuffix(_ string: String) {
        #expect(string.removingSuffix("") == string)
    }
}
