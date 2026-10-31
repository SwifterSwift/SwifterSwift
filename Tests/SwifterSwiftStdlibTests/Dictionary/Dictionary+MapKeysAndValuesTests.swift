// Dictionary+MapKeysAndValuesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct DictionaryMapKeysAndValuesTests {
    @Test
    func transformsKeysAndValues() {
        let numbers = ["one": 1, "two": 2]
        let mapped = numbers.mapKeysAndValues(
            { ($0.value, $0.key.uppercased()) },
            uniquingKeysWith: { current, _ in current }
        )
        #expect(mapped == [1: "ONE", 2: "TWO"])
    }

    @Test
    func combinesTheValuesOfDuplicateKeysInsteadOfTrapping() {
        let stock = ["Apple": 3, "apple": 2, "APPLE": 1, "Pear": 5]
        let merged = stock.mapKeysAndValues({ ($0.key.lowercased(), $0.value) }, uniquingKeysWith: +)
        #expect(merged == ["apple": 6, "pear": 5])
    }

    @Test
    func canMapEveryEntryToTheSameKey() {
        let numbers = Dictionary(uniqueKeysWithValues: (1...100).map { ($0, $0) })
        let total = numbers.mapKeysAndValues({ ("total", $0.value) }, uniquingKeysWith: +)
        #expect(total == ["total": 5050])
    }

    @Test
    func doesNotCallCombineWithoutDuplicateKeys() {
        let numbers = [1: "one", 2: "two"]
        let mapped = numbers.mapKeysAndValues(
            { ($0.key * 10, $0.value) },
            uniquingKeysWith: { current, _ in
                Issue.record("The combine closure shouldn't be called without duplicate keys.")
                return current
            }
        )
        #expect(mapped == [10: "one", 20: "two"])
    }

    @Test
    func returnsEmptyDictionaryForEmptyDictionary() {
        let empty: [String: Int] = [:]
        #expect(empty.mapKeysAndValues({ ($0.key, $0.value) }, uniquingKeysWith: +).isEmpty)
    }

    @Test
    func rethrowsErrorsFromTransform() {
        let numbers = ["one": 1]
        #expect(throws: CancellationError.self) {
            try numbers.mapKeysAndValues({ _ -> (String, Int) in throw CancellationError() }, uniquingKeysWith: +)
        }
    }

    @Test
    func rethrowsErrorsFromCombine() {
        let numbers = ["a": 1, "A": 2]
        #expect(throws: CancellationError.self) {
            try numbers.mapKeysAndValues(
                { ($0.key.lowercased(), $0.value) },
                uniquingKeysWith: { _, _ in throw CancellationError() }
            )
        }
    }
}
