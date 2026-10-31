// String+PadStartTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringPadStartTests {
    @Test(arguments: [
        ("str", 10, " ", "       str"),
        ("str", 10, "br", "brbrbrbstr"),
        ("str", 5, "brazil", "brstr"),
        ("str", 6, "abc", "abcstr"),
        ("", 2, "😀", "😀😀"),
        ("str", 2, "ab", "str"),
        ("str", -1, "ab", "str"),
        ("str", 10, "", "str"),
        ("str", Int.max, "", "str")
    ])
    func padsInPlace(_ string: String, _ length: Int, _ padding: String, _ expected: String) {
        var value = string
        value.padStart(length, with: padding)
        #expect(value == expected)
    }

    @Test
    func padsWithSpacesByDefault() {
        var value = "str"
        value.padStart(5)
        #expect(value == "  str")
    }
}
