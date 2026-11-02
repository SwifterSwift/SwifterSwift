// String+PadEndTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringPadEndTests {
    @Test(arguments: [
        ("str", 10, " ", "str       "),
        ("str", 10, "br", "strbrbrbrb"),
        ("str", 5, "brazil", "strbr"),
        ("str", 6, "abc", "strabc"),
        ("", 2, "😀", "😀😀"),
        ("str", 2, "ab", "str"),
        ("str", -1, "ab", "str"),
        ("str", 10, "", "str"),
        ("str", Int.max, "", "str")
    ])
    func padsInPlace(_ string: String, _ length: Int, _ padding: String, _ expected: String) {
        var value = string
        value.padEnd(length, with: padding)
        #expect(value == expected)
    }

    @Test
    func padsWithSpacesByDefault() {
        var value = "str"
        value.padEnd(5)
        #expect(value == "str  ")
    }
}
