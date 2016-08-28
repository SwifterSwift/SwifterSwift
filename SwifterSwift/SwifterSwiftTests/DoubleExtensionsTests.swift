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
		XCTAssert(Double(-9.3).abs == Double(9.3), "Couldn't get correct value for \(#function)")
	}
	
	func testCeil() {
		XCTAssert(Double(9.3).ceil == Double(10.0), "Couldn't get correct value for \(#function)")
	}
	
	func testDegreesToRadians() {
		XCTAssert(Double(180).degreesToRadians == M_PI, "Couldn't get correct value for \(#function)")
	}
	
	func testRandomBetween() {
		XCTAssert(Double.randomBetween(min: 1, max: 5) > 0 && Double.randomBetween(min: 1, max: 5) < 5, "Couldn't get correct value for \(#function)")
	}
	
	func testFloor() {
		XCTAssert(Double(9.3).floor == Double(9.0), "Couldn't get correct value for \(#function)")
	}
	
	func testRadiansToDegrees() {
		XCTAssert(Double(M_PI).radiansToDegrees == Double(180), "Couldn't get correct value for \(#function)")
	}
	
	func testOperators() {
		XCTAssert((Double(5.0) ** Double(2.0)) == Double(25.0), "Couldn't get correct value for \(#function)")
		
		XCTAssert((Double(5.0) ± Double(2.0)) == (Double(3.0), Double(7.0)) || (Double(5.0) ± Double(2.0)) == (Double(7.0), Double(3.0)), "Couldn't get correct value for \(#function)")
		
		XCTAssert((±Double(2.0)) == (Double(2.0), Double(-2.0)) || (±Double(2.0)) == (Double(-2.0), Double(2.0)), "Couldn't get correct value for \(#function)")
		
		XCTAssert((√Double(25.0)) == Double(5.0), "Couldn't get correct value for \(#function)")
	}
}
