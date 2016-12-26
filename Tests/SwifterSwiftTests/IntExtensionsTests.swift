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
		XCTAssert((-9).abs == 9, "Couldn't get correct value for \(#function)")
	}
	
	func testDegreesToRadians() {
		XCTAssert(180.degreesToRadians == M_PI, "Couldn't get correct value for \(#function)")
	}
	
	func testDigits() {
		XCTAssert(180.digits == [1, 8, 0], "Couldn't get correct value for \(#function)")
	}
	
	func testDigitsCount() {
		XCTAssert(180.digitsCount == 3, "Couldn't get correct value for \(#function)")
	}
	
	func testGcd() {
		XCTAssert(8.gcd(of: 20) == 4, "Couldn't get correct value for \(#function)")
	}
	
	func testIsEven() {
		XCTAssert(2.isEven == true && 3.isEven == false, "Couldn't get correct value for \(#function)")
	}
	
	func testIsOdd() {
		XCTAssert(3.isOdd == true && 2.isOdd == false, "Couldn't get correct value for \(#function)")
	}
	
	func testLcm() {
		XCTAssert(4.lcm(of: 3) == 12, "Couldn't get correct value for \(#function)")
	}
	
	func testRadiansToDegrees() {
		XCTAssert(Int(3.radiansToDegrees) == 171, "Couldn't get correct value for \(#function)")
	}
	
	func testRandomBetween() {
		XCTAssert(Int.randomBetween(min: 1, max: 5) > 0 && Float.randomBetween(min: 1, max: 5) < 5, "Couldn't get correct value for \(#function)")
	}
	
	func testRomanNumeral() {
		XCTAssert(10.romanNumeral == "X" && (-1).romanNumeral == nil, "Couldn't get correct value for \(#function)")
	}
	
	func testTimeString() {
		XCTAssert(120.timeString == "2 min", "Couldn't get correct value for \(#function)")
	}
	
	func testOperators() {
		print(5 ** 2)
		//XCTAssert((5 ^ 2) == 25, "Couldn't get correct value for \(#function)")
		
		XCTAssert((5 ± 2) == (3, 7) || (5 ± 2) == (7, 3), "Couldn't get correct value for \(#function)")
		
		XCTAssert((±2) == (2, -2) || (±2) == (-2, 2), "Couldn't get correct value for \(#function)")
		
		XCTAssert((√25) == 5.0, "Couldn't get correct value for \(#function)")
	}
}
