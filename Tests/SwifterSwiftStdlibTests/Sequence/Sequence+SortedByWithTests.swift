// Sequence+SortedByWithTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceSortedByWithTests {
    @Test
    func sortsByTheKeyUsingTheComparison() {
        #expect(["banana", "fig", "apple"].sorted(by: \.count, with: >) == ["banana", "apple", "fig"])
        #expect(["banana", "fig", "apple"].sorted(by: \.count, with: <) == ["fig", "apple", "banana"])
    }

    @Test
    func acceptsKeysThatAreNotComparable() {
        let pairs = [(1, "b"), (2, "a"), (3, "c")]
        let sorted = pairs.sorted(by: { [$0.1] }, with: { $0.lexicographicallyPrecedes($1) })
        #expect(sorted.map(\.0) == [2, 1, 3])
    }

    @Test
    func keepsTheOriginalOrderOfEqualKeys() {
        #expect(["bb", "a", "cc", "b"].sorted(by: \.count, with: >) == ["bb", "cc", "a", "b"])
    }

    @Test
    func returnsEmptyArrayForEmptySequence() {
        #expect([String]().sorted(by: \.count, with: <).isEmpty)
    }

    @Test
    func sortsStringsByUnicodeScalarCount() {
        // "e" with a combining accent is one `Character` made of two Unicode scalars.
        let words = ["e\u{301}", "a", "👍🏽🇸🇾"]
        #expect(words.sorted(by: \.unicodeScalars.count, with: <) == ["a", "e\u{301}", "👍🏽🇸🇾"])
    }

    @Test
    func rethrowsErrorsFromEitherClosure() {
        #expect(throws: CancellationError.self) {
            try [1, 2].sorted(by: { (_: Int) throws -> Int in throw CancellationError() }, with: <)
        }
        #expect(throws: CancellationError.self) {
            try [1, 2].sorted(by: { $0 }, with: { (_: Int, _: Int) throws -> Bool in throw CancellationError() })
        }
    }
}
