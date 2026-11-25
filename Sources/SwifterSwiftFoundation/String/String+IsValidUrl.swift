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
    /// The URL must have both a scheme and a non-empty host, so relative references such as `"apple.com"` or
    /// `"/path"` are rejected. Use `isValidSchemedUrl` if you only need a scheme without a host, or parse the string
    /// directly with `URL(string:encodingInvalidCharacters:)` for loose validation. An empty string isn't a valid URL.
    ///
    /// ```swift
    /// "https://apple.com".isValidUrl  // true
    /// "https://apple.com/a%20b".isValidUrl  // true
    /// "apple.com".isValidUrl  // false (no scheme)
    /// "/path/to/file".isValidUrl  // false (no scheme or host)
    /// "not a url".isValidUrl  // false
    /// "https://apple.com/a b".isValidUrl  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var isValidUrl: Bool {
        guard let url = URL(string: self, encodingInvalidCharacters: false),
              url.scheme != nil,
              let host = url.host(percentEncoded: true),
              !host.isEmpty
        else { return false }
        return true
    }
}
#endif
