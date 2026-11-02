// String+Lines.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the lines of the string, without their line endings.
    ///
    /// Lines are separated by any character for which `Character.isNewline` is true: `"\n"`, `"\r"`, `"\r\n"`, vertical
    /// tab, form feed, and the Unicode next line, line separator and paragraph separator characters. A `"\r\n"` pair is
    /// a single line break. Empty lines in the middle are kept, but a line break at the very end doesn't start an extra
    /// empty line, and an empty string has no lines.
    ///
    /// Splitting on `"\n"` alone misses Windows line endings, because Swift treats `"\r\n"` as a single character.
    /// Foundation's `enumerateLines(invoking:)` gives the same lines, except that it doesn't break at vertical tabs or
    /// form feeds.
    ///
    /// ```swift
    /// "Hello\nWorld".lines()  // ["Hello", "World"]
    /// "one\r\ntwo\n\nfour\n".lines()  // ["one", "two", "", "four"]
    /// "".lines()  // []
    /// ```
    ///
    /// - Returns: The lines of the string, in order.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func lines() -> [String] {
        var lines = split(omittingEmptySubsequences: false, whereSeparator: \.isNewline).map(String.init)
        if lines.last?.isEmpty == true {
            lines.removeLast()
        }
        return lines
    }
}
