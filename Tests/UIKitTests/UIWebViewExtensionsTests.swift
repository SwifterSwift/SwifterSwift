//
//  UIWebViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/6/17.
//
//

import XCTest
@testable import SwifterSwift

#if os(iOS)
class UIWebViewExtensionsTests: XCTestCase {
	
	var webView = UIWebView()
	let successExpectation = XCTestExpectation(description: "Correct URL")
	
	override func setUp() {
		webView = UIWebView()
	}
	
	func testLoadURL() {
		let url = URL(string: "https://www.w3schools.com/")!
		webView.loadURL(url)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			guard let webViewURL = self.webView.request?.url else {
				XCTFail("No URL in webView")
				return
			}
			
			guard webViewURL == url else {
				XCTFail("Wrong URL in webView")
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
			guard let webViewURLString = self.webView.request?.url?.absoluteString else {
				XCTFail("No URL in webView")
				return
			}
			
			guard webViewURLString == urlString else {
				XCTFail("Wrong URL in webView")
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
			if let _ = self.webView.request?.url?.absoluteString {
				XCTFail("Request was made by an invalid URL :(")
				return
			}
			self.successExpectation.fulfill()
		}
		wait(for: [successExpectation], timeout: 2.5)
		
	}
	
	
}
	
#endif
