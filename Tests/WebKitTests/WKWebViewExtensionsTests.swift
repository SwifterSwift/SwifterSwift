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

    override func setUp() {
        webView = WKWebView()
    }

    func testLoadURL() {
        let successExpectation = WebViewSuccessExpectation(description: "Correct URL", webView: webView)

        let url = URL(string: "https://example.com/")!
        let navigation = webView.loadURL(url)

        XCTAssertNotNil(navigation)

        wait(for: [successExpectation], timeout: 3)
    }

    func testLoadURLString() {
        let successExpectation = WebViewSuccessExpectation(description: "Correct URL string", webView: webView)

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

    func testLoadDeadURLString() {
        let failureExpectation = WebViewFailureExpectation(description: "Dead URL string", webView: webView)

        let deadURLString = "https://deadurl.com"
        let navigation = webView.loadURLString(deadURLString)

        XCTAssertNotNil(navigation)

        wait(for: [failureExpectation], timeout: 3)
    }

}

class WebViewSuccessExpectation: XCTestExpectation, WKNavigationDelegate {
    init(description: String, webView: WKWebView) {
        super.init(description: description)
        webView.navigationDelegate = self
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        fulfill()
    }
}

class WebViewFailureExpectation: XCTestExpectation, WKNavigationDelegate {
    init(description: String, webView: WKWebView) {
        super.init(description: description)
        webView.navigationDelegate = self
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        fulfill()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        fulfill()
    }
}

#endif
