// URLSessionExtensionsTests.swift - Copyright 2023 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

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
        let url = URL(string: "https://raw.githubusercontent.com/SwifterSwift/SwifterSwift/5.3.0/Gemfile")!
        var data: Data!
        var response: URLResponse!
        XCTAssertNoThrow((data, response) = try URLSession.shared.dataSync(with: URLRequest(url: url)))
        XCTAssertNotNil(data)
        let httpResponse = response as? HTTPURLResponse
        let content = String(data: data!, encoding: .utf8)
        XCTAssertEqual(content, gemfileContent)
        XCTAssertNotNil(httpResponse)
        XCTAssertEqual(httpResponse!.statusCode, 200)
        XCTAssertEqual(httpResponse!.url, url)
    }
    
    func testDataSyncError() {
        let url = URL(string: "https://something.cm/something")!
        XCTAssertThrowsError(_ = try URLSession.shared.dataSync(with: URLRequest(url: url)))
    }
}

#endif