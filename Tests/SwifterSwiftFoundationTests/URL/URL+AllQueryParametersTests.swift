// URL+AllQueryParametersTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct URLAllQueryParametersTests {
    @Test
    func returnsEveryItemInOrder() throws {
        let url = try #require(URL(string: "https://www.example.com?q=swifter%20swift&steve=jobs&empty"))
        #expect(
            url.allQueryParameters == [
                URLQueryItem(name: "q", value: "swifter swift"),
                URLQueryItem(name: "steve", value: "jobs"),
                URLQueryItem(name: "empty", value: nil)
            ]
        )
    }

    @Test
    func keepsRepeatedNames() throws {
        let url = try #require(URL(string: "https://example.com/?tag=a&tag=b&tag="))
        #expect(
            url.allQueryParameters == [
                URLQueryItem(name: "tag", value: "a"),
                URLQueryItem(name: "tag", value: "b"),
                URLQueryItem(name: "tag", value: "")
            ]
        )
    }

    @Test
    func returnsNilWithoutAQuery() throws {
        let url = try #require(URL(string: "https://example.com/search"))
        #expect(url.allQueryParameters == nil)
    }

    @Test
    func decodesPercentEncodingButKeepsPlusSigns() throws {
        let url = try #require(URL(string: "https://example.com/?emoji=%F0%9F%9A%80&sum=1+2&na%20me=x"))
        #expect(
            url.allQueryParameters == [
                URLQueryItem(name: "emoji", value: "🚀"),
                URLQueryItem(name: "sum", value: "1+2"),
                URLQueryItem(name: "na me", value: "x")
            ]
        )
    }

    @Test
    func ignoresTheFragment() throws {
        let url = try #require(URL(string: "https://example.com/?a=1#b=2"))
        #expect(url.allQueryParameters == [URLQueryItem(name: "a", value: "1")])
    }

    @Test
    func readsTheQueryOfARelativeURL() throws {
        let base = try #require(URL(string: "https://example.com/api/"))
        let url = try #require(URL(string: "search?q=swift", relativeTo: base))
        #expect(url.allQueryParameters == [URLQueryItem(name: "q", value: "swift")])
    }
}
#endif
