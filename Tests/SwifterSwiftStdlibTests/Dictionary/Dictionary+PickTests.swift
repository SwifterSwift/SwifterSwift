// Dictionary+PickTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct DictionaryPickTests {
    @Test
    func returnsTheEntriesForTheGivenKeys() {
        let scores = ["Ana": 3, "Ben": 5, "Cy": 8]
        #expect(scores.pick(keys: ["Ana", "Cy"]) == ["Ana": 3, "Cy": 8])
        #expect(scores.pick(keys: ["Ben"]) == ["Ben": 5])
    }

    @Test
    func skipsMissingAndRepeatedKeys() {
        let scores = ["Ana": 3, "Ben": 5]
        #expect(scores.pick(keys: ["Dee", "Ana", "Ana"]) == ["Ana": 3])
        #expect(scores.pick(keys: ["Dee"]).isEmpty)
    }

    @Test
    func returnsEmptyDictionaryForNoKeys() {
        let scores = ["Ana": 3]
        #expect(scores.pick(keys: []).isEmpty)
    }

    @Test
    func returnsEmptyDictionaryForEmptyDictionary() {
        let empty: [String: Int] = [:]
        #expect(empty.pick(keys: ["Ana"]).isEmpty)
    }

    @Test
    func keepsEntriesWhoseOptionalValueIsNil() {
        let ages: [String: Int?] = ["Ana": 30, "Ben": nil, "Cy": 12]
        let picked = ages.pick(keys: ["Ben", "Cy", "Dee"])
        #expect(picked.count == 2)
        #expect(picked["Ben"] == .some(nil))
        #expect(picked["Cy"] == 12)
        #expect(picked["Dee"] == nil)
    }

    @Test
    func acceptsAnySequenceOfKeys() {
        let numbers = [1: "one", 2: "two", 3: "three", 4: "four"]
        #expect(numbers.pick(keys: Set([1, 3])) == [1: "one", 3: "three"])
        #expect(numbers.pick(keys: 2...3) == [2: "two", 3: "three"])
    }
}
