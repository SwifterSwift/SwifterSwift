// String+WithoutSpacesAndNewLinesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringWithoutSpacesAndNewLinesTests {
    @Test(arguments: [
        ("   \n Swifter   \n  Swift  ", "SwifterSwift"),
        ("tab\tseparated", "tabseparated"),
        ("windows\r\nline", "windowsline"),
        ("mac\rline", "macline"),
        ("1\u{A0}234\u{2009}567", "1234567"),
        ("a\u{2028}b\u{2029}c\u{3000}d", "abcd"),
        ("no-whitespace", "no-whitespace"),
        ("👋🏽 e\u{301} 🇸🇾", "👋🏽e\u{301}🇸🇾")
    ])
    func removesAllWhitespace(_ string: String, _ expected: String) {
        #expect(string.withoutSpacesAndNewLines == expected)
    }

    @Test(arguments: ["", " ", "\n\t\r\n "])
    func returnsEmptyStringForWhitespaceOnly(_ string: String) {
        #expect(string.withoutSpacesAndNewLines.isEmpty)
    }
}
