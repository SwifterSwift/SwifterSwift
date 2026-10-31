// String+IsDigitsTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringIsDigitsTests {
    @Test(arguments: ["0", "123", "987654321", "0000", "99999999999999999999999999999"])
    func returnsTrueForASCIIDigits(_ string: String) {
        #expect(string.isDigits)
    }

    @Test(arguments: [
        "",
        " ",
        "123.4",
        "1.25e2",
        "123abc",
        "-1",
        "+1",
        " 1",
        "1 ",
        "1,000",
        "٣",
        "١٢٣",
        "３",
        "½",
        "Ⅻ",
        "1\u{301}"
    ])
    func returnsFalseForAnythingElse(_ string: String) {
        #expect(!string.isDigits)
    }
}
