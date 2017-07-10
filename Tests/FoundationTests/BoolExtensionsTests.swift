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
