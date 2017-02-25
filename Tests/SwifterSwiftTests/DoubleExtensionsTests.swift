//
//  DoubleExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class DoubleExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testAbs() {
		XCTAssertEqual(Double(-9.3).abs, Double(9.3))
	}
	
	func testCeil() {
		XCTAssertEqual(Double(9.3).ceil, Double(10.0))
	}
	
	func testDegreesToRadians() {
		XCTAssertEqual(Double(180).degreesToRadians, Double.pi)
	}
	
	func testRandomBetween() {
		XCTAssertGreaterThan(Double.random(between: 1, and: 5), 0)
		XCTAssertLessThan(Double.random(between: 1, and: 5), 6)
		
		XCTAssertGreaterThan(Double(randomBetween: 1, and: 5), 0)
		XCTAssertLessThan(Double(randomBetween: 1, and: 5), 6)
		
		XCTAssertGreaterThan(Double.random(inRange: 1...5), 0)
		XCTAssertLessThan(Double.random(inRange: 1...5), 6)
		
		XCTAssertGreaterThan(Double(randomInRange: 1...5), 0)
		XCTAssertLessThan(Double(randomInRange: 1...5), 6)
	}
	
	func testFloor() {
		XCTAssertEqual(Double(9.3).floor, Double(9.0))
	}
	
	func testIsPositive() {
		XCTAssert(Double(1).isPositive)
		XCTAssertFalse(Double(0).isPositive)
		XCTAssertFalse(Double(-1).isPositive)
	}
	
	func testIsNegative() {
		XCTAssert(Double(-1).isNegative)
		XCTAssertFalse(Double(0).isNegative)
		XCTAssertFalse(Double(1).isNegative)
	}
	
	func testInt() {
		XCTAssertEqual(Double(-1).int, -1)
		XCTAssertEqual(Double(2).int, 2)
		XCTAssertEqual(Double(4.3).int, 4)
	}
	
	func testFloat() {
		XCTAssertEqual(Double(-1).float, Float(-1))
		XCTAssertEqual(Double(2).float, Float(2))
		XCTAssertEqual(Double(4.3).float, Float(4.3))
	}
	
	func testCGFloat() {
		XCTAssertEqual(Double(4.3).cgFloat, CGFloat(4.3))
	}
	
	func testString() {
		XCTAssertEqual(Double(2.3).string, "2.3")
	}
	
	func testRadiansToDegrees() {
		XCTAssertEqual(Double.pi.radiansToDegrees, Double(180))
	}
	
	func testOperators() {
		XCTAssertEqual((Double(5.0) ** Double(2.0)), Double(25.0))
		XCTAssert((Double(5.0) ± Double(2.0)) == (Double(3.0), Double(7.0)) || (Double(5.0) ± Double(2.0)) == (Double(7.0), Double(3.0)))
		XCTAssert((±Double(2.0)) == (Double(2.0), Double(-2.0)) || (±Double(2.0)) == (Double(-2.0), Double(2.0)))
		XCTAssertEqual((√Double(25.0)), Double(5.0))
	}
	
	func testAsLocaleCurrency() {
		let num = Double(10.23)
		if let symbol = Locale.current.currencySymbol {
			XCTAssert(num.asLocaleCurrency.contains(symbol))
		}
		XCTAssert(num.asLocaleCurrency.contains("\(num)"))
	}
	
}
