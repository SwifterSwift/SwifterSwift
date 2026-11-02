// Dictionary+KeysForValueTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct DictionaryKeysForValueTests {
    @Test
    func returnsEveryKeyWithTheValue() {
        let colors = ["sky": "blue", "sea": "blue", "grass": "green"]
        #expect(colors.keys(forValue: "blue").sorted() == ["sea", "sky"])
        #expect(colors.keys(forValue: "green") == ["grass"])
    }

    @Test
    func returnsEmptyArrayForMissingValue() {
        let colors = ["sky": "blue"]
        #expect(colors.keys(forValue: "red").isEmpty)
    }

    @Test
    func returnsEmptyArrayForEmptyDictionary() {
        let empty: [String: Int] = [:]
        #expect(empty.keys(forValue: 1).isEmpty)
    }

    @Test
    func comparesOptionalValues() {
        let ages: [String: Int?] = ["Ana": nil, "Ben": 30, "Cy": nil]
        #expect(ages.keys(forValue: nil).sorted() == ["Ana", "Cy"])
        #expect(ages.keys(forValue: 30) == ["Ben"])
    }

    @Test
    func matchesCanonicallyEquivalentStrings() {
        let words = ["first": "caf\u{E9}", "second": "cafe\u{301}", "third": "cafe"]
        #expect(words.keys(forValue: "café").sorted() == ["first", "second"])
    }

    @Test
    func neverMatchesNaN() {
        // NaN isn't equal to anything, including itself.
        let values = ["a": Double.nan, "b": 1]
        #expect(values.keys(forValue: .nan).isEmpty)
        #expect(values.keys(forValue: 1) == ["b"])
    }
}
