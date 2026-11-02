// Sequence+SortedByAndTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceSortedByAndTests {
    private struct Person: Equatable {
        var firstName: String
        var lastName: String
    }

    @Test
    func sortsByTheSecondKeyWhenTheFirstKeysAreEqual() {
        #expect(["bb", "c", "aa", "b"].sorted(by: \.count, and: \.self) == ["b", "c", "aa", "bb"])
    }

    @Test
    func sortsByPropertiesOfTheElements() {
        let people = [
            Person(firstName: "Cy", lastName: "Lee"),
            Person(firstName: "Ana", lastName: "Lee"),
            Person(firstName: "Ben", lastName: "Kim")
        ]
        let sorted = people.sorted(by: \.lastName, and: \.firstName)
        #expect(sorted.map(\.firstName) == ["Ben", "Ana", "Cy"])
    }

    @Test
    func keepsTheOriginalOrderWhenBothKeysAreEqual() {
        let pairs = [(1, "x"), (0, "y"), (1, "z")]
        let sorted = pairs.sorted(by: { $0.0 }, and: { _ in 0 })
        #expect(sorted.map(\.1) == ["y", "x", "z"])
    }

    @Test
    func computesTheSecondKeyOnlyForEqualFirstKeys() {
        var secondKeyCalls = 0
        let sorted = [3, 1, 2].sorted(
            by: { $0 },
            and: { number in
                secondKeyCalls += 1
                return number
            })
        #expect(sorted == [1, 2, 3])
        #expect(secondKeyCalls == 0)
    }

    @Test
    func returnsEmptyArrayForEmptySequence() {
        #expect([String]().sorted(by: \.count, and: \.self).isEmpty)
    }

    @Test
    func sortsNegativeAndExtremeKeys() {
        let pairs = [(Int.max, 1), (Int.min, 2), (-1, 3), (Int.min, 1)]
        let sorted = pairs.sorted(by: { $0.0 }, and: { $0.1 })
        #expect(sorted.map(\.0) == [Int.min, Int.min, -1, Int.max])
        #expect(sorted.map(\.1) == [1, 2, 3, 1])
    }

    @Test
    func rethrowsErrorsFromEitherKeyClosure() {
        #expect(throws: CancellationError.self) {
            try [1, 2].sorted(by: { (_: Int) throws -> Int in throw CancellationError() }, and: { $0 })
        }
        #expect(throws: CancellationError.self) {
            try [1, 1].sorted(by: { $0 }, and: { (_: Int) throws -> Int in throw CancellationError() })
        }
    }
}
