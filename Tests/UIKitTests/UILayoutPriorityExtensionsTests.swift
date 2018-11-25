//
//  UILayoutPriorityExtensionsTests.swift
//  SwifterSwift
//
//  Created by diamantidis on 8/19/18.
//  Copyright © 2018 SwifterSwift. All rights reserved.
//

#if os(iOS) || os(tvOS)

import XCTest
@testable import SwifterSwift

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
