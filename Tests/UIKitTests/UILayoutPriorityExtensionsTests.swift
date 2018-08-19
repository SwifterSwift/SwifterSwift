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

    // MARK: - Initializers
    func testFloatLiteralInitializer() {
        let constraint = NSLayoutConstraint(
            item: UIView(),
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: UIView(),
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 0
        )
        constraint.priority = 0.5

        XCTAssertEqual(0.5, constraint.priority)
    }

    func testIntegerLiteralInitializer() {
        let constraint = NSLayoutConstraint(
            item: UIView(),
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: UIView(),
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 0
        )
        constraint.priority = 5

        XCTAssertEqual(5, constraint.priority)
    }
}

#endif
