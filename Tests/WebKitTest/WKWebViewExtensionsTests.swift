//
//  WKWebViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Tigran Hambardzumyan on 5/23/20.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(WebKit)
import WebKit

final class WKWebViewExtensionsTests: XCTestCase {

    var webView: WKWebView!
    let successExpectation = XCTestExpectation(description: "Correct URL")

    override func setUp() {
        webView = WKWebView()
        webView.navigationDelegate = self
    }

    func testLoadURL() {
        let url = URL(string: "https://www.w3schools.com/")!
        let navigation = webView.loadURL(url)

        XCTAssertNotNil(navigation)

        wait(for: [successExpectation], timeout: 2.5)
    }

    func testLoadURLString() {
        let urlString = "https://www.w3schools.com/"
        let navigation = webView.loadURLString(urlString)

        XCTAssertNotNil(navigation)

        wait(for: [successExpectation], timeout: 2.5)
    }

    func testLoadInvalidURLString() {
        let invalidURLString = "invalid url"
        let navigation = webView.loadURLString(invalidURLString)

        XCTAssertNil(navigation)
    }

}

extension WKWebViewExtensionsTests: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        XCTAssertNotNil(self.webView.url)
        self.successExpectation.fulfill()
    }

}

#endif
