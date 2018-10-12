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

    func testRounded() {
        let num: Double = 3.1415927
        XCTAssertEqual(num.rounded(numberOfDecimalPlaces: 3, rule: .up), 3.142)
        XCTAssertEqual(num.rounded(numberOfDecimalPlaces: 3, rule: .down), 3.141)
        XCTAssertEqual(num.rounded(numberOfDecimalPlaces: 2, rule: .awayFromZero), 3.15)
        XCTAssertEqual(num.rounded(numberOfDecimalPlaces: 4, rule: .towardZero), 3.1415)
        XCTAssertEqual(num.rounded(numberOfDecimalPlaces: -1, rule: .toNearestOrEven), 3)
        XCTAssertEqual(num.rounded(numberOfDecimalPlaces: 0, rule: .toNearestOrAwayFromZero), 3)
    }

    func testOperators() {
        XCTAssertEqual((Double(5.0) ** Double(2.0)), Double(25.0))
        XCTAssertEqual((√Double(25.0)), Double(5.0))
    }

}
