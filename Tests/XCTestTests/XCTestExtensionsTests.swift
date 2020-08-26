// XCTestExtensionsTests.swift - Copyright 2020 SwifterSwift

@testable import SwifterSwift
import XCTest

final class XCTestExtensionsTests: XCTestCase {
    #if canImport(AppKit) || canImport(UIKit)
    func testAssertEqualColorsWithAccuracy() {
        XCTAssertEqual(.blue, .blue, accuracy: 0)

        let accuracy = CGFloat(0.1)
        XCTAssertEqual(Color(red: 0, green: 0, blue: 0, alpha: 0),
                       Color(red: accuracy, green: 0, blue: 0, alpha: 0),
                       accuracy: accuracy)
        XCTAssertEqual(Color(red: 0, green: 0, blue: 0, alpha: 0),
                       Color(red: 0, green: accuracy, blue: 0, alpha: 0),
                       accuracy: accuracy)
        XCTAssertEqual(Color(red: 0, green: 0, blue: 0, alpha: 0),
                       Color(red: 0, green: 0, blue: accuracy, alpha: 0),
                       accuracy: accuracy)
        XCTAssertEqual(Color(red: 0, green: 0, blue: 0, alpha: 0),
                       Color(red: 0, green: 0, blue: 0, alpha: accuracy),
                       accuracy: accuracy)
    }
    #endif
}
