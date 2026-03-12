// UIStoryboardExtensionsTests.swift - Copyright 2026 SwifterSwift

@testable import SwifterSwift
import XCTest

#if os(iOS)
import UIKit

@MainActor
final class UIStoryboardExtensionsTests: XCTestCase {
    func testMainStoryboard() {
        XCTAssertNil(UIStoryboard.main)
    }

    func testInstantiateViewController() throws {
        let bundle = Bundle(for: UIStoryboardExtensionsTests.self)

        guard bundle.path(forResource: "TestStoryboard", ofType: "storyboardc") != nil else {
            throw XCTSkip("Storyboard fixtures are not compiled for this test destination.")
        }

        let storyboard = UIStoryboard(name: "TestStoryboard", bundle: bundle)
        let viewController = storyboard.instantiateViewController(withClass: UIViewController.self)
        XCTAssertNotNil(viewController)
    }
}

#endif
