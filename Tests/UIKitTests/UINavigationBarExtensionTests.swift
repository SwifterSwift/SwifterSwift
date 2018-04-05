//
//  UINavigationBarExtensionTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/16/17.
//  Copyright © 2017 SwifterSwift
//

#if os(iOS) || os(tvOS)

import XCTest
@testable import SwifterSwift

final class UINavigationBarExtensionsTests: XCTestCase {

	func testSetTitleFont() {
		let navigationBar = UINavigationBar()
		let helveticaFont = UIFont(name: "HelveticaNeue", size: 14)!
		navigationBar.setTitleFont(helveticaFont, color: .green)
		let color = navigationBar.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
		XCTAssertEqual(color, .green)
		let font = navigationBar.titleTextAttributes?[NSAttributedStringKey.font] as? UIFont
		XCTAssertEqual(font, helveticaFont)

		navigationBar.setTitleFont(helveticaFont)
		let defaultColor = navigationBar.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
		XCTAssertEqual(defaultColor, .black)
	}

	func testMakeTransparent() {
		let navigationBar = UINavigationBar()
		navigationBar.makeTransparent(withTint: .red)
		XCTAssertNotNil(navigationBar.backgroundImage(for: .default))
		XCTAssertNotNil(navigationBar.shadowImage)
		XCTAssert(navigationBar.isTranslucent)
		XCTAssertEqual(navigationBar.tintColor, .red)
		let color = navigationBar.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
		XCTAssertEqual(color, .red)

		navigationBar.makeTransparent()
		let defaultColor = navigationBar.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
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
		let color = navigationBar.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
		XCTAssertEqual(color, .green)
	}

}
#endif
