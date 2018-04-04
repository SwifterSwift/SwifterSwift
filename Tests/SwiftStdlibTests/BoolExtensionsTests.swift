//
//  BoolExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 20/01/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class BoolExtensionsTests: XCTestCase {

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

	func testRandom() {
		var trueCount = 0, falseCount = 0
		for _ in 1...10000 {
			if Bool.random {
				trueCount += 1
			} else {
				falseCount += 1
			}
		}
		XCTAssert(trueCount >= 10 && falseCount >= 10)
	}

	func testToggle() {
		var boolean = true
		boolean.toggle()
		XCTAssertFalse(boolean)
		boolean.toggle()
		XCTAssert(boolean)
	}

}
