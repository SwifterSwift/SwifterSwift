//
//  UINavigationControllerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/16/17.
//  Copyright © 2017 SwifterSwift
//

#if os(iOS) || os(tvOS)
    
import XCTest
@testable import SwifterSwift
    
final class UINavigationControllerExtensionsTests: XCTestCase {
// This test is commented because we not sure if after the animation it already removed the viewcontroller from the array, it's something internal of UIKit that require a deeper looking.    
//    func testPopViewController() {
//        let navigationController = UINavigationController()
//        let vcToPop = UIViewController()
//        let exp = expectation(description: "popCallback")
//
//        navigationController.pushViewController(vcToPop, animated: false)
//        
//        navigationController.popViewController() {
//            XCTAssert(navigationController.viewControllers.isEmpty)
//            exp.fulfill()
//        }
//        waitForExpectations(timeout: 5, handler: nil)
//    }
    
    func testPushViewController() {
        let navigationController = UINavigationController()
        let vcToPush = UIViewController()
        
        navigationController.pushViewController(vcToPush, animated: false)
        
        let exp = expectation(description: "pushCallback")

        navigationController.pushViewController(vcToPush) {
            XCTAssert(navigationController.viewControllers.count == 1)
            XCTAssertEqual(navigationController.topViewController, vcToPush)
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

    }
    
//    func testMakeTransparent() {
//        let navigationController = UINavigationController()
//        navigationController.makeTransparent(withTint: .red)
//        XCTAssertNotNil(navigationController.navigationBar.backgroundImage(for: .default))
//        XCTAssertNotNil(navigationController.navigationBar.shadowImage)
//        XCTAssert(navigationController.navigationBar.isTranslucent)
//        XCTAssertEqual(navigationController.navigationBar.tintColor, .red)
//		let titleColor = navigationController.navigationBar.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
//        XCTAssertEqual(titleColor, .red)
//    }
}
#endif
