// Sequence+DuplicatesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceDuplicatesTests {
    @Test(arguments: [
        ([3, 1, 2, 1, 3, 3], [3, 1]),
        ([1, 1, 2, 2, 3, 3, 3, 4, 5], [1, 2, 3]),
        ([5, 5, 5], [5]),
        ([Int.max, Int.min, Int.max], [Int.max]),
        ([1, 2, 3], []),
        ([], [])
    ])
    func returnsRepeatedElementsInTheOrderTheyFirstAppear(_ numbers: [Int], expected: [Int]) {
        #expect(numbers.duplicates() == expected)
    }

    @Test
    func returnsTheSameOrderEveryTime() {
        let numbers = Array(0..<100) + Array((0..<100).reversed())
        #expect(numbers.duplicates() == Array(0..<100))
    }

    @Test
    func findsRepeatedCharacters() {
        #expect("bookkeeper".duplicates() == ["o", "k", "e"])
        // The precomposed "é" and "e" with a combining accent are the same `Character`.
        #expect("\u{E9}👍🏽e\u{301}👍🇸🇾🇸🇾".duplicates() == ["é", "🇸🇾"])
    }

    @Test
    func worksWithSinglePassSequences() {
        var iterator = [2, 1, 2, 1].makeIterator()
        #expect(AnyIterator { iterator.next() }.duplicates() == [2, 1])
    }
}
