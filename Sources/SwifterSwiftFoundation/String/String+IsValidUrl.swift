// String+IsValidUrl.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Whether the string is a valid URL, absolute or relative, exactly as written.
    ///
    /// The string is parsed with `URL(string:encodingInvalidCharacters: false)`, so characters that aren't allowed in a
    /// URL, such as spaces or non-ASCII letters, make it invalid instead of being percent-encoded. Since iOS 17 and
    /// macOS 14, plain `URL(string:)` encodes them silently, so it accepts almost any text.
    ///
    /// A relative reference such as `"apple.com"` or `"/path"` is a valid URL; use `isValidSchemedUrl` to require a
    /// scheme. An empty string isn't a valid URL.
    ///
    /// ```swift
    /// "https://apple.com".isValidUrl  // true
    /// "apple.com".isValidUrl  // true
    /// "https://apple.com/a%20b".isValidUrl  // true
    /// "not a url".isValidUrl  // false
    /// "https://apple.com/a b".isValidUrl  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var isValidUrl: Bool {
        URL(string: self, encodingInvalidCharacters: false) != nil
    }
}
#endif
