//
//  NSViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 3/3/17.
//  Copyright © 2017 SwifterSwift
//

#if os(macOS)

import XCTest
@testable import SwifterSwift

final class NSViewExtensionsTests: XCTestCase {

    func testBorderColor() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        view.borderColor = nil
        XCTAssertNil(view.layer?.borderColor)

        view.borderColor = NSColor.red
        XCTAssertNotNil(view.layer?.borderColor)
        XCTAssertEqual(view.borderColor, NSColor.red)
        XCTAssertEqual(view.layer?.borderColor?.nsColor, NSColor.red)
    }

    func testBorderWidth() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        view.borderWidth = 0
        XCTAssertEqual(view.layer?.borderWidth, 0)

        view.borderWidth = 5
        XCTAssertEqual(view.borderWidth, 5)
    }

    func testCornerRadius() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        XCTAssertNil(view.layer?.cornerRadius)

        view.cornerRadius = 50
        XCTAssertEqual(view.cornerRadius, 50)
    }

    func testHeight() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        XCTAssertEqual(view.height, 100)
        view.height = 150
        XCTAssertEqual(view.frame.size.height, 150)
    }

    func testShadowColor() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        view.layer?.shadowColor = nil
        XCTAssertNil(view.shadowColor)
        view.shadowColor = NSColor.orange
        XCTAssertNotNil(view.layer?.shadowColor)
        XCTAssertEqual(view.layer?.shadowColor?.nsColor, NSColor.orange)
    }

    func testShadowOffset() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        view.layer?.shadowOffset = CGSize.zero
        XCTAssertEqual(view.shadowOffset, CGSize.zero)
        let size = CGSize(width: 5, height: 5)
        view.shadowOffset = size
        XCTAssertEqual(view.layer?.shadowOffset, size)
    }

    func testShadowOpacity() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        view.layer?.shadowOpacity = 0
        XCTAssertEqual(view.shadowOpacity, 0)
        view.shadowOpacity = 0.5
        XCTAssertEqual(view.layer?.shadowOpacity, 0.5)
    }

    func testShadowRadius() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        view.layer?.shadowRadius = 0
        XCTAssertEqual(view.shadowRadius, 0)
        view.shadowRadius = 0.5
        XCTAssertEqual(view.layer?.shadowRadius, 0.5)
    }

    func testSize() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        XCTAssertEqual(view.size, view.frame.size)

        view.size = CGSize(width: 50, height: 50)
        XCTAssertEqual(view.frame.size.width, 50)
        XCTAssertEqual(view.frame.size.height, 50)
    }

    func testWidth() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        XCTAssertEqual(view.width, 100)
        view.width = 150
        XCTAssertEqual(view.frame.size.width, 150)
    }

    func testAddSubviews() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        XCTAssertEqual(view.subviews.count, 0)

        view.addSubviews([NSView(), NSView()])
        XCTAssertEqual(view.subviews.count, 2)
    }

    func testRemoveSubviews() {
        let view = NSView()
        view.addSubviews([NSView(), NSView()])
        view.removeSubviews()
        XCTAssertEqual(view.subviews.count, 0)
    }

}

#endif
