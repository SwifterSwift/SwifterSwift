// DoubleExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

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
        #if canImport(CoreGraphics)
        XCTAssertEqual(Double(4.3).cgFloat, CGFloat(4.3))
        #endif
    }

    func testOperators() {
        XCTAssertEqual(Double(5.0) ** Double(2.0), Double(25.0))
    }
}
