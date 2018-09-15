//
//  SignedIntegerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 5.04.2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class SignedIntegerExtensionsTests: XCTestCase {

    func testAbs() {
        XCTAssertEqual((-9).abs, 9)
    }

    func testIsPositive() {
        XCTAssert(1.isPositive)
        XCTAssertFalse(0.isPositive)
        XCTAssertFalse((-1).isPositive)
    }

    func testIsNegative() {
        XCTAssert((-1).isNegative)
        XCTAssertFalse(0.isNegative)
        XCTAssertFalse(1.isNegative)
    }

    func testIsEven() {
        XCTAssert(2.isEven)
        XCTAssertFalse(3.isEven)
    }

    func testIsOdd() {
        XCTAssert(3.isOdd)
        XCTAssertFalse(2.isOdd)
    }

    func testTimeString() {
        XCTAssertEqual((-1).timeString, "0 sec")
        XCTAssertEqual(45.timeString, "45 sec")
        XCTAssertEqual(120.timeString, "2 min")
        XCTAssertEqual(3600.timeString, "1h")
        XCTAssertEqual(3660.timeString, "1h 1m")
    }

    func testGcd() {
        XCTAssertEqual(8.gcd(of: 20), 4)
    }

    func testLcm() {
        XCTAssertEqual(4.lcm(of: 3), 12)
    }

    func testString() {
        XCTAssertEqual(2.string, "2")
    }

}
