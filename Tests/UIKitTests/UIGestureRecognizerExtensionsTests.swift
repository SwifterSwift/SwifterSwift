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

        //First Baseline Assertion
        XCTAssert(view.gestureRecognizers == nil)
        XCTAssert(tap.view == nil)

        view.addGestureRecognizer(tap)

        //Verify change
        XCTAssertFalse(view.gestureRecognizers == nil)
        XCTAssertFalse(tap.view == nil)

        //Second Baseline Assertion
        XCTAssertFalse((view.gestureRecognizers?.count ?? 0) == 0)
        XCTAssertFalse(view.gestureRecognizers?.isEmpty ?? true)

        tap.removeFromView()

        //Verify change
        XCTAssert((view.gestureRecognizers?.count ?? 1) == 0)
        XCTAssert(view.gestureRecognizers?.isEmpty ?? false)
        XCTAssert(tap.view == nil)
    }

}
#endif
