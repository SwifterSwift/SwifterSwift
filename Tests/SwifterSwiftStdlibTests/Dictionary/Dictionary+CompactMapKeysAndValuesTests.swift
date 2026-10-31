// Dictionary+CompactMapKeysAndValuesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct DictionaryCompactMapKeysAndValuesTests {
    @Test
    func transformsKeysAndValuesAndDropsNil() {
        let fields = ["age": "42", "height": "1.8", "name": "Ana"]
        let numbers = fields.compactMapKeysAndValues(
            { entry in Int(entry.value).map { (entry.key.uppercased(), $0) } },
            uniquingKeysWith: { current, _ in current }
        )
        #expect(numbers == ["AGE": 42])
    }

    @Test
    func combinesTheValuesOfDuplicateKeysInsteadOfTrapping() {
        let fields = ["Age": "42", "age": "7", "AGE": "x", "Name": "Ana"]
        let numbers = fields.compactMapKeysAndValues(
            { entry in Int(entry.value).map { (entry.key.lowercased(), $0) } },
            uniquingKeysWith: max
        )
        #expect(numbers == ["age": 42])
    }

    @Test
    func returnsEmptyDictionaryWhenEveryEntryIsDropped() {
        let fields = ["a": "x", "b": "y"]
        let numbers = fields.compactMapKeysAndValues(
            { entry in Int(entry.value).map { (entry.key, $0) } },
            uniquingKeysWith: +
        )
        #expect(numbers.isEmpty)
    }

    @Test
    func returnsEmptyDictionaryForEmptyDictionary() {
        let empty: [String: Int] = [:]
        #expect(empty.compactMapKeysAndValues({ ($0.key, $0.value) }, uniquingKeysWith: +).isEmpty)
    }

    @Test
    func doesNotCombineValuesOfDroppedEntries() {
        let values = ["a": 1, "A": 2, "b": 3]
        let kept = values.compactMapKeysAndValues(
            { entry in entry.value == 2 ? nil : (entry.key.lowercased(), entry.value) },
            uniquingKeysWith: { current, _ in
                Issue.record("Only one entry is kept for each key, so nothing should be combined.")
                return current
            }
        )
        #expect(kept == ["a": 1, "b": 3])
    }

    @Test
    func rethrowsErrorsFromTransform() {
        let numbers = ["one": 1]
        #expect(throws: CancellationError.self) {
            try numbers.compactMapKeysAndValues(
                { _ -> (String, Int)? in throw CancellationError() },
                uniquingKeysWith: +
            )
        }
    }

    @Test
    func rethrowsErrorsFromCombine() {
        let numbers = ["a": 1, "A": 2]
        #expect(throws: CancellationError.self) {
            try numbers.compactMapKeysAndValues(
                { ($0.key.lowercased(), $0.value) },
                uniquingKeysWith: { _, _ in throw CancellationError() }
            )
        }
    }
}
