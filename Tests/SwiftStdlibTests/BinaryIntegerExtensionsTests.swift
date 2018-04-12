//
//  BinaryIntegerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 11/04/2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class BinaryIntegerExtensionsTests: XCTestCase {

    func testRandomInts() {
        var values = Set<Int>()
        for _ in 0..<10000 {
            let random = Int.random(lowerBound: -50, upperBound: 50)
            XCTAssert(random >= -50 && random < 50)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 100)
    }

    func testRandomUInts() {
        var values = Set<UInt>()
        for _ in 0..<10000 {
            let random = UInt.random(upperBound: 100)
            XCTAssert(random >= 0 && random < 100)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 100)
    }

    func testMinInt64s() {
        var values = Set<Int64>()
        for _ in 0..<10000 {
            let min = Int64.min
            let max = min + 100
            let random = Int64.random(lowerBound: min, upperBound: max)
            XCTAssert(random >= min && random < max)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 100)
    }

    func testMaxInt64s() {
        var values = Set<Int64>()
        for _ in 0..<10000 {
            let max = Int64.max
            let min = max - 100
            let random = Int64.random(lowerBound: min, upperBound: max)
            XCTAssert(random >= min && random < max)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 100)
    }

    func testMaxUInt32s() {
        var values = Set<UInt32>()
        for _ in 0..<10000 {
            let max = UInt32.max
            let min = max - 100
            let random = UInt32.random(lowerBound: min, upperBound: max)
            XCTAssert(random >= min && random < max)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 100)
    }

}
