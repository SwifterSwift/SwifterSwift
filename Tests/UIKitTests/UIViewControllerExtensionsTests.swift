//
//  UIViewControllerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/25/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UIViewControllerExtensionsTests: XCTestCase {

    class MockNotificationViewController: UIViewController {
        var notificationFired = false

        @objc func testSelector() {
            notificationFired = true
        }
    }

    let notificationIdentifier = Notification.Name("MockNotification")

    func testAddNotificationObserver() {
        let viewController = MockNotificationViewController()
        let selector = #selector(MockNotificationViewController.testSelector)
        viewController.addNotificationObserver(name: notificationIdentifier, selector: selector)
        NotificationCenter.default.post(name: notificationIdentifier, object: nil)
        XCTAssert(viewController.notificationFired)
    }

    func testIsVisible() {
        let viewController = UIViewController()
        XCTAssertFalse(viewController.isVisible)
    }

    func testRemoveNotificationObserver() {
        let viewController = MockNotificationViewController()
        let selector = #selector(MockNotificationViewController.testSelector)
        viewController.addNotificationObserver(name: notificationIdentifier, selector: selector)
        viewController.removeNotificationObserver(name: notificationIdentifier)
        NotificationCenter.default.post(name: notificationIdentifier, object: nil)
        XCTAssertFalse(viewController.notificationFired)
    }

    func testRemoveNotificationsObserver() {
        let viewController = MockNotificationViewController()
        let selector = #selector(MockNotificationViewController.testSelector)
        viewController.addNotificationObserver(name: notificationIdentifier, selector: selector)
        viewController.removeNotificationsObserver()
        NotificationCenter.default.post(name: notificationIdentifier, object: nil)
        XCTAssertFalse(viewController.notificationFired)
    }

    func testShowAlert() {
        let viewController = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        let title = "test title"
        let message = "test message"
        let actionButtons = ["OK", "Cancel"]
        let preferredButtonIndex = 1
        let alertController = viewController.showAlert(
            title: title,
            message: message,
            buttonTitles: actionButtons,
            highlightedButtonIndex: preferredButtonIndex,
            completion: nil)

        XCTAssertEqual(alertController.preferredStyle, .alert)
        XCTAssertEqual(alertController.title, title)
        XCTAssertEqual(alertController.message, message)
        //check whether the buttons are added in the same order
        for action in 0..<alertController.actions.count {
            XCTAssertEqual(alertController.actions[action].title, actionButtons[action])
        }
        XCTAssertEqual(alertController.preferredAction, alertController.actions[preferredButtonIndex])
    }

    func testAddChildViewController() {
        let parentViewController = UIViewController()
        let childViewController = UIViewController()

        XCTAssert(parentViewController.children.isEmpty)
        XCTAssertNil(childViewController.parent)

        parentViewController.addChildViewController(childViewController, toContainerView: parentViewController.view)

        XCTAssertEqual(parentViewController.children, [childViewController])
        XCTAssertNotNil(childViewController.parent)
        XCTAssertEqual(childViewController.parent, parentViewController)
    }

    func testRemoveChildViewController() {
        let parentViewController = UIViewController()
        let childViewController = UIViewController()

        parentViewController.addChild(childViewController)
        parentViewController.view.addSubview(childViewController.view)
        childViewController.didMove(toParent: parentViewController)

        XCTAssertEqual(parentViewController.children, [childViewController])
        XCTAssertNotNil(childViewController.parent)
        XCTAssertEqual(childViewController.parent, parentViewController)

        childViewController.removeViewAndControllerFromParentViewController()

        XCTAssert(parentViewController.children.isEmpty)
        XCTAssertNil(childViewController.parent)
    }

    func testRemoveChildViewControllerWithNoParent() {
        let childViewController = UIViewController()
        XCTAssertNil(childViewController.parent)

        childViewController.removeViewAndControllerFromParentViewController()

        XCTAssertNil(childViewController.parent)
    }

}
#endif
