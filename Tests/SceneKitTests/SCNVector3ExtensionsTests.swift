//
//  SCNVector3ExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 06.04.19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

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

    func testAdd() {
        let result = vector1 + vector2
        XCTAssertEqual(result, SCNVector3(30, -20, 20))
    }

    func testAddEqual() {
        var vector = vector1
        vector += vector2
        XCTAssertEqual(vector, SCNVector3(30, -20, 20))
    }

    func testSubstract() {
        let result = vector1 - vector2
        XCTAssertEqual(result, SCNVector3(-10, -20, 40))
    }

    func testSubstractEqual() {
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

}

extension SCNVector3: Equatable {
    public static func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}

#endif
