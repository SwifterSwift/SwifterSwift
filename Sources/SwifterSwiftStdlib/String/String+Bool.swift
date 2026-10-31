// String+Bool.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: The Boolean value the string spells, if it's one of the common ways to write true or false.
    ///
    /// The string is matched case-insensitively, after trimming whitespace and newlines from both ends. `"true"`,
    /// `"yes"` and `"1"` give `true`, and `"false"`, `"no"` and `"0"` give `false`. Anything else gives `nil`.
    ///
    /// The standard library's `Bool(_:)` accepts exactly `"true"` and `"false"` and nothing else; this property is
    /// meant for loosely formatted input such as configuration files, environment variables and query parameters.
    ///
    /// ```swift
    /// "YES".bool  // true
    /// " false\n".bool  // false
    /// "0".bool  // false
    /// "maybe".bool  // nil
    /// "".bool  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var bool: Bool? {
        guard let first = firstIndex(where: { !$0.isWhitespace }),
            let last = lastIndex(where: { !$0.isWhitespace })
        else { return nil }
        switch self[first...last].lowercased() {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
