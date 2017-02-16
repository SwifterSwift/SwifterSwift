//
//  UINavigationControllerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/16/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
import XCTest
@testable import SwifterSwift
    
class UINavigationControllerExtensionsTests: XCTestCase {
    
    func testPopViewController() {
        let navigationController = UINavigationController()
        let vcToPop = UIViewController()
        
        navigationController.pushViewController(vcToPop, animated: false)
        
        var completionCalled = false
        
        navigationController.popViewController() {
            completionCalled = true
            XCTAssert(completionCalled)
            XCTAssert(navigationController.viewControllers.isEmpty)
        }
    }
    
    func testPushViewController() {
        let navigationController = UINavigationController()
        let vcToPush = UIViewController()
        
        navigationController.pushViewController(vcToPush, animated: false)
        
        var completionCalled = false
        
        navigationController.pushViewController(viewController: vcToPush) {
            completionCalled = true
            XCTAssert(completionCalled)
            XCTAssert(navigationController.viewControllers.count == 1)
            XCTAssertEqual(navigationController.topViewController, vcToPush)
        }
    }
    
    func testMakeTransparent() {
        let navigationController = UINavigationController()
        navigationController.makeTransparent(withTint: .red)
        XCTAssertNotNil(navigationController.navigationBar.backgroundImage(for: .default))
        XCTAssertNotNil(navigationController.navigationBar.shadowImage)
        XCTAssert(navigationController.navigationBar.isTranslucent)
        XCTAssertEqual(navigationController.navigationBar.tintColor, .red)
        let titleColor = navigationController.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
        XCTAssertEqual(titleColor, .red)
    }
}
#endif
