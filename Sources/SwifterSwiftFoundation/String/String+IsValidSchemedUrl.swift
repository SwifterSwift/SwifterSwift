// String+IsValidSchemedUrl.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Whether the string is a valid URL that starts with a scheme, such as `https:` or `mailto:`.
    ///
    /// The string is parsed with `URL(string:encodingInvalidCharacters: false)`, so characters that aren't allowed in a
    /// URL, such as spaces or non-ASCII letters, make it invalid instead of being percent-encoded. Since iOS 17 and
    /// macOS 14, plain `URL(string:)` encodes them silently, so it accepts almost any text. Any scheme is accepted, and
    /// a host isn't required.
    ///
    /// ```swift
    /// "https://apple.com".isValidSchemedUrl  // true
    /// "mailto:tim@apple.com".isValidSchemedUrl  // true
    /// "apple.com".isValidSchemedUrl  // false
    /// "https://apple.com/a b".isValidSchemedUrl  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var isValidSchemedUrl: Bool {
        URL(string: self, encodingInvalidCharacters: false)?.scheme != nil
    }
}
#endif
