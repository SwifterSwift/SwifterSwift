// String+UrlEncodedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringUrlEncodedTests {
    @Test(arguments: [
        ("it's easy to encode strings", "it%27s%20easy%20to%20encode%20strings"),
        ("a&b=c+d", "a%26b%3Dc%2Bd"),
        ("a&b=c d", "a%26b%3Dc%20d"),
        ("?#/:@[]!$'()*,;", "%3F%23%2F%3A%40%5B%5D%21%24%27%28%29%2A%2C%3B"),
        ("100%", "100%25"),
        ("café", "caf%C3%A9"),
        ("cafe\u{301}", "cafe%CC%81"),
        ("🚀", "%F0%9F%9A%80"),
        ("line\nbreak\ttab", "line%0Abreak%09tab"),
        ("\u{0}", "%00")
    ])
    func percentEncodesReservedAndNonASCIICharacters(_ string: String, _ expected: String) {
        #expect(string.urlEncoded == expected)
    }

    @Test(arguments: ["", "abcXYZ", "0123456789", "-._~", "Swifter-Swift_9.0~beta"])
    func keepsUnreservedCharacters(_ string: String) {
        #expect(string.urlEncoded == string)
    }

    @Test
    func usesUppercaseHexDigits() {
        #expect("\u{FF}".urlEncoded == "%C3%BF")
    }

    @Test
    func encodesAnAlreadyEncodedStringAgain() {
        #expect("a%20b".urlEncoded == "a%2520b")
    }
}
