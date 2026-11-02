// BinaryInteger+GCDTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryIntegerGCDTests {
    @Test(arguments: [
        (8, 20, UInt(4)),
        (20, 8, 4),
        (12, 18, 6),
        (17, 31, 1),
        (7, 7, 7),
        (1, 1_000_000, 1),
        (7, 0, 7),
        (0, 7, 7),
        (0, 0, 0)
    ])
    func returnsTheGreatestCommonDivisor(lhs: Int, rhs: Int, expected: UInt) {
        #expect(lhs.gcd(of: rhs) == expected)
    }

    @Test(arguments: [(4, -6), (-4, 6), (-4, -6)])
    func isNeverNegative(lhs: Int, rhs: Int) {
        #expect(lhs.gcd(of: rhs) == 2)
    }

    @Test
    func handlesMinAndMaxWithoutOverflowing() {
        #expect(Int.min.gcd(of: 0) == Int.min.magnitude)
        #expect(Int.min.gcd(of: .min) == Int.min.magnitude)
        #expect(Int.min.gcd(of: 6) == 2)
        #expect(Int.min.gcd(of: .max) == 1)
        #expect(Int.max.gcd(of: .max) == UInt(Int.max))
        #expect(Int8.min.gcd(of: -64) == 64)
        #expect(UInt64.max.gcd(of: UInt64.max - 1) == 1)
        #expect(UInt8(255).gcd(of: 85) == 85)
    }

    @Test
    func matchesTheLargestCommonDivisorForSmallValues() {
        for lhs in -30...30 {
            for rhs in -30...30 {
                let common = (1...30).filter { lhs.isMultiple(of: $0) && rhs.isMultiple(of: $0) }
                let expected = lhs == 0 && rhs == 0 ? 0 : UInt(common.max() ?? 0)
                #expect(lhs.gcd(of: rhs) == expected)
            }
        }
    }
}
