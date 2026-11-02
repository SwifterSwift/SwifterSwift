// String+HasSuffix.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Returns whether the string ends with the given suffix, optionally ignoring case.
    ///
    /// When `caseSensitive` is `true`, this is the standard `hasSuffix(_:)`. When it's `false`, the comparison uses
    /// Unicode case folding rather than `lowercased()`, so `"STRASSE"` matches the end of `"Hauptstraße"`. Either way,
    /// characters are compared whole: `"e"` isn't a suffix of `"café"`. The comparison doesn't depend on any locale,
    /// and every string has the empty string as a suffix.
    ///
    /// ```swift
    /// "Hello, World!".hasSuffix("WORLD!", caseSensitive: false)  // true
    /// "Hello, World!".hasSuffix("WORLD!", caseSensitive: true)  // false
    /// "photo.JPG".hasSuffix(".jpg", caseSensitive: false)  // true
    /// ```
    ///
    /// - Parameters:
    ///   - suffix: The string to look for at the end.
    ///   - caseSensitive: Whether uppercase and lowercase letters must match exactly.
    /// - Returns: `true` if the string ends with `suffix`; otherwise, `false`.
    /// - Complexity: O(*m*), where *m* is the length of `suffix`.
    func hasSuffix(_ suffix: String, caseSensitive: Bool) -> Bool {
        if caseSensitive || suffix.isEmpty {
            return hasSuffix(suffix)
        }
        guard let range = range(of: suffix, options: [.anchored, .backwards, .caseInsensitive]) else { return false }
        // Foundation outside Apple platforms can match part of a character, such as an emoji's skin tone modifier.
        return range.lowerBound.samePosition(in: self) != nil
    }
}
#endif
