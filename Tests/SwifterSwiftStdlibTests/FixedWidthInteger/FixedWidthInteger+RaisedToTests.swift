// FixedWidthInteger+RaisedToTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct FixedWidthIntegerRaisedToTests {
    @Test(arguments: [
        (2, 0, 1),
        (2, 1, 2),
        (2, 10, 1024),
        (-3, 3, -27),
        (-3, 4, 81),
        (10, 9, 1_000_000_000),
        (7, 2, 49),
        (-1, 0, 1),
        (0, 0, 1),
        (0, 1, 0),
        (0, 1000, 0)
    ])
    func raisesToNonNegativePowers(_ base: Int, _ exponent: Int, _ expected: Int) {
        #expect(base.raised(to: exponent) == expected)
    }

    @Test
    func isExactBeyondTheDoublePrecisionLimit() {
        // 3³⁹ is above 2⁵³, so `Int64(pow(3.0, 39.0))` isn't exact.
        #expect(Int64(3).raised(to: 39) == 4_052_555_153_018_976_267)
        #expect(UInt64(3).raised(to: 40) == 12_157_665_459_056_928_801)
        #expect(Int64(10).raised(to: 18) == 1_000_000_000_000_000_000)
        #expect(UInt64(2).raised(to: 63) == 9_223_372_036_854_775_808)
    }

    @Test
    func returnsNilOnOverflow() {
        #expect(Int64(3).raised(to: 40) == nil)
        #expect(UInt64(3).raised(to: 41) == nil)
        #expect(Int64(10).raised(to: 19) == nil)
        #expect(Int64(-10).raised(to: 19) == nil)
        #expect(UInt64(2).raised(to: 64) == nil)
        #expect(Int8(2).raised(to: 7) == nil)
        #expect(UInt8(2).raised(to: 8) == nil)
        #expect(UInt8(16).raised(to: 2) == nil)
        #expect(2.raised(to: Int.max) == nil)
        #expect((-2).raised(to: Int.max) == nil)
    }

    @Test
    func reachesTheBoundsOfTheType() {
        #expect(Int8(-2).raised(to: 7) == Int8.min)
        #expect(UInt8(2).raised(to: 7) == 128)
        #expect(UInt8(15).raised(to: 2) == 225)
        #expect(UInt8.max.raised(to: 1) == UInt8.max)
        #expect(Int.min.raised(to: 1) == Int.min)
        #expect(Int.max.raised(to: 1) == Int.max)
        #expect(Int.min.raised(to: 2) == nil)
        #expect(Int.max.raised(to: 2) == nil)
        #expect(2.raised(to: Int.bitWidth - 2) == 1 << (Int.bitWidth - 2))
        #expect(2.raised(to: Int.bitWidth - 1) == nil)
        #expect((-2).raised(to: Int.bitWidth - 1) == Int.min)
        #expect(UInt(2).raised(to: UInt.bitWidth - 1) == 1 << (UInt.bitWidth - 1))
    }

    @Test(arguments: [-1, -2, -3, Int.min])
    func returnsNilForNegativeExponentsOfOtherBases(_ exponent: Int) {
        #expect(2.raised(to: exponent) == nil)
        #expect((-2).raised(to: exponent) == nil)
        #expect(0.raised(to: exponent) == nil)
        #expect(Int.max.raised(to: exponent) == nil)
        #expect(Int.min.raised(to: exponent) == nil)
        #expect(UInt8(2).raised(to: exponent) == nil)
        #expect(UInt8(0).raised(to: exponent) == nil)
    }

    @Test
    func returnsExactPowersOfOneAndMinusOneForNegativeExponents() {
        #expect(1.raised(to: -1) == 1)
        #expect(1.raised(to: Int.min) == 1)
        #expect(UInt8(1).raised(to: -5) == 1)
        #expect((-1).raised(to: -1) == -1)
        #expect((-1).raised(to: -2) == 1)
        #expect((-1).raised(to: Int.min) == 1)
        #expect(Int8(-1).raised(to: -3) == -1)
    }

    @Test
    func handlesHugeExponentsOfOneMinusOneAndZero() {
        #expect(1.raised(to: Int.max) == 1)
        #expect((-1).raised(to: Int.max) == -1)
        #expect((-1).raised(to: Int.max - 1) == 1)
        #expect(0.raised(to: Int.max) == 0)
        #expect(UInt64(1).raised(to: Int.max) == 1)
    }

    @Test
    func matchesRepeatedMultiplicationForEveryInt8() {
        for base in Int8.min...Int8.max {
            for exponent in 0...9 {
                #expect(base.raised(to: exponent) == Self.reference(base, exponent), "\(base) ^ \(exponent)")
            }
        }
    }

    @Test
    func matchesRepeatedMultiplicationForEveryUInt8() {
        for base in UInt8.min...UInt8.max {
            for exponent in 0...9 {
                #expect(base.raised(to: exponent) == Self.reference(base, exponent), "\(base) ^ \(exponent)")
            }
        }
    }

    /// Multiplies in `Int64`, where nothing here can overflow, then narrows the result.
    private static func reference<T: FixedWidthInteger>(_ base: T, _ exponent: Int) -> T? {
        var result: Int64 = 1
        for _ in 0..<exponent {
            result *= Int64(base)
            if result.magnitude > 1 << 16 {
                return nil
            }
        }
        return T(exactly: result)
    }
}
