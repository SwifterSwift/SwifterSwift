// URL+QueryValueTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct URLQueryValueTests {
    @Test
    func returnsValueForName() throws {
        let url = try #require(URL(string: "https://example.com/search?q=swift&page=2"))
        #expect(url.queryValue(for: "q") == "swift")
        #expect(url.queryValue(for: "page") == "2")
    }

    @Test
    func returnsNilForMissingName() throws {
        let url = try #require(URL(string: "https://example.com/search?q=swift"))
        #expect(url.queryValue(for: "page") == nil)
    }

    @Test
    func returnsNilWhenURLHasNoQuery() throws {
        let url = try #require(URL(string: "https://example.com/search"))
        #expect(url.queryValue(for: "q") == nil)
    }

    @Test
    func returnsFirstValueForRepeatedName() throws {
        let url = try #require(URL(string: "https://example.com/?tag=a&tag=b"))
        #expect(url.queryValue(for: "tag") == "a")
    }

    @Test
    func decodesPercentEncodedValues() throws {
        let url = try #require(URL(string: "https://example.com/?q=Swifter%20Swift&emoji=%F0%9F%9A%80"))
        #expect(url.queryValue(for: "q") == "Swifter Swift")
        #expect(url.queryValue(for: "emoji") == "🚀")
    }

    @Test
    func keepsPlusSigns() throws {
        let url = try #require(URL(string: "https://example.com/?q=a+b"))
        #expect(url.queryValue(for: "q") == "a+b")
    }

    @Test
    func distinguishesEmptyValueFromMissingValue() throws {
        let url = try #require(URL(string: "https://example.com/?empty=&flag"))
        #expect(url.queryValue(for: "empty") == "")
        #expect(url.queryValue(for: "flag") == nil)
    }

    @Test
    func matchesNamesCaseSensitively() throws {
        let url = try #require(URL(string: "https://example.com/?Q=1"))
        #expect(url.queryValue(for: "q") == nil)
        #expect(url.queryValue(for: "Q") == "1")
    }

    @Test
    func readsQueryOfRelativeURL() throws {
        let base = try #require(URL(string: "https://example.com/api/"))
        let url = try #require(URL(string: "search?q=swift", relativeTo: base))
        #expect(url.queryValue(for: "q") == "swift")
    }
}
#endif
