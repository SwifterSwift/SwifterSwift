// String+TruncateTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringTruncateTests {
    @Test(arguments: [
        ("This is a very long sentence", 14, "…", "This is a ver…"),
        ("This is a very long sentence", 14, "...", "This is a v..."),
        ("This is a very long sentence", 14, "", "This is a very"),
        ("This is a short sentence", 100, "…", "This is a short sentence"),
        ("This is a short sentence", 24, "…", "This is a short sentence"),
        ("Hello", 2, "...", "He"),
        ("Hello", 0, "…", ""),
        ("Hello", -1, "…", ""),
        ("", 5, "…", ""),
        ("👋🏽🇸🇾abc", 3, "…", "👋🏽🇸🇾…")
    ])
    func truncatesInPlace(_ string: String, _ length: Int, _ trailing: String, _ expected: String) {
        var value = string
        value.truncate(toLength: length, trailing: trailing)
        #expect(value == expected)
    }

    @Test
    func usesEllipsisByDefault() {
        var value = "Swifter Swift"
        value.truncate(toLength: 8)
        #expect(value == "Swifter…")
    }
}
