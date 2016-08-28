//
//  CGFloatExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class CGFloatExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testAbs() {
		XCTAssert(CGFloat(-9.3).abs == CGFloat(9.3), "Couldn't get correct value for \(#function)")
	}
	
	func testCeil() {
		XCTAssert(CGFloat(9.3).ceil == CGFloat(10.0), "Couldn't get correct value for \(#function)")
	}
	
	func testDegreesToRadians() {
		XCTAssert(CGFloat(180).degreesToRadians == CGFloat(M_PI), "Couldn't get correct value for \(#function)")
	}
	
	func testRandomBetween() {
		XCTAssert(CGFloat.randomBetween(min: 1, max: 5) > 0 && CGFloat.randomBetween(min: 1, max: 5) < 5, "Couldn't get correct value for \(#function)")
	}
	
	func testFloor() {
		XCTAssert(CGFloat(9.3).floor == CGFloat(9.0), "Couldn't get correct value for \(#function)")
	}
	
	func testRadiansToDegrees() {
		XCTAssert(CGFloat(M_PI).radiansToDegrees == CGFloat(180), "Couldn't get correct value for \(#function)")
	}
}
