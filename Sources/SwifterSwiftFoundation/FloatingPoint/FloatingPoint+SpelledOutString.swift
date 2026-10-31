// FloatingPoint+SpelledOutString.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension FloatingPoint {
    /// SwifterSwift: Returns the number spelled out in words, such as "twelve point three two", in the given locale.
    ///
    /// Foundation's format styles have no spell-out style, so this uses a `NumberFormatter` with the `.spellOut`
    /// style, created on each call. The words follow the number as it prints, the shortest decimal that reads back as
    /// the same value, so `Float(2.3)` is "two point three" rather than the digits of its `Double` widening,
    /// `2.299999952316284`.
    ///
    /// ```swift
    /// let english = Locale(identifier: "en_US")
    /// 12.32.spelledOutString(locale: english)  // "twelve point three two"
    /// (-0.5).spelledOutString(locale: english)  // "minus zero point five"
    /// Float(2.3).spelledOutString(locale: english)  // "two point three"
    /// 12.32.spelledOutString(locale: Locale(identifier: "de_DE"))  // "zwölf Komma drei zwei"
    /// ```
    ///
    /// `NumberFormatter` spells wrong numbers beyond ±2⁵³ (9,007,199,254,740,992) and cuts fractions after 20
    /// digits, so values outside those limits return `nil`, as do NaN and infinity.
    ///
    /// - Parameter locale: The locale whose language to use. The default is the user's current locale.
    /// - Returns: The number in words, or `nil` if it isn't finite, its magnitude is greater than 2⁵³, or it has
    ///   more than 20 digits after the decimal point.
    func spelledOutString(locale: Locale = .current) -> String? {
        guard isFinite,
            let decimal = Decimal(string: "\(self)"),
            decimal.magnitude <= pow(Decimal(2), 53),
            decimal.exponent >= -20
        else { return nil }
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .spellOut
        return formatter.string(from: NSDecimalNumber(decimal: decimal))
    }
}
#endif
