// URL+QueryParameters.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension URL {
    /// SwifterSwift: The URL's query items that have a value, as a dictionary from name to value.
    ///
    /// Values are percent-decoded, but a `+` is kept as is and isn't treated as a space. When a name appears more
    /// than once, the first value wins. Items without a value (as in `?flag`) are left out; an item written as
    /// `?flag=` has an empty value and is kept. Use `allQueryParameters` to see every item, in order.
    ///
    /// ```swift
    /// let url = URL(string: "https://example.com/search?q=Swifter%20Swift&page=2&page=3&debug")!
    /// url.queryParameters  // ["q": "Swifter Swift", "page": "2"]
    /// URL(string: "https://example.com")!.queryParameters  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the URL.
    var queryParameters: [String: String]? {
        guard let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems else {
            return nil
        }
        return queryItems.reduce(into: [:]) { parameters, item in
            if parameters[item.name] == nil, let value = item.value {
                parameters[item.name] = value
            }
        }
    }
}
#endif
