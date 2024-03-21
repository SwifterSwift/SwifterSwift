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
}

#endif
