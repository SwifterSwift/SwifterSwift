// URLRequest+Header.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation) && !os(WASI)
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public extension URLRequest {
    /// SwifterSwift: Returns a copy of the request with the given HTTP header field set to the given value.
    ///
    /// It lets you build a request in one expression, without a `var`. Like `setValue(_:forHTTPHeaderField:)`, it
    /// replaces any existing value for the field, and field names are matched case-insensitively. To send several
    /// values for one field, use `addValue(_:forHTTPHeaderField:)` instead.
    ///
    /// ```swift
    /// let url = URL(string: "https://api.example.com/items")!
    /// let request = URLRequest(url: url)
    ///     .header(name: "Accept", value: "application/json")
    ///     .header(name: "Accept-Language", value: "fr-CH")
    /// request.value(forHTTPHeaderField: "accept")  // "application/json"
    /// ```
    ///
    /// - Parameters:
    ///   - name: The name of the header field.
    ///   - value: The new value of the header field. Any carriage return (`\r`) or newline (`\n`) characters are
    ///     stripped from `value` before being set, as HTTP header values must be single-line to prevent request
    ///     smuggling and CRLF injection attacks.
    /// - Returns: A copy of the request with the header field `name` set to `value`.
    func header(name: String, value: String) -> URLRequest {
        // Guard against CRLF injection attacks: HTTP header values must not contain
        // carriage return or newline characters.
        sanitizedValue = value
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
        var request = self
        request.setValue(sanitizedValue, forHTTPHeaderField: name)
        return request
    }
}
#endif
