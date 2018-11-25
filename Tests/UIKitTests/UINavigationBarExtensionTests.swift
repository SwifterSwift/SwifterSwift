//
//  UINavigationBarExtensionTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/16/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UINavigationBarExtensionsTests: XCTestCase {

    func testSetTitleFont() {
        let navigationBar = UINavigationBar()
        let helveticaFont = UIFont(name: "HelveticaNeue", size: 14)!
        navigationBar.setTitleFont(helveticaFont, color: .green)
        let color = navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor
        XCTAssertEqual(color, .green)
        let font = navigationBar.titleTextAttributes?[NSAttributedString.Key.font] as? UIFont
        XCTAssertEqual(font, helveticaFont)

        navigationBar.setTitleFont(helveticaFont)
        let defaultColor = navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor
        XCTAssertEqual(defaultColor, .black)
    }

    func testMakeTransparent() {
        let navigationBar = UINavigationBar()
        navigationBar.makeTransparent(withTint: .red)
        XCTAssertNotNil(navigationBar.backgroundImage(for: .default))
        XCTAssertNotNil(navigationBar.shadowImage)
        XCTAssert(navigationBar.isTranslucent)
        XCTAssertEqual(navigationBar.tintColor, .red)
        let color = navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor
        XCTAssertEqual(color, .red)

        navigationBar.makeTransparent()
        let defaultColor = navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor
        XCTAssertEqual(defaultColor, .white)
    }

    func testSetColors() {
        let navigationBar = UINavigationBar()
        navigationBar.setColors(background: .blue, text: .green)
        XCTAssertFalse(navigationBar.isTranslucent)
        XCTAssertEqual(navigationBar.backgroundColor, .blue)
        XCTAssertEqual(navigationBar.barTintColor, .blue)
        XCTAssertNotNil(navigationBar.backgroundImage(for: .default))
        XCTAssertEqual(navigationBar.tintColor, .green)
        let color = navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor
        XCTAssertEqual(color, .green)
    }

}
#endif
