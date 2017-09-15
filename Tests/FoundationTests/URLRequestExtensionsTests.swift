//
//  URLRequestExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/6/17.
//
//
import XCTest
@testable import SwifterSwift

class URLRequestExtensionsTests: XCTestCase {
	
	func testInitFromURLString() {
		let urlString = "https://www.w3schools.com/"
		let request1 = URLRequest(url: URL(string: urlString)!)
		let request2 = URLRequest(urlString: urlString)
		XCTAssertNotNil(request2)
		XCTAssertEqual(request1.url, request2!.url)
		
		let invalidURLString = "invalid url"
		XCTAssertNil(URLRequest(urlString: invalidURLString))
	}
	
}
