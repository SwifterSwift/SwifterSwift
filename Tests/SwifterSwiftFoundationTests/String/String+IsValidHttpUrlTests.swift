// String+IsValidHttpUrlTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringIsValidHttpUrlTests {
    @Test(arguments: [
        "http://google.com",
        "HTTP://google.com",
        "http://localhost:8080/path",
        "http://127.0.0.1",
        "http://[::1]:80/",
        "http://example.com/a%20b?q=1&r=2"
    ])
    func acceptsHTTPURLsWithHost(_ string: String) {
        #expect(string.isValidHttpUrl)
    }

    @Test(arguments: [
        "",
        "Hello world!",
        "google.com",
        "https://google.com",
        "http://",
        "http:google.com",
        "http:///path",
        "http://google.com/a b"
    ])
    func rejectsEverythingElse(_ string: String) {
        #expect(!string.isValidHttpUrl)
    }
}
#endif
