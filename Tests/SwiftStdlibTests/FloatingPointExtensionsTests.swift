// FloatingPointExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

final class FloatingPointExtensionsTests: XCTestCase {
    func testAbs() {
        XCTAssertEqual(Float(-9.3).abs, Float(9.3))
        XCTAssertEqual(Double(-9.3).abs, Double(9.3))
    }

    func testIsPositive() {
        XCTAssert(Float(1).isPositive)
        XCTAssertFalse(Float(0).isPositive)
        XCTAssertFalse(Float(-1).isPositive)

        XCTAssert(Double(1).isPositive)
        XCTAssertFalse(Double(0).isPositive)
        XCTAssertFalse(Double(-1).isPositive)
    }

    func testIsNegative() {
        XCTAssert(Float(-1).isNegative)
        XCTAssertFalse(Float(0).isNegative)
        XCTAssertFalse(Float(1).isNegative)

        XCTAssert(Double(-1).isNegative)
        XCTAssertFalse(Double(0).isNegative)
        XCTAssertFalse(Double(1).isNegative)
    }

    func testCeil() {
        XCTAssertEqual(Float(-1.0).ceil, Float(-1.0))
        XCTAssertEqual(Float(-0.75).ceil, Float(0.0))
        XCTAssertEqual(Float(-0.5).ceil, Float(0.0))
        XCTAssertEqual(Float(-0.25).ceil, Float(0.0))
        XCTAssertEqual(Float(-0.0).ceil, Float(0.0))
        XCTAssertEqual(Float(0.0).ceil, Float(0.0))
        XCTAssertEqual(Float(0.25).ceil, Float(1.0))
        XCTAssertEqual(Float(0.5).ceil, Float(1.0))
        XCTAssertEqual(Float(0.75).ceil, Float(1.0))
        XCTAssertEqual(Float(1.0).ceil, Float(1.0))

        XCTAssertEqual(Double(-1.0).ceil, Double(-1.0))
        XCTAssertEqual(Double(-0.75).ceil, Double(0.0))
        XCTAssertEqual(Double(-0.5).ceil, Double(0.0))
        XCTAssertEqual(Double(-0.25).ceil, Double(0.0))
        XCTAssertEqual(Double(-0.0).ceil, Double(0.0))
        XCTAssertEqual(Double(0.0).ceil, Double(0.0))
        XCTAssertEqual(Double(0.25).ceil, Double(1.0))
        XCTAssertEqual(Double(0.5).ceil, Double(1.0))
        XCTAssertEqual(Double(0.75).ceil, Double(1.0))
        XCTAssertEqual(Double(1.0).ceil, Double(1.0))
    }

    func testFloor() {
        XCTAssertEqual(Float(-1.0).floor, Float(-1.0))
        XCTAssertEqual(Float(-0.75).floor, Float(-1.0))
        XCTAssertEqual(Float(-0.5).floor, Float(-1.0))
        XCTAssertEqual(Float(-0.25).floor, Float(-1.0))
        XCTAssertEqual(Float(-0.0).floor, Float(0.0))
        XCTAssertEqual(Float(0.0).floor, Float(0.0))
        XCTAssertEqual(Float(0.25).floor, Float(0.0))
        XCTAssertEqual(Float(0.5).floor, Float(0.0))
        XCTAssertEqual(Float(0.75).floor, Float(0.0))
        XCTAssertEqual(Float(1.0).floor, Float(1.0))

        XCTAssertEqual(Double(-1.0).floor, Double(-1.0))
        XCTAssertEqual(Double(-0.75).floor, Double(-1.0))
        XCTAssertEqual(Double(-0.5).floor, Double(-1.0))
        XCTAssertEqual(Double(-0.25).floor, Double(-1.0))
        XCTAssertEqual(Double(-0.0).floor, Double(0.0))
        XCTAssertEqual(Double(0.0).floor, Double(0.0))
        XCTAssertEqual(Double(0.25).floor, Double(0.0))
        XCTAssertEqual(Double(0.5).floor, Double(0.0))
        XCTAssertEqual(Double(0.75).floor, Double(0.0))
        XCTAssertEqual(Double(1.0).floor, Double(1.0))
    }

    func testDegreesToRadians() {
        XCTAssertEqual(Float(180).degreesToRadians, Float.pi)
        XCTAssertEqual(Double(180).degreesToRadians, Double.pi)
    }

    func testRadiansToDegrees() {
        XCTAssertEqual(Float.pi.radiansToDegrees, Float(180))
        XCTAssertEqual(Double.pi.radiansToDegrees, Double(180))
    }

    func testOperators() {
        XCTAssert((Float(5.0) ± Float(2.0)) == (Float(3.0), Float(7.0)) || (Float(5.0) ± Float(2.0)) ==
            (Float(7.0), Float(3.0)))
        XCTAssert((±Float(2.0)) == (Float(2.0), Float(-2.0)) || ±Float(2.0) == (Float(-2.0), Float(2.0)))
        XCTAssertEqual(√Float(25.0), Float(5.0))

        XCTAssert((Double(5.0) ± Double(2.0)) == (Double(3.0), Double(7.0)) || (Double(5.0) ± Double(2.0)) ==
            (Double(7.0), Double(3.0)))
        XCTAssert((±Double(2.0)) == (Double(2.0), Double(-2.0)) || ±Double(2.0) == (Double(-2.0), Double(2.0)))
        XCTAssertEqual(√Double(25.0), Double(5.0))
    }
}
