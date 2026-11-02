// RangeReplaceableCollection+RemoveDuplicatesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct RangeReplaceableCollectionRemoveDuplicatesTests {
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
        var numbers = numbers
        numbers.removeDuplicates()
        #expect(numbers == expected)
    }

    @Test
    func removesDuplicateEquatableElements() {
        var points = [Point(x: 1, y: 1), Point(x: 0, y: 0), Point(x: 1, y: 1), Point(x: 0, y: 0)]
        points.removeDuplicates()
        #expect(points == [Point(x: 1, y: 1), Point(x: 0, y: 0)])

        var empty: [Point] = []
        empty.removeDuplicates()
        #expect(empty.isEmpty)
    }

    @Test
    func removesDuplicateCharactersFromStrings() {
        var word = "bookkeeper"
        word.removeDuplicates()
        #expect(word == "bokepr")

        // The precomposed "é" and "e" with a combining accent are the same `Character`.
        var symbols = "\u{E9}e\u{301}🇸🇾🇸🇾👍🏽👍"
        symbols.removeDuplicates()
        #expect(symbols == "é🇸🇾👍🏽👍")
    }

    @Test
    func removesDuplicatesFromSlices() {
        var slice = [9, 1, 2, 1, 3, 2][1...]
        slice.removeDuplicates()
        #expect(Array(slice) == [1, 2, 3])
    }
}
