// Sequence+ProductTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceProductTests {
    @Test(arguments: [
        ([1, 2, 3, 4], 24),
        ([-1, 2, -3], 6),
        ([-2, 3], -6),
        ([5, 0, Int.max], 0),
        ([Int.min, 1], Int.min),
        ([42], 42),
        ([], 1)
    ])
    func returnsTheProductOfIntegers(_ numbers: [Int], expected: Int) {
        #expect(numbers.product() == expected)
    }

    @Test
    func returnsTheProductOfFloatingPointNumbers() {
        #expect([0.5, 4].product() == 2)
        #expect([Double]().product() == 1)
        #expect([Double.infinity, -1].product() == -.infinity)
        #expect([Double.infinity, 0].product().isNaN)
        #expect([Float.greatestFiniteMagnitude, 2].product() == .infinity)
    }

    @Test
    func worksWithOtherSequences() {
        #expect((1...5).product() == 120)
        #expect(Set([2, 3]).product() == 6)
    }
}
