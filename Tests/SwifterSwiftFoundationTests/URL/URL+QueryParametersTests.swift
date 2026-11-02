// URL+QueryParametersTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct URLQueryParametersTests {
    @Test
    func returnsItemsWithValues() throws {
        let url = try #require(URL(string: "https://www.example.com?q=swifter%20swift&steve=jobs&empty"))
        #expect(url.queryParameters == ["q": "swifter swift", "steve": "jobs"])
    }

    @Test
    func keepsTheFirstValueOfRepeatedNames() throws {
        let url = try #require(URL(string: "https://example.com/?page=2&page=3&tag=a"))
        #expect(url.queryParameters == ["page": "2", "tag": "a"])
    }

    @Test
    func skipsValuelessItemsBeforeTheFirstValue() throws {
        let url = try #require(URL(string: "https://example.com/?flag&flag=on"))
        #expect(url.queryParameters == ["flag": "on"])
    }

    @Test
    func keepsEmptyValues() throws {
        let url = try #require(URL(string: "https://example.com/?empty=&flag"))
        #expect(url.queryParameters == ["empty": ""])
    }

    @Test
    func returnsNilWithoutAQuery() throws {
        let url = try #require(URL(string: "https://example.com/search"))
        #expect(url.queryParameters == nil)
    }

    @Test
    func returnsAnEmptyDictionaryWhenNoItemHasAValue() throws {
        let url = try #require(URL(string: "https://example.com/?a&b"))
        #expect(url.queryParameters == [:])
    }

    @Test
    func decodesPercentEncodingButKeepsPlusSigns() throws {
        let url = try #require(URL(string: "https://example.com/?emoji=%F0%9F%9A%80&name=Zo%C3%AB&sum=1+2"))
        #expect(url.queryParameters == ["emoji": "🚀", "name": "Zoë", "sum": "1+2"])
    }

    @Test
    func matchesNamesCaseSensitively() throws {
        let url = try #require(URL(string: "https://example.com/?Q=1&q=2"))
        #expect(url.queryParameters == ["Q": "1", "q": "2"])
    }

    @Test
    func readsTheQueryOfARelativeURL() throws {
        let base = try #require(URL(string: "https://example.com/api/"))
        let url = try #require(URL(string: "search?q=swift", relativeTo: base))
        #expect(url.queryParameters == ["q": "swift"])
    }
}
#endif
