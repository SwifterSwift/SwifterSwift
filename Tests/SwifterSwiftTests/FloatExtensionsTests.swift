//
//  FloatExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class FloatExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testAbs() {
		XCTAssertEqual(Float(-9.3).abs, Float(9.3))
	}
	
	func testCeil() {
		XCTAssertEqual(Float(9.3).ceil, Float(10.0))
	}
	
	func testDegreesToRadians() {
		XCTAssertEqual(Float(180).degreesToRadians, Float.pi)
	}
	
	func testRandomBetween() {
		XCTAssertGreaterThan(Float.random(between: 1, and: 5), 0)
		XCTAssertLessThan(Float.random(between: 1, and: 5), 6)
		
		XCTAssertGreaterThan(Float(randomBetween: 1, and: 5), 0)
		XCTAssertLessThan(Float(randomBetween: 1, and: 5), 6)
		
		XCTAssertGreaterThan(Float.random(inRange: 1...5), 0)
		XCTAssertLessThan(Float.random(inRange: 1...5), 6)
		
		XCTAssertGreaterThan(Float(randomInRange: 1...5), 0)
		XCTAssertLessThan(Float(randomInRange: 1...5), 6)
	}
	
	func testFloor() {
		XCTAssertEqual(Float(9.3).floor, Float(9.0))
	}
	
	func testIsPositive() {
		XCTAssert(Float(1).isPositive)
		XCTAssertFalse(Float(0).isPositive)
		XCTAssertFalse(Float(-1).isPositive)
	}
	
	func testIsNegative() {
		XCTAssert(Float(-1).isNegative)
		XCTAssertFalse(Float(0).isNegative)
		XCTAssertFalse(Float(1).isNegative)
	}
	
	func testInt() {
		XCTAssertEqual(Float(-1).int, -1)
		XCTAssertEqual(Float(2).int, 2)
		XCTAssertEqual(Float(4.3).int, 4)
	}
	
	func testDouble() {
		XCTAssertEqual(Float(-1).double, Double(-1))
		XCTAssertEqual(Float(2).double, Double(2))
		XCTAssertEqualWithAccuracy(Float(4.3).double, Double(4.3), accuracy: 0.00001)
	}
	
	func testCGFloat() {
		XCTAssertEqualWithAccuracy(Float(4.3).cgFloat, CGFloat(4.3), accuracy: 0.00001)
	}
	
	func testString() {
		XCTAssertEqual(Float(2.3).string, "2.3")
	}
	
	func testRadiansToDegrees() {
		XCTAssertEqual(Float.pi.radiansToDegrees, Float(180))
	}
	
	func testOperators() {
		XCTAssertEqual((Float(5.0) ** Float(2.0)), Float(25.0))
		XCTAssert((Float(5.0) ± Float(2.0)) == (Float(3.0), Float(7.0)) || (Float(5.0) ± Float(2.0)) == (Float(7.0), Float(3.0)))
		XCTAssert((±Float(2.0)) == (Float(2.0), Float(-2.0)) || (±Float(2.0)) == (Float(-2.0), Float(2.0)))
		XCTAssertEqual((√Float(25.0)), Float(5.0))
	}
	
	func testAsLocaleCurrency() {
		let num = Float(10.23)
		if let symbol = Locale.current.currencySymbol {
			XCTAssert(num.asLocaleCurrency.contains(symbol))
		}
		XCTAssert(num.asLocaleCurrency.contains("\(num)"))
	}
}
