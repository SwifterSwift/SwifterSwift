// String+IsSpelledCorrectly.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension String {
    /// SwifterSwift: Returns whether every word in the string is spelled correctly in the given language.
    ///
    /// The string is checked with `UITextChecker`, which uses the dictionaries installed on the device, together with
    /// the words the user has taught it. Punctuation, numbers and the empty string are never misspelled.
    ///
    /// Pass one of `UITextChecker.availableLanguages`, such as `"en_US"` or `"fr_FR"`. A language without a
    /// dictionary can't flag anything, so every string is reported as correctly spelled.
    ///
    /// ```swift
    /// "Hello, World!".isSpelledCorrectly(language: "en_US")  // true
    /// "Helol, Wrold!".isSpelledCorrectly(language: "en_US")  // false
    /// "Bonjour le monde".isSpelledCorrectly(language: "fr_FR")  // true
    /// ```
    ///
    /// - Parameters:
    ///   - language: The language to check the spelling in. The default is the user's preferred spell-checking
    ///     language, the first of `UITextChecker.availableLanguages`.
    ///   - checker: The text checker to use, for example one with words to ignore. The default is a new checker.
    /// - Returns: `true` if the text checker finds no misspelled word; otherwise, `false`.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    @MainActor
    func isSpelledCorrectly(
        language: String = UITextChecker.availableLanguages.first ?? "en_US",
        checker: UITextChecker = UITextChecker()
    ) -> Bool {
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: self,
            range: NSRange(startIndex..<endIndex, in: self),
            startingAt: 0,
            wrap: false,
            language: language
        )
        return misspelledRange.location == NSNotFound
    }
}
#endif
