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

    #if os(iOS)
    func testPresentPopover() {
        let popover = UIViewController()
        let presentingViewController = UIViewController()

        // Putting the view controller in a window and running a RunLoop seems to be the only way to make
        // the presentedViewController and presentingViewController properties to be set.
        let window = UIWindow()
        window.rootViewController = presentingViewController
        window.addSubview(presentingViewController.view)
        RunLoop.current.run(until: Date())

        presentingViewController.presentPopover(popover, sourcePoint: presentingViewController.view.center, animated: false)

        XCTAssertEqual(presentingViewController.presentedViewController, popover)
        XCTAssertEqual(popover.presentingViewController, presentingViewController)
        XCTAssertEqual(popover.modalPresentationStyle, .popover)
    }

    func testPresentPopoverWithCustomSize() {
        let popover = UIViewController()
        let presentingViewController = UIViewController()
        let customSize = CGSize(width: 100, height: 100)

        // Putting the view controller in a window and running a RunLoop seems to be the only way to make
        // the presentedViewController and presentingViewController properties to be set.
        let window = UIWindow()
        window.rootViewController = presentingViewController
        window.addSubview(presentingViewController.view)
        RunLoop.current.run(until: Date())

        presentingViewController.presentPopover(popover, sourcePoint: presentingViewController.view.center, size: customSize)

        XCTAssertEqual(presentingViewController.presentedViewController, popover)
        XCTAssertEqual(popover.presentingViewController, presentingViewController)
        XCTAssertEqual(popover.modalPresentationStyle, .popover)
        XCTAssertEqual(popover.preferredContentSize, customSize)
    }

    func testPresentPopoverWithDelegate() {
        // swiftlint:disable:next nesting
        class PopoverDelegate: NSObject, UIPopoverPresentationControllerDelegate {
            func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
                return .popover
            }
        }

        let popover = UIViewController()
        let presentingViewController = UIViewController()
        let delegate = PopoverDelegate()

        // Putting the view controller in a window and running a RunLoop seems to be the only way to make
        // the presentedViewController and presentingViewController properties to be set.
        let window = UIWindow()
        window.rootViewController = presentingViewController
        window.addSubview(presentingViewController.view)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 5))

        presentingViewController.presentPopover(popover, sourcePoint: presentingViewController.view.center, delegate: delegate)

        XCTAssertEqual(presentingViewController.presentedViewController, popover)
        XCTAssertEqual(popover.presentingViewController, presentingViewController)
        XCTAssertEqual(popover.modalPresentationStyle, .popover)

        let popoverDelegate = popover.popoverPresentationController?.delegate as? PopoverDelegate
        XCTAssertNotNil(popoverDelegate)
        XCTAssertEqual(popoverDelegate, delegate)
    }

    #endif

}
#endif
