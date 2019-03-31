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
        XCTAssertFalse(1.isBetween(5...7), "number range")
        XCTAssertTrue(7.isBetween(6...12), "number range")
        XCTAssertTrue(0.32.isBetween(0.31...0.33), "float range")
        XCTAssertTrue("c".isBetween("a"..."d"), "string range")

        let date = Date()
        XCTAssertTrue(date.isBetween(date...date.addingTimeInterval(1000)), "date range")
    }

    func testClamped() {
        XCTAssertEqual(1.clamped(to: 3...8), 3)
        XCTAssertEqual(4.clamped(to: 3...7), 4)
        XCTAssertEqual("c".clamped(to: "e"..."g"), "e")
        XCTAssertEqual(0.32.clamped(to: 0.37...0.42), 0.37)
    }

}
