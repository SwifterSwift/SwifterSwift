//
//  DoubleExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class DoubleExtensionsTests: XCTestCase {
	
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
    
    func testUnitsOfMeasurement() {
        let meters = 1.0
        
        XCTAssertTrue(meters.km == 0.001)
        XCTAssertTrue(meters.cm == 100)
        XCTAssertTrue(meters.mm == 1000)
        XCTAssertTrue(meters.ft == 3.28084)
        XCTAssertTrue(meters.mi == 0.00062137)
        XCTAssertTrue(meters.yd == 1093.61)
        XCTAssertTrue(meters.inch == 39.3701)
    }
    
    func testDurationString() {
        // Default parameters
        var durationString = 3.5.toDurationString()
        XCTAssert(durationString == "03h 30m 00s")
        
        durationString = 3.5.toDurationString(withSeconds: false, separatedBy: ":")
        XCTAssert(durationString == "03:30")
        
        durationString = 3.5.toDurationString(withSeconds: true, separatedBy: " ")
        XCTAssert(durationString == "03 30 00")
    }
	
}
