// URLRequestExtensionsTests.swift - Copyright 2026 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class URLRequestExtensionsTests: XCTestCase {
    func testInitFromURLString() throws {
        let urlString = "https://www.w3schools.com/"
        let request1 = try URLRequest(url: XCTUnwrap(URL(string: urlString)))
        let request2 = URLRequest(urlString: urlString)
        XCTAssertNotNil(request2)
        XCTAssertEqual(request1.url, request2?.url)

        if #unavailable(iOS 17.0) {
            let invalidURLString = "invalid url"
            XCTAssertNil(URLRequest(urlString: invalidURLString))
        }
    }

    func testCUrlString() throws {
        let insightNASAcURL =
            "curl https://api.nasa.gov/insight_weather/?api_key=mxbd8VDIy5CheCbrYgknXVH6X9ElpQaHMhne2YXP&feedtype=json&ver=1.0"
        let planetaryNASAcURL =
            "curl https://api.nasa.gov/planetary/apod?api_key=mxbd8VDIy5CheCbrYgknXVH6X9ElpQaHMhne2YXP&date=2020-01-09&hd=true"
        var components = URLComponents(string: "https://api.nasa.gov")
        let apiKey = "mxbd8VDIy5CheCbrYgknXVH6X9ElpQaHMhne2YXP"

        // #1 scenario
        components?.path = "/insight_weather/"

        let feedType = "json"
        let version = "1.0"

        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "feedtype", value: feedType),
            URLQueryItem(name: "ver", value: version)
        ]

        XCTAssertNotNil(components?.url)
        let insightRequest = try URLRequest(url: XCTUnwrap(components?.url))
        XCTAssertEqual(insightRequest.curlString, insightNASAcURL)

        // #2 scenario
        components?.path = "/planetary/apod"

        let date = "2020-01-09"
        let isHD = "true"

        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "date", value: date),
            URLQueryItem(name: "hd", value: isHD)
        ]

        XCTAssertNotNil(components?.url)
        let planetaryRequest = try URLRequest(url: XCTUnwrap(components?.url))
        XCTAssertEqual(planetaryRequest.curlString, planetaryNASAcURL)
    }

    // MARK: - Methods

    func testMethod() throws {
        let url = try XCTUnwrap(URL(string: "https://api.server.com/"))
        let request = URLRequest(url: url)
            .method("post")
        XCTAssertEqual(request.url, url)
        XCTAssertEqual(request.httpMethod, "POST")
    }

    func testHeader() throws {
        let url = try XCTUnwrap(URL(string: "https://api.server.com/"))
        let request = URLRequest(url: url)
            .header(name: "Content-Type", value: "application/json")
            .header(name: "Number", value: "10")
        XCTAssertNotNil(request.allHTTPHeaderFields)
        XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(try Int(XCTUnwrap(request.allHTTPHeaderFields?["Number"])), 10)
    }
}

#endif
