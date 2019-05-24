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
        let color = UIColor(r: 255, g: 255, b: 255, a: 1)
        let viewController = UIViewController()
        ViewController.view.backgroundColor = color
    }
}
