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
		XCTAssertEqual(Float(180).degreesToRadians, Float(M_PI))
	}
	
	func testRandomBetween() {
		XCTAssertGreaterThan(Float.randomBetween(min: 1, max: 5), 0)
		XCTAssertLessThan(Float.randomBetween(min: 1, max: 5), 5)
	}
	
	func testFloor() {
		XCTAssertEqual(Float(9.3).floor, Float(9.0))
	}
	
	func testRadiansToDegrees() {
		XCTAssertEqual(Float(M_PI).radiansToDegrees, Float(180))
	}
	
	func testOperators() {
		XCTAssertEqual((Float(5.0) ** Float(2.0)), Float(25.0))
		XCTAssert((Float(5.0) ± Float(2.0)) == (Float(3.0), Float(7.0)) || (Float(5.0) ± Float(2.0)) == (Float(7.0), Float(3.0)))
		XCTAssert((±Float(2.0)) == (Float(2.0), Float(-2.0)) || (±Float(2.0)) == (Float(-2.0), Float(2.0)))
		XCTAssertEqual((√Float(25.0)), Float(5.0))
	}
	
	func testAsLocaleCurrency() {
		let num = Float(10.23)
		let asLocaleCurrency = "\(Locale.current.currencySymbol ?? "")\(num)"
		if let symbol = Locale.current.currencySymbol {
			XCTAssert(num.asLocaleCurrency.contains(symbol))
		}
		XCTAssert(num.asLocaleCurrency.contains("\(num)"))
	}
}
