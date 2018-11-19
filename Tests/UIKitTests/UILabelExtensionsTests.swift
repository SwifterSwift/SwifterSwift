//
//  UILabelExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 3/26/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UILabelExtensionsTests: XCTestCase {

    func testInitWithText() {
        let label = UILabel(text: "Hello world")
        XCTAssertEqual(label.text, "Hello world")
    }

    func testInitWithTextAndStyle() {
        let style = UIFont.TextStyle.headline
        let text = "Hello world"
        let label = UILabel(text: text, style: style)

        let preferredFont = UIFont.preferredFont(forTextStyle: style)
        XCTAssertEqual(label.text, text)
        XCTAssertEqual(label.font, preferredFont)
    }

    func testrequiredHeight() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let label = UILabel(frame: frame)
        label.text = "Hello world"

        #if os(iOS)
        XCTAssert(label.requiredHeight > 20)
        XCTAssert(label.requiredHeight < 25)
        #else
        XCTAssert(label.requiredHeight > 0)
        XCTAssert(label.requiredHeight < 100)
        #endif
    }

}
#endif
