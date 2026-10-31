// MutableCollection+SortByTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct MutableCollectionSortByTests {
    private struct Person: Equatable {
        var name: String
        var age: Int
    }

    @Test
    func sortsByTheKeyInIncreasingOrder() {
        var fruits = ["banana", "fig", "apple"]
        fruits.sort(by: \.count)
        #expect(fruits == ["fig", "apple", "banana"])

        var numbers = [3, -1, 2, Int.min, Int.max]
        numbers.sort(by: { $0 })
        #expect(numbers == [Int.min, -1, 2, 3, Int.max])
    }

    @Test
    func sortsByAPropertyOfTheElements() {
        var people = [Person(name: "Ana", age: 30), Person(name: "Ben", age: 12), Person(name: "Cy", age: 50)]
        people.sort(by: \.age)
        #expect(people.map(\.name) == ["Ben", "Ana", "Cy"])
        people.sort(by: \.name)
        #expect(people.map(\.name) == ["Ana", "Ben", "Cy"])
    }

    @Test
    func acceptsTheIdentityKeyPath() {
        var letters = ["c", "a", "b"]
        letters.sort(by: \.self)
        #expect(letters == ["a", "b", "c"])
    }

    @Test
    func keepsTheOriginalOrderOfEqualKeys() {
        var words = ["bb", "a", "cc", "b", "aa", "c"]
        words.sort(by: \.count)
        #expect(words == ["a", "b", "c", "bb", "cc", "aa"])
    }

    @Test
    func matchesTheNonMutatingForm() {
        let words = ["pear", "fig", "banana", "kiwi", "apple", "date"]
        var sorted = words
        sorted.sort(by: \.count)
        #expect(sorted == words.sorted(by: \.count))
    }

    @Test
    func leavesTheStandardLibraryComparisonOverloadAlone() {
        var numbers = [3, 1, 2]
        numbers.sort(by: <)
        #expect(numbers == [1, 2, 3])
        numbers.sort(by: >)
        #expect(numbers == [3, 2, 1])
        numbers.sort { $0 < $1 }
        #expect(numbers == [1, 2, 3])
        numbers.sort { lhs, rhs in lhs > rhs }
        #expect(numbers == [3, 2, 1])

        var words = ["b", "c", "a"]
        words.sort(by: <)
        #expect(words == ["a", "b", "c"])
    }

    @Test
    func sortsOnlyTheElementsOfASlice() {
        var numbers = [9, 4, 3, 2, 1, 0]
        numbers[1..<5].sort(by: { $0 })
        #expect(numbers == [9, 1, 2, 3, 4, 0])
    }

    @Test
    func worksWithOtherMutableRandomAccessCollections() {
        var numbers: ContiguousArray = [3, 1, 2]
        numbers.sort(by: { -$0 })
        #expect(numbers == [3, 2, 1])
    }

    @Test
    func doesNothingForEmptyAndSingleElementCollections() {
        var empty: [String] = []
        empty.sort(by: \.count)
        #expect(empty.isEmpty)

        var single = ["a"]
        single.sort(by: \.count)
        #expect(single == ["a"])
    }

    @Test
    func sortsStringsByUnicodeScalarCount() {
        // "e" with a combining accent is one `Character` made of two Unicode scalars.
        var words = ["👍🏽🇸🇾", "e\u{301}", "a"]
        words.sort(by: \.unicodeScalars.count)
        #expect(words == ["a", "e\u{301}", "👍🏽🇸🇾"])
    }

    @Test
    func doesNotTrapForNaNKeys() {
        var numbers = [3.0, .nan, 1.0, -.infinity]
        numbers.sort(by: { $0 })
        #expect(numbers.count == 4)
    }

    @Test
    func rethrowsErrorsFromTheKeyClosureWithoutLosingElements() {
        // 37 and 100 are coprime, so this is a shuffled permutation of 0..<100 that takes many comparisons to sort.
        var numbers = (0..<100).map { $0 * 37 % 100 }
        var calls = 0
        #expect(throws: CancellationError.self) {
            try numbers.sort(by: { (number: Int) throws -> Int in
                calls += 1
                if calls == 200 {
                    throw CancellationError()
                }
                return number
            })
        }
        #expect(numbers.sorted() == Array(0..<100))
    }
}
