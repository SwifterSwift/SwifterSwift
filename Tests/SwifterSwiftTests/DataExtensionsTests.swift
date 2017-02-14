//
//  DataExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 09/02/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class DataExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testAttributedString() {
		let attrString = "Hello".colored(with: .orange)
		XCTAssertNotEqual(Data().attributedString, attrString)
	}
	
	func testString() {
		let dataFromString = "hello".data(using: .utf8)
		XCTAssertNotNil(dataFromString)
		XCTAssertNotNil(dataFromString!.string(encoding: .utf8))
		XCTAssertEqual(dataFromString!.string(encoding: .utf8)!, "hello")
	}
	
}
