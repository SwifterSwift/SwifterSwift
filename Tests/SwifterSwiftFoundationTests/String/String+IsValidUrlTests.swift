// String+IsValidUrlTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringIsValidUrlTests {
    @Test(arguments: [
        "https://google.com",
        "http://google.com",
        "ftp://google.com",
        "https://apple.com/a%20b?q=1#top",
        "mailto:tim@apple.com",
        "file:///Users/tim/notes.txt",
        "http://[::1]:8080/",
        "google.com",
        "/relative/path",
        "relative/path",
        "?query=only",
        "#fragment"
    ])
    func acceptsValidURLs(_ string: String) {
        #expect(string.isValidUrl)
    }

    @Test(arguments: [
        "",
        "not url",
        "Hello world!",
        "https://apple.com/a b",
        "https://exa mple.com",
        "https://例え.jp",
        "https://apple.com/👋",
        "http://[::1",
        "https://apple.com/%zz"
    ])
    func rejectsInvalidURLs(_ string: String) {
        #expect(!string.isValidUrl)
    }
}
#endif
