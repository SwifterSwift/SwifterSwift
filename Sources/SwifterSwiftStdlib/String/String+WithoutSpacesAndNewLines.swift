// String+WithoutSpacesAndNewLines.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: The string with every whitespace and newline character removed.
    ///
    /// All characters for which `Character.isWhitespace` is true are removed, wherever they are: spaces, tabs, line
    /// breaks (including `"\r\n"`), no-break spaces and the other Unicode space and line separator characters.
    /// Replacing only `" "` and `"\n"` would leave tabs and Windows line endings behind.
    ///
    /// ```swift
    /// "   \n Swifter \t  Swift \r\n".withoutSpacesAndNewLines  // "SwifterSwift"
    /// "1 234 567".withoutSpacesAndNewLines  // "1234567"
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var withoutSpacesAndNewLines: String {
        filter { !$0.isWhitespace }
    }
}
