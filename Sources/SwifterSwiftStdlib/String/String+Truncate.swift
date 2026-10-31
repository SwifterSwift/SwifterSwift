// String+Truncate.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Cuts the string to the given length, ending it with a trailing string such as an ellipsis.
    ///
    /// The string never ends up longer than `length` characters, trailing string included. A string that already fits
    /// isn't changed. Otherwise it's cut so that the trailing string fits after it; if the trailing string is as long
    /// as `length` or longer, the string is simply cut to `length` characters without it. A length of zero or less
    /// leaves an empty string. Lengths count characters as the user sees them, so an emoji is never split.
    ///
    /// ```swift
    /// var sentence = "This is a very long sentence"
    /// sentence.truncate(toLength: 14)
    /// sentence  // "This is a ver…"
    /// ```
    ///
    /// - Parameters:
    ///   - length: The maximum length of the string, in characters.
    ///   - trailing: The string that ends a truncated string. The default is an ellipsis (`…`).
    /// - Complexity: O(*n*), where *n* is the length of the string.
    mutating func truncate(toLength length: Int, trailing: String = "…") {
        guard count > length else { return }
        guard length > 0 else {
            removeAll()
            return
        }
        let trailingLength = trailing.count
        guard trailingLength < length else {
            self = String(prefix(length))
            return
        }
        self = String(prefix(length - trailingLength)) + trailing
    }
}
