// String+TrimmedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringTrimmedTests {
    @Test(arguments: [
        ("  Hello, World! \n", "Hello, World!"),
        ("\t Swifter Swift \r\n", "Swifter Swift"),
        ("\u{A0}\u{2003}text\u{2028}\u{3000}", "text"),
        ("no-whitespace", "no-whitespace"),
        ("  inner  space  ", "inner  space"),
        ("\n\nline 1\nline 2\n\n", "line 1\nline 2"),
        (" 👋🏽 ", "👋🏽"),
        (" e\u{301} ", "e\u{301}")
    ])
    func trimsWhitespaceAndNewlines(_ string: String, _ expected: String) {
        #expect(string.trimmed == expected)
    }

    @Test(arguments: ["", " ", "\n", " \t\r\n ", "\u{2029}\u{85}"])
    func returnsEmptyStringForWhitespaceOnly(_ string: String) {
        #expect(string.trimmed.isEmpty)
    }

    @Test
    func keepsZeroWidthSpace() {
        // U+200B isn't a whitespace character in Unicode, so it's kept.
        #expect("\u{200B}a ".trimmed == "\u{200B}a")
    }
}
