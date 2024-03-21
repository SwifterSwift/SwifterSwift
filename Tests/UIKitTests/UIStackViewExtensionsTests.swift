// UIStackViewExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UIStackViewExtensionsTest: XCTestCase {
    // MARK: - Initializers

    func testInitWithViews() {
        let view1 = UIView()
        let view2 = UIView()
        var stack = UIStackView(arrangedSubviews: [view1, view2], axis: .horizontal)

        XCTAssertEqual(stack.arrangedSubviews.count, 2)
        XCTAssert(stack.arrangedSubviews[0] === view1)
        XCTAssert(stack.arrangedSubviews[1] === view2)

        XCTAssertEqual(stack.axis, .horizontal)
        XCTAssertEqual(stack.alignment, .fill)
        XCTAssertEqual(stack.distribution, .fill)
        XCTAssertEqual(stack.spacing, 0.0)

        XCTAssertEqual(UIStackView(arrangedSubviews: [view1, view2], axis: .vertical).axis, .vertical)
        XCTAssertEqual(UIStackView(arrangedSubviews: [view1, view2], axis: .vertical, alignment: .center).alignment,
                       .center)

        XCTAssertEqual(UIStackView(arrangedSubviews: [view1, view2], axis: .vertical,
                                   distribution: .fillEqually).distribution, .fillEqually)

        XCTAssertEqual(UIStackView(arrangedSubviews: [view1, view2], axis: .vertical, spacing: 16.0).spacing, 16.0)

        stack = UIStackView(arrangedSubviews: [view1, view2], axis: .vertical, spacing: 16.0,
                            alignment: .center, distribution: .fillEqually)

        XCTAssertEqual(stack.axis, .vertical)
        XCTAssertEqual(stack.alignment, .center)
        XCTAssertEqual(stack.distribution, .fillEqually)
        XCTAssertEqual(stack.spacing, 16.0)
    }

    func testAddArrangedSubviews() {
        let view1 = UIView()
        let view2 = UIView()
        let stack = UIStackView()
        stack.addArrangedSubviews([view1, view2])
        XCTAssertEqual(stack.arrangedSubviews.count, 2)
    }

    func testRemoveArrangedSubviews() {
        let view1 = UIView()
        let view2 = UIView()
        let stack = UIStackView()
        stack.addArrangedSubview(view1)
        stack.addArrangedSubview(view2)
        stack.removeArrangedSubviews()
        XCTAssert(stack.arrangedSubviews.isEmpty)
    }

    func testSwap() {
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()
        let view5 = UIView()
        let view6 = UIView()
        let stack = UIStackView(arrangedSubviews: [view1, view2, view3, view4, view5])
        stack.swap(view1, view3)
        stack.swap(view2, view5)
        XCTAssertEqual(stack.arrangedSubviews.firstIndex(of: view1), 2)
        XCTAssertEqual(stack.arrangedSubviews.firstIndex(of: view2), 4)
        XCTAssertEqual(stack.arrangedSubviews.firstIndex(of: view3), 0)
        XCTAssertEqual(stack.arrangedSubviews.firstIndex(of: view4), 3)
        XCTAssertEqual(stack.arrangedSubviews.firstIndex(of: view5), 1)

        stack.swap(view5, view6)
        XCTAssertEqual(stack.arrangedSubviews.firstIndex(of: view5), 1)
        XCTAssertNil(stack.arrangedSubviews.firstIndex(of: view6))

        let swapExpectation = expectation(description: "views swapped")
        stack.swap(view4, view3, animated: true, duration: 0.5) { _ in
            swapExpectation.fulfill()
        }
        XCTAssertEqual(stack.arrangedSubviews.firstIndex(of: view3), 3)
        XCTAssertEqual(stack.arrangedSubviews.firstIndex(of: view4), 0)
        waitForExpectations(timeout: 1.0)
    }

    func testBackgroundViewColor() {
        let stack = UIStackView()
        stack.backgroundViewColor = nil
        XCTAssertNil(stack.backgroundViewColor)

        stack.backgroundViewColor = .red
        XCTAssertNotNil(stack.backgroundViewColor)

        XCTAssertEqual(stack.backgroundViewColor!, UIColor.red)

        if #available(iOS 14, *) {
            XCTAssertEqual(stack.backgroundColor!, UIColor.red)
        }
    }
}

#endif
