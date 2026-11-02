// String+IsValidHttpsUrl.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Whether the string is a valid `https` URL with a host.
    ///
    /// The string is parsed with `URL(string:encodingInvalidCharacters: false)`, so characters that aren't allowed in a
    /// URL, such as spaces or non-ASCII letters, make it invalid instead of being percent-encoded. Since iOS 17 and
    /// macOS 14, plain `URL(string:)` encodes them silently, so it accepts almost any text.
    ///
    /// The scheme is compared case-insensitively, as URL schemes are, and the URL must have a non-empty host, so
    /// `"https:apple.com"` and `"https://"` are rejected. Internationalized host names must be written in their ASCII
    /// (Punycode) form.
    ///
    /// ```swift
    /// "https://apple.com".isValidHttpsUrl  // true
    /// "HTTPS://apple.com".isValidHttpsUrl  // true
    /// "http://apple.com".isValidHttpsUrl  // false
    /// "https://".isValidHttpsUrl  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var isValidHttpsUrl: Bool {
        guard let url = URL(string: self, encodingInvalidCharacters: false),
            url.scheme?.lowercased() == "https",
            let host = url.host(percentEncoded: true)
        else { return false }
        return !host.isEmpty
    }
}
#endif
