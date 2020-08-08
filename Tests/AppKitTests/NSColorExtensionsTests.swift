// NSColorExtensionsTests.swift - Copyright 2020 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(AppKit)
import AppKit

final class NSColorExtensionsTests: XCTestCase {
    func testInitLightDark() {
        if #available(OSX 10.15, *) {
            let lightModeColor = NSColor.red
            let darkModeColor = NSColor.blue
            let color = NSColor(light: lightModeColor, dark: darkModeColor)

            let view = NSView()

            NSAppearance.current = NSAppearance(named: .aqua)
            view.backgroundColor = color
            XCTAssertEqual(view.backgroundColor, lightModeColor)

            NSAppearance.current = NSAppearance(named: .darkAqua)
            view.backgroundColor = color
            XCTAssertEqual(view.backgroundColor, darkModeColor)
        }
    }
}

#endif
