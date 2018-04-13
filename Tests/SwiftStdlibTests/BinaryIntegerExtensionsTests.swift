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

    let testRuns = 10000

    // MARK: Test helpers

    func runBinaryIntegers<B: BinaryInteger>(lowerBound: B, upperBound: B) {
        var values = Set<B>(minimumCapacity: testRuns)
        for _ in 0..<testRuns {
            let random = B.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertEqual(B(values.count), upperBound - lowerBound)
    }

    // MARK: Test methods

    func testRandomInts() {
        runBinaryIntegers(lowerBound: -50, upperBound: 50)
    }

}
