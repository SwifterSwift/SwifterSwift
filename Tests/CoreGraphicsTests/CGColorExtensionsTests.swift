// CGColorExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(CoreGraphics)
import CoreGraphics

#if os(macOS)
import AppKit
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
