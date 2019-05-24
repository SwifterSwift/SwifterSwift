//
//  UIColorExtentionTest.swift
//  SwifterSwift
//
//  Created by freedom on 5/24/19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift
final class UIColorExtensionTest: XCTestCase {
    func testRGB() {
        let color = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        let viewController = UIViewController()
        viewController.view.backgroundColor = color
    }
}
