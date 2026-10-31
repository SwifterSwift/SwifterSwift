// String+Base64Encoded.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: The string's UTF-8 bytes encoded as Base64 text, with `=` padding.
    ///
    /// The result uses the standard alphabet (`+` and `/`) and isn't wrapped into lines. Encoding can't fail, so unlike
    /// `data(using: .utf8)?.base64EncodedString()` the result isn't optional.
    ///
    /// ```swift
    /// "Hello World!".base64Encoded  // "SGVsbG8gV29ybGQh"
    /// "🚀".base64Encoded  // "8J+agA=="
    /// "".base64Encoded  // ""
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string in UTF-8 bytes.
    var base64Encoded: String {
        Data(utf8).base64EncodedString()
    }
}
#endif
