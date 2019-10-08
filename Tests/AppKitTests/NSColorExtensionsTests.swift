//
//  UIColorExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Haertwig on 10/08/19.
//  Copyright © 2019 SwifterSwift
//

import Foundation

import XCTest
@testable import SwifterSwift

final class NSColorExtensionsTests: XCTestCase {
    
    @available(OSX 10.15, *)
    func testInitLightDark() {
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
