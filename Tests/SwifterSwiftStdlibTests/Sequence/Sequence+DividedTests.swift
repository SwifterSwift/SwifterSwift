// Sequence+DividedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceDividedTests {
    @Test
    func splitsIntoMatchingAndNonMatchingElements() {
        let (even, odd) = [1, 2, 3, 4, 5].divided(by: { $0.isMultiple(of: 2) })
        #expect(even == [2, 4])
        #expect(odd == [1, 3, 5])
    }

    @Test
    func keepsTheOriginalOrder() {
        let parts = [5, -1, 3, -4, 0, -2].divided(by: { $0 < 0 })
        #expect(parts.matching == [-1, -4, -2])
        #expect(parts.nonMatching == [5, 3, 0])
    }

    @Test
    func handlesAllOrNoMatches() {
        let all = [2, 4].divided(by: { $0.isMultiple(of: 2) })
        #expect(all.matching == [2, 4])
        #expect(all.nonMatching.isEmpty)

        let none = [1, 3].divided(by: { $0.isMultiple(of: 2) })
        #expect(none.matching.isEmpty)
        #expect(none.nonMatching == [1, 3])
    }

    @Test
    func returnsTwoEmptyArraysForEmptySequence() {
        let parts = [Int]().divided(by: { _ in true })
        #expect(parts.matching.isEmpty)
        #expect(parts.nonMatching.isEmpty)
    }

    @Test
    func dividesCharacters() {
        let parts = "a👍🏽b🇸🇾".divided(by: \.isASCII)
        #expect(String(parts.matching) == "ab")
        #expect(String(parts.nonMatching) == "👍🏽🇸🇾")
    }

    @Test
    func rethrowsErrorsFromThePredicate() {
        #expect(throws: CancellationError.self) {
            try [1].divided(by: { _ in throw CancellationError() })
        }
    }
}
