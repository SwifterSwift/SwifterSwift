// BinaryInteger+RoundedToMultipleOfTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryIntegerRoundedToMultipleOfTests {
    @Test(arguments: [
        (12, 5, 10),
        (13, 5, 15),
        (63, 25, 75),
        (42, 10, 40),
        (0, 7, 0),
        (7, 7, 7),
        (-7, 7, -7),
        (-12, 5, -10),
        (-13, 5, -15)
    ])
    func roundsToTheNearestMultiple(value: Int, multiple: Int, expected: Int) {
        #expect(value.rounded(toMultipleOf: multiple) == expected)
    }

    @Test(arguments: [(15, 10, 20), (-15, 10, -20), (5, 10, 10), (-5, 10, -10), (25, 10, 30)])
    func roundsHalfwayValuesAwayFromZero(value: Int, multiple: Int, expected: Int) {
        #expect(value.rounded(toMultipleOf: multiple) == expected)
    }

    @Test(arguments: [(12, -5, 10), (13, -5, 15), (-15, -10, -20)])
    func ignoresTheSignOfTheMultiple(value: Int, multiple: Int, expected: Int) {
        #expect(value.rounded(toMultipleOf: multiple) == expected)
    }

    @Test(arguments: [42, 0, -42, Int.max, Int.min])
    func returnsNilForAZeroMultiple(value: Int) {
        #expect(value.rounded(toMultipleOf: 0) == nil)
    }

    @Test
    func returnsNilWhenTheNearestMultipleOverflows() {
        #expect(Int.max.rounded(toMultipleOf: 10) == nil)
        #expect(Int.min.rounded(toMultipleOf: 10) == nil)
        #expect(Int.max.rounded(toMultipleOf: .min) == nil)
        #expect(UInt.max.rounded(toMultipleOf: 10) == nil)
        #expect(UInt8(250).rounded(toMultipleOf: 100) == nil)
        #expect(Int8.min.rounded(toMultipleOf: 3) == nil)
    }

    @Test
    func handlesMinAndMaxWhenTheResultFits() {
        #expect(Int.min.rounded(toMultipleOf: -1) == .min)
        #expect(Int.min.rounded(toMultipleOf: 1) == .min)
        #expect(Int.min.rounded(toMultipleOf: .min) == .min)
        #expect(Int.max.rounded(toMultipleOf: .max) == .max)
        #expect(Int.max.rounded(toMultipleOf: 7) == .max)  // Int.max is a multiple of 7
        #expect(1.rounded(toMultipleOf: .min) == 0)
        #expect((Int.min / 2).rounded(toMultipleOf: .min) == .min)
        #expect(UInt8(249).rounded(toMultipleOf: 100) == 200)
        #expect(Int8(-127).rounded(toMultipleOf: 3) == -126)
    }

    @Test
    func matchesWideArithmeticForEveryInt8Pair() {
        for value in Int8.min...Int8.max {
            for multiple in Int8.min...Int8.max {
                #expect(value.rounded(toMultipleOf: multiple) == Self.reference(value, multiple))
            }
        }
    }

    /// Rounds in `Int`, where nothing can overflow, then narrows the result.
    private static func reference(_ value: Int8, _ multiple: Int8) -> Int8? {
        guard multiple != 0 else { return nil }
        let value = Int(value)
        let step = abs(Int(multiple))
        let below = value - ((value % step) + step) % step
        let above = below == value ? value : below + step
        let distanceBelow = value - below
        let distanceAbove = above - value
        let nearest: Int
        if distanceBelow == distanceAbove {
            nearest = value < 0 ? below : above
        } else {
            nearest = distanceBelow < distanceAbove ? below : above
        }
        return Int8(exactly: nearest)
    }
}
