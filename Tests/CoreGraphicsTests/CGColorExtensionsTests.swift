//
//  CGColorExtensionsTests.swift
//  SwifterSwift-iOS
//
//  Created by Ryan Batchelder on 10/8/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

final class CGColorExtensionsTests: XCTestCase {

    #if !os(macOS)
    func testUIColor() {
        let red = UIColor.red
        let cgRed = red.cgColor
        XCTAssertEqual(cgRed.uiColor, red)
    }
    #endif

    #if os(macOS)
    func testNSColor() {
        let red = NSColor.red
        let cgRed = red.cgColor
        XCTAssertEqual(cgRed.nsColor, red)
    }
    #endif

}

#endif
