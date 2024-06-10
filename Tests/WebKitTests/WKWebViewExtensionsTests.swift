// WKWebViewExtensionsTests.swift - Copyright 2024 SwifterSwift

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

        let url = URL(string: "https://www.apple.com/")!
        let navigation = webView.loadURL(url)

        XCTAssertNotNil(navigation)

        wait(for: [successExpectation], timeout: timeout)
    }

    func testLoadURLString() {
        let successExpectation = WebViewSuccessExpectation(description: "Correct URL string", webView: webView)

        let urlString = "https://www.apple.com/"
        let navigation = webView.loadURLString(urlString)

        XCTAssertNotNil(navigation)

        wait(for: [successExpectation], timeout: timeout)
    }

    func testLoadInvalidURLString() {
        if #unavailable(iOS 17.0) {
            let invalidURLString = "invalid url"
            let navigation = webView.loadURLString(invalidURLString)

            XCTAssertNil(navigation)
        }
    }

    func testLoadDeadURLString() {
        let failureExpectation = WebViewFailureExpectation(description: "Dead URL string", webView: webView)

        let deadURLString = "https://dead-url-573489574389.com"
        let navigation = webView.loadURLString(deadURLString, timeout: 5.0)

        XCTAssertNotNil(navigation)

        wait(for: [failureExpectation], timeout: timeout)
    }
}

class WebViewSuccessExpectation: XCTestExpectation, WKNavigationDelegate, @unchecked Sendable {
    init(description: String, webView: WKWebView) {
        super.init(description: description)
        webView.navigationDelegate = self
    }

    func webView(_: WKWebView, didCommit _: WKNavigation!) {
        fulfill()
    }
}

class WebViewFailureExpectation: XCTestExpectation, WKNavigationDelegate, @unchecked Sendable {
    init(description: String, webView: WKWebView) {
        super.init(description: description)
        webView.navigationDelegate = self
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError _: any Error) {
        fulfill()
    }

    func webView(_: WKWebView, didFailProvisionalNavigation _: WKNavigation!, withError _: any Error) {
        fulfill()
    }
}

#endif
