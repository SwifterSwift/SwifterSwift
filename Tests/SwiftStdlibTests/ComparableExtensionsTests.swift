//
//  ComparableExtensionsTests.swift
//  SwifterSwift
//
//  Created by Shai Mishali on 5/4/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest

@testable import SwifterSwift

final class ComparableExtensionsTests: XCTestCase {

    func testIsBetween() {
        XCTAssertFalse(1.isBetween(min: 5, max: 7), "number range")
        XCTAssertTrue(7.isBetween(min: 6, max: 12), "number range")
        XCTAssertTrue(0.32.isBetween(min: 0.31, max: 0.33), "float range")
        XCTAssertTrue("c".isBetween(min: "a", max: "d"), "string range")

        let date = Date()
        XCTAssertTrue(date.isBetween(min: date, max: date.addingTimeInterval(1000)), "date range")
    }

    func testClamped() {
        XCTAssertEqual(1.clamped(min: 3, max: 8), 3)
        XCTAssertEqual(4.clamped(min: 3, max: 7), 4)
        XCTAssertEqual("c".clamped(min: "e", max: "g"), "e")
        XCTAssertEqual(0.32.clamped(min: 0.37, max: 0.42), 0.37)
    }
}
