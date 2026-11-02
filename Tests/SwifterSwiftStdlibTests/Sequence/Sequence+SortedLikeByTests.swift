// Sequence+SortedLikeByTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceSortedLikeByTests {
    private struct Todo: Equatable {
        var title: String
        var priority: String
    }

    @Test
    func sortsByThePositionOfEachKey() {
        let todos = [
            Todo(title: "Email", priority: "low"),
            Todo(title: "Fix bug", priority: "high"),
            Todo(title: "Review", priority: "medium")
        ]
        let sorted = todos.sorted(like: ["high", "medium", "low"], by: \.priority)
        #expect(sorted.map(\.title) == ["Fix bug", "Review", "Email"])
    }

    @Test
    func putsElementsWithUnknownKeysLastInTheirOriginalOrder() {
        let numbers = [9, 3, 8, 1, 7, 2]
        #expect(numbers.sorted(like: [1, 2, 3], by: { $0 }) == [1, 2, 3, 9, 8, 7])
    }

    @Test
    func keepsTheOriginalOrderOfElementsWithTheSameKey() {
        let words = ["bb", "a", "cc", "b", "aa"]
        #expect(words.sorted(like: [2, 1], by: \.count) == ["bb", "cc", "aa", "a", "b"])
    }

    @Test
    func usesTheFirstPositionOfARepeatedKey() {
        #expect([3, 1, 2].sorted(like: [2, 1, 2, 3, 1], by: { $0 }) == [2, 1, 3])
    }

    @Test
    func keepsTheOriginalOrderForAnEmptyOrder() {
        #expect([3, 1, 2].sorted(like: [], by: { $0 }) == [3, 1, 2])
    }

    @Test
    func returnsEmptyArrayForEmptySequence() {
        #expect([Int]().sorted(like: [1, 2], by: { $0 }).isEmpty)
    }

    @Test
    func callsTheKeyClosureOncePerElement() {
        var calls = 0
        let sorted = [3, 1, 2, 1].sorted(like: [1, 2, 3]) { number in
            calls += 1
            return number
        }
        #expect(sorted == [1, 1, 2, 3])
        #expect(calls == 4)
    }

    @Test
    func matchesCanonicallyEquivalentStringKeys() {
        let words = ["tea", "cafe\u{301}", "juice"]
        #expect(words.sorted(like: ["caf\u{E9}", "juice"], by: { $0 }) == ["café", "juice", "tea"])
    }

    @Test
    func acceptsSinglePassSequences() {
        var orderIterator = [2, 1].makeIterator()
        var iterator = [1, 2, 3].makeIterator()
        let sorted = AnyIterator { iterator.next() }.sorted(like: AnyIterator { orderIterator.next() }, by: { $0 })
        #expect(sorted == [2, 1, 3])
    }

    @Test
    func rethrowsErrorsFromTheKeyClosure() {
        #expect(throws: CancellationError.self) {
            try [1, 2].sorted(like: [2, 1], by: { (_: Int) throws -> Int in throw CancellationError() })
        }
    }
}
