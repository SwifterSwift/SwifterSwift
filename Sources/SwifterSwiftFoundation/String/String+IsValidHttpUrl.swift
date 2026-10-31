// String+IsValidHttpUrl.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Whether the string is a valid `http` URL with a host.
    ///
    /// The string is parsed with `URL(string:encodingInvalidCharacters: false)`, so characters that aren't allowed in a
    /// URL, such as spaces or non-ASCII letters, make it invalid instead of being percent-encoded. Since iOS 17 and
    /// macOS 14, plain `URL(string:)` encodes them silently, so it accepts almost any text.
    ///
    /// The scheme is compared case-insensitively, as URL schemes are, and the URL must have a non-empty host, so
    /// `"http:apple.com"` and `"http://"` are rejected. An `https` URL isn't an `http` URL; check both properties to
    /// accept either.
    ///
    /// ```swift
    /// "http://apple.com".isValidHttpUrl  // true
    /// "HTTP://localhost:8080/path".isValidHttpUrl  // true
    /// "https://apple.com".isValidHttpUrl  // false
    /// "http://".isValidHttpUrl  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var isValidHttpUrl: Bool {
        guard let url = URL(string: self, encodingInvalidCharacters: false),
            url.scheme?.lowercased() == "http",
            let host = url.host(percentEncoded: true)
        else { return false }
        return !host.isEmpty
    }
}
#endif
