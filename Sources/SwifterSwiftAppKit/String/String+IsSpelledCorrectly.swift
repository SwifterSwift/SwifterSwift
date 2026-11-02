// String+IsSpelledCorrectly.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Foundation

public extension String {
    /// SwifterSwift: Returns whether every word in the string is spelled correctly in the given language.
    ///
    /// The string is checked with `NSSpellChecker`, which uses the dictionaries installed on the Mac, together with the
    /// words the user has taught it. Punctuation, numbers and the empty string are never misspelled.
    ///
    /// Pass a language code that the spell checker supports, such as `"en"` or `"fr"` (see the checker's
    /// `availableLanguages`). A language without a dictionary can't flag anything, so every string is reported as
    /// correctly spelled.
    ///
    /// ```swift
    /// "Hello, World!".isSpelledCorrectly(language: "en")  // true
    /// "Helol, Wrold!".isSpelledCorrectly(language: "en")  // false
    /// "Bonjour le monde".isSpelledCorrectly(language: "fr")  // true
    /// ```
    ///
    /// - Parameters:
    ///   - language: The language to check the spelling in, or `nil` for the language the spell checker is set to. The
    ///     default is `nil`.
    ///   - checker: The spell checker to use. The default is the shared spell checker.
    /// - Returns: `true` if the spell checker finds no misspelled word; otherwise, `false`.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func isSpelledCorrectly(language: String? = nil, checker: NSSpellChecker = .shared) -> Bool {
        let misspelledRange = checker.checkSpelling(
            of: self,
            startingAt: 0,
            language: language,
            wrap: false,
            inSpellDocumentWithTag: 0,
            wordCount: nil
        )
        return misspelledRange.location == NSNotFound
    }
}
#endif
