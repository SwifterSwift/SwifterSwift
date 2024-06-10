// SCNVector3ExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(SceneKit)
import SceneKit

final class SceneKitTests: XCTestCase {
    let vector1 = SCNVector3(10, -20, 30)
    let vector2 = SCNVector3(20, 0, -10)

    func testAbsolute() {
        XCTAssertEqual(vector1.absolute, SCNVector3(10, 20, 30))
    }

    func testLength() {
        let vector = SCNVector3(2, 3, 6)
        XCTAssertEqual(vector.length, 7)
    }

    func testNormalized() {
        let v3Norm = SCNVector3(3, -5, 0.125).normalized
        XCTAssertEqual(v3Norm.length, 1)

        let vector4 = SCNVector3(4, 4, 2)
        let v4Norm = vector4.normalized
        XCTAssertEqual(v4Norm.x, 4 / 6)
        XCTAssertEqual(v4Norm.x, v4Norm.y)
        XCTAssertEqual(v4Norm.z, 2 / 6)
    }

    func testAdd() {
        let result = vector1 + vector2
        XCTAssertEqual(result, SCNVector3(30, -20, 20))
    }

    func testAddEqual() {
        var vector = vector1
        vector += vector2
        XCTAssertEqual(vector, SCNVector3(30, -20, 20))
    }

    func testSubtract() {
        let result = vector1 - vector2
        XCTAssertEqual(result, SCNVector3(-10, -20, 40))
    }

    func testSubtractEqual() {
        var vector = vector1
        vector -= vector2
        XCTAssertEqual(vector, SCNVector3(-10, -20, 40))
    }

    func testMultiply() {
        let result = vector1 * 3
        XCTAssertEqual(result, SCNVector3(30, -60, 90))
    }

    func testMultiplyEqual() {
        var vector = vector1
        vector *= 3
        XCTAssertEqual(vector, SCNVector3(30, -60, 90))
    }

    func testMultiplyScalarFirst() {
        let result = 3 * vector1
        XCTAssertEqual(result, SCNVector3(30, -60, 90))
    }

    func testDivide() {
        let result = vector1 / 10
        XCTAssertEqual(result, SCNVector3(1, -2, 3))
    }

    func testDivideEqual() {
        var vector = vector1
        vector /= 10
        XCTAssertEqual(vector, SCNVector3(1, -2, 3))
    }
}

extension SCNVector3: Swift.Equatable {
    public static func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}

#endif
