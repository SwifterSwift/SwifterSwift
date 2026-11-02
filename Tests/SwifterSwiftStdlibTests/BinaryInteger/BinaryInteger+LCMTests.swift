// BinaryInteger+LCMTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryIntegerLCMTests {
    @Test(arguments: [
        (4, 3, UInt(12)),
        (4, 6, 12),
        (6, 4, 12),
        (21, 6, 42),
        (7, 7, 7),
        (1, 1_000_000, 1_000_000),
        (17, 31, 527)
    ])
    func returnsTheLeastCommonMultiple(lhs: Int, rhs: Int, expected: UInt) {
        #expect(lhs.lcm(of: rhs) == expected)
    }

    @Test(arguments: [(4, -6), (-4, 6), (-4, -6)])
    func isNeverNegative(lhs: Int, rhs: Int) {
        #expect(lhs.lcm(of: rhs) == 12)
    }

    @Test(arguments: [(0, 0), (0, 5), (5, 0), (0, Int.min), (Int.max, 0)])
    func returnsZeroWhenEitherValueIsZero(lhs: Int, rhs: Int) {
        #expect(lhs.lcm(of: rhs) == 0)
    }

    @Test
    func returnsResultsThatOnlyFitInTheMagnitudeType() {
        #expect(Int.max.lcm(of: 2) == Int.max.magnitude * 2)
        #expect(Int.min.lcm(of: 2) == Int.min.magnitude)
        #expect(Int.min.lcm(of: .min) == Int.min.magnitude)
        #expect(Int8.min.lcm(of: -128) == 128)
        #expect(UInt64.max.lcm(of: .max) == .max)
    }

    @Test
    func returnsNilWhenTheResultOverflows() {
        #expect(Int.max.lcm(of: 3) == nil)
        #expect(Int.max.lcm(of: .max - 1) == nil)
        #expect(Int.min.lcm(of: 3) == nil)
        #expect(UInt64.max.lcm(of: 2) == nil)
        #expect(Int8.min.lcm(of: 3) == nil)
    }

    @Test
    func timesTheGreatestCommonDivisorEqualsTheProduct() {
        for lhs in -30...30 {
            for rhs in -30...30 where lhs != 0 && rhs != 0 {
                let lcm = lhs.lcm(of: rhs)
                #expect(lcm.map { $0 * lhs.gcd(of: rhs) } == lhs.magnitude * rhs.magnitude)
                #expect(lcm.map { $0.isMultiple(of: lhs.magnitude) && $0.isMultiple(of: rhs.magnitude) } == true)
            }
        }
    }
}
