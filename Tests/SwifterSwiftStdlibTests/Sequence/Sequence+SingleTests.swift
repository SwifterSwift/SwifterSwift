// Sequence+SingleTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceSingleTests {
    @Test(arguments: [
        ([1, 4, 7], 4),
        ([4], 4),
        ([1, 3, 7, 8], 8)
    ])
    func returnsTheOnlyMatch(_ numbers: [Int], expected: Int) {
        #expect(numbers.single(where: { $0.isMultiple(of: 2) }) == expected)
    }

    @Test(arguments: [[2, 4, 7], [1, 3, 7], [2, 2], []])
    func returnsNilUnlessExactlyOneElementMatches(_ numbers: [Int]) {
        #expect(numbers.single(where: { $0.isMultiple(of: 2) }) == nil)
    }

    @Test
    func stopsAtTheSecondMatch() {
        var calls = 0
        let match = [2, 3, 4, 5, 6].single { number in
            calls += 1
            return number.isMultiple(of: 2)
        }
        #expect(match == nil)
        #expect(calls == 3)

        #expect((1...).single(where: { $0.isMultiple(of: 3) }) == nil)
    }

    @Test
    func returnsOptionalElements() {
        let values: [Int?] = [1, nil, 3]
        #expect(values.single(where: { $0 == nil }) == .some(nil))
    }

    @Test
    func matchesCharacters() {
        #expect("swift👍🏽".single(where: { !$0.isASCII }) == "👍🏽")
        #expect("👍🏽swift👍".single(where: { !$0.isASCII }) == nil)
    }

    @Test
    func rethrowsErrorsFromThePredicate() {
        #expect(throws: CancellationError.self) {
            try [1].single(where: { _ in throw CancellationError() })
        }
    }
}
