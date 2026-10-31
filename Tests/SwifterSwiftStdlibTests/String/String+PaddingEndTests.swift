// String+PaddingEndTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringPaddingEndTests {
    @Test(arguments: [
        ("str", 10, " ", "str       "),
        ("str", 10, "br", "strbrbrbrb"),
        ("str", 5, "brazil", "strbr"),
        ("str", 6, "a", "straaa"),
        ("str", 6, "abc", "strabc"),
        ("Name", 8, ".", "Name...."),
        ("", 3, "ab", "aba"),
        ("str", 4, "😀", "str😀"),
        ("👋🏽", 3, "🇸🇾", "👋🏽🇸🇾🇸🇾")
    ])
    func padsToLength(_ string: String, _ length: Int, _ padding: String, _ expected: String) {
        let result = string.paddingEnd(length, with: padding)
        #expect(result == expected)
        #expect(result.count == length)
    }

    @Test
    func padsWithSpacesByDefault() {
        #expect("str".paddingEnd(6) == "str   ")
    }

    @Test(arguments: [3, 2, 0, -1, Int.min])
    func returnsStringUnchangedWhenLongEnough(_ length: Int) {
        #expect("str".paddingEnd(length, with: "ab") == "str")
    }

    @Test(arguments: [3, 10, Int.max])
    func returnsStringUnchangedForEmptyPadding(_ length: Int) {
        #expect("str".paddingEnd(length, with: "") == "str")
        #expect("".paddingEnd(length, with: "").isEmpty)
    }
}
