// URL+DeletingAllPathComponentsTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct URLDeletingAllPathComponentsTests {
    @Test(arguments: [
        ("https://domain.com/path/other/", "https://domain.com/"),
        ("https://domain.com/path/other", "https://domain.com/"),
        ("https://domain.com/path", "https://domain.com/"),
        ("https://domain.com/", "https://domain.com/"),
        ("https://user:pw@domain.com:8080/a/b?q=1&r=2#top", "https://user:pw@domain.com:8080/?q=1&r=2#top"),
        ("https://domain.com/a;params/b", "https://domain.com/"),
        ("https://domain.com/%C3%BCber/%F0%9F%9A%80", "https://domain.com/"),
        ("file:///Users/me/file.txt", "file:///"),
        ("custom:/a/b", "custom:/")
    ])
    func replacesThePathWithTheRoot(string: String, expected: String) throws {
        let url = try #require(URL(string: string))
        #expect(url.deletingAllPathComponents().absoluteString == expected)
    }

    @Test(arguments: [
        "https://domain.com",
        "https://domain.com?q=1",
        "mailto:someone@example.com",
        "tel:+15551234567",
        "relative/path"
    ])
    func returnsURLsWithoutAnAbsolutePathUnchanged(string: String) throws {
        let url = try #require(URL(string: string))
        #expect(url.deletingAllPathComponents() == url)
    }

    @Test
    func resolvesRelativeURLs() throws {
        let base = try #require(URL(string: "https://example.com/api/"))
        let url = try #require(URL(string: "search/items?q=1", relativeTo: base))
        let result = url.deletingAllPathComponents()
        #expect(result.absoluteString == "https://example.com/?q=1")
        #expect(result.baseURL == nil)
    }

    @Test
    func leavesTheOriginalUnchanged() throws {
        let url = try #require(URL(string: "https://domain.com/path"))
        _ = url.deletingAllPathComponents()
        #expect(url.absoluteString == "https://domain.com/path")
    }
}
#endif
