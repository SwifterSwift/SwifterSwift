// Sequence+WithoutDuplicatesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceWithoutDuplicatesTests {
    private struct Point: Equatable {
        var x: Int
        var y: Int
    }

    @Test(arguments: [
        ([3, 1, 3, 2, 1], [3, 1, 2]),
        ([1, 1, 1], [1]),
        ([1, 2, 3], [1, 2, 3]),
        ([Int.min, Int.max, Int.min], [Int.min, Int.max]),
        ([], [])
    ])
    func keepsTheFirstOccurrenceOfEachElement(_ numbers: [Int], expected: [Int]) {
        #expect(numbers.withoutDuplicates() == expected)
    }

    @Test
    func removesDuplicateEquatableElements() {
        let points = [Point(x: 1, y: 1), Point(x: 0, y: 0), Point(x: 1, y: 1), Point(x: 0, y: 0)]
        #expect(points.withoutDuplicates() == [Point(x: 1, y: 1), Point(x: 0, y: 0)])
        #expect([Point]().withoutDuplicates().isEmpty)
    }

    @Test
    func removesDuplicateCharacters() {
        #expect("bookkeeper".withoutDuplicates() == ["b", "o", "k", "e", "p", "r"])
        // The precomposed "é" and "e" with a combining accent are the same `Character`.
        #expect("\u{E9}e\u{301}🇸🇾🇸🇾👍🏽👍".withoutDuplicates() == ["é", "🇸🇾", "👍🏽", "👍"])
    }

    @Test
    func worksWithSinglePassSequences() {
        var iterator = [2, 1, 2, 3, 1].makeIterator()
        #expect(AnyIterator { iterator.next() }.withoutDuplicates() == [2, 1, 3])

        var pointIterator = [Point(x: 1, y: 1), Point(x: 1, y: 1)].makeIterator()
        #expect(AnyIterator { pointIterator.next() }.withoutDuplicates() == [Point(x: 1, y: 1)])
    }
}
