// RangeReplaceableCollection+RemoveAllTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct RangeReplaceableCollectionRemoveAllTests {
    private struct Point: Equatable {
        var x: Int
        var y: Int
    }

    @Test
    func removesEveryOccurrenceOfTheGivenElements() {
        var numbers = [1, 2, 2, 3, 4, 5]
        numbers.removeAll([2, 5, 9])
        #expect(numbers == [1, 3, 4])
    }

    @Test
    func removesEveryOccurrenceOfEquatableElements() {
        var points = [Point(x: 0, y: 0), Point(x: 1, y: 1), Point(x: 0, y: 0), Point(x: 2, y: 2)]
        points.removeAll([Point(x: 0, y: 0), Point(x: 9, y: 9)])
        #expect(points == [Point(x: 1, y: 1), Point(x: 2, y: 2)])
    }

    @Test
    func leavesTheCollectionUnchangedForNoElements() {
        var numbers = [1, 2, 3]
        numbers.removeAll([])
        #expect(numbers == [1, 2, 3])

        var points = [Point(x: 0, y: 0)]
        points.removeAll([])
        #expect(points == [Point(x: 0, y: 0)])
    }

    @Test
    func doesNothingForEmptyCollection() {
        var empty: [Int] = []
        empty.removeAll([1, 2])
        #expect(empty.isEmpty)

        var noPoints: [Point] = []
        noPoints.removeAll([Point(x: 0, y: 0)])
        #expect(noPoints.isEmpty)
    }

    @Test
    func canRemoveEveryElement() {
        var numbers = [1, 1, 2]
        numbers.removeAll([2, 1])
        #expect(numbers.isEmpty)
    }

    @Test
    func acceptsSinglePassSequences() {
        var numbers = [1, 2, 3, 4]
        var hashableIterator = [2, 4].makeIterator()
        numbers.removeAll(AnyIterator { hashableIterator.next() })
        #expect(numbers == [1, 3])

        var points = [Point(x: 0, y: 0), Point(x: 1, y: 1)]
        var equatableIterator = [Point(x: 1, y: 1)].makeIterator()
        points.removeAll(AnyIterator { equatableIterator.next() })
        #expect(points == [Point(x: 0, y: 0)])
    }

    @Test
    func removesCharactersFromStrings() {
        var text = "hello, world"
        text.removeAll("lo")
        #expect(text == "he, wrd")

        // "e" followed by a combining accent is the same `Character` as the precomposed "é".
        var symbols = "🇸🇾 cafe\u{301} 👍🏽 👍"
        symbols.removeAll(["é", "👍🏽", " "])
        #expect(symbols == "🇸🇾caf👍")
    }
}
