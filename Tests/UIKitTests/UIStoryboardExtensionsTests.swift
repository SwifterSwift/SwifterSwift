// UIStoryboardExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

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
