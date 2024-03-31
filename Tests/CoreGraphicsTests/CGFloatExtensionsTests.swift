// CGFloatExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(CoreGraphics)
import CoreGraphics

final class CGFloatExtensionsTests: XCTestCase {
    func testAbs() {
        XCTAssertEqual(CGFloat(-9.3).abs, CGFloat(9.3))
    }

    func testCeil() {
        XCTAssertEqual(CGFloat(9.3).ceil, CGFloat(10.0))
    }

    func testDegreesToRadians() {
        XCTAssertEqual(CGFloat(180).degreesToRadians, CGFloat.pi)
    }

    func testIsPositive() {
        XCTAssert(CGFloat(9.3).isPositive)
        XCTAssertFalse(CGFloat(0).isPositive)
        XCTAssertFalse(CGFloat(-9.2).isPositive)
    }

    func testIsNegative() {
        XCTAssert(CGFloat(-9.3).isNegative)
        XCTAssertFalse(CGFloat(0).isNegative)
        XCTAssertFalse(CGFloat(9.3).isNegative)
    }

    func testInt() {
        XCTAssertEqual(CGFloat(9.3).int, Int(9))
    }

    func testDouble() {
        XCTAssertEqual(CGFloat(9.3).double, Double(9.3))
    }

    func testFloat() {
        XCTAssertEqual(CGFloat(9.3).float, Float(9.3))
    }

    func testFloor() {
        XCTAssertEqual(CGFloat(9.3).floor, CGFloat(9.0))
    }

    func testRadiansToDegrees() {
        XCTAssertEqual(CGFloat.pi.radiansToDegrees, CGFloat(180))
    }
}

#endif
