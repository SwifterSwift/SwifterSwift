// URL+DeletingAllPathComponents.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension URL {
    /// SwifterSwift: Returns a URL with all path components removed, leaving the root path `/`.
    ///
    /// Only the path changes: the scheme, user, host, port, query and fragment are kept. A URL with no path, such as
    /// `https://example.com`, is returned unchanged, and so is a URL whose path isn't absolute, such as a `mailto:`
    /// URL or a relative path. A URL relative to a base URL is resolved first, so the result is absolute.
    ///
    /// ```swift
    /// let url = URL(string: "https://example.com/path/to/page?q=1#top")!
    /// url.deletingAllPathComponents()  // https://example.com/?q=1#top
    /// URL(fileURLWithPath: "/Users/me/file.txt").deletingAllPathComponents()  // file:///
    /// ```
    ///
    /// - Returns: The URL with its path replaced by `/`.
    /// - Complexity: O(*n*), where *n* is the length of the URL.
    func deletingAllPathComponents() -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            components.path.hasPrefix("/")
        else { return self }
        components.path = "/"
        return components.url ?? self
    }
}
#endif
