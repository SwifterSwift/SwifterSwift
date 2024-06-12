// URLSessionExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class URLSessionExtensionsTests: XCTestCase {
    func testDataSync() {
        let gemfileContent = "source 'https://rubygems.org'\n\n" +
            "gem 'xcpretty'\n" +
            "gem 'danger'\n" +
            "gem 'danger-swiftlint'\n" +
            "gem 'danger-xcode_summary'\n" +
            "gem 'xcpretty-json-formatter'\n\n" +
            "gem 'fastlane'\n" +
            "gem 'cocoapods'"
        let url = URL(string: "https://raw.githubusercontent.com/SwifterSwift/SwifterSwift/6.0.0/Gemfile")!
        var data: Data?
        var response: URLResponse?
        XCTAssertNoThrow((data, response) = try URLSession.shared.dataSync(with: URLRequest(url: url)))
        XCTAssertNotNil(data)
        XCTAssertNotNil(response)
        let httpResponse = response as? HTTPURLResponse
        let content = String(decoding: data!, as: UTF8.self)
        XCTAssertEqual(content, gemfileContent)
        XCTAssertNotNil(httpResponse)
        XCTAssertEqual(httpResponse!.statusCode, 200)
        XCTAssertEqual(httpResponse!.url, url)
    }

    func testDataSyncError() {
        let url = URL(string: "http://something.notexistingcountry/something")!
        XCTAssertThrowsError(_ = try URLSession.shared.dataSync(with: URLRequest(url: url)))
    }
}

#endif
