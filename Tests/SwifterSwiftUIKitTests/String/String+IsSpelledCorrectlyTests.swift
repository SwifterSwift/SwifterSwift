// String+IsSpelledCorrectlyTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct StringIsSpelledCorrectlyTests {
    static let english = "en_US"

    @Test(arguments: ["Hello, World!", "The quick brown fox jumps over the lazy dog.", "don't", "Swift"])
    func acceptsCorrectSpelling(_ string: String) {
        #expect(string.isSpelledCorrectly(language: Self.english))
    }

    @Test(arguments: ["Helol, Wrold!", "Teh quick brown fox", "The quick brwon fox", "recieve"])
    func rejectsMisspelledWords(_ string: String) {
        #expect(!string.isSpelledCorrectly(language: Self.english))
    }

    @Test(arguments: ["", " ", "1234 !!", "👋🏽 🇸🇾", "...?"])
    func acceptsTextWithoutWords(_ string: String) {
        #expect(string.isSpelledCorrectly(language: Self.english))
    }

    @Test
    func checksInTheGivenLanguage() throws {
        try #require(UITextChecker.availableLanguages.contains("fr_FR"))
        #expect("Bonjour le monde".isSpelledCorrectly(language: "fr_FR"))
        #expect(!"Bonjour le monde".isSpelledCorrectly(language: Self.english))
    }

    @Test
    func usesTheGivenChecker() {
        let checker = UITextChecker()
        checker.ignoreWord("Wrold")
        #expect("Hello, Wrold!".isSpelledCorrectly(language: Self.english, checker: checker))
        #expect(!"Hello, Wrold!".isSpelledCorrectly(language: Self.english))
    }

    @Test
    func checksTheWholeStringWithEmojiAndCombiningMarks() {
        #expect(!"👋🏽 cafe\u{301} Helol".isSpelledCorrectly(language: Self.english))
    }
}
#endif
