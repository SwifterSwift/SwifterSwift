//
//  CGSizeExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

final class CGSizeExtensionsTests: XCTestCase {

    func testAspectFit() {
        let rect = CGSize(width: 120, height: 80)
        let parentRect  = CGSize(width: 100, height: 50)
        let newRect = rect.aspectFit(to: parentRect)
        XCTAssertEqual(newRect.width, 75)
        XCTAssertEqual(newRect.height, 50)
    }

    func testAspectFill() {
        let rect = CGSize(width: 20, height: 120)
        let parentRect  = CGSize(width: 100, height: 60)
        let newRect = rect.aspectFill(to: parentRect)
        XCTAssertEqual(newRect.width, 100)
        XCTAssertEqual(newRect.height, 60)
    }

    func testAdd() {
        let sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        let result = sizeA + sizeB
        XCTAssertEqual(result.width, 8)
        XCTAssertEqual(result.height, 14)
    }

    func testAddEqual() {
        var sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        sizeA += sizeB
        XCTAssertEqual(sizeA.width, 8)
        XCTAssertEqual(sizeA.height, 14)
    }

    func testSubtract() {
        let sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        let result = sizeA - sizeB
        XCTAssertEqual(result.width, 2)
        XCTAssertEqual(result.height, 6)
    }

    func testSubtractEqual() {
        var sizeA = CGSize(width: 5, height: 10)
        let sizeB = CGSize(width: 3, height: 4)
        sizeA -= sizeB
        XCTAssertEqual(sizeA.width, 2)
        XCTAssertEqual(sizeA.height, 6)
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
