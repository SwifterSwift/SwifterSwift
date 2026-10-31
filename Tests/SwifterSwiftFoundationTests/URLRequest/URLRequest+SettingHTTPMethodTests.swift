// URLRequest+SettingHTTPMethodTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation) && !os(WASI)
import Foundation
import SwifterSwiftFoundation
import Testing
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct URLRequestSettingHTTPMethodTests {
    @Test(arguments: ["GET", "POST", "PUT", "PATCH", "DELETE", "HEAD", "OPTIONS"])
    func setsTheMethod(method: String) throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        let request = URLRequest(url: url).settingHTTPMethod(method)
        #expect(request.httpMethod == method)
        #expect(request.url == url)
    }

    @Test(arguments: ["PROPFIND", "patch", "Custom", "post"])
    func passesTheMethodToURLRequestWithoutChangingItsCase(method: String) throws {
        // HTTP methods are case-sensitive, so the extension doesn't uppercase them. (On Apple platforms URLRequest
        // itself uppercases a few standard methods, such as "post".)
        let url = try #require(URL(string: "https://api.example.com/items"))
        var expected = URLRequest(url: url)
        expected.httpMethod = method
        #expect(URLRequest(url: url).settingHTTPMethod(method).httpMethod == expected.httpMethod)
    }

    @Test
    func doesNotUppercaseTheMethod() throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        #expect(URLRequest(url: url).settingHTTPMethod("patch").httpMethod == "patch")
        #expect(URLRequest(url: url).settingHTTPMethod("Custom").httpMethod == "Custom")
    }

    @Test
    func leavesTheOriginalRequestUnchanged() throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        let original = URLRequest(url: url)
        _ = original.settingHTTPMethod("DELETE")
        #expect(original.httpMethod == "GET")
    }

    @Test
    func keepsTheRestOfTheRequest() throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        var original = URLRequest(url: url, timeoutInterval: 12)
        original.setValue("application/json", forHTTPHeaderField: "Accept")
        original.httpBody = Data("{}".utf8)

        let request = original.settingHTTPMethod("POST")
        #expect(request.value(forHTTPHeaderField: "Accept") == "application/json")
        #expect(request.httpBody == Data("{}".utf8))
        #expect(request.timeoutInterval == 12)
    }

    @Test
    func chains() throws {
        let url = try #require(URL(string: "https://api.example.com/items"))
        let request = URLRequest(url: url).settingHTTPMethod("POST").settingHTTPMethod("PUT")
        #expect(request.httpMethod == "PUT")
    }
}
#endif
