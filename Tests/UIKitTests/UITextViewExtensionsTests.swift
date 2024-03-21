// UITextViewExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UITextViewExtensionsTests: XCTestCase {
    var textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    func testClear() {
        textView.text = "Hello"
        textView.clear()
        XCTAssertEqual(textView.text, "")
        XCTAssertEqual(textView.attributedText?.string, "")
    }

    func testScroll() {
        let text =
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation."
        textView.text = text
        textView.scrollToBottom()
        XCTAssertGreaterThan(textView.contentOffset.y, 0.0)

        textView.scrollToTop()
        XCTAssertNotEqual(textView.contentOffset.y, 0.0)
    }

    #if !targetEnvironment(macCatalyst)
    func testWrapToContent() {
        let text =
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

        // initial setting
        textView.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 20))
        textView.font = UIFont.systemFont(ofSize: 20.0)
        textView.text = text

        // determining the text size
        let constraintRect = CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: textView.font!],
                                            context: nil)

        // before setting wrap, content won't be equal to bounds
        XCTAssertNotEqual(textView.bounds.size, textView.contentSize)

        // calling the wrap extension method
        textView.wrapToContent()

        // Setting the frame:
        // This is important to set the frame after calling the wrapToContent, otherwise
        // boundingRect can give you fractional value, and method call `sizeToFit` inside the
        // wrapToContent would change to the fractional value instead of the ceil value.
        textView.bounds.size = CGSize(width: 100, height: ceil(boundingBox.height))

        // after setting wrap, content size will be equal to bounds
        XCTAssertEqual(textView.bounds.size, textView.contentSize)
    }
    #endif
}

#endif
