// String+Truncated.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the string cut to the given length, ending with a trailing string such as an ellipsis.
    ///
    /// The result is never longer than `length` characters, trailing string included. A string that already fits is
    /// returned unchanged. Otherwise the string is cut so that the trailing string fits after it; if the trailing
    /// string is as long as `length` or longer, the string is simply cut to `length` characters without it. A length of
    /// zero or less gives an empty string. Lengths count characters as the user sees them, so an emoji is never split.
    ///
    /// ```swift
    /// "This is a very long sentence".truncated(toLength: 14)  // "This is a ver…"
    /// "This is a very long sentence".truncated(toLength: 14, trailing: "...")  // "This is a v..."
    /// "This is a very long sentence".truncated(toLength: 14, trailing: "")  // "This is a very"
    /// "Short".truncated(toLength: 14)  // "Short"
    /// ```
    ///
    /// - Parameters:
    ///   - length: The maximum length of the result, in characters.
    ///   - trailing: The string that ends a truncated result. The default is an ellipsis (`…`).
    /// - Returns: The original string if it's at most `length` characters long; otherwise, the truncated string.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func truncated(toLength length: Int, trailing: String = "…") -> String {
        guard count > length else { return self }
        guard length > 0 else { return "" }
        let trailingLength = trailing.count
        guard trailingLength < length else { return String(prefix(length)) }
        return String(prefix(length - trailingLength)) + trailing
    }
}
