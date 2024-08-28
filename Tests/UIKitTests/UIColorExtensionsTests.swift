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

    func testShouldMakeSureThatValidHexColorStringWithHashIsValidColor() {
        let color = UIColor(hex: "#FF5733")
        XCTAssertNotNil(color, "Color must not be nil for a valid hex string with a hash.")

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 1.0, accuracy: 0.01, "Red component should be 1.0")
        XCTAssertEqual(green, 0.34, accuracy: 0.01, "Green component should be approximately 0.34")
        XCTAssertEqual(blue, 0.2, accuracy: 0.01, "Blue component should be approximately 0.2")
        XCTAssertEqual(alpha, 1.0, "Alpha component should be 1.0")
    }

    func testShouldMakeSureThatValidHexColorStringWithoutHashIsValidColor() {
        let color = UIColor(hex: "FF5733")
        XCTAssertNotNil(color, "Color must not be nil for a valid hex string.")

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 1.0, accuracy: 0.01, "Red component should be 1.0")
        XCTAssertEqual(green, 0.34, accuracy: 0.01, "Green component should be approximately 0.34")
        XCTAssertEqual(blue, 0.2, accuracy: 0.01, "Blue component should be approximately 0.2")
        XCTAssertEqual(alpha, 1.0, "Alpha component should be 1.0")
    }

    func testShouldMakeSureThatValidHexColorStringWithSpaceIsValidColor() {
        let colorWithWhitespace = UIColor(hex: "  FF5733  ")
        XCTAssertNotNil(colorWithWhitespace, "Color must not be nil for a valid hex string with whitespace around it.")

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        colorWithWhitespace?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 1.0, accuracy: 0.01, "Red component should be 1.0")
        XCTAssertEqual(green, 0.34, accuracy: 0.01, "Green component should be approximately 0.34")
        XCTAssertEqual(blue, 0.2, accuracy: 0.01, "Blue component should be approximately 0.2")
        XCTAssertEqual(alpha, 1.0, "Alpha component should be 1.0")
    }

    func testShouldMakeSureThatTooShortHexColorStringIsInvalidColor() {
        let color = UIColor(hex: "FFF")
        XCTAssertNil(color, "Color must be null for a short length hex string.")
    }

    func testShouldMakeSureThatTooLongHexColorStringIsInvalidColor() {
        let color = UIColor(hex: "FF5733FF")
        XCTAssertNil(color, "Color must be null for a long length hex string.")
    }

    func testShouldMakeSureThatNonValidFormatHexColorStringIsInvalidColor() {
        let color = UIColor(hex: "ZZZZZZ")
        XCTAssertNil(color, "Color must be null for an invalid hex string.")
    }
}

#endif
