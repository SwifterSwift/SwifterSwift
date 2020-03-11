//
//  CGRectExtensionsTests.swift
//  SwifterSwift
//
//  Created by Chen Qizhi on 2020/03/11.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

final class CGRectExtensionsTests: XCTestCase {

    func testCenter() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        let center = rect.center
        XCTAssertEqual(center.x, 25)
        XCTAssertEqual(center.y, 40)
    }

    func testInitWithCenterAndSize() {
        let rect = CGRect(center: CGPoint(x: 10, y: 20), size: CGSize(width: 30, height: 40))
        XCTAssertEqual(rect.midX, 10)
        XCTAssertEqual(rect.midY, 20)
        XCTAssertEqual(rect.width, 30)
        XCTAssertEqual(rect.height, 40)
    }

    func testResizingWithAnchor() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        var resizingRect: CGRect
        let newSize = CGSize(width: 40, height: 50)

        // By anchor top left
        resizingRect = rect.resizing(to: newSize)
        let rect2 = rect.resizing(to: newSize, anchor: .topLeft)
        XCTAssertEqual(resizingRect, rect2)
        XCTAssertEqual(rect.origin, resizingRect.origin)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor top right
        resizingRect = rect.resizing(to: newSize, anchor: .topRight)
        XCTAssertEqual(rect.maxX, resizingRect.maxX)
        XCTAssertEqual(rect.minY, resizingRect.minY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor bottom left
        resizingRect = rect.resizing(to: newSize, anchor: .bottomLeft)
        XCTAssertEqual(rect.minX, resizingRect.minX)
        XCTAssertEqual(rect.maxY, resizingRect.maxY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor bottom right
        resizingRect = rect.resizing(to: newSize, anchor: .bottomRight)
        XCTAssertEqual(rect.maxX, resizingRect.maxX)
        XCTAssertEqual(rect.maxY, resizingRect.maxY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor center
        resizingRect = rect.resizing(to: newSize, anchor: .center)
        XCTAssertEqual(rect.midX, resizingRect.midX)
        XCTAssertEqual(rect.midY, resizingRect.midY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)
    }

}

#endif
