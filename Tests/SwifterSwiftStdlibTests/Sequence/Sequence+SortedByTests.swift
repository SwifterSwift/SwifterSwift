// Sequence+SortedByTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceSortedByTests {
    private struct Person: Equatable {
        var name: String
        var age: Int
    }

    @Test
    func sortsByTheKeyInIncreasingOrder() {
        #expect(["banana", "fig", "apple"].sorted(by: \.count) == ["fig", "apple", "banana"])
        #expect([3, -1, 2, Int.min, Int.max].sorted(by: { $0 }) == [Int.min, -1, 2, 3, Int.max])
    }

    @Test
    func sortsByAPropertyOfTheElements() {
        let people = [Person(name: "Ana", age: 30), Person(name: "Ben", age: 12), Person(name: "Cy", age: 50)]
        #expect(people.sorted(by: \.age).map(\.name) == ["Ben", "Ana", "Cy"])
        #expect(people.sorted(by: \.name).map(\.name) == ["Ana", "Ben", "Cy"])
    }

    @Test
    func keepsTheOriginalOrderOfEqualKeys() {
        #expect(["bb", "a", "cc", "b"].sorted(by: \.count) == ["a", "b", "bb", "cc"])
    }

    @Test
    func doesNotChangeTheStandardLibraryComparisonOverload() {
        #expect([3, 1, 2].sorted(by: >) == [3, 2, 1])
        #expect([3, 1, 2].sorted { $0 < $1 } == [1, 2, 3])
    }

    @Test
    func returnsEmptyArrayForEmptySequence() {
        #expect([String]().sorted(by: \.count).isEmpty)
    }

    @Test
    func doesNotTrapForNaNKeys() {
        let sorted = [3.0, .nan, 1.0].sorted(by: { $0 })
        #expect(sorted.count == 3)
    }

    @Test
    func worksWithSinglePassSequences() {
        var iterator = [3, 1, 2].makeIterator()
        #expect(AnyIterator { iterator.next() }.sorted(by: { (number: Int) in -number }) == [3, 2, 1])
    }

    @Test
    func rethrowsErrorsFromTheKeyClosure() {
        #expect(throws: CancellationError.self) {
            try [1, 2].sorted(by: { (_: Int) throws -> Int in throw CancellationError() })
        }
    }
}
