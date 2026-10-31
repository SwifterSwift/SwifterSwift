// URL+QueryValue.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension URL {
    /// SwifterSwift: Returns the value of the first query item with the given name.
    ///
    /// Names are matched exactly, so the lookup is case-sensitive. Values are percent-decoded, but a `+` is kept as is
    /// and isn't treated as a space.
    ///
    /// ```swift
    /// let url = URL(string: "https://example.com/search?q=Swifter%20Swift&page=2")!
    /// url.queryValue(for: "q")  // "Swifter Swift"
    /// url.queryValue(for: "page")  // "2"
    /// url.queryValue(for: "sort")  // nil
    /// ```
    ///
    /// - Parameter name: The name of the query item to look up.
    /// - Returns: The decoded value of the first query item named `name`, or `nil` if the URL has no such item or the
    ///   item has no value (as in `?flag`). An item written as `?flag=` returns an empty string.
    func queryValue(for name: String) -> String? {
        URLComponents(url: self, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == name }?
            .value
    }
}
#endif
