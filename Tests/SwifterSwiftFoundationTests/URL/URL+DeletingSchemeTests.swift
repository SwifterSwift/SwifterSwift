// URL+DeletingSchemeTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct URLDeletingSchemeTests {
    @Test(arguments: [
        ("https://domain.com/path/other/", "domain.com/path/other/"),
        ("https://domain.com", "domain.com"),
        ("http://domain.com", "domain.com"),
        ("HTTPS://Domain.com/X", "Domain.com/X"),
        ("https://user:pw@domain.com:8080/a/b?q=1&r=2#top", "user:pw@domain.com:8080/a/b?q=1&r=2#top"),
        ("file://domain.com/image.jpeg", "domain.com/image.jpeg"),
        ("file:///Users/me/file.txt", "/Users/me/file.txt"),
        ("custom:/a/b", "/a/b"),
        ("data:text/plain,hello", "text/plain,hello")
    ])
    func removesTheSchemeAndTheHostPrefix(string: String, expected: String) throws {
        let url = try #require(URL(string: string))
        #expect(url.deletingScheme()?.absoluteString == expected)
    }

    @Test(arguments: [
        ("mailto:someone@example.com", "someone@example.com"),
        ("tel:+15551234567", "+15551234567"),
        ("sms:+15551234567?body=hi", "+15551234567?body=hi")
    ])
    func keepsTheWholeAddressOfURLsWithoutAHost(string: String, expected: String) throws {
        // The old implementation dropped three characters for "://", turning mailto:someone@… into meone@….
        let url = try #require(URL(string: string))
        #expect(url.deletingScheme()?.absoluteString == expected)
    }

    @Test(arguments: [("//apple.com", "apple.com"), ("apple.com", "apple.com"), ("/a/b", "/a/b")])
    func handlesURLsWithoutAScheme(string: String, expected: String) throws {
        let url = try #require(URL(string: string))
        #expect(url.deletingScheme()?.absoluteString == expected)
    }

    @Test(arguments: ["http://", "//"])
    func returnsNilWhenNothingIsLeft(string: String) throws {
        let url = try #require(URL(string: string))
        #expect(url.deletingScheme() == nil)
    }

    @Test
    func resolvesRelativeURLs() throws {
        let base = try #require(URL(string: "https://example.com/api/"))
        let url = try #require(URL(string: "search?q=1", relativeTo: base))
        #expect(url.deletingScheme()?.absoluteString == "example.com/api/search?q=1")
    }

    @Test
    func keepsPercentEncoding() throws {
        let url = try #require(URL(string: "https://example.com/%C3%BCber?q=%F0%9F%9A%80"))
        #expect(url.deletingScheme()?.absoluteString == "example.com/%C3%BCber?q=%F0%9F%9A%80")
    }
}
#endif
