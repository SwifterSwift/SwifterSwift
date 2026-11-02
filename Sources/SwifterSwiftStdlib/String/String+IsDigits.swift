// String+IsDigits.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Whether the string is non-empty and made only of the ASCII digits `0` to `9`.
    ///
    /// Signs, decimal separators, spaces and digits from other scripts (such as the Arabic-Indic `"٣"` or the
    /// full-width `"３"`) don't count, so a string that passes can always be parsed by `Int(_:)` or `UInt(_:)` as long
    /// as the value fits. `Character.isNumber` and Foundation's `CharacterSet.decimalDigits` accept those other digits,
    /// which is why they're easy to get wrong for input validation.
    ///
    /// ```swift
    /// "0123".isDigits  // true
    /// "12.5".isDigits  // false
    /// "-1".isDigits  // false
    /// "٣".isDigits  // false
    /// "".isDigits  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var isDigits: Bool {
        !isEmpty && utf8.allSatisfy { $0 >= UInt8(ascii: "0") && $0 <= UInt8(ascii: "9") }
    }
}
