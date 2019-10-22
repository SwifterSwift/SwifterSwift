//
//  UIColorExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Haertwig on 10/06/19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit)
import UIKit

final class UIColorExtensionsTests: XCTestCase {

    #if !os(watchOS)
    @available(iOS 13.0, tvOS 13.0, *)
    func testInitLightDark() {
        let lightModeColor = UIColor.red
        let darkModeColor = UIColor.blue
        let color = UIColor(light: lightModeColor, dark: darkModeColor)
        XCTAssertEqual(color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light)), lightModeColor)
        XCTAssertEqual(color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark)), darkModeColor)
    }
    #endif

}

#endif
