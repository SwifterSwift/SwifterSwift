// UILayoutPriorityExtensionsTests.swift - Copyright 2024 SwifterSwift

#if os(iOS) || os(tvOS)

@testable import SwifterSwift
import XCTest

final class UILayoutPriorityExtensionsTests: XCTestCase {
    func testFloatLiteralInitializer() {
        var priority: UILayoutPriority = 0.5
        XCTAssertEqual(UILayoutPriority(rawValue: 0.5), priority)

        priority = -0.5
        XCTAssertEqual(UILayoutPriority(rawValue: -0.5), priority)

        priority = 0.0
        XCTAssertEqual(UILayoutPriority(rawValue: 0.0), priority)
    }

    func testIntegerLiteralInitializer() {
        var priority: UILayoutPriority = 5
        XCTAssertEqual(UILayoutPriority(rawValue: 5), priority)

        priority = -5
        XCTAssertEqual(UILayoutPriority(rawValue: -5), priority)

        priority = 0
        XCTAssertEqual(UILayoutPriority(rawValue: 0), priority)
    }
}

#endif
