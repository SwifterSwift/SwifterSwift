// URL+DeleteAllPathComponents.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension URL {
    /// SwifterSwift: Removes all path components from the URL, leaving the root path `/`.
    ///
    /// Only the path changes: the scheme, user, host, port, query and fragment are kept. A URL with no path, such as
    /// `https://example.com`, is left unchanged, and so is a URL whose path isn't absolute, such as a `mailto:` URL
    /// or a relative path. A URL relative to a base URL is resolved first, so it becomes absolute.
    ///
    /// ```swift
    /// var url = URL(string: "https://example.com/path/to/page?q=1#top")!
    /// url.deleteAllPathComponents()
    /// url  // https://example.com/?q=1#top
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the URL.
    mutating func deleteAllPathComponents() {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            components.path.hasPrefix("/")
        else { return }
        components.path = "/"
        if let url = components.url {
            self = url
        }
    }
}
#endif
