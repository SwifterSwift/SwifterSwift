// String+Slugified.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Returns the string as a URL slug: lowercase words joined by hyphens, such as `"swift-is-amazing"`.
    ///
    /// Accents and other diacritics are removed (`"é"` becomes `"e"`), case is folded (`"ß"` becomes `"ss"`) and
    /// full-width forms become their ordinary forms. Every run of characters that aren't letters or numbers becomes a
    /// single hyphen, and there are no hyphens at the start or end. Apostrophes are dropped without a hyphen, so
    /// `"Don't"` becomes `"dont"`. The folding doesn't depend on any locale, so the result is the same on every device.
    ///
    /// Letters from scripts without a Latin form, such as Cyrillic or Chinese, are kept (lowercased), which is valid in
    /// modern URLs. A string without letters or numbers gives an empty string.
    ///
    /// ```swift
    /// "Swift is amazing".slugified()  // "swift-is-amazing"
    /// "  Crème Brûlée & Café!  ".slugified()  // "creme-brulee-cafe"
    /// "Don't stop me now".slugified()  // "dont-stop-me-now"
    /// "Привет, мир".slugified()  // "привет-мир"
    /// ```
    ///
    /// - Returns: The slug for the string.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func slugified() -> String {
        let folded = folding(options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive], locale: nil)
        var slug = ""
        var needsHyphen = false
        for character in folded where character != "'" && character != "’" {
            if character.isLetter || character.isNumber {
                if needsHyphen && !slug.isEmpty {
                    slug.append("-")
                }
                needsHyphen = false
                slug += character.lowercased()
            } else {
                needsHyphen = true
            }
        }
        return slug
    }
}
#endif
