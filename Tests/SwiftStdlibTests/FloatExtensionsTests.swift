//
//  FloatExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class FloatExtensionsTests: XCTestCase {

    func testInt() {
        XCTAssertEqual(Float(-1).int, -1)
        XCTAssertEqual(Float(2).int, 2)
        XCTAssertEqual(Float(4.3).int, 4)
    }

    func testDouble() {
        XCTAssertEqual(Float(-1).double, Double(-1))
        XCTAssertEqual(Float(2).double, Double(2))
        XCTAssertEqual(Float(4.3).double, Double(4.3), accuracy: 0.00001)
    }

    func testCGFloat() {
        #if canImport(CoreGraphics)
        XCTAssertEqual(Float(4.3).cgFloat, CGFloat(4.3), accuracy: 0.00001)
        #endif
    }

    func testOperators() {
        XCTAssertEqual((Float(5.0) ** Float(2.0)), Float(25.0))
        XCTAssertEqual((√Float(25.0)), Float(5.0))
    }

}
