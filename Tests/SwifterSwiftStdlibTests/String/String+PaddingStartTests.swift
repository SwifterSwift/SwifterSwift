// String+PaddingStartTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringPaddingStartTests {
    @Test(arguments: [
        ("str", 10, " ", "       str"),
        ("str", 10, "br", "brbrbrbstr"),
        ("str", 5, "brazil", "brstr"),
        ("str", 6, "a", "aaastr"),
        ("str", 6, "abc", "abcstr"),
        ("42", 5, "0", "00042"),
        ("", 3, "ab", "aba"),
        ("str", 4, "😀", "😀str"),
        ("👋🏽", 3, "🇸🇾", "🇸🇾🇸🇾👋🏽"),
        ("e\u{301}", 3, "x", "xxe\u{301}")
    ])
    func padsToLength(_ string: String, _ length: Int, _ padding: String, _ expected: String) {
        let result = string.paddingStart(length, with: padding)
        #expect(result == expected)
        #expect(result.count == length)
    }

    @Test
    func padsWithSpacesByDefault() {
        #expect("str".paddingStart(6) == "   str")
    }

    @Test(arguments: [3, 2, 0, -1, Int.min])
    func returnsStringUnchangedWhenLongEnough(_ length: Int) {
        #expect("str".paddingStart(length, with: "ab") == "str")
    }

    @Test(arguments: [3, 10, Int.max])
    func returnsStringUnchangedForEmptyPadding(_ length: Int) {
        #expect("str".paddingStart(length, with: "") == "str")
        #expect("".paddingStart(length, with: "").isEmpty)
    }
}
