// Dictionary+RemoveAllKeysTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct DictionaryRemoveAllKeysTests {
    @Test
    func removesTheGivenKeys() {
        var scores = ["Ana": 3, "Ben": 5, "Cy": 8]
        scores.removeAll(keys: ["Ana", "Cy"])
        #expect(scores == ["Ben": 5])
    }

    @Test
    func ignoresMissingAndRepeatedKeys() {
        var scores = ["Ana": 3, "Ben": 5]
        scores.removeAll(keys: ["Dee", "Ana", "Ana"])
        #expect(scores == ["Ben": 5])
    }

    @Test
    func leavesTheDictionaryUnchangedForNoKeys() {
        var scores = ["Ana": 3, "Ben": 5]
        scores.removeAll(keys: [])
        #expect(scores == ["Ana": 3, "Ben": 5])
    }

    @Test
    func doesNothingForEmptyDictionary() {
        var empty: [String: Int] = [:]
        empty.removeAll(keys: ["Ana"])
        #expect(empty.isEmpty)
    }

    @Test
    func removesEveryKey() {
        var scores = ["Ana": 3, "Ben": 5]
        scores.removeAll(keys: scores.keys)
        #expect(scores.isEmpty)
    }

    @Test
    func acceptsAnySequenceOfKeys() {
        var numbers = [1: "one", 2: "two", 3: "three", 4: "four"]
        numbers.removeAll(keys: Set([1, 2]))
        numbers.removeAll(keys: stride(from: 4, to: 10, by: 2))
        #expect(numbers == [3: "three"])
    }

    @Test
    func matchesCanonicallyEquivalentStringKeys() {
        // "é" as one scalar and as "e" plus a combining accent are equal strings, so they're the same key.
        var words = ["caf\u{E9}": 1, "tea": 2]
        words.removeAll(keys: ["cafe\u{301}"])
        #expect(words == ["tea": 2])
    }
}
