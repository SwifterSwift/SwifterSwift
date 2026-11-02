// URL+DeleteAllPathComponentsTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct URLDeleteAllPathComponentsTests {
    @Test(arguments: [
        ("https://domain.com/path/other/", "https://domain.com/"),
        ("https://domain.com/path/other", "https://domain.com/"),
        ("https://domain.com/", "https://domain.com/"),
        ("https://user:pw@domain.com:8080/a/b?q=1&r=2#top", "https://user:pw@domain.com:8080/?q=1&r=2#top"),
        ("https://domain.com/%C3%BCber/%F0%9F%9A%80", "https://domain.com/"),
        ("file:///Users/me/file.txt", "file:///")
    ])
    func replacesThePathWithTheRoot(string: String, expected: String) throws {
        var url = try #require(URL(string: string))
        url.deleteAllPathComponents()
        #expect(url.absoluteString == expected)
    }

    @Test(arguments: [
        "https://domain.com",
        "https://domain.com?q=1",
        "mailto:someone@example.com",
        "tel:+15551234567",
        "relative/path"
    ])
    func leavesURLsWithoutAnAbsolutePathUnchanged(string: String) throws {
        let original = try #require(URL(string: string))
        var url = original
        url.deleteAllPathComponents()
        #expect(url == original)
    }

    @Test
    func resolvesRelativeURLs() throws {
        let base = try #require(URL(string: "https://example.com/api/"))
        var url = try #require(URL(string: "search/items?q=1", relativeTo: base))
        url.deleteAllPathComponents()
        #expect(url.absoluteString == "https://example.com/?q=1")
        #expect(url.baseURL == nil)
    }

    @Test
    func isIdempotent() throws {
        var url = try #require(URL(string: "https://domain.com/a/b/c"))
        url.deleteAllPathComponents()
        url.deleteAllPathComponents()
        #expect(url.absoluteString == "https://domain.com/")
    }
}
#endif
