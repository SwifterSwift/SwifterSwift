// CGSizeExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(CoreGraphics)
import CoreGraphics

final class CGSizeExtensionsTests: XCTestCase {
    func testAspectFit() {
        let rect = CGSize(width: 120, height: 80)
        let parentRect = CGSize(width: 100, height: 50)
        let newRect = rect.aspectFit(to: parentRect)
        XCTAssertEqual(newRect.width, 75)
        XCTAssertEqual(newRect.height, 50)
    }

    func testAspectFill() {
        let rect = CGSize(width: 20, height: 120)
        let parentRect = CGSize(width: 100, height: 60)
        let newRect = rect.aspectFill(to: parentRect)
        XCTAssertEqual(newRect.width, 100)
        XCTAssertEqual(newRect.height, 60)
    }

    func testAspectRatio() {
        let size1 = CGSize(width: 10, height: 0)
        XCTAssertEqual(size1.aspectRatio, 0)

        let size2 = CGSize(width: 20, height: 10)
        XCTAssertEqual(size2.aspectRatio, 2)
    }

    func testMaxDimension() {
        let size1 = CGSize(width: 10, height: 0)
        XCTAssertEqual(size1.maxDimension, 10)

        let size2 = CGSize(width: 20, height: 40)
        XCTAssertEqual(size2.maxDimension, 40)
    }

    func testMinDimension() {
        let size1 = CGSize(width: 10, height: 0)
        XCTAssertEqual(size1.minDimension, 0)

        let size2 = CGSize(width: 20, height: 40)
        XCTAssertEqual(size2.minDimension, 20)
    }

    func testAdd() {
        let sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        let result = sizeA + sizeB
        XCTAssertEqual(result.width, 8)
        XCTAssertEqual(result.height, 14)
    }

    func testAddTuple() {
        let size = CGSize(width: 5, height: 10)
        let result = size + (width: 4, height: 4)
        XCTAssertEqual(result.width, 9)
        XCTAssertEqual(result.height, 14)
    }

    func testAddEqual() {
        var sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        sizeA += sizeB
        XCTAssertEqual(sizeA.width, 8)
        XCTAssertEqual(sizeA.height, 14)
    }

    func testAddEqualTuple() {
        var size = CGSize(width: 5, height: 10)
        size += (3, 0)
        XCTAssertEqual(size.width, 8)
        XCTAssertEqual(size.height, 10)
    }

    func testSubtract() {
        let sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        let result = sizeA - sizeB
        XCTAssertEqual(result.width, 2)
        XCTAssertEqual(result.height, 6)
    }

    func testSubtractTuple() {
        let size = CGSize(width: 5, height: 10)
        let result = size - (2, 3)
        XCTAssertEqual(result.width, 3)
        XCTAssertEqual(result.height, 7)
    }

    func testSubtractEqual() {
        var sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        sizeA -= sizeB
        XCTAssertEqual(sizeA.width, 2)
        XCTAssertEqual(sizeA.height, 6)
    }

    func testSubtractEqualTuple() {
        var size = CGSize(width: 5, height: 10)
        size -= (1, 4)
        XCTAssertEqual(size.width, 4)
        XCTAssertEqual(size.height, 6)
    }

    func testMultiplyCGSize() {
        let sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        let result = sizeA * sizeB
        XCTAssertEqual(result.width, 15)
        XCTAssertEqual(result.height, 40)
    }

    func testMultiplyScalarRight() {
        let sizeA = CGSize(width: 5, height: 10)
        let result = sizeA * 4
        XCTAssertEqual(result.width, 20)
        XCTAssertEqual(result.height, 40)
    }

    func testMultiplyScalarLeft() {
        let sizeA = CGSize(width: 5, height: 10)
        let result = 5 * sizeA
        XCTAssertEqual(result.width, 25)
        XCTAssertEqual(result.height, 50)
    }

    func testMultiplyEqualCGSize() {
        var sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        sizeA *= sizeB
        XCTAssertEqual(sizeA.width, 15)
        XCTAssertEqual(sizeA.height, 40)
    }

    func testMultiplyEqualScalar() {
        var sizeA = CGSize(width: 5, height: 0)
        sizeA *= 4
        XCTAssertEqual(sizeA.width, 20)
        XCTAssertEqual(sizeA.height, 0)
    }
}

#endif
