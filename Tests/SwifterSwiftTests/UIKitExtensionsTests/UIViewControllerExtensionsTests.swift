//
//  UIViewControllerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/25/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)

import XCTest
@testable import SwifterSwift
    
class UIViewControllerExtensionsTests: XCTestCase {
    
    class MockNotificationViewController: UIViewController {
        var notificationFired = false
        
        func testSelector() {
            notificationFired = true
        }
    }
    
    let notificationIdentifier = Notification.Name("MockNotification")
    
    func testNavigationBar() {
        let viewController = UIViewController()
        XCTAssertNil(viewController.navigationBar)
        let navigationController = UINavigationController(rootViewController: viewController)
        XCTAssertEqual(navigationController.navigationBar, viewController.navigationBar)
    }
    
    func testAddNotificationObserver() {
        let viewController = MockNotificationViewController()
        let selector = #selector(MockNotificationViewController.testSelector)
        viewController.addNotificationObserver(name: notificationIdentifier, selector: selector)
        NotificationCenter.default.post(name: notificationIdentifier, object: nil)
        XCTAssert(viewController.notificationFired)
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
}
#endif
