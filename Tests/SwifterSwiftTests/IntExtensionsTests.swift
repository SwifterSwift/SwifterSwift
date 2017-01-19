//
//  IntExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class IntExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testAbs() {
		XCTAssertEqual((-9).abs, 9)
	}
	
	func testDegreesToRadians() {
		XCTAssertEqual(180.degreesToRadians, M_PI)
	}
	
	func testDigits() {
		XCTAssertEqual(180.digits, [1, 8, 0])
	}
	
	func testDigitsCount() {
		XCTAssertEqual(180.digitsCount, 3)
	}
	
	func testGcd() {
		XCTAssertEqual(8.gcd(of: 20), 4)
	}
	
	func testIsEven() {
		XCTAssertTrue(2.isEven)
		XCTAssertFalse(3.isEven)
	}
	
	func testIsOdd() {
		XCTAssertTrue(3.isOdd)
		XCTAssertFalse(2.isOdd)
	}
	
	func testLcm() {
		XCTAssertEqual(4.lcm(of: 3), 12)
	}
	
	func testRadiansToDegrees() {
		XCTAssertEqual(Int(3.radiansToDegrees), 171)
	}
	
	func testRandomBetween() {
		XCTAssertGreaterThan(Int.randomBetween(min: 1, max: 5), 0)
		XCTAssertLessThan(Int.randomBetween(min: 1, max: 5), 5)
	}
	
	func testRomanNumeral() {
		XCTAssertEqual(10.romanNumeral, "X")
		XCTAssertNil((-1).romanNumeral)
	}
	
	func testTimeString() {
		XCTAssertEqual(120.timeString, "2 min")
	}
	
	func testOperators() {
		XCTAssertEqual(5 ** 2, 25)
		XCTAssert((5 ± 2) == (3, 7) || (5 ± 2) == (7, 3))
		XCTAssert((±2) == (2, -2) || (±2) == (-2, 2))
		XCTAssertEqual(√25, 5.0)
	}
}
