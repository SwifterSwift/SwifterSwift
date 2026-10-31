// String+WithPrefix.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the string with the given prefix added, unless it already starts with it.
    ///
    /// The prefix is matched like `hasPrefix(_:)`: character by character and case-sensitively, so `"HTTPS://"` isn't
    /// treated as an existing `"https://"` prefix.
    ///
    /// ```swift
    /// "www.apple.com".withPrefix("https://")  // "https://www.apple.com"
    /// "https://www.apple.com".withPrefix("https://")  // "https://www.apple.com"
    /// ```
    ///
    /// - Parameter prefix: The prefix the result should start with.
    /// - Returns: The original string if it already starts with `prefix`; otherwise, `prefix` followed by the string.
    /// - Complexity: O(*n* + *m*), where *n* is the length of the string and *m* is the length of `prefix`.
    func withPrefix(_ prefix: String) -> String {
        hasPrefix(prefix) ? self : prefix + self
    }
}
