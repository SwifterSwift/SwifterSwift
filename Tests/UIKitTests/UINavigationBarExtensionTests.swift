// UINavigationBarExtensionTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UINavigationBarExtensionsTests: XCTestCase {
    func testSetTitleFont() {
        let navigationBar = UINavigationBar()
        let helveticaFont = UIFont(name: "HelveticaNeue", size: 14)!
        navigationBar.setTitleFont(helveticaFont, color: .green)
        if #available(iOS 13.0, tvOS 13.0, *) {
            let color = navigationBar.standardAppearance
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            XCTAssertEqual(color, .green)

            let font = navigationBar.standardAppearance.titleTextAttributes[NSAttributedString.Key.font] as? UIFont
            XCTAssertEqual(font, helveticaFont)

            navigationBar.setTitleFont(helveticaFont)
            let defaultColor = navigationBar.standardAppearance
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            XCTAssertEqual(defaultColor, .black)
        } else {
            let color = navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor
            XCTAssertEqual(color, .green)
            let font = navigationBar.titleTextAttributes?[NSAttributedString.Key.font] as? UIFont
            XCTAssertEqual(font, helveticaFont)

            navigationBar.setTitleFont(helveticaFont)
            let defaultColor = navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor
            XCTAssertEqual(defaultColor, .black)
        }
    }

    func testMakeTransparent() {
        let navigationBar = UINavigationBar()
        navigationBar.makeTransparent(withTint: .red)
        let legacyTests = {
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
        #if os(tvOS)
        legacyTests()
        #else
        if #available(iOS 13.0, *) {
            XCTAssertEqual(navigationBar.tintColor, .red)

            let standardAppearanceColor = navigationBar.standardAppearance
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            let scrollEdgeAppearanceColor = navigationBar.scrollEdgeAppearance?
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            let compactAppearanceColor = navigationBar.compactAppearance?
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            XCTAssertEqual(standardAppearanceColor, .red)
            XCTAssertEqual(scrollEdgeAppearanceColor, .red)
            XCTAssertEqual(compactAppearanceColor, .red)

            navigationBar.makeTransparent()
            let standardAppearanceDefaultColor = navigationBar.standardAppearance
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            let scrollEdgeAppearanceDefaultColor = navigationBar.scrollEdgeAppearance?
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            let compactAppearanceDefaultColor = navigationBar.compactAppearance?
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            XCTAssertEqual(standardAppearanceDefaultColor, .white)
            XCTAssertEqual(scrollEdgeAppearanceDefaultColor, .white)
            XCTAssertEqual(compactAppearanceDefaultColor, .white)
        } else {
            legacyTests()
        }
        #endif
    }

    func testSetColors() {
        let navigationBar = UINavigationBar()
        navigationBar.setColors(background: .blue, text: .green)
        let legacyTests = {
            XCTAssertFalse(navigationBar.isTranslucent)
            XCTAssertEqual(navigationBar.backgroundColor, .blue)
            XCTAssertEqual(navigationBar.barTintColor, .blue)
            XCTAssertNotNil(navigationBar.backgroundImage(for: .default))
            XCTAssertEqual(navigationBar.tintColor, .green)
            let color = navigationBar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor
            XCTAssertEqual(color, .green)
        }
        #if os(tvOS)
        legacyTests()
        #else
        if #available(iOS 13.0, *) {
            XCTAssertEqual(navigationBar.tintColor, .green)

            let standardAppearanceBackgroundColor = navigationBar.standardAppearance.backgroundColor
            let scrollEdgeAppearanceBackgroundColor = navigationBar.scrollEdgeAppearance?.backgroundColor
            let compactAppearanceBackgroundColor = navigationBar.compactAppearance?.backgroundColor
            XCTAssertEqual(standardAppearanceBackgroundColor, .blue)
            XCTAssertEqual(scrollEdgeAppearanceBackgroundColor, .blue)
            XCTAssertEqual(compactAppearanceBackgroundColor, .blue)

            let standardAppearanceTextColor = navigationBar.standardAppearance
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            let scrollEdgeAppearanceTextColor = navigationBar.scrollEdgeAppearance?
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            let compactAppearanceTextColor = navigationBar.compactAppearance?
                .titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
            XCTAssertEqual(standardAppearanceTextColor, .green)
            XCTAssertEqual(scrollEdgeAppearanceTextColor, .green)
            XCTAssertEqual(compactAppearanceTextColor, .green)
        } else {
            legacyTests()
        }
        #endif
    }
}

#endif
