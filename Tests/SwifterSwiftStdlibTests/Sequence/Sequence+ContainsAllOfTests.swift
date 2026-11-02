// Sequence+ContainsAllOfTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceContainsAllOfTests {
    private struct Point: Equatable {
        var x: Int
        var y: Int
    }

    @Test(arguments: [[3, 1], [1, 2, 3, 4], [4], [2, 2, 2], []])
    func returnsTrueWhenEveryElementIsContained(_ elements: [Int]) {
        #expect([1, 2, 3, 4].contains(allOf: elements))
    }

    @Test(arguments: [[1, 5], [5], [0, 1, 2, 3, 4], [Int.min]])
    func returnsFalseWhenAnyElementIsMissing(_ elements: [Int]) {
        #expect(![1, 2, 3, 4].contains(allOf: elements))
    }

    @Test
    func handlesEquatableElements() {
        let points = [Point(x: 0, y: 0), Point(x: 1, y: 1), Point(x: 2, y: 2)]
        #expect(points.contains(allOf: [Point(x: 2, y: 2), Point(x: 0, y: 0)]))
        #expect(points.contains(allOf: [Point(x: 1, y: 1), Point(x: 1, y: 1)]))
        #expect(points.contains(allOf: []))
        #expect(!points.contains(allOf: [Point(x: 0, y: 0), Point(x: 3, y: 3)]))
    }

    @Test
    func handlesEmptySequences() {
        #expect([Int]().contains(allOf: []))
        #expect(![Int]().contains(allOf: [1]))
        #expect([Point]().contains(allOf: []))
        #expect(![Point]().contains(allOf: [Point(x: 0, y: 0)]))
    }

    @Test
    func leavesTheStandardLibraryContainsUnchanged() {
        // The standard library's `contains(_:)` looks for a contiguous run in the same order.
        #expect(![1, 2, 3, 4].contains([3, 1]))
        #expect(![1, 2, 3, 4].contains([1, 3]))
        #expect([1, 2, 3, 4].contains([2, 3]))
        #expect([1, 2, 3, 4].contains(allOf: [3, 1]))
        #expect([1, 2, 3, 4].contains(allOf: [1, 3]))
    }

    @Test
    func checksCharactersOfStrings() {
        #expect("swift".contains(allOf: "fist"))
        #expect(!"swift".contains(allOf: "fast"))
        // The precomposed "é" and "e" with a combining accent are the same `Character`.
        let accentedLetter: Character = "\u{E9}"
        #expect("cafe\u{301} 👍🏽🇸🇾".contains(allOf: [accentedLetter, "🇸🇾", "👍🏽"]))
        #expect(!"cafe\u{301} 👍🏽".contains(allOf: ["e", "👍"] as [Character]))
    }

    @Test
    func stopsOnceEveryElementIsFound() {
        #expect((1...).contains(allOf: [5, 2, 9]))
        #expect((1...).lazy.map { Point(x: $0, y: 0) }.contains(allOf: [Point(x: 5, y: 0), Point(x: 2, y: 0)]))

        var visited = 0
        var iterator = [1, 2, 3, 4, 5].makeIterator()
        let numbers = AnyIterator {
            visited += 1
            return iterator.next()
        }
        #expect(numbers.contains(allOf: [2, 1]))
        #expect(visited == 2)
    }

    @Test
    func iteratesSinglePassSequencesOnlyOnce() {
        var iterator = [Point(x: 1, y: 1), Point(x: 2, y: 2), Point(x: 3, y: 3)].makeIterator()
        let points = AnyIterator { iterator.next() }
        #expect(points.contains(allOf: [Point(x: 3, y: 3), Point(x: 1, y: 1)]))
    }
}
