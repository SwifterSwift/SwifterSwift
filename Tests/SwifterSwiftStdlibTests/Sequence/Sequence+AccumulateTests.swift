// Sequence+AccumulateTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceAccumulateTests {
    @Test
    func returnsTheRunningResults() {
        #expect([1, 2, 3, 4].accumulate(initial: 0, next: +) == [1, 3, 6, 10])
        #expect([1, 2, 3, 4].accumulate(initial: 1, next: *) == [1, 2, 6, 24])
        #expect(["a", "b", "c"].accumulate(initial: "", next: +) == ["a", "ab", "abc"])
    }

    @Test
    func doesNotIncludeTheInitialValue() {
        #expect([5].accumulate(initial: 100, next: +) == [105])
        #expect([Int]().accumulate(initial: 100, next: +).isEmpty)
    }

    @Test
    func canProduceADifferentType() {
        let lengths = ["a", "bb", "ccc"].accumulate(initial: 0) { $0 + $1.count }
        #expect(lengths == [1, 3, 6])
    }

    @Test
    func handlesNegativeNumbersAndExtremes() {
        #expect([-1, -2, 3].accumulate(initial: 0, next: +) == [-1, -3, 0])
        #expect([Int.max, Int.min].accumulate(initial: 0, next: +) == [Int.max, -1])
    }

    @Test
    func worksWithSinglePassSequences() {
        var iterator = [1, 2, 3].makeIterator()
        #expect(AnyIterator { iterator.next() }.accumulate(initial: 0, next: +) == [1, 3, 6])
    }

    @Test
    func rethrowsErrorsFromTheClosure() {
        #expect(throws: CancellationError.self) {
            try [1, 2].accumulate(initial: 0) { (_: Int, _: Int) throws -> Int in throw CancellationError() }
        }
    }
}
