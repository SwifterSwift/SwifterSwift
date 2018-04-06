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

}
#endif
