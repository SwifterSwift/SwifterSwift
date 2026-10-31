// String+Base64EncodedTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringBase64EncodedTests {
    @Test(arguments: [
        ("Hello World!", "SGVsbG8gV29ybGQh"),
        ("Hello World", "SGVsbG8gV29ybGQ="),
        ("a", "YQ=="),
        ("http://example.com/xxx", "aHR0cDovL2V4YW1wbGUuY29tL3h4eA=="),
        ("🚀", "8J+agA=="),
        ("café", "Y2Fmw6k="),
        ("cafe\u{301}", "Y2FmZcyB"),
        ("", "")
    ])
    func encodesUTF8BytesAsBase64(_ string: String, _ expected: String) {
        #expect(string.base64Encoded == expected)
    }

    @Test
    func doesNotWrapLongOutput() {
        let encoded = String(repeating: "a", count: 1000).base64Encoded
        #expect(!encoded.contains("\n"))
        #expect(!encoded.contains("\r"))
    }

    @Test(arguments: ["", "Hello", "👋🏽🇸🇾", "line\r\nbreak", String(repeating: "xyz", count: 100)])
    func roundTripsThroughData(_ string: String) throws {
        let data = try #require(Data(base64Encoded: string.base64Encoded))
        #expect(String(decoding: data, as: UTF8.self) == string)
    }
}
#endif
