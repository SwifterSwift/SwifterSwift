//
//  BinaryFloatingPointExtensionsTests.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 11/04/2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class BinaryFloatingPointExtensionsTests: XCTestCase {

    let testRuns = 10000

    func testRandomDoubles() {
        var values = Set<Double>()
        for _ in 0..<10000 {
            let random = Double.random(lowerBound: -1, upperBound: 1)
            XCTAssert(random >= -1 && random <= 1)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 10000)
    }

    func testRandomFloat80s() {
        var values = Set<Float80>()
        for _ in 0..<10000 {
            let random = Float80.random(lowerBound: -1, upperBound: 1)
            XCTAssert(random >= -1 && random <= 1)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 10000)
    }

    func testLargePositiveDoubles() {
        var values = Set<Double>(minimumCapacity: testRuns)
        let lowerBound = 0.0
        let upperBound = Double.greatestFiniteMagnitude
        for _ in 0..<testRuns {
            let random = Double.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertEqual(values.count, testRuns)
    }

    func testLargeNegativeDoubles() {
        var values = Set<Double>(minimumCapacity: testRuns)
        let lowerBound = -Double.greatestFiniteMagnitude
        let upperBound = 0.0
        for _ in 0..<testRuns {
            let random = Double.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertEqual(values.count, testRuns)
    }

}
