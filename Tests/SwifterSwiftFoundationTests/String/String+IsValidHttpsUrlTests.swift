// String+IsValidHttpsUrlTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringIsValidHttpsUrlTests {
    @Test(arguments: [
        "https://google.com",
        "HTTPS://google.com",
        "Https://Google.com/Path?q=1#top",
        "https://localhost:8443",
        "https://192.168.0.1/",
        "https://[::1]/",
        "https://user:password@example.com",
        "https://xn--r8jz45g.jp"
    ])
    func acceptsHTTPSURLsWithHost(_ string: String) {
        #expect(string.isValidHttpsUrl)
    }

    @Test(arguments: [
        "",
        "Hello world!",
        "google.com",
        "http://google.com",
        "ftp://google.com",
        "https://",
        "https:google.com",
        "https:///path",
        "https://google .com",
        "https://例え.jp",
        "httpss://google.com"
    ])
    func rejectsEverythingElse(_ string: String) {
        #expect(!string.isValidHttpsUrl)
    }
}
#endif
