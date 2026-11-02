// BinaryInteger+OrdinalString.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension BinaryInteger {
    /// SwifterSwift: Returns the integer as an ordinal number, such as "1st" or "22nd", in the given locale.
    ///
    /// Foundation's format styles have no ordinal style, so this uses a `NumberFormatter` with the `.ordinal` style,
    /// created on each call. Locales whose language has no ordinal form in the system's number data, such as Arabic,
    /// get the plain number.
    ///
    /// ```swift
    /// let english = Locale(identifier: "en_US")
    /// 1.ordinalString(locale: english)  // "1st"
    /// 22.ordinalString(locale: english)  // "22nd"
    /// 113.ordinalString(locale: english)  // "113th"
    /// 1.ordinalString(locale: Locale(identifier: "fr_FR"))  // "1er"
    /// ```
    ///
    /// Beyond ±2,147,483,647 (`Int32.max`), `NumberFormatter` picks wrong suffixes, such as "1,099,511,627,777st",
    /// and from 2⁵³ on wrong digits too, so those values return `nil` instead.
    ///
    /// - Parameter locale: The locale whose language and digits to use. The default is the user's current locale.
    /// - Returns: The ordinal form of the integer, or `nil` if its magnitude is greater than `Int32.max`.
    func ordinalString(locale: Locale = .current) -> String? {
        guard let value = Int32(exactly: self), value != .min else { return nil }
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: value))
    }
}
#endif
