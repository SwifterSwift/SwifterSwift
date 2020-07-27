//
//  UIScrollViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by camila oliveira on 22/04/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UIScrollViewExtensionsTest: XCTestCase {
    let scroll = UIScrollView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

    override func setUp() {
        super.setUp()

        scroll.contentSize = CGSize(width: 500, height: 500)
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
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 50, y: 0))
    }

    func testScrollToLeft() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.scrollToLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 0, y: 50))
    }

    func testScrollToBottom() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.scrollToBottom(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 50, y: scroll.contentSize.height - scroll.bounds.height))
    }

    func testScrollToRight() {
        scroll.contentOffset = CGPoint(x: 50, y: 50)
        scroll.scrollToRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: scroll.contentSize.width - scroll.bounds.height, y: 50))
    }

    func testScrollUp() {
        let offset = CGPoint(x: 50, y: 250)
        scroll.contentOffset = offset
        scroll.scrollUp(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 150))
        scroll.scrollUp(animated: false)
        scroll.scrollUp(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 0))

        scroll.isPagingEnabled = true
        scroll.contentOffset = offset
        scroll.scrollUp(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 100))
    }

    func testScrollLeft() {
        let offset = CGPoint(x: 250, y: 50)
        scroll.contentOffset = offset
        scroll.scrollLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 150, y: offset.y))
        scroll.scrollLeft(animated: false)
        scroll.scrollLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 0, y: offset.y))

        scroll.isPagingEnabled = true
        scroll.contentOffset = offset
        scroll.scrollLeft(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 100, y: offset.y))
    }

    func testScrollDown() {
        let offset = CGPoint(x: 50, y: 250)
        scroll.contentOffset = offset
        scroll.scrollDown(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 350))
        scroll.scrollDown(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 400))

        scroll.isPagingEnabled = true
        scroll.contentOffset = offset
        scroll.scrollDown(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: offset.x, y: 400))
    }

    func testScrollRight() {
        let offset = CGPoint(x: 250, y: 50)
        scroll.contentOffset = offset
        scroll.scrollRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 350, y: offset.y))
        scroll.scrollRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 400, y: offset.y))

        scroll.isPagingEnabled = true
        scroll.contentOffset = offset
        scroll.scrollRight(animated: false)
        XCTAssertEqual(scroll.contentOffset, CGPoint(x: 400, y: offset.y))
    }

}

#endif
