// String+IsValidSchemedUrlTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringIsValidSchemedUrlTests {
    @Test(arguments: [
        "https://google.com",
        "ftp://google.com",
        "HTTPS://GOOGLE.COM",
        "mailto:tim@apple.com",
        "tel:+15555555555",
        "file:///tmp/file.txt",
        "custom-app://open?id=1",
        "urn:isbn:0451450523"
    ])
    func acceptsURLsWithScheme(_ string: String) {
        #expect(string.isValidSchemedUrl)
    }

    @Test(arguments: [
        "",
        "Hello world!",
        "google.com",
        "/relative/path",
        "//google.com/path",
        "https://apple.com/a b",
        "not a url:",
        "1http://google.com"
    ])
    func rejectsURLsWithoutSchemeOrInvalidURLs(_ string: String) {
        #expect(!string.isValidSchemedUrl)
    }
}
#endif
