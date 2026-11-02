// BinaryInteger+DigitsTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryIntegerDigitsTests {
    @Test(arguments: [
        (0, [0]),
        (7, [7]),
        (10, [1, 0]),
        (123, [1, 2, 3]),
        (2026, [2, 0, 2, 6]),
        (1_000_000, [1, 0, 0, 0, 0, 0, 0])
    ])
    func returnsDecimalDigitsMostSignificantFirst(value: Int, expected: [Int]) {
        #expect(value.digits == expected)
    }

    @Test
    func ignoresTheSign() {
        #expect((-123).digits == [1, 2, 3])
        #expect((-1).digits == [1])
    }

    @Test
    func handlesMinAndMaxWithoutOverflowing() {
        #expect(Int.min.digits == [9, 2, 2, 3, 3, 7, 2, 0, 3, 6, 8, 5, 4, 7, 7, 5, 8, 0, 8])
        #expect(Int.max.digits == [9, 2, 2, 3, 3, 7, 2, 0, 3, 6, 8, 5, 4, 7, 7, 5, 8, 0, 7])
        #expect(Int8.min.digits == [1, 2, 8])
        #expect(UInt64.max.digits == [1, 8, 4, 4, 6, 7, 4, 4, 0, 7, 3, 7, 0, 9, 5, 5, 1, 6, 1, 5])
        #expect(UInt8.max.digits == [2, 5, 5])
    }

    @Test
    func matchesTheDecimalDescription() {
        for value in [Int16.min, -9999, -10, -9, 0, 9, 10, 99, 100, 9999, 10_000, Int16.max] {
            let expected = String(value.magnitude).compactMap(\.wholeNumberValue)
            #expect(value.digits == expected)
        }
    }
}
