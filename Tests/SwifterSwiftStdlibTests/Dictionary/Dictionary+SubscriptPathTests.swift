// Dictionary+SubscriptPathTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct DictionarySubscriptPathTests {
    private let json: [String: Any] = [
        "id": 7,
        "user": [
            "name": "Ana",
            "address": ["city": "Damascus", "zip": 12345] as [String: Any],
            "tags": ["swift", "ios"]
        ] as [String: Any],
        "scores": ["math": 9, "art": 7] as [String: Int],
        "items": [["id": 1], ["id": 2]] as [[String: Any]]
    ]

    @Test
    func returnsTheValueAtTheEndOfThePath() {
        #expect(json[path: ["user", "address", "city"]] as? String == "Damascus")
        #expect(json[path: ["user", "address", "zip"]] as? Int == 12345)
        #expect(json[path: ["user", "name"]] as? String == "Ana")
        #expect(json[path: ["user", "tags"]] as? [String] == ["swift", "ios"])
    }

    @Test
    func returnsTheValueForASingleKey() {
        #expect(json[path: ["id"]] as? Int == 7)
        #expect(json[path: ["missing"]] == nil)
    }

    @Test
    func returnsNestedDictionaries() throws {
        let address = try #require(json[path: ["user", "address"]] as? [String: Any])
        #expect(address["city"] as? String == "Damascus")
    }

    @Test
    func followsNestedDictionariesWithTypedValues() {
        #expect(json[path: ["scores", "math"]] as? Int == 9)
        #expect(json[path: ["scores", "music"]] == nil)
    }

    @Test
    func returnsNilForAMissingKey() {
        #expect(json[path: ["user", "age"]] == nil)
        #expect(json[path: ["account", "name"]] == nil)
        #expect(json[path: ["user", "address", "street"]] == nil)
    }

    @Test
    func returnsNilWhenAKeyDoesNotLeadToADictionary() {
        #expect(json[path: ["id", "value"]] == nil)
        #expect(json[path: ["user", "name", "first"]] == nil)
        #expect(json[path: ["user", "tags", "0"]] == nil)
    }

    @Test
    func doesNotIndexIntoArrays() {
        #expect(json[path: ["items", "id"]] == nil)
    }

    @Test
    func returnsNilForAnEmptyPath() {
        #expect(json[path: []] == nil)
        let empty: [String: Any] = [:]
        #expect(empty[path: []] == nil)
        #expect(empty[path: ["a"]] == nil)
    }

    @Test
    func worksWithNonStringKeys() {
        let tree: [Int: Any] = [1: [2: [3: "deep"] as [Int: Any]] as [Int: Any]]
        #expect(tree[path: [1, 2, 3]] as? String == "deep")
        #expect(tree[path: [1, 3]] == nil)
    }

    @Test
    func worksWithAnyHashableKeysOfMixedTypes() {
        let info: [AnyHashable: Any] = ["user": [1: "first", "name": "Ana"] as [AnyHashable: Any]]
        #expect(info[path: ["user", 1]] as? String == "first")
        #expect(info[path: ["user", "name"]] as? String == "Ana")
        #expect(info[path: ["user", 2]] == nil)
    }

    @Test
    func matchesKeysExactlyWithoutSplittingAtDots() {
        let settings: [String: Any] = ["a.b": 1, "a": ["b": 2] as [String: Any]]
        #expect(settings[path: ["a.b"]] as? Int == 1)
        #expect(settings[path: ["a", "b"]] as? Int == 2)
    }

    @Test
    func matchesCanonicallyEquivalentStringKeys() {
        let places: [String: Any] = ["caf\u{E9}": ["name": "Rawda"] as [String: Any]]
        #expect(places[path: ["cafe\u{301}", "name"]] as? String == "Rawda")
    }
}
