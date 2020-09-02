// WKWebViewExtensionsTests.swift - Copyright 2020 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(WebKit)
import WebKit

final class WKWebViewExtensionsTests: XCTestCase {
    private let timeout = TimeInterval(10)

    var webView: WKWebView!

    override func setUp() {
        webView = WKWebView()
    }

    func testLoadURL() {
        let successExpectation = WebViewSuccessExpectation(description: "Correct URL", webView: webView)

        let url = URL(string: "https://example.com/")!
        let navigation = webView.loadURL(url)

        XCTAssertNotNil(navigation)

        wait(for: [successExpectation], timeout: timeout)
    }

    func testLoadURLString() {
        let successExpectation = WebViewSuccessExpectation(description: "Correct URL string", webView: webView)

        let urlString = "https://example.com/"
        let navigation = webView.loadURLString(urlString)

        XCTAssertNotNil(navigation)

        wait(for: [successExpectation], timeout: timeout)
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

        wait(for: [failureExpectation], timeout: timeout)
    }
}

class WebViewSuccessExpectation: XCTestExpectation, WKNavigationDelegate {
    init(description: String, webView: WKWebView) {
        super.init(description: description)
        webView.navigationDelegate = self
    }

    func webView(_: WKWebView, didCommit _: WKNavigation!) {
        fulfill()
    }
}

class WebViewFailureExpectation: XCTestExpectation, WKNavigationDelegate {
    init(description: String, webView: WKWebView) {
        super.init(description: description)
        webView.navigationDelegate = self
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {
        fulfill()
    }

    func webView(_: WKWebView, didFailProvisionalNavigation _: WKNavigation!, withError _: Error) {
        fulfill()
    }
}

#endif
