// String+UrlEncodeTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringUrlEncodeTests {
    @Test(arguments: [
        ("it's easy to encode strings", "it%27s%20easy%20to%20encode%20strings"),
        ("a&b=c d", "a%26b%3Dc%20d"),
        ("100%", "100%25"),
        ("café 🚀", "caf%C3%A9%20%F0%9F%9A%80"),
        ("", ""),
        ("Swifter-Swift_9.0~beta", "Swifter-Swift_9.0~beta")
    ])
    func percentEncodesInPlace(_ string: String, _ expected: String) {
        var value = string
        value.urlEncode()
        #expect(value == expected)
    }
}
