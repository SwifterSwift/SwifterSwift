// String+Trimmed.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: The string without leading and trailing whitespace and newlines.
    ///
    /// Whitespace is anything `Character.isWhitespace` accepts: spaces, tabs, line breaks (including `"\r\n"`) and the
    /// other Unicode space and line separator characters. Whitespace inside the string is kept.
    ///
    /// This gives the same result as Foundation's `trimmingCharacters(in: .whitespacesAndNewlines)` for ordinary text,
    /// but needs only the standard library, so it also works where Foundation isn't available.
    ///
    /// ```swift
    /// "  Hello, World! \n".trimmed  // "Hello, World!"
    /// "\t Swifter Swift \r\n".trimmed  // "Swifter Swift"
    /// "   ".trimmed  // ""
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var trimmed: String {
        guard let first = firstIndex(where: { !$0.isWhitespace }),
            let last = lastIndex(where: { !$0.isWhitespace })
        else { return "" }
        return String(self[first...last])
    }
}
