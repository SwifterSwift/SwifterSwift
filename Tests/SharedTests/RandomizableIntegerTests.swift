//
//  RandomizableIntegerTests.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 13/04/2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

class IntegerCounterpartsTests: XCTestCase {

    let testRuns = 10000

    // MARK: Test helpers

    func runIntsTest<T: SignedRandomizableInteger>(type: T.Type) {
        var values = Set<T>(minimumCapacity: testRuns)
        let lowerBound: T = -50
        let upperBound: T = 50
        for _ in 0..<testRuns {
            let random = T.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 100)
    }

    func runUIntsTest<T: UnsignedRandomizableInteger>(type: T.Type) {
        var values = Set<T>(minimumCapacity: testRuns)
        let lowerBound: T = 0
        let upperBound: T = 100
        for _ in 0..<testRuns {
            let random = T.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 100)
    }

    // MARK: Test methods

    func testRandomInts() {
        runIntsTest(type: Int.self)
        runIntsTest(type: Int8.self)
        runIntsTest(type: Int16.self)
        runIntsTest(type: Int32.self)
        runIntsTest(type: Int64.self)
    }

    func testRandomUInts() {
        runUIntsTest(type: UInt.self)
        runUIntsTest(type: UInt8.self)
        runUIntsTest(type: UInt16.self)
        runUIntsTest(type: UInt32.self)
        runUIntsTest(type: UInt64.self)
    }

    func testMinInt64s() {
        var values = Set<Int64>(minimumCapacity: testRuns)
        let lowerBound = Int64.min
        let upperBound = lowerBound + 100
        for _ in 0..<testRuns {
            let random = Int64.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 100)
    }

    func testMaxInt64s() {
        var values = Set<Int64>(minimumCapacity: testRuns)
        let upperBound = Int64.max
        let lowerBound = upperBound - 100
        for _ in 0..<testRuns {
            let random = Int64.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertEqual(values.count, 100)
    }

    func testMinMaxInt64s() {
        var values = Set<Int64>(minimumCapacity: testRuns)
        let lowerBound = Int64.min
        let upperBound = Int64.max
        for _ in 0..<testRuns {
            let random = Int64.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertNotNil(values.first(where: { $0 < Int32.min }))
        XCTAssertNotNil(values.first(where: { $0 > Int32.max }))
        XCTAssertEqual(values.count, testRuns)
    }

    func testMaxUInt32s() {
        var values = Set<UInt32>(minimumCapacity: testRuns)
        let lowerBound = UInt32(0)
        let upperBound = UInt32.max
        for _ in 0..<testRuns {
            let random = UInt32.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertNotNil(values.first(where: { $0 > UInt16.max }))
        XCTAssertEqual(values.count, testRuns)
    }

    func testMaxUInt64s() {
        var values = Set<UInt64>(minimumCapacity: testRuns)
        let lowerBound = UInt64(0)
        let upperBound = UInt64.max
        for _ in 0..<testRuns {
            let random = UInt64.random(lowerBound: lowerBound, upperBound: upperBound)
            XCTAssert(random >= lowerBound && random < upperBound)
            values.insert(random)
        }
        XCTAssertNotNil(values.first(where: { $0 > UInt32.max }))
        XCTAssertEqual(values.count, testRuns)
    }

}
