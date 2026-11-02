// Sequence+SumTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceSumTests {
    @Test(arguments: [
        ([1, 2, 3, 4], 10),
        ([-1, -2, 3], 0),
        ([Int.max, Int.min], -1),
        ([42], 42),
        ([], 0)
    ])
    func returnsTheSumOfIntegers(_ numbers: [Int], expected: Int) {
        #expect(numbers.sum() == expected)
    }

    @Test
    func returnsTheSumOfFloatingPointNumbers() {
        #expect([0.5, 1.5].sum() == 2)
        #expect([Double]().sum() == 0)
        #expect([Double.infinity, 1].sum() == .infinity)
        #expect([Double.infinity, -.infinity].sum().isNaN)
        #expect([Float.greatestFiniteMagnitude, .greatestFiniteMagnitude].sum() == .infinity)
    }

    @Test
    func worksWithAnyAdditiveArithmeticType() {
        #expect([Duration.seconds(1), .milliseconds(500)].sum() == .milliseconds(1500))
        #expect([UInt8(200), 55].sum() == 255)
    }

    @Test
    func worksWithOtherSequences() {
        #expect((1...100).sum() == 5050)
        #expect(Set([1, 2, 3]).sum() == 6)
        #expect(stride(from: 0.5, through: 2, by: 0.5).sum() == 5)
    }
}
