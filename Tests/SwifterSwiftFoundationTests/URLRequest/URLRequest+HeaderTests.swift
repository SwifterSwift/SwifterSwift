// URLRequest+HeaderTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation) && !os(WASI)
import Foundation
import SwifterSwiftFoundation
import Testing
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct URLRequestHeaderTests {
    @Test
    func setsTheHeader() throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        let request = URLRequest(url: url)
            .header(name: "Content-Type", value: "application/json")
            .header(name: "X-Count", value: "10")
        #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
        #expect(request.value(forHTTPHeaderField: "X-Count") == "10")
        #expect(request.url == url)
    }

    @Test
    func replacesAnExistingValueMatchingTheNameCaseInsensitively() throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        let request = URLRequest(url: url)
            .header(name: "Accept", value: "text/html")
            .header(name: "accept", value: "application/json")
        #expect(request.value(forHTTPHeaderField: "ACCEPT") == "application/json")
        #expect(request.allHTTPHeaderFields?.count == 1)
    }

    @Test
    func leavesTheOriginalRequestUnchanged() throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        let original = URLRequest(url: url)
        _ = original.header(name: "Authorization", value: "Bearer token")
        #expect(original.value(forHTTPHeaderField: "Authorization") == nil)
    }

    @Test
    func keepsTheRestOfTheRequest() throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        var original = URLRequest(url: url)
        original.httpMethod = "POST"
        original.httpBody = Data("{}".utf8)

        let request = original.header(name: "Accept", value: "*/*")
        #expect(request.httpMethod == "POST")
        #expect(request.httpBody == Data("{}".utf8))
    }

    @Test
    func keepsUnicodeValues() throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        let request = URLRequest(url: url).header(name: "X-Greeting", value: "Grüße 👋")
        #expect(request.value(forHTTPHeaderField: "X-Greeting") == "Grüße 👋")
    }
}
#endif
