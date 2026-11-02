// String+TrimTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringTrimTests {
    @Test(arguments: [
        ("  \n Swifter Swift \t", "Swifter Swift"),
        ("\r\nHello\r\n", "Hello"),
        ("  inner  space  ", "inner  space"),
        ("unchanged", "unchanged"),
        (" 🇸🇾 ", "🇸🇾")
    ])
    func trimsWhitespaceAndNewlines(_ string: String, _ expected: String) {
        var value = string
        value.trim()
        #expect(value == expected)
    }

    @Test(arguments: ["", " ", "\n\t\r\n"])
    func leavesEmptyStringForWhitespaceOnly(_ string: String) {
        var value = string
        value.trim()
        #expect(value.isEmpty)
    }
}
