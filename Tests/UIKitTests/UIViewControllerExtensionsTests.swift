//
//  UIViewControllerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/25/17.
//  Copyright © 2017 SwifterSwift
//

#if os(iOS) || os(tvOS)

import XCTest
@testable import SwifterSwift

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

    func testPush() {
        let rootViewControoler = UIViewController()
        let navigationController = UINavigationController(rootViewController: rootViewControoler)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        let viewController = UIViewController()
        XCTAssertNoThrow(rootViewControoler.push(viewController))
        XCTAssertNoThrow(rootViewControoler.push(viewController, animated: true))
    }

    func testPop() {
        let rootViewControoler = UIViewController()
        let navigationController = UINavigationController(rootViewController: rootViewControoler)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        let viewController = UIViewController()
        XCTAssertNoThrow(viewController.pop())
        XCTAssertNoThrow(viewController.pop(animated: true))
    }

    func testPopToViewController() {
        let rootViewControoler = UIViewController()
        let navigationController = UINavigationController(rootViewController: rootViewControoler)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        let viewController = UIViewController()
        XCTAssertNoThrow(viewController.popToViewController(rootViewControoler))
        XCTAssertNoThrow(viewController.popToViewController(rootViewControoler, animated: true))
    }

    func testPresent() {
        let viewControoler = UIViewController()
        XCTAssertNoThrow(viewControoler.present(UIViewController()))
        XCTAssertNoThrow(viewControoler.present(UIViewController()) { })
        XCTAssertNoThrow(viewControoler.present(UIViewController(), animated: true))
    }

    func testDismiss() {
        let viewControoler = UIViewController()
        XCTAssertNoThrow(viewControoler.dismiss())
        XCTAssertNoThrow(viewControoler.dismiss(animated: true))
        XCTAssertNoThrow(viewControoler.dismiss({ }))
    }
}
#endif
