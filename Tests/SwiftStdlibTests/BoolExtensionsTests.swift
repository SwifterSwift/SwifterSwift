// BoolExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

final class BoolExtensionsTests: XCTestCase {
    func testInt() {
        XCTAssertEqual(true.int, 1)
        XCTAssertEqual(false.int, 0)
    }

    func testString() {
        XCTAssertEqual(true.string, "true")
        XCTAssertEqual(false.string, "false")
    }
}
