//
//  UIStoryboardExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/25/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if os(iOS)
import UIKit

final class UIStoryboardExtensionsTests: XCTestCase {

    func testMainStoryboard() {
        XCTAssertNil(UIStoryboard.main)
    }

    func testInstantiateViewController() {
        let storyboard = UIStoryboard(name: "TestStoryboard", bundle: Bundle(for: UIStoryboardExtensionsTests.self))
        let viewController = storyboard.instantiateViewController(withClass: UIViewController.self)
        XCTAssertNotNil(viewController)
    }

}

#endif
