//
//  URLExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class URLExtensionsTests: XCTestCase {
	
	var url = URL(string: "https://www.google.com")!
	let params = ["q": "swifter swift"]
	let queryUrl = URL(string: "https://www.google.com?q=swifter%20swift")!
	
	func testAppendingQueryParameters() {
		XCTAssertEqual(url.appendingQueryParameters(params), queryUrl)
	}
	
	func testAppendQueryParameters() {
		url.appendQueryParameters(params)
		XCTAssertEqual(url, queryUrl)
	}
    
    func testQueryParameters() {
        let url = URL(string: "https://www.google.com?q=swifter%20swift&steve=jobs&empty")!
        guard let parameters = url.queryParameters else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(parameters.count, 2)
        XCTAssertEqual(parameters["q"], "swifter swift")
        XCTAssertEqual(parameters["steve"], "jobs")
        XCTAssertEqual(parameters["empty"], nil)
    }
	
}
