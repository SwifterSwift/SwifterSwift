// CGRectExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(CoreGraphics)
import CoreGraphics

final class CGRectExtensionsTests: XCTestCase {
    func testCenterGet() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        XCTAssertEqual(rect.center, CGPointMake(25, 40))
    }

    func testCenterSet() {
        var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        rect.center = CGPoint(x: 50, y: 60)
        XCTAssertEqual(rect, CGRect(x: 35, y: 40, width: 30, height: 40))
        XCTAssertEqual(rect.center, CGPoint(x: 50, y: 60))
    }

    func testTopLeftGet() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        XCTAssertEqual(rect.topLeft, CGPointMake(10, 20))
    }

    func testTopLeftSet() {
        var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        rect.topLeft = CGPoint(x: 50, y: 60)
        XCTAssertEqual(rect, CGRect(x: 50, y: 60, width: 30, height: 40))
        XCTAssertEqual(rect.topLeft, CGPoint(x: 50, y: 60))
    }

    func testTopCenterGet() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        XCTAssertEqual(rect.topCenter, CGPointMake(25, 20))
    }

    func testTopCenterSet() {
        var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        rect.topCenter = CGPoint(x: 50, y: 60)
        XCTAssertEqual(rect, CGRect(x: 35, y: 60, width: 30, height: 40))
        XCTAssertEqual(rect.topCenter, CGPoint(x: 50, y: 60))
    }

    func testTopRightGet() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        XCTAssertEqual(rect.topRight, CGPointMake(40, 20))
    }

    func testTopRightSet() {
        var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        rect.topRight = CGPoint(x: 50, y: 60)
        XCTAssertEqual(rect, CGRect(x: 20, y: 60, width: 30, height: 40))
        XCTAssertEqual(rect.topRight, CGPoint(x: 50, y: 60))
    }

    func testCenterLeftGet() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        XCTAssertEqual(rect.centerLeft, CGPointMake(10, 40))
    }

    func testCenterLeftSet() {
        var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        rect.centerLeft = CGPoint(x: 50, y: 60)
        XCTAssertEqual(rect, CGRect(x: 50, y: 40, width: 30, height: 40))
        XCTAssertEqual(rect.centerLeft, CGPoint(x: 50, y: 60))
    }

    func testCenterRightGet() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        XCTAssertEqual(rect.centerRight, CGPointMake(40, 40))
    }

    func testCenterRightSet() {
        var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        rect.centerRight = CGPoint(x: 50, y: 60)
        XCTAssertEqual(rect, CGRect(x: 20, y: 40, width: 30, height: 40))
        XCTAssertEqual(rect.centerRight, CGPoint(x: 50, y: 60))
    }

    func testBottomLeftGet() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        XCTAssertEqual(rect.bottomLeft, CGPointMake(10, 60))
    }

    func testBottomLeftSet() {
        var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        rect.bottomLeft = CGPoint(x: 50, y: 60)
        XCTAssertEqual(rect, CGRect(x: 50, y: 20, width: 30, height: 40))
        XCTAssertEqual(rect.bottomLeft, CGPoint(x: 50, y: 60))
    }

    func testBottomCenterGet() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        XCTAssertEqual(rect.bottomCenter, CGPointMake(25, 60))
    }

    func testBottomCenterSet() {
        var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        rect.bottomCenter = CGPoint(x: 50, y: 60)
        XCTAssertEqual(rect, CGRect(x: 35, y: 20, width: 30, height: 40))
        XCTAssertEqual(rect.bottomCenter, CGPoint(x: 50, y: 60))
    }

    func testBottomRightGet() {
        let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        XCTAssertEqual(rect.bottomRight, CGPointMake(40, 60))
    }

    func testBottomRightSet() {
        var rect = CGRect(x: 10, y: 20, width: 30, height: 40)
        rect.bottomRight = CGPoint(x: 50, y: 60)
        XCTAssertEqual(rect, CGRect(x: 20, y: 20, width: 30, height: 40))
        XCTAssertEqual(rect.bottomRight, CGPoint(x: 50, y: 60))
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

        // By anchor center
        resizingRect = rect.resizing(to: newSize, anchor: CGPoint(x: 0.5, y: 0.5))
        let rect2 = rect.resizing(to: newSize)
        XCTAssertEqual(resizingRect, rect2)
        XCTAssertEqual(rect.midX, resizingRect.midX)
        XCTAssertEqual(rect.midY, resizingRect.midY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor top left
        resizingRect = rect.resizing(to: newSize, anchor: .zero)
        XCTAssertEqual(rect.origin, resizingRect.origin)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor top right
        resizingRect = rect.resizing(to: newSize, anchor: CGPoint(x: 1.0, y: 0.0))
        XCTAssertEqual(rect.maxX, resizingRect.maxX)
        XCTAssertEqual(rect.minY, resizingRect.minY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor bottom left
        resizingRect = rect.resizing(to: newSize, anchor: CGPoint(x: 0.0, y: 1.0))
        XCTAssertEqual(rect.minX, resizingRect.minX)
        XCTAssertEqual(rect.maxY, resizingRect.maxY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)

        // By anchor bottom right
        resizingRect = rect.resizing(to: newSize, anchor: CGPoint(x: 1.0, y: 1.0))
        XCTAssertEqual(rect.maxX, resizingRect.maxX)
        XCTAssertEqual(rect.maxY, resizingRect.maxY)
        XCTAssertNotEqual(rect.size, resizingRect.size)
        XCTAssertEqual(newSize, resizingRect.size)
    }
}

#endif
