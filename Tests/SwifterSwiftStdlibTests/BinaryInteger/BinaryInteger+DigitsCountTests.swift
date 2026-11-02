// BinaryInteger+DigitsCountTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryIntegerDigitsCountTests {
    @Test(arguments: [
        (0, 1),
        (1, 1),
        (9, 1),
        (10, 2),
        (99, 2),
        (100, 3),
        (180, 3),
        (2026, 4)
    ])
    func countsDecimalDigits(value: Int, expected: Int) {
        #expect(value.digitsCount == expected)
    }

    @Test
    func ignoresTheSign() {
        #expect((-123).digitsCount == 3)
        #expect((-1).digitsCount == 1)
    }

    // `Int64` rather than `Int`, because `Int` is 32 bits on Apple Watch hardware.
    @Test(
        arguments: [
            (99_999_999_999_999_999, 17),
            (100_000_000_000_000_000, 18),
            (999_999_999_999_999_999, 18),
            (1_000_000_000_000_000_000, 19)
        ] as [(Int64, Int)])
    func isExactForLongNumbers(value: Int64, expected: Int) {
        // A count based on `log10(Double(value))` reports 19 digits for 999_999_999_999_999_999.
        #expect(value.digitsCount == expected)
    }

    @Test
    func handlesMinAndMaxWithoutOverflowing() {
        #expect(Int64.min.digitsCount == 19)
        #expect(Int64.max.digitsCount == 19)
        #expect(Int32.min.digitsCount == 10)
        #expect(Int8.min.digitsCount == 3)
        #expect(UInt64.max.digitsCount == 20)
        #expect(UInt8.max.digitsCount == 3)
    }

    @Test
    func matchesTheLengthOfTheDecimalDescription() {
        var value = 1
        for _ in 0..<18 {
            for candidate in [value - 1, value, value + 1, -value] {
                #expect(candidate.digitsCount == String(candidate.magnitude).count)
            }
            value *= 10
        }
    }
}
