// Dictionary+LowercaseAllKeysTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct DictionaryLowercaseAllKeysTests {
    @Test
    func lowercasesEveryKey() {
        var headers = ["Content-Type": "json", "ACCEPT": "html", "x-id": "1"]
        headers.lowercaseAllKeys(uniquingKeysWith: { current, _ in current })
        #expect(headers == ["content-type": "json", "accept": "html", "x-id": "1"])
    }

    @Test
    func combinesTheValuesOfCollidingKeys() {
        var counts = ["Swift": 2, "SWIFT": 3, "swift": 4, "Kotlin": 1]
        counts.lowercaseAllKeys(uniquingKeysWith: +)
        #expect(counts == ["swift": 9, "kotlin": 1])
    }

    @Test
    func lowercasesNonASCIIKeys() {
        var words = ["ÉCOLE": 1, "ĞÜNEŞ": 2, "ΑΒΓ": 3, "DŽUNGLA": 4]
        words.lowercaseAllKeys(uniquingKeysWith: +)
        #expect(words == ["école": 1, "ğüneş": 2, "αβγ": 3, "džungla": 4])
    }

    @Test
    func doesNotDependOnALocale() {
        // In a Turkish locale "I" would lowercase to a dotless "ı"; the Unicode default mapping gives "i".
        var keys = ["TITLE": 1]
        keys.lowercaseAllKeys(uniquingKeysWith: +)
        #expect(keys == ["title": 1])
    }

    @Test
    func keepsKeysWithoutCaseUnchanged() {
        var keys = ["123": 1, "👍🏽": 2, "": 3, "مرحبا": 4]
        keys.lowercaseAllKeys(uniquingKeysWith: +)
        #expect(keys == ["123": 1, "👍🏽": 2, "": 3, "مرحبا": 4])
    }

    @Test
    func doesNothingForEmptyDictionary() {
        var empty: [String: Int] = [:]
        empty.lowercaseAllKeys(uniquingKeysWith: +)
        #expect(empty.isEmpty)
    }

    @Test
    func leavesTheDictionaryUnchangedWhenCombineThrows() {
        var counts = ["A": 1, "a": 2]
        #expect(throws: CancellationError.self) {
            try counts.lowercaseAllKeys(uniquingKeysWith: { _, _ in throw CancellationError() })
        }
        #expect(counts == ["A": 1, "a": 2])
    }
}
