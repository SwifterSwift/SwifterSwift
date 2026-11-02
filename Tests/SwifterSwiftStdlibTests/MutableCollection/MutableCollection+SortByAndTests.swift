// MutableCollection+SortByAndTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct MutableCollectionSortByAndTests {
    private struct Person: Equatable {
        var first: String
        var last: String
    }

    @Test
    func sortsByTheSecondKeyWhenTheFirstKeysAreEqual() {
        var words = ["bb", "c", "aa", "b"]
        words.sort(by: \.count, and: \.self)
        #expect(words == ["b", "c", "aa", "bb"])
    }

    @Test
    func sortsByLastNameThenFirstName() {
        var people = [
            Person(first: "Zed", last: "Ali"),
            Person(first: "Ana", last: "Kaya"),
            Person(first: "Bea", last: "Ali")
        ]
        people.sort(by: \.last, and: \.first)
        #expect(people.map(\.first) == ["Bea", "Zed", "Ana"])
    }

    @Test
    func keepsTheOriginalOrderWhenBothKeysAreEqual() {
        var pairs = [(1, "x", 0), (0, "y", 1), (1, "x", 2), (0, "y", 3)]
        pairs.sort(by: \.0, and: \.1)
        #expect(pairs.map(\.2) == [1, 3, 0, 2])
    }

    @Test
    func onlyComputesTheSecondKeyForEqualFirstKeys() {
        var numbers = [3, 1, 2]
        var secondKeyCalls = 0
        numbers.sort(
            by: { $0 },
            and: { (number: Int) -> Int in
                secondKeyCalls += 1
                return number
            })
        #expect(numbers == [1, 2, 3])
        #expect(secondKeyCalls == 0)
    }

    @Test
    func matchesTheNonMutatingForm() {
        let words = ["pear", "fig", "banana", "kiwi", "apple", "date", "Fig"]
        var sorted = words
        sorted.sort(by: \.count, and: { $0.lowercased() })
        #expect(sorted == words.sorted(by: \.count, and: { $0.lowercased() }))
    }

    @Test
    func sortsOnlyTheElementsOfASlice() {
        var words = ["z", "bb", "a", "ab", "y"]
        words[1..<4].sort(by: \.count, and: \.self)
        #expect(words == ["z", "a", "ab", "bb", "y"])
    }

    @Test
    func doesNothingForEmptyCollection() {
        var empty: [String] = []
        empty.sort(by: \.count, and: \.self)
        #expect(empty.isEmpty)
    }

    @Test
    func rethrowsErrorsFromEitherKeyWithoutLosingElements() {
        var numbers = [2, 1, 2, 1]
        #expect(throws: CancellationError.self) {
            try numbers.sort(by: { (_: Int) throws -> Int in throw CancellationError() }, and: { $0 })
        }
        #expect(throws: CancellationError.self) {
            try numbers.sort(by: { $0 }, and: { (_: Int) throws -> Int in throw CancellationError() })
        }
        #expect(numbers.sorted() == [1, 1, 2, 2])
    }
}
