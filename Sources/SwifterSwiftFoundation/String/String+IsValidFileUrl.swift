// String+IsValidFileUrl.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Whether the string is a valid `file` URL for a path on this machine.
    ///
    /// The string is parsed with `URL(string:encodingInvalidCharacters: false)`, so characters that aren't allowed in a
    /// URL, such as spaces or non-ASCII letters, make it invalid instead of being percent-encoded. Since iOS 17 and
    /// macOS 14, plain `URL(string:)` encodes them silently, so it accepts almost any text.
    ///
    /// The scheme must be `file` (in any case), the host must be empty or `localhost`, and the path must be absolute.
    /// That rejects the common mistake of writing two slashes instead of three: in `"file://var/log"`, `var` is the
    /// host and the path is only `/log`.
    ///
    /// ```swift
    /// "file:///Users/tim/notes.txt".isValidFileUrl  // true
    /// "file://localhost/tmp/notes.txt".isValidFileUrl  // true
    /// "file://var/log/system.log".isValidFileUrl  // false
    /// "/Users/tim/notes.txt".isValidFileUrl  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var isValidFileUrl: Bool {
        guard let url = URL(string: self, encodingInvalidCharacters: false),
            url.scheme?.lowercased() == "file"
        else { return false }
        let host = url.host(percentEncoded: true) ?? ""
        return (host.isEmpty || host.lowercased() == "localhost") && url.path(percentEncoded: true).hasPrefix("/")
    }
}
#endif
