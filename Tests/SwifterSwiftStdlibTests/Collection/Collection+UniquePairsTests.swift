// Collection+UniquePairsTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct CollectionUniquePairsTests {
    @Test
    func pairsEachElementWithEveryLaterElementInOrder() {
        let pairs = [1, 2, 3].uniquePairs()
        #expect(pairs.map { [$0.0, $0.1] } == [[1, 2], [1, 3], [2, 3]])

        let letters = ["a", "b", "c", "d"].uniquePairs().map { $0.0 + $0.1 }
        #expect(letters == ["ab", "ac", "ad", "bc", "bd", "cd"])
    }

    @Test
    func returnsNoPairsForFewerThanTwoElements() {
        #expect([Int]().uniquePairs().isEmpty)
        #expect([1].uniquePairs().isEmpty)
        #expect("".uniquePairs().isEmpty)
    }

    @Test
    func returnsOnePairForTwoElements() {
        #expect([7, 8].uniquePairs().map { [$0.0, $0.1] } == [[7, 8]])
    }

    @Test(arguments: 0...12)
    func returnsEveryTwoCombination(_ count: Int) {
        let pairs = Array(0..<count).uniquePairs()
        #expect(pairs.count == count * (count - 1) / 2)
        #expect(pairs.allSatisfy { $0.0 < $0.1 })
        #expect(Set(pairs.map { [$0.0, $0.1] }).count == pairs.count)
    }

    @Test
    func pairsEqualElementsByPosition() {
        #expect(["a", "a"].uniquePairs().map { $0.0 + $0.1 } == ["aa"])
        #expect([1, 1, 2].uniquePairs().map { [$0.0, $0.1] } == [[1, 1], [1, 2], [1, 2]])
    }

    @Test
    func givesTheSameResultWhenCalledAgain() {
        let numbers = [1, 2, 3, 4]
        let first = numbers.uniquePairs().map { [$0.0, $0.1] }
        let second = numbers.uniquePairs().map { [$0.0, $0.1] }
        #expect(first == second)
        #expect(first.count == 6)
    }

    @Test
    func pairsTheCharactersOfAString() {
        // Each emoji and flag is one `Character`, however many Unicode scalars it has.
        let pairs = "a🇸🇾🧑‍💻".uniquePairs().map { String([$0.0, $0.1]) }
        #expect(pairs == ["a🇸🇾", "a🧑‍💻", "🇸🇾🧑‍💻"])
    }

    @Test
    func pairsTheElementsOfASlice() {
        let pairs = [0, 1, 2, 3, 4][1..<4].uniquePairs()
        #expect(pairs.map { [$0.0, $0.1] } == [[1, 2], [1, 3], [2, 3]])
    }

    @Test
    func worksWithCollectionsThatAreNotRandomAccess() {
        let pairs = Set([1, 2, 3]).uniquePairs()
        #expect(pairs.count == 3)
        #expect(Set(pairs.map { Set([$0.0, $0.1]) }) == [[1, 2], [1, 3], [2, 3]])

        let lazyPairs = [1, 2, 3].lazy.filter { $0 != 2 }.uniquePairs()
        #expect(lazyPairs.map { [$0.0, $0.1] } == [[1, 3]])
    }
}
