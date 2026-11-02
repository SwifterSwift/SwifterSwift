// MutableCollection+SortByAndAndTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct MutableCollectionSortByAndAndTests {
    private struct Day: Equatable {
        var year: Int
        var month: Int
        var day: Int
    }

    @Test
    func sortsByEachKeyInTurn() {
        var words = ["bat", "Cat", "Bat", "be", "ant"]
        words.sort(by: \.count, and: { $0.lowercased() }, and: \.self)
        #expect(words == ["be", "ant", "Bat", "bat", "Cat"])
    }

    @Test
    func sortsDatesByYearMonthAndDay() {
        var days = [
            Day(year: 2026, month: 1, day: 2),
            Day(year: 2025, month: 12, day: 31),
            Day(year: 2026, month: 1, day: 1),
            Day(year: 2026, month: -1, day: 9)
        ]
        days.sort(by: \.year, and: \.month, and: \.day)
        #expect(
            days == [
                Day(year: 2025, month: 12, day: 31),
                Day(year: 2026, month: -1, day: 9),
                Day(year: 2026, month: 1, day: 1),
                Day(year: 2026, month: 1, day: 2)
            ])
    }

    @Test
    func keepsTheOriginalOrderWhenAllKeysAreEqual() {
        var rows = [(1, 1, 1, "a"), (0, 0, 0, "b"), (1, 1, 1, "c"), (0, 0, 0, "d")]
        rows.sort(by: \.0, and: \.1, and: \.2)
        #expect(rows.map(\.3) == ["b", "d", "a", "c"])
    }

    @Test
    func onlyComputesLaterKeysForEqualEarlierKeys() {
        var rows = [(2, 0), (1, 5), (1, 3)]
        var thirdKeyCalls = 0
        rows.sort(
            by: \.0, and: \.1,
            and: { (row: (Int, Int)) -> Int in
                thirdKeyCalls += 1
                return row.0
            })
        #expect(rows.map(\.1) == [3, 5, 0])
        #expect(thirdKeyCalls == 0)
    }

    @Test
    func matchesTheNonMutatingForm() {
        let words = ["bat", "Cat", "Bat", "be", "ant", "BE", "cat"]
        var sorted = words
        sorted.sort(by: \.count, and: { $0.lowercased() }, and: \.self)
        #expect(sorted == words.sorted(by: \.count, and: { $0.lowercased() }, and: \.self))
    }

    @Test
    func doesNothingForEmptyCollection() {
        var empty: [String] = []
        empty.sort(by: \.count, and: \.self, and: \.self)
        #expect(empty.isEmpty)
    }

    @Test
    func rethrowsErrorsFromAnyKeyWithoutLosingElements() {
        var numbers = [2, 1, 2, 1]
        let failing = { (_: Int) throws -> Int in throw CancellationError() }
        #expect(throws: CancellationError.self) {
            try numbers.sort(by: failing, and: { $0 }, and: { $0 })
        }
        #expect(throws: CancellationError.self) {
            try numbers.sort(by: { $0 }, and: failing, and: { $0 })
        }
        #expect(throws: CancellationError.self) {
            try numbers.sort(by: { $0 }, and: { $0 }, and: failing)
        }
        #expect(numbers.sorted() == [1, 1, 2, 2])
    }
}
