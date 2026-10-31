// String+Latinized.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: The string transliterated into the Latin script, without accents or other diacritics.
    ///
    /// Text in other scripts is spelled out in Latin letters by the `.toLatin` transform, so Cyrillic, Greek, Arabic,
    /// Hebrew, Chinese, Japanese, Korean and Indic text all come out in Latin. The `.stripDiacritics` transform then
    /// removes accents, so `"é"` becomes `"e"`. This is handy for search keys and sorting, but the spelling is
    /// mechanical: it isn't the customary English name (`"北京"` gives `"bei jing"`, not `"Beijing"`), and it isn't a
    /// reversible romanization.
    ///
    /// Letters that are distinct Latin letters rather than a letter plus a mark, such as `"ß"`, `"æ"`, `"ø"` and
    /// `"ł"`, are kept, so the result isn't always ASCII. Digits, punctuation, emoji and scripts the transform doesn't
    /// cover are kept as they are. Case isn't changed. To only remove diacritics, use
    /// `folding(options: .diacriticInsensitive, locale:)`.
    ///
    /// ```swift
    /// "Привет, мир".latinized  // "Privet, mir"
    /// "Ångström".latinized  // "Angstrom"
    /// "Αθήνα".latinized  // "Athena"
    /// "こんにちは".latinized  // "kon'nichiha"
    /// "Straße".latinized  // "Straße"
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var latinized: String {
        // `String.applyingTransform(_:reverse:)` only exists on Apple platforms; the NSString method exists everywhere.
        let latin = NSString(string: self).applyingTransform(.toLatin, reverse: false) ?? self
        return NSString(string: latin).applyingTransform(.stripDiacritics, reverse: false) ?? latin
    }
}
#endif
