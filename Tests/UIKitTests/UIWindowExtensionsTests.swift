// UIWindowExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && os(iOS)
import UIKit

@MainActor
final class UIWindowExtensionsTests: XCTestCase {
    func testSwitchRootViewController() {
        let viewController = UIViewController()
        let tableViewController = UITableViewController()

        let window = UIWindow()
        window.rootViewController = viewController

        XCTAssertNotNil(window.rootViewController)
        XCTAssertEqual(window.rootViewController!, viewController)

        window.switchRootViewController(to: tableViewController, animated: false)
        XCTAssertNotNil(window.rootViewController)
        XCTAssertEqual(window.rootViewController!, tableViewController)

        let completionExpectation = expectation(description: "Completed")

        window.switchRootViewController(to: viewController, animated: true, duration: 0.75) {
            completionExpectation.fulfill()
            XCTAssertNotNil(window.rootViewController)
            XCTAssertEqual(window.rootViewController!, viewController)
        }

        waitForExpectations(timeout: 1)
    }
    
    func testKeyWindow() {
        // Test that keyWindow returns a window (should be the test window)
        let keyWindow = UIWindow.keyWindow
        XCTAssertNotNil(keyWindow)
        
        // Test that the returned window is actually a UIWindow
        XCTAssertTrue(keyWindow is UIWindow)
    }
}

#endif
