// MutableCollection+MutateEachTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct MutableCollectionMutateEachTests {
    private struct User: Equatable {
        var name: String
        var isActive: Bool
    }

    @Test
    func changesEveryElementInPlace() {
        var prices = [10, 20, 30]
        prices.mutateEach { $0 *= 2 }
        #expect(prices == [20, 40, 60])
    }

    @Test
    func changesPropertiesOfEveryElement() {
        var users = [User(name: "Ana", isActive: true), User(name: "Ben", isActive: false)]
        users.mutateEach { $0.isActive.toggle() }
        #expect(users == [User(name: "Ana", isActive: false), User(name: "Ben", isActive: true)])
    }

    @Test
    func visitsElementsInOrder() {
        var letters = ["a", "b", "c"]
        var visited: [String] = []
        letters.mutateEach { letter in
            visited.append(letter)
            letter = letter.uppercased()
        }
        #expect(visited == ["a", "b", "c"])
        #expect(letters == ["A", "B", "C"])
    }

    @Test
    func doesNothingForEmptyCollection() {
        var empty: [Int] = []
        empty.mutateEach { _ in Issue.record("The closure shouldn't be called for an empty collection.") }
        #expect(empty.isEmpty)
    }

    @Test
    func changesOnlyTheElementsOfASlice() {
        var numbers = [1, 2, 3, 4, 5]
        numbers[1..<3].mutateEach { $0 = 0 }
        #expect(numbers == [1, 0, 0, 4, 5])
    }

    @Test
    func keepsChangesMadeBeforeAnErrorIsThrown() {
        var numbers = [1, 2, 3]
        #expect(throws: CancellationError.self) {
            try numbers.mutateEach { number in
                number = -number
                if number == -2 {
                    throw CancellationError()
                }
            }
        }
        #expect(numbers == [-1, -2, 3])
    }
}
