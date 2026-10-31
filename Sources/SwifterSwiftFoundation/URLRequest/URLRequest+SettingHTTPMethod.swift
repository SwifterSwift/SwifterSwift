// URLRequest+SettingHTTPMethod.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation) && !os(WASI)
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public extension URLRequest {
    /// SwifterSwift: Returns a copy of the request that uses the given HTTP method.
    ///
    /// It lets you build a request in one expression, without a `var`. The method is passed to `httpMethod` without
    /// changing its case, because HTTP methods are case-sensitive (RFC 9110, section 9.1): pass `"POST"`, not
    /// `"post"`. (On Apple platforms `URLRequest` itself uppercases a few standard methods, such as `"post"`, but not
    /// others, such as `"patch"`.)
    ///
    /// ```swift
    /// let url = URL(string: "https://api.example.com/items")!
    /// let request = URLRequest(url: url).settingHTTPMethod("POST")
    /// request.httpMethod  // "POST"
    /// ```
    ///
    /// - Parameter method: The HTTP method, such as `"GET"`, `"POST"` or `"DELETE"`.
    /// - Returns: A copy of the request with its `httpMethod` set to `method`.
    func settingHTTPMethod(_ method: String) -> URLRequest {
        var request = self
        request.httpMethod = method
        return request
    }
}
#endif
