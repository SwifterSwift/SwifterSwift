//
//  CGColorExtensionsTests.swift
//  SwifterSwift-iOS
//
//  Created by Ryan Batchelder on 10/8/17.
//

import XCTest
#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif
@testable import SwifterSwift

final class CGColorExtensionsTests: XCTestCase {
    #if !os(macOS)
    func testUiColor() {
    let red = UIColor.red
        let cgRed = red.cgColor
        XCTAssertEqual(cgRed.uiColor, red)
    }
    #endif
    
    #if os(macOS)
    func testNsColor() {
        let red = NSColor.red
        let cgRed = red.cgColor
        XCTAssertEqual(cgRed.nsColor, red)
    }
    #endif
}
