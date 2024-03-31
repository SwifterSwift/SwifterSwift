// ComparableExtensionsTests.swift - Copyright 2024 SwifterSwift

import XCTest

@testable import SwifterSwift

final class ComparableExtensionsTests: XCTestCase {
    func testIsBetween() {
        XCTAssertFalse(1.isBetween(5...7), "number range")
        XCTAssert(7.isBetween(6...12), "number range")
        XCTAssert(0.32.isBetween(0.31...0.33), "float range")
        XCTAssert("c".isBetween("a"..."d"), "string range")

        let date = Date()
        XCTAssert(date.isBetween(date...date.addingTimeInterval(1000)), "date range")
    }

    func testClamped() {
        XCTAssertEqual(1.clamped(to: 3...8), 3)
        XCTAssertEqual(4.clamped(to: 3...7), 4)
        XCTAssertEqual("c".clamped(to: "e"..."g"), "e")
        XCTAssertEqual(0.32.clamped(to: 0.37...0.42), 0.37)
    }
}
