//
//  UIGestureRecognizerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Morgan Dock on 4/21/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if os(iOS) && !os(watchOS)
import UIKit

final class UIGestureRecognizerExtensionsTests: XCTestCase {

    func testRemoveFromView() {
        let view = UIImageView()
        let tap = UITapGestureRecognizer()

        // First Baseline Assertion
        XCTAssertNil(view.gestureRecognizers)
        XCTAssertNil(tap.view)

        view.addGestureRecognizer(tap)

        // Verify change
        XCTAssertNotNil(view.gestureRecognizers)
        XCTAssertNotNil(tap.view)

        // Second Baseline Assertion
        XCTAssertNotEqual(view.gestureRecognizers?.count, 0)
        XCTAssertFalse(view.gestureRecognizers?.isEmpty ?? true)

        tap.removeFromView()

        // Verify change
        XCTAssertEqual(view.gestureRecognizers?.count, 0)
        XCTAssert(view.gestureRecognizers?.isEmpty ?? false)
        XCTAssertNil(tap.view)
    }

}

#endif
