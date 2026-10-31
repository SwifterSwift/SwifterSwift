// Sequence+SortedByAndAndTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceSortedByAndAndTests {
    private struct Day: Equatable {
        var year: Int
        var month: Int
        var day: Int
    }

    @Test
    func sortsByEachKeyWhenTheKeysBeforeItAreEqual() {
        let words = ["bat", "Cat", "Bat", "be", "ant"]
        let sorted = words.sorted(by: \.count, and: { $0.lowercased() }, and: \.self)
        #expect(sorted == ["be", "ant", "Bat", "bat", "Cat"])
    }

    @Test
    func sortsByPropertiesOfTheElements() {
        let days = [
            Day(year: 2026, month: 3, day: 2),
            Day(year: 2025, month: 12, day: 31),
            Day(year: 2026, month: 3, day: 1),
            Day(year: 2026, month: 1, day: 9)
        ]
        let sorted = days.sorted(by: \.year, and: \.month, and: \.day)
        #expect(
            sorted == [
                Day(year: 2025, month: 12, day: 31),
                Day(year: 2026, month: 1, day: 9),
                Day(year: 2026, month: 3, day: 1),
                Day(year: 2026, month: 3, day: 2)
            ]
        )
    }

    @Test
    func keepsTheOriginalOrderWhenAllKeysAreEqual() {
        let pairs = [(1, "x"), (0, "y"), (1, "z")]
        let sorted = pairs.sorted(by: { $0.0 }, and: { _ in 0 }, and: { _ in "" })
        #expect(sorted.map(\.1) == ["y", "x", "z"])
    }

    @Test
    func computesLaterKeysOnlyForEqualEarlierKeys() {
        var secondKeyCalls = 0
        var thirdKeyCalls = 0
        let sorted = [3, 1, 2].sorted(
            by: { $0 },
            and: { number in
                secondKeyCalls += 1
                return number
            },
            and: { number in
                thirdKeyCalls += 1
                return number
            }
        )
        #expect(sorted == [1, 2, 3])
        #expect(secondKeyCalls == 0)
        #expect(thirdKeyCalls == 0)
    }

    @Test
    func returnsEmptyArrayForEmptySequence() {
        #expect([String]().sorted(by: \.count, and: \.self, and: \.self).isEmpty)
    }

    @Test
    func rethrowsErrorsFromAnyKeyClosure() {
        #expect(throws: CancellationError.self) {
            try [1, 2].sorted(by: { (_: Int) throws -> Int in throw CancellationError() }, and: { $0 }, and: { $0 })
        }
        #expect(throws: CancellationError.self) {
            try [1, 1].sorted(by: { $0 }, and: { (_: Int) throws -> Int in throw CancellationError() }, and: { $0 })
        }
        #expect(throws: CancellationError.self) {
            try [1, 1].sorted(by: { $0 }, and: { $0 }, and: { (_: Int) throws -> Int in throw CancellationError() })
        }
    }
}
