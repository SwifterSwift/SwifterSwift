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

    func testRequiredHeight() {
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

    @available(iOS 10, *)
    func testSizeThatFitsAttributedString() {

        // Empty attributed string

        let zeroSize = UILabel.size(thatFitsAttributedString: NSAttributedString.init(), withConstraints: CGSize(width: 10, height: CGFloat.greatestFiniteMagnitude))

        XCTAssertTrue(CGSize.zero.equalTo(zeroSize), "empty string should size to zero")

        // Single line attributed string

        let string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."

        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16) ]

        let attributedString = NSAttributedString(string: string, attributes: attributes)

        let label = UILabel()

        label.attributedText = attributedString

        let singleLineSize = UILabel.size(thatFitsAttributedString: attributedString, withConstraints: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))

        guard let font = attributedString.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil) as? UIFont else {
            XCTFail("Unable to find font in attributed string")
            return
        }

        XCTAssertLessThan(singleLineSize.height, font.pointSize * 2, "Label should size to less than two lines")

        // Multi line attributed string

        let multipleLineSize = UILabel.size(thatFitsAttributedString: attributedString, withConstraints: CGSize(width: 90, height: CGFloat.greatestFiniteMagnitude))

        XCTAssertGreaterThan(multipleLineSize.height, font.pointSize, "Text should size to more than one line")

    }
}

#endif
