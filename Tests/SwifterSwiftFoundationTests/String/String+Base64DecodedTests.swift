// String+Base64DecodedTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringBase64DecodedTests {
    @Test(arguments: [
        ("SGVsbG8gV29ybGQh", "Hello World!"),
        ("aHR0cDovL2V4YW1wbGUuY29tL3h4eA", "http://example.com/xxx"),
        ("aHR0cDovL2V4YW1wbGUuY29tL3h4eA==", "http://example.com/xxx"),
        ("SGVsbG8gV29ybGQ", "Hello World"),
        ("SGVsbG8gV29ybGQ=", "Hello World"),
        ("YQ", "a"),
        ("YQ=", "a"),
        ("YQ==", "a"),
        ("8J+agA==", "🚀"),
        ("Y2Fmw6k=", "café"),
        ("", "")
    ])
    func decodesStandardBase64WithOrWithoutPadding(_ string: String, _ expected: String) {
        #expect(string.base64Decoded == expected)
    }

    @Test(arguments: [
        ("SGVsbG\n8gV29ybGQh", "Hello World!"),
        ("SGVsbG8gV29ybGQh\n", "Hello World!"),
        ("SGVs\r\nbG8g\r\nV29y\r\nbGQh\r\n", "Hello World!"),
        ("  SGVs bG8g\tV29ybGQh  ", "Hello World!")
    ])
    func ignoresWhitespaceAndLineBreaks(_ string: String, _ expected: String) {
        #expect(string.base64Decoded == expected)
    }

    @Test(arguments: [("8J-agA", "🚀"), ("8J-agA==", "🚀"), ("Pz8_", "???"), ("Pz8-Pz8_", "??>???")])
    func decodesURLSafeBase64(_ string: String, _ expected: String) {
        #expect(string.base64Decoded == expected)
    }

    @Test(arguments: [
        "Hello World!",
        "SGVs!bG8",
        "Y",
        "YQ===",
        "=",
        "==",
        "====",
        "YWJj=",
        "Y=Q=",
        "SGVsbG8gV29ybGQh€",
        "Zm9v.YmFy"
    ])
    func returnsNilForInvalidBase64(_ string: String) {
        #expect(string.base64Decoded == nil)
    }

    @Test(arguments: ["/w==", "wyg=", "gA=="])
    func returnsNilForDataThatIsNotUTF8(_ string: String) {
        #expect(string.base64Decoded == nil)
    }
}
#endif
