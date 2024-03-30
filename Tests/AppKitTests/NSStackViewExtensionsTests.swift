// NSStackViewExtensionsTests.swift - Copyright 2024 SwifterSwift

#if os(macOS)

@testable import SwifterSwift
import XCTest

final class NSStackViewExtensionsTests: XCTestCase {
    func testAddArrangedSubviews() {
        let view1 = NSView()
        let view2 = NSView()
        let stack = NSStackView()
        stack.addArrangedSubviews([view1, view2])
        XCTAssertEqual(stack.arrangedSubviews.count, 2)
    }

    func testRemoveArrangedSubviews() {
        let view1 = NSView()
        let view2 = NSView()
        let stack = NSStackView()
        stack.addArrangedSubview(view1)
        stack.addArrangedSubview(view2)
        stack.removeArrangedSubviews()
        XCTAssert(stack.arrangedSubviews.isEmpty)
    }
}

#endif
