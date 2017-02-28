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
	
	#if !os(macOS)
	func testAbs() {
		XCTAssertEqual(CGFloat(-9.3).abs, CGFloat(9.3))
	}
	#endif
	
	#if !os(macOS)
	func testCeil() {
		XCTAssertEqual(CGFloat(9.3).ceil, CGFloat(10.0))
	}
	#endif
	
	#if !os(macOS)
	func testDegreesToRadians() {
		XCTAssertEqual(CGFloat(180).degreesToRadians, CGFloat.pi)
	}
	#endif
    
    #if !os(macOS)
    func testIsPositive() {
        XCTAssert(CGFloat(9.3).isPositive)
        XCTAssertFalse(CGFloat(0).isPositive)
        XCTAssertFalse(CGFloat(-9.2).isPositive)
    }
    #endif
    
    #if !os(macOS)
    func testIsNegative() {
        XCTAssert(CGFloat(-9.3).isNegative)
        XCTAssertFalse(CGFloat(0).isNegative)
        XCTAssertFalse(CGFloat(9.3).isNegative)
    }
    #endif
    
    #if !os(macOS)
    func testInt() {
        XCTAssertEqual(CGFloat(9.3).int, Int(9))
    }
    #endif
    
    #if !os(macOS)
    func testDouble() {
        XCTAssertEqual(CGFloat(9.3).double, Double(9.3))
    }
    #endif
    
    #if !os(macOS)
    func testFloat() {
        XCTAssertEqual(CGFloat(9.3).float, Float(9.3))
    }
    #endif
	
	#if !os(macOS)
	func testRandomBetween() {
		XCTAssertGreaterThan(CGFloat.randomBetween(min: 1, max: 5), 0)
		XCTAssertLessThan(CGFloat.randomBetween(min: 1, max: 5), 5)
	}
	#endif
	
	#if !os(macOS)
	func testFloor() {
		XCTAssertEqual(CGFloat(9.3).floor, CGFloat(9.0))
	}
	#endif
	
	#if !os(macOS)
	func testRadiansToDegrees() {
		XCTAssertEqual(CGFloat.pi.radiansToDegrees, CGFloat(180))
	}
	#endif
	
}
