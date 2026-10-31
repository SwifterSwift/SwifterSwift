// String+HasPrefix.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Returns whether the string starts with the given prefix, optionally ignoring case.
    ///
    /// When `caseSensitive` is `true`, this is the standard `hasPrefix(_:)`. When it's `false`, the comparison uses
    /// Unicode case folding rather than `lowercased()`, so `"STRASSE"` matches the start of `"Straße"`. Either way,
    /// characters are compared whole: `"e"` isn't a prefix of `"é"`. The comparison doesn't depend on any locale, and
    /// every string has the empty string as a prefix.
    ///
    /// ```swift
    /// "Hello, World!".hasPrefix("hello", caseSensitive: false)  // true
    /// "Hello, World!".hasPrefix("hello", caseSensitive: true)  // false
    /// "Straße 5".hasPrefix("STRASSE", caseSensitive: false)  // true
    /// ```
    ///
    /// - Parameters:
    ///   - prefix: The string to look for at the start.
    ///   - caseSensitive: Whether uppercase and lowercase letters must match exactly.
    /// - Returns: `true` if the string starts with `prefix`; otherwise, `false`.
    /// - Complexity: O(*m*), where *m* is the length of `prefix`.
    func hasPrefix(_ prefix: String, caseSensitive: Bool) -> Bool {
        if caseSensitive || prefix.isEmpty {
            return hasPrefix(prefix)
        }
        return range(of: prefix, options: [.anchored, .caseInsensitive]) != nil
    }
}
#endif
