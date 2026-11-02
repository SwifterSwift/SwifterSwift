// String+IsNumeric.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Whether the string is a finite number written the way the given locale writes numbers.
    ///
    /// Leading and trailing whitespace is ignored, and the rest must be a whole number in the locale's format: its
    /// decimal separator, its grouping separator (with correctly sized groups), an optional minus sign and an optional
    /// exponent such as `e5`. For example, `"1,234.5"` is numeric in `en_US` and `"1.234,5"` in `de_DE`, but not the
    /// other way around. Decimal digits from other scripts, such as the Arabic-Indic `"١٢٣"`, are accepted as well.
    /// Foundation outside Apple platforms parses more leniently, and accepts `"1 000"` in `en_US`, for example.
    ///
    /// Text that only starts with a number (`"12abc"`), hexadecimal floats (`"0x1p3"`), not-a-number and infinity are
    /// all rejected, even though `Double(_:)` accepts some of them. Parse the string with `Double(_:format:lenient:)`
    /// and the same locale to get its value.
    ///
    /// ```swift
    /// let unitedStates = Locale(identifier: "en_US")
    /// "1,234.5".isNumeric(locale: unitedStates)  // true
    /// "-1.5e3".isNumeric(locale: unitedStates)  // true
    /// "1.234,5".isNumeric(locale: Locale(identifier: "de_DE"))  // true
    /// "1.234,5".isNumeric(locale: unitedStates)  // false
    /// "nan".isNumeric(locale: unitedStates)  // false
    /// ```
    ///
    /// - Parameter locale: The locale whose number format to accept. The default is the user's current locale.
    /// - Returns: `true` if the string, without surrounding whitespace, is a finite number in the locale's format.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func isNumeric(locale: Locale = .current) -> Bool {
        let number = trimmingCharacters(in: .whitespacesAndNewlines)
        guard let value = number.wholeMatch(of: FloatingPointFormatStyle<Double>(locale: locale))?.output else {
            return false
        }
        return value.isFinite
    }
}
#endif
