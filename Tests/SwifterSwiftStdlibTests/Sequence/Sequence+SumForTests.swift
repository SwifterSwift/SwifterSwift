// Sequence+SumForTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceSumForTests {
    @Test
    func returnsTheSumOfTheValues() {
        #expect(["Ana", "Ben", "Cyril"].sum(for: \.count) == 11)
        #expect([1, 2, 3].sum(for: { $0 * 2 }) == 12)
        #expect([1, 2, 3].sum(for: { Double($0) / 2 }) == 3)
    }

    @Test
    func returnsZeroForEmptySequence() {
        #expect([String]().sum(for: \.count) == 0)
        #expect([Int]().sum(for: { Double($0) }) == 0)
    }

    @Test
    func handlesNegativeAndExtremeValues() {
        #expect([1, 2].sum(for: { $0 - 3 }) == -3)
        #expect([Int.max, Int.min].sum(for: { $0 }) == -1)
    }

    @Test
    func countsCharactersOfUnicodeStrings() {
        #expect(["🇸🇾", "e\u{301}", "👍🏽a"].sum(for: \.count) == 4)
        #expect(["🇸🇾", "e\u{301}", "👍🏽a"].sum(for: \.unicodeScalars.count) == 7)
    }

    @Test
    func rethrowsErrorsFromTheClosure() {
        #expect(throws: CancellationError.self) {
            try [1].sum(for: { (_: Int) throws -> Int in throw CancellationError() })
        }
    }
}
