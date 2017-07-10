//
//  URLExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class URLExtensionsTests: XCTestCase {
	
	var url = URL(string: "https://www.google.com")!
	let params = ["q": "swifter swift"]
	let queryUrl = URL(string: "https://www.google.com?q=swifter%20swift")!

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testAppendingQueryParameters() {
		XCTAssertEqual(url.appendingQueryParameters(params), queryUrl)
	}
	
	func testAppendQueryParameters() {
		url.appendQueryParameters(params)
		XCTAssertEqual(url, queryUrl)
	}
	
}
