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
		XCTAssert(Float(-9.3).abs == Float(9.3), "Couldn't get correct value for \(#function)")
	}
	
	func testCeil() {
		XCTAssert(Float(9.3).ceil == Float(10.0), "Couldn't get correct value for \(#function)")
	}
	
	func testDegreesToRadians() {
		XCTAssert(Float(180).degreesToRadians == Float(M_PI), "Couldn't get correct value for \(#function)")
	}
	
	func testRandomBetween() {
		XCTAssert(Float.randomBetween(min: 1, max: 5) > 0 && Float.randomBetween(min: 1, max: 5) < 5, "Couldn't get correct value for \(#function)")
	}
	
	func testFloor() {
		XCTAssert(Float(9.3).floor == Float(9.0), "Couldn't get correct value for \(#function)")
	}
	
	func testRadiansToDegrees() {
		XCTAssert(Float(M_PI).radiansToDegrees == Float(180), "Couldn't get correct value for \(#function)")
	}
	
	func testOperators() {
		XCTAssert((Float(5.0) ** Float(2.0)) == Float(25.0), "Couldn't get correct value for \(#function)")
		
		XCTAssert((Float(5.0) ± Float(2.0)) == (Float(3.0), Float(7.0)) || (Float(5.0) ± Float(2.0)) == (Float(7.0), Float(3.0)), "Couldn't get correct value for \(#function)")
		
		XCTAssert((±Float(2.0)) == (Float(2.0), Float(-2.0)) || (±Float(2.0)) == (Float(-2.0), Float(2.0)), "Couldn't get correct value for \(#function)")
		
		XCTAssert((√Float(25.0)) == Float(5.0), "Couldn't get correct value for \(#function)")
	}
}
