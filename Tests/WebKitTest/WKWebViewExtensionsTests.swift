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
    }

    func testLoadURL() {
        let url = URL(string: "https://www.w3schools.com/")!
        webView.loadURL(url)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            guard self.webView.url != nil else {
                XCTFail("No URL in webView")
                return
            }
            self.successExpectation.fulfill()
        }
        wait(for: [successExpectation], timeout: 2.5)

    }

    func testLoadURLString() {
        let urlString = "https://www.w3schools.com/"
        webView.loadURLString(urlString)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            guard self.webView.url?.absoluteString != nil else {
                XCTFail("No URL in webView")
                return
            }
            self.successExpectation.fulfill()
        }
        wait(for: [successExpectation], timeout: 2.5)
    }

    func testLoadInvalidURLString() {
        let invalidURLString = "invalid url"
        webView.loadURLString(invalidURLString)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.webView.url?.absoluteString != nil {
                XCTFail("Request was made by an invalid URL :(")
                return
            }
            self.successExpectation.fulfill()
        }
        wait(for: [successExpectation], timeout: 2.5)

    }
}
#endif
