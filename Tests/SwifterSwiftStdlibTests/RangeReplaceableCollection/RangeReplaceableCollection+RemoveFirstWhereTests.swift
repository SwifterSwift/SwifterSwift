// RangeReplaceableCollection+RemoveFirstWhereTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct RangeReplaceableCollectionRemoveFirstWhereTests {
    @Test
    func removesOnlyTheFirstMatch() {
        var numbers = [1, 2, 3, 4, 2]
        #expect(numbers.removeFirst(where: { $0.isMultiple(of: 2) }) == 2)
        #expect(numbers == [1, 3, 4, 2])
    }

    @Test
    func removesTheFirstAndLastElements() {
        var numbers = [1, 2, 3]
        #expect(numbers.removeFirst(where: { $0 == 1 }) == 1)
        #expect(numbers.removeFirst(where: { $0 == 3 }) == 3)
        #expect(numbers == [2])
    }

    @Test
    func returnsNilAndKeepsTheCollectionWhenNothingMatches() {
        var numbers = [1, 3, 5]
        #expect(numbers.removeFirst(where: { $0.isMultiple(of: 2) }) == nil)
        #expect(numbers == [1, 3, 5])
    }

    @Test
    func returnsNilForEmptyCollection() {
        var empty: [Int] = []
        #expect(empty.removeFirst(where: { _ in true }) == nil)
        #expect(empty.isEmpty)
    }

    @Test
    func removesCharactersFromStrings() {
        var text = "h\u{E9}llo👍🏽"
        #expect(text.removeFirst(where: { !$0.isASCII }) == "é")
        #expect(text == "hllo👍🏽")
        #expect(text.removeFirst(where: { !$0.isASCII }) == "👍🏽")
        #expect(text == "hllo")
    }

    @Test
    func rethrowsAndLeavesTheCollectionUnchanged() {
        var numbers = [1, 2, 3]
        #expect(throws: CancellationError.self) {
            try numbers.removeFirst(where: { _ in throw CancellationError() })
        }
        #expect(numbers == [1, 2, 3])
    }
}
