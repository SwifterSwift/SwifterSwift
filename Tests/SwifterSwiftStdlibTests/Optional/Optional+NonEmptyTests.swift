// Optional+NonEmptyTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct OptionalNonEmptyTests {
    @Test
    func returnsNilForNil() {
        let string: String? = nil
        let array: [Int]? = nil
        #expect(string.nonEmpty == nil)
        #expect(array.nonEmpty == nil)
    }

    @Test
    func returnsNilForEmptyCollections() {
        let string: String? = ""
        let array: [Int]? = []
        let dictionary: [String: Int]? = [:]
        #expect(string.nonEmpty == nil)
        #expect(array.nonEmpty == nil)
        #expect(dictionary.nonEmpty == nil)
    }

    @Test(arguments: [" ", "a", "\u{301}", "👍🏽", "🇸🇾", "Swift"])
    func returnsNonEmptyStringsUnchanged(text: String) {
        let optional: String? = text
        #expect(optional.nonEmpty == text)
    }

    @Test
    func returnsNonEmptyCollectionsUnchanged() {
        let array: [Int]? = [1, 2, 3]
        let dictionary: [String: Int]? = ["a": 1]
        #expect(array.nonEmpty == [1, 2, 3])
        #expect(dictionary.nonEmpty == ["a": 1])
    }

    @Test
    func worksWithNilCoalescing() {
        let empty: String? = ""
        let missing: String? = nil
        let name: String? = "Taylor"
        #expect((empty.nonEmpty ?? "Anonymous") == "Anonymous")
        #expect((missing.nonEmpty ?? "Anonymous") == "Anonymous")
        #expect((name.nonEmpty ?? "Anonymous") == "Taylor")
    }
}
