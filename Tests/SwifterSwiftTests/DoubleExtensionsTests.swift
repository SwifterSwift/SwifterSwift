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
		XCTAssertEqual(Double(180).degreesToRadians, M_PI)
	}
	
	func testRandomBetween() {
		XCTAssertGreaterThan(Double.randomBetween(min: 1, max: 5), 0)
		XCTAssertLessThan(Double.randomBetween(min: 1, max: 5), 5)
	}
	
	func testFloor() {
		XCTAssertEqual(Double(9.3).floor, Double(9.0))
	}
	
	func testRadiansToDegrees() {
		XCTAssertEqual(Double(M_PI).radiansToDegrees, Double(180))
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
