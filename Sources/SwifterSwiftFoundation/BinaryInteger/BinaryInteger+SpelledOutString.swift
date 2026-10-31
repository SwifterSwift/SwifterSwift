// BinaryInteger+SpelledOutString.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension BinaryInteger {
    /// SwifterSwift: Returns the integer spelled out in words, such as "twenty-one", in the given locale.
    ///
    /// Foundation's format styles have no spell-out style, so this uses a `NumberFormatter` with the `.spellOut`
    /// style, created on each call. It works for unsigned types as well as signed ones.
    ///
    /// ```swift
    /// let english = Locale(identifier: "en_US")
    /// 21.spelledOutString(locale: english)  // "twenty-one"
    /// (-5).spelledOutString(locale: english)  // "minus five"
    /// 92.spelledOutString(locale: Locale(identifier: "fr_FR"))  // "quatre-vingt-douze"
    /// ```
    ///
    /// `NumberFormatter` converts integers to `Double`, so beyond ±2⁵³ (9,007,199,254,740,992) it spells the wrong
    /// number or falls back to digits; those values return `nil` instead.
    ///
    /// - Parameter locale: The locale whose language to use. The default is the user's current locale.
    /// - Returns: The integer in words, or `nil` if its magnitude is greater than 2⁵³.
    func spelledOutString(locale: Locale = .current) -> String? {
        guard let value = Int64(exactly: self), value.magnitude <= 1 << 53 else { return nil }
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .spellOut
        return formatter.string(from: NSNumber(value: value))
    }
}
#endif
