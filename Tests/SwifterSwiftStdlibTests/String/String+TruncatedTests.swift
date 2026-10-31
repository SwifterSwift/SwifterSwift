// String+TruncatedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringTruncatedTests {
    let sentence = "This is a very long sentence"

    @Test
    func truncatesWithEllipsisByDefault() {
        let result = sentence.truncated(toLength: 14)
        #expect(result == "This is a ver…")
        #expect(result.count == 14)
    }

    @Test
    func truncatesWithCustomTrailing() {
        #expect(sentence.truncated(toLength: 14, trailing: "...") == "This is a v...")
        #expect(sentence.truncated(toLength: 14, trailing: "") == "This is a very")
        #expect(sentence.truncated(toLength: 10, trailing: " (more)") == "Thi (more)")
    }

    @Test(arguments: [28, 29, 100, Int.max])
    func returnsStringUnchangedWhenItFits(_ length: Int) {
        #expect(sentence.truncated(toLength: length) == sentence)
    }

    @Test
    func cutsWithoutTrailingWhenTrailingDoesNotFit() {
        #expect(sentence.truncated(toLength: 3, trailing: "...") == "Thi")
        #expect(sentence.truncated(toLength: 2, trailing: "...") == "Th")
        #expect(sentence.truncated(toLength: 1) == "T")
        #expect(sentence.truncated(toLength: 2) == "T…")
    }

    @Test(arguments: [0, -1, Int.min])
    func returnsEmptyStringForNonPositiveLength(_ length: Int) {
        #expect(sentence.truncated(toLength: length).isEmpty)
        #expect(sentence.truncated(toLength: length, trailing: "").isEmpty)
    }

    @Test(arguments: [-1, 0, 5])
    func returnsEmptyStringForEmptyInput(_ length: Int) {
        #expect("".truncated(toLength: length).isEmpty)
    }

    @Test
    func neverSplitsACharacter() {
        let emoji = "👋🏽🇸🇾e\u{301}abc"
        #expect(emoji.truncated(toLength: 4) == "👋🏽🇸🇾e\u{301}…")
        #expect(emoji.truncated(toLength: 2, trailing: "") == "👋🏽🇸🇾")
    }
}
