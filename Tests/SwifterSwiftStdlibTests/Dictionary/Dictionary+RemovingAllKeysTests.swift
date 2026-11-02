// Dictionary+RemovingAllKeysTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct DictionaryRemovingAllKeysTests {
    @Test
    func returnsTheDictionaryWithoutTheGivenKeys() {
        let scores = ["Ana": 3, "Ben": 5, "Cy": 8]
        #expect(scores.removingAll(keys: ["Ana", "Cy"]) == ["Ben": 5])
    }

    @Test
    func leavesTheOriginalDictionaryUnchanged() {
        let scores = ["Ana": 3, "Ben": 5]
        _ = scores.removingAll(keys: ["Ana"])
        #expect(scores == ["Ana": 3, "Ben": 5])
    }

    @Test
    func ignoresMissingAndRepeatedKeys() {
        let scores = ["Ana": 3, "Ben": 5]
        #expect(scores.removingAll(keys: ["Dee", "Ana", "Ana"]) == ["Ben": 5])
    }

    @Test
    func returnsAnEqualDictionaryForNoKeys() {
        let scores = ["Ana": 3, "Ben": 5]
        #expect(scores.removingAll(keys: []) == scores)
    }

    @Test
    func returnsEmptyDictionaryForEmptyDictionary() {
        let empty: [String: Int] = [:]
        #expect(empty.removingAll(keys: ["Ana"]).isEmpty)
    }

    @Test
    func removesEveryKey() {
        let scores = ["Ana": 3, "Ben": 5]
        #expect(scores.removingAll(keys: scores.keys).isEmpty)
    }

    @Test
    func acceptsAnySequenceOfKeys() {
        let numbers = [1: "one", 2: "two", 3: "three", 4: "four"]
        #expect(numbers.removingAll(keys: Set([1, 2])) == [3: "three", 4: "four"])
        #expect(numbers.removingAll(keys: stride(from: 2, to: 10, by: 2)) == [1: "one", 3: "three"])
    }

    @Test
    func isTheOppositeOfPick() {
        let scores = ["Ana": 3, "Ben": 5, "Cy": 8]
        let keys = ["Ana", "Dee"]
        let picked = scores.pick(keys: keys)
        let removed = scores.removingAll(keys: keys)
        #expect(picked.merging(removed) { first, _ in first } == scores)
        #expect(Set(picked.keys).isDisjoint(with: removed.keys))
    }

    @Test
    func removesEntriesWhoseValueIsNil() {
        let values: [String: Int?] = ["a": nil, "b": 2]
        #expect(values.removingAll(keys: ["a"]) == ["b": 2])
    }

    @Test
    func matchesCanonicallyEquivalentStringKeys() {
        // "é" as one scalar and as "e" plus a combining accent are equal strings, so they're the same key.
        let words = ["caf\u{E9}": 1, "tea": 2]
        #expect(words.removingAll(keys: ["cafe\u{301}"]) == ["tea": 2])
    }
}
