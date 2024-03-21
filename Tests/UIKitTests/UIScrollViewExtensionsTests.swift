// UIScrollViewExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UIScrollViewExtensionsTest: XCTestCase {
    let scroll = UIScrollView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

    override func setUp() {
        super.setUp()

        scroll.contentSize = CGSize(width: 500, height: 500)
        scroll.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    }

    func testSnapshot() {
        let snapshot = scroll.snapshot
        XCTAssertNotNil(snapshot)
        let view = UIScrollView()
        XCTAssertNil(view.snapshot)
    }

    func testVisibleRect() {
        XCTAssertEqual(scroll.visibleRect, CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

        scroll.contentOffset = CGPoint(x: 50, y: 50)
        XCTAssertEqual(scroll.visibleRect, CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 100, height: 100)))

        let offset = CGPoint(x: 490, y: 480)
        scroll.contentOffset = offset
        XCTAssertEqual(scroll.visibleRect, CGRect(origin: offset, size: CGSize(width: 10, height: 20)))
    }

    func testScrollToTop() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.scrollToTop(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 50, y: -10))
    }

    func testScrollToLeft() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.scrollToLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: -20, y: 50))
    }

    func testScrollToBottom() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.scrollToBottom(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 50, y: scroll.contentSize.height - scroll.bounds.height + 30))
    }

    func testScrollToRight() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.scrollToRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: scroll.contentSize.width - scroll.bounds.height + 40, y: 50))
    }

    func testScrollUp() {
        let offset = CGPoint(x: 50, y: 250)
        scroll.contentOffset = offset
        scroll.scrollUp(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 150))
        scroll.scrollUp(animated: false)
        scroll.scrollUp(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: -10))

        let scrollView = UIScrollView()
        scrollView.scrollUp(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)

        #if !os(tvOS)
        scroll.isPagingEnabled = true
        scroll.contentOffset = offset
        scroll.scrollUp(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 90))

        scrollView.isPagingEnabled = true
        scrollView.scrollUp(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)
        #endif
    }

    func testScrollLeft() {
        let offset = CGPoint(x: 250, y: 50)
        scroll.contentOffset = offset
        scroll.scrollLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 150, y: offset.y))
        scroll.scrollLeft(animated: false)
        scroll.scrollLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: -20, y: offset.y))

        let scrollView = UIScrollView()
        scrollView.scrollLeft(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)

        #if !os(tvOS)
        scroll.isPagingEnabled = true
        scroll.contentOffset = offset
        scroll.scrollLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 80, y: offset.y))

        scrollView.isPagingEnabled = true
        scrollView.scrollLeft(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)
        #endif
    }

    func testScrollDown() {
        let offset = CGPoint(x: 50, y: 250)
        scroll.contentOffset = offset
        scroll.scrollDown(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 350))
        scroll.scrollDown(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 430))

        let scrollView = UIScrollView()
        scrollView.scrollDown(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)

        #if !os(tvOS)
        scroll.isPagingEnabled = true
        scroll.contentOffset = offset
        scroll.scrollDown(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 290))

        scrollView.isPagingEnabled = true
        scrollView.scrollDown(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)
        #endif
    }

    func testScrollRight() {
        let offset = CGPoint(x: 250, y: 50)
        scroll.contentOffset = offset
        scroll.scrollRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 350, y: offset.y))
        scroll.scrollRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 440, y: offset.y))

        let scrollView = UIScrollView()
        scrollView.scrollRight(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)

        #if !os(tvOS)
        scroll.isPagingEnabled = true
        scroll.contentOffset = offset
        scroll.scrollRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 280, y: offset.y))

        scrollView.isPagingEnabled = true
        scrollView.scrollRight(animated: false)
        XCTAssertEqual(scrollView.contentOffset, .zero)
        #endif
    }
}

#endif
