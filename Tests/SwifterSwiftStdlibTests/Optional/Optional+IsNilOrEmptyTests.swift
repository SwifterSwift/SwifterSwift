// Optional+IsNilOrEmptyTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct OptionalIsNilOrEmptyTests {
    @Test
    func returnsTrueForNil() {
        let string: String? = nil
        let array: [Int]? = nil
        let dictionary: [String: Int]? = nil
        #expect(string.isNilOrEmpty)
        #expect(array.isNilOrEmpty)
        #expect(dictionary.isNilOrEmpty)
    }

    @Test
    func returnsTrueForEmptyCollections() {
        let string: String? = ""
        let array: [Int]? = []
        let set: Set<Int>? = []
        let dictionary: [String: Int]? = [:]
        let substring: Substring? = "abc".dropFirst(3)
        #expect(string.isNilOrEmpty)
        #expect(array.isNilOrEmpty)
        #expect(set.isNilOrEmpty)
        #expect(dictionary.isNilOrEmpty)
        #expect(substring.isNilOrEmpty)
    }

    @Test(arguments: [" ", "\n", "a", "\u{301}", "👍🏽", "🇸🇾", "Swift"])
    func returnsFalseForNonEmptyStrings(text: String) {
        let optional: String? = text
        #expect(!optional.isNilOrEmpty)
    }

    @Test
    func returnsFalseForNonEmptyCollections() {
        let array: [Int]? = [0]
        let optionalElements: [Int?]? = [nil]
        let range: Range<Int>? = 0..<1
        #expect(!array.isNilOrEmpty)
        #expect(!optionalElements.isNilOrEmpty)
        #expect(!range.isNilOrEmpty)
    }

    @Test
    func differsFromTheOptionalChainingShortcut() {
        let missing: [Int]? = nil
        #expect((missing?.isEmpty == true) == false)
        #expect(missing.isNilOrEmpty)
    }
}
