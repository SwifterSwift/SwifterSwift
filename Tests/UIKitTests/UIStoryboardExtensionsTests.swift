//
//  UIStoryboardExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/25/17.
//  Copyright © 2017 SwifterSwift
//

#if os(iOS)

import XCTest
@testable import SwifterSwift
    
final class UIStoryboardExtensionsTests: XCTestCase {
    
    func testInstantiateViewController() {
        let storyboard = UIStoryboard(name: "TestStoryboard", bundle: Bundle(for: UIStoryboardExtensionsTests.self))
        let viewController = storyboard.instantiateViewController(withClass: UIViewController.self)
        XCTAssertNotNil(viewController)
    }
}
#endif
