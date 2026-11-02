// URL+DeletingScheme.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension URL {
    /// SwifterSwift: Returns the URL without its scheme and the `//` that introduces the host.
    ///
    /// Everything after the scheme is kept: user, host, port, path, query and fragment. URLs without a host lose only
    /// the scheme, so `mailto:` and `tel:` URLs keep their whole address. A URL relative to a base URL is resolved
    /// first.
    ///
    /// ```swift
    /// URL(string: "https://example.com/path?q=1")!.deletingScheme()  // example.com/path?q=1
    /// URL(string: "mailto:someone@example.com")!.deletingScheme()  // someone@example.com
    /// URL(string: "file:///Users/me/file.txt")!.deletingScheme()  // /Users/me/file.txt
    /// URL(string: "http://")!.deletingScheme()  // nil
    /// ```
    ///
    /// The result is a relative reference meant mostly for display. Without the `//`, Foundation reads the former
    /// host as the start of a path (and a `host:port` prefix as a scheme), so use `absoluteString` rather than `host`
    /// on it.
    ///
    /// - Returns: The URL without its scheme, or `nil` if nothing is left.
    /// - Complexity: O(*n*), where *n* is the length of the URL.
    func deletingScheme() -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = nil
        guard var string = components.string else { return nil }
        if string.hasPrefix("//") {
            string.removeFirst(2)
        }
        return URL(string: string)
    }
}
#endif
