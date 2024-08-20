// UIColorExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit)
import UIKit

final class UIColorExtensionsTests: XCTestCase {
    #if !os(watchOS)
    func testInitLightDark() {
        let lightModeColor = UIColor.red
        let darkModeColor = UIColor.blue
        let color = UIColor(light: lightModeColor, dark: darkModeColor)

        if #available(iOS 13.0, tvOS 13.0, *) {
            XCTAssertEqual(color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light)), lightModeColor)
            XCTAssertEqual(color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark)), darkModeColor)
        } else {
            XCTAssertEqual(color, lightModeColor)
        }
    }
    #endif

    func testShouldMakeSureThatValidHexColorStringWithHashIsValidColor() throws {
        let color = try UIColor(hex: "#FF5733")
        XCTAssertEqual(color, UIColor(red: 1.0, green: 0.341, blue: 0.2, alpha: 1.0))
    }

    func testShouldMakeSureThatValidHexColorStringWithoutHashIsValidColor() throws {
        let color = try UIColor(hex: "FF5733")
        XCTAssertEqual(color, UIColor(red: 1.0, green: 0.341, blue: 0.2, alpha: 1.0))
    }

    func testShouldMakeSureThatTooShortHexColorStringIsInvalidColor() {
        XCTAssertThrowsError(try UIColor(hex: "FFF")) { error in
            XCTAssertEqual(error as? ColorError, ColorError.invalidHexLength)
        }
    }

    func testShouldMakeSureThatTooLongHexColorStringIsInvalidColor() {
        XCTAssertThrowsError(try UIColor(hex: "FF5733FF")) { error in
            XCTAssertEqual(error as? ColorError, ColorError.invalidHexLength)
        }
    }

    func testShouldMakeSureThatNonValidFormatHexColorStringIsInvalidColor() {
        XCTAssertThrowsError(try UIColor(hex: "ZZZZZZ")) { error in
            XCTAssertEqual(error as? ColorError, ColorError.invalidHexFormat)
        }
    }
}

#endif
