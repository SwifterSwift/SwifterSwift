// String+IsSpelledCorrectlyTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct StringIsSpelledCorrectlyTests {
    static let english = "en"

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
        try #require(NSSpellChecker.shared.availableLanguages.contains("fr"))
        #expect("Bonjour le monde".isSpelledCorrectly(language: "fr"))
        #expect(!"Bonjour le monde".isSpelledCorrectly(language: Self.english))
    }

    @Test
    func checksTheWholeStringWithEmojiAndCombiningMarks() {
        #expect(!"👋🏽 cafe\u{301} Helol".isSpelledCorrectly(language: Self.english))
    }
}
#endif
