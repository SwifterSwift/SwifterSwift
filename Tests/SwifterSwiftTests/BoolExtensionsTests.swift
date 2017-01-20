//
//  BoolExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 20/01/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class BoolExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testInt() {
		XCTAssertEqual(true.int, 1)
		XCTAssertEqual(false.int, 0)
	}
	
	func testString() {
		XCTAssertEqual(true.string, "true")
		XCTAssertEqual(false.string, "false")
	}
	
	func testToggled() {
		XCTAssertFalse(true.toggled)
		XCTAssert(false.toggled)
	}
	
	func testToggle() {
		var t = true
		t.toggle()
		XCTAssertFalse(t)
		t.toggle()
		XCTAssert(t)
	}
	
}
