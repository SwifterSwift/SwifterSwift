// String+Trim.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Removes leading and trailing whitespace and newlines from the string.
    ///
    /// Whitespace is anything `Character.isWhitespace` accepts: spaces, tabs, line breaks (including `"\r\n"`) and the
    /// other Unicode space and line separator characters. Whitespace inside the string is kept, and a string made only
    /// of whitespace becomes empty.
    ///
    /// ```swift
    /// var name = "  \n Swifter Swift \t"
    /// name.trim()
    /// name  // "Swifter Swift"
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    mutating func trim() {
        if let first = firstIndex(where: { !$0.isWhitespace }), let last = lastIndex(where: { !$0.isWhitespace }) {
            self = String(self[first...last])
        } else {
            removeAll()
        }
    }
}
