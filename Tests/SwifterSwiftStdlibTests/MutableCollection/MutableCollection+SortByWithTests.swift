// MutableCollection+SortByWithTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct MutableCollectionSortByWithTests {
    @Test
    func sortsByTheKeyUsingTheComparison() {
        var fruits = ["banana", "fig", "apple"]
        fruits.sort(by: \.count, with: >)
        #expect(fruits == ["banana", "apple", "fig"])
        fruits.sort(by: \.count, with: <)
        #expect(fruits == ["fig", "apple", "banana"])
    }

    @Test
    func acceptsKeysThatAreNotComparable() {
        var pairs = [(1, "b"), (2, "a"), (3, "c")]
        pairs.sort(by: { [$0.1] }, with: { $0.lexicographicallyPrecedes($1) })
        #expect(pairs.map(\.0) == [2, 1, 3])
    }

    @Test
    func keepsTheOriginalOrderOfEqualKeys() {
        var words = ["bb", "a", "cc", "b"]
        words.sort(by: \.count, with: >)
        #expect(words == ["bb", "cc", "a", "b"])
    }

    @Test
    func matchesTheNonMutatingForm() {
        let words = ["pear", "fig", "banana", "kiwi", "apple", "date"]
        var sorted = words
        sorted.sort(by: \.count, with: >)
        #expect(sorted == words.sorted(by: \.count, with: >))
    }

    @Test
    func sortsOnlyTheElementsOfASlice() {
        var numbers = [0, 1, 2, 3, 9]
        numbers[1...3].sort(by: { $0 }, with: >)
        #expect(numbers == [0, 3, 2, 1, 9])
    }

    @Test
    func doesNothingForEmptyCollection() {
        var empty: [String] = []
        empty.sort(by: \.count, with: <)
        #expect(empty.isEmpty)
    }

    @Test
    func sortsStringsByUnicodeScalarCount() {
        // "e" with a combining accent is one `Character` made of two Unicode scalars.
        var words = ["👍🏽🇸🇾", "a", "e\u{301}"]
        words.sort(by: \.unicodeScalars.count, with: <)
        #expect(words == ["a", "e\u{301}", "👍🏽🇸🇾"])
    }

    @Test
    func rethrowsErrorsFromEitherClosureWithoutLosingElements() {
        var numbers = [2, 1, 3]
        #expect(throws: CancellationError.self) {
            try numbers.sort(by: { (_: Int) throws -> Int in throw CancellationError() }, with: <)
        }
        #expect(throws: CancellationError.self) {
            try numbers.sort(by: { $0 }, with: { (_: Int, _: Int) throws -> Bool in throw CancellationError() })
        }
        #expect(numbers.sorted() == [1, 2, 3])
    }
}
