// URL+AllQueryParameters.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension URL {
    /// SwifterSwift: All of the URL's query items, in the order they appear.
    ///
    /// Unlike `queryParameters`, this keeps repeated names and items without a value. Names and values are
    /// percent-decoded, but a `+` is kept as is and isn't treated as a space. It reads the same items as
    /// `URLComponents.queryItems` without the detour through `URLComponents(url:resolvingAgainstBaseURL:)`.
    ///
    /// ```swift
    /// let url = URL(string: "https://example.com/?tag=a&tag=b&debug")!
    /// url.allQueryParameters
    /// // [URLQueryItem(name: "tag", value: "a"), URLQueryItem(name: "tag", value: "b"),
    /// //  URLQueryItem(name: "debug", value: nil)]
    /// URL(string: "https://example.com")!.allQueryParameters  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the URL.
    var allQueryParameters: [URLQueryItem]? {
        URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems
    }
}
#endif
