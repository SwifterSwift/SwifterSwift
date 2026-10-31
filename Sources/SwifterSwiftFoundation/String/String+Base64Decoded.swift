// String+Base64Decoded.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: The UTF-8 text the string decodes to as Base64, or `nil` if it isn't valid Base64 text.
    ///
    /// The decoding is more forgiving than `Data(base64Encoded:)` in three ways that are common in practice: missing
    /// `=` padding is added, whitespace and line breaks (as in wrapped MIME or PEM text) are ignored, and the URL-safe
    /// alphabet (`-` and `_` instead of `+` and `/`, as in JSON Web Tokens) is accepted. Any other character that isn't
    /// part of the Base64 alphabet, padding where none is needed or more than two `=`, and data that isn't valid UTF-8
    /// all make the result `nil`.
    ///
    /// ```swift
    /// "SGVsbG8gV29ybGQh".base64Decoded  // "Hello World!"
    /// "SGVsbG8gV29ybGQ".base64Decoded  // "Hello World"
    /// "8J-agA".base64Decoded  // "🚀"
    /// "Hello World!".base64Decoded  // nil
    /// "====".base64Decoded  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var base64Decoded: String? {
        var base64 = String(
            compactMap { character -> Character? in
                switch character {
                case "-": "+"
                case "_": "/"
                case _ where character.isWhitespace: nil
                default: character
                }
            }
        )
        var paddingCount = 0
        while base64.last == "=" {
            base64.removeLast()
            paddingCount += 1
        }
        let remainder = base64.count % 4
        guard paddingCount <= 2, remainder != 1, paddingCount == 0 || remainder != 0 else { return nil }
        if remainder != 0 {
            base64 += String(repeating: "=", count: 4 - remainder)
        }
        guard let data = Data(base64Encoded: base64) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
#endif
