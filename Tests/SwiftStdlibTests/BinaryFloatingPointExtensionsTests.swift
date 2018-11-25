//
//  BinaryFloatingPointExtensionsTests.swift
//  SwifterSwift
//
//  Created by Quentin Jin on 2018/10/13.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class BinaryFloatingPointExtensionsTests: XCTestCase {

    func testRounded() {
        let double = 3.1415927
        XCTAssertEqual(double.rounded(numberOfDecimalPlaces: 3, rule: .up), 3.142)
        XCTAssertEqual(double.rounded(numberOfDecimalPlaces: 3, rule: .down), 3.141)
        XCTAssertEqual(double.rounded(numberOfDecimalPlaces: 2, rule: .awayFromZero), 3.15)

        let float: Float = 3.1415927
        XCTAssertEqual(float.rounded(numberOfDecimalPlaces: 4, rule: .towardZero), 3.1415)
        XCTAssertEqual(float.rounded(numberOfDecimalPlaces: -1, rule: .toNearestOrEven), 3)
        XCTAssertEqual(float.rounded(numberOfDecimalPlaces: 0, rule: .toNearestOrAwayFromZero), 3)
    }

}
