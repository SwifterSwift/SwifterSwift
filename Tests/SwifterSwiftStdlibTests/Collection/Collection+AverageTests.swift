// Collection+AverageTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct CollectionAverageTests {
    @Test(arguments: [
        ([1, 2, 3, 4], 2.5),
        ([5], 5.0),
        ([-4, 4], 0.0),
        ([-1, -2], -1.5),
        ([0, 0, 1], 1.0 / 3.0)
    ])
    func returnsMeanOfIntegers(_ numbers: [Int], expected: Double) {
        #expect(numbers.average() == expected)
    }

    @Test
    func returnsNilForEmptyCollections() {
        #expect([Int]().average() == nil)
        #expect([UInt8]().average() == nil)
        #expect([Double]().average() == nil)
        #expect([Float]().average() == nil)
    }

    @Test
    func doesNotOverflowNearIntegerLimits() {
        #expect([Int.max, 1].average() == (Double(Int.max) + 1) / 2)
        #expect([Int.max, Int.max].average() == Double(Int.max))
        #expect([Int.min, Int.min].average() == Double(Int.min))
        #expect([UInt64.max, UInt64.max].average() == Double(UInt64.max))
        #expect([Int8.max, Int8.max, Int8.max].average() == 127)
        #expect([Int8.min, Int8.max].average() == -0.5)
        #expect([UInt8.max, 1].average() == 128)
    }

    @Test
    func worksWithOtherCollections() {
        #expect(Set([1, 2, 3, 6]).average() == 3)
        #expect((1...100).average() == 50.5)
        #expect([1, 2, 3, 4][2...].average() == 3.5)
        #expect([Float(1), 2].average() == 1.5)
    }

    @Test(arguments: [
        ([1.5, 2.5, 3.5], 2.5),
        ([-1.0, 1.0], 0.0),
        ([0.25], 0.25),
        ([-2.5, -0.5], -1.5)
    ])
    func returnsMeanOfFloatingPointNumbers(_ numbers: [Double], expected: Double) {
        #expect(numbers.average() == expected)
    }

    @Test
    func propagatesNaNAndInfinity() throws {
        #expect(try #require([1, .nan].average()).isNaN)
        #expect([Double.infinity, 1].average() == .infinity)
        #expect([-Double.infinity, 1].average() == -.infinity)
        #expect(try #require([Double.infinity, -.infinity].average()).isNaN)
    }

    @Test(arguments: [2, 3, 7, 1000])
    func doesNotOverflowNearFloatingPointLimits(_ count: Int) {
        let max = Double.greatestFiniteMagnitude
        #expect(Array(repeating: max, count: count).average() == max)
        #expect(Array(repeating: -max, count: count).average() == -max)
        #expect(Array(repeating: Float.greatestFiniteMagnitude, count: count).average() == .greatestFiniteMagnitude)
    }

    @Test
    func handlesMixedExtremeFloatingPointValues() throws {
        let max = Double.greatestFiniteMagnitude
        #expect([max, -max].average() == 0)
        #expect([max, max, 0].average() == max / 3 * 2)
        #expect(try #require([max, max / 2, -max].average()).isFinite)
        #expect([Double.leastNonzeroMagnitude, .leastNonzeroMagnitude].average() == .leastNonzeroMagnitude)
    }

    @Test
    func staysBetweenTheSmallestAndLargestElement() {
        // Adding 0.1 three times rounds up, so dividing the sum by 3 would give 0.10000000000000002.
        #expect([0.1, 0.1, 0.1].average() == 0.1)
        #expect([Float(0.1), 0.1, 0.1].average() == 0.1)
        #expect(Array(repeating: 1.1, count: 10).average() == 1.1)
    }
}
