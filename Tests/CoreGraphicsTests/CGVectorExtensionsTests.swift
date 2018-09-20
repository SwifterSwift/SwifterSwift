//
//  CGVectorExtensionsTests.swift
//  SwifterSwift
//
//  Created by Robbie Moyer on 7/25/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

final class CGVectorExtensionsTests: XCTestCase {

    func testAngle() {
        let vector1 = CGVector(dx: 1, dy: 1)    // pi/4
        let vector2 = CGVector(dx: 1, dy: 0)    // 0
        let vector3 = CGVector(dx: 0, dy: 1)    // pi/2
        let vector4 = CGVector(dx: -1, dy: 0)   // pi
        let vector5 = CGVector(dx: 0, dy: -1)   // -pi/2
        let vector6 = CGVector(dx: -1, dy: -1)  // -3pi/4
        let vector7 = CGVector(dx: 1, dy: -1)   // -pi/4
        let vector8 = CGVector(dx: -1, dy: 1)   // 3pi/4

        XCTAssertEqual(vector1.angle, .pi/4)
        XCTAssertEqual(vector2.angle, 0)
        XCTAssertEqual(vector3.angle, .pi/2)
        XCTAssertEqual(vector4.angle, .pi)
        XCTAssertEqual(vector5.angle, -(.pi/2))
        XCTAssertEqual(vector6.angle, -(3 * .pi/4))
        XCTAssertEqual(vector7.angle, -(.pi/4))
        XCTAssertEqual(vector8.angle, 3 * .pi/4)
    }

    func testMagnitude() {
        let vector1 = CGVector(dx: 3, dy: 4)
        let vector2 = CGVector(dx: 1, dy: 1)
        let vector3 = CGVector(dx: 20, dy: 0)
        let vector4 = CGVector(dx: 5, dy: 12)
        let vector5 = CGVector(dx: 8, dy: 15)

        XCTAssertEqual(vector1.magnitude, 5)
        XCTAssertEqual(vector2.magnitude, sqrt(2))
        XCTAssertEqual(vector3.magnitude, 20)
        XCTAssertEqual(vector4.magnitude, 13)
        XCTAssertEqual(vector5.magnitude, 17)
    }

    func testScalarMultiplication() {
        let vector = CGVector(dx: 3, dy: 4)

        XCTAssertEqual(2 * vector, vector * 2)
        XCTAssertEqual(0 * vector, .zero)
        XCTAssertEqual(1 * vector, vector)
        XCTAssertEqual(-1 * vector, CGVector(dx: -3, dy: -4))
        XCTAssertEqual(3 * vector, CGVector(dx: 9, dy: 12))

        var mutableVector = CGVector(dx: 3, dy: 4)

        XCTAssertEqual(vector, mutableVector)

        mutableVector *= 5

        XCTAssertEqual(mutableVector, CGVector(dx: 15, dy: 20))
        XCTAssertEqual(mutableVector, vector * 5)
    }

    func testNegation() {
        let vector = CGVector(dx: 3, dy: -4)

        XCTAssertEqual(-vector, CGVector(dx: -3, dy: 4))
    }

    func testInitWithAngleAndMagnitude() {
        let vector1 = CGVector(angle: .pi/4, magnitude: sqrt(2))
        let vector2 = CGVector(angle: .pi, magnitude: 1)
        let vector3 = CGVector(angle: .pi/6, magnitude: 2)
        let vector4 = CGVector(angle: .pi/3, magnitude: 2)

        let cgFloatPrecision: CGFloat = 0.000000000000001

        XCTAssertEqual(vector1.dx, 1, accuracy: cgFloatPrecision)
        XCTAssertEqual(vector1.dy, 1, accuracy: cgFloatPrecision)

        XCTAssertEqual(vector2.dx, -1, accuracy: cgFloatPrecision)
        XCTAssertEqual(vector2.dy, 0, accuracy: cgFloatPrecision)

        XCTAssertEqual(vector3.dx, sqrt(3), accuracy: cgFloatPrecision)
        XCTAssertEqual(vector3.dy, 1, accuracy: cgFloatPrecision)

        XCTAssertEqual(vector4.dx, 1, accuracy: cgFloatPrecision)
        XCTAssertEqual(vector4.dy, sqrt(3), accuracy: cgFloatPrecision)
    }
}

#endif
