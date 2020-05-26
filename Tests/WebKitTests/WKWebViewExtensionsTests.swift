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
        let url = URL(string: "https://example.com/")!
        let navigation = webView.loadURL(url)

        XCTAssertNotNil(navigation)

        wait(for: [successExpectation], timeout: 3)
    }

    func testLoadURLString() {
        let urlString = "https://example.com/"
        let navigation = webView.loadURLString(urlString)

        XCTAssertNotNil(navigation)

        wait(for: [successExpectation], timeout: 3)
    }

    func testLoadInvalidURLString() {
        let invalidURLString = "invalid url"
        let navigation = webView.loadURLString(invalidURLString)

        XCTAssertNil(navigation)
    }

}

extension WKWebViewExtensionsTests: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        XCTAssertNotNil(self.webView.url)
        self.successExpectation.fulfill()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        XCTFail(error.localizedDescription)
        self.successExpectation.fulfill()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        XCTFail(error.localizedDescription)
        self.successExpectation.fulfill()
    }

}

#endif
