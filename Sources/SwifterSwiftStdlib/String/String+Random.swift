// String+Random.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns a random string of ASCII letters and digits.
    ///
    /// Each character is picked independently and uniformly from the 62 characters `a`–`z`, `A`–`Z` and `0`–`9`, using
    /// the system's random number generator. A length of zero or less gives an empty string.
    ///
    /// The system generator is cryptographically secure on Apple platforms and Linux, but 62 possible characters per
    /// position may still be too few for secrets; use a dedicated API for tokens and passwords.
    ///
    /// ```swift
    /// String.random(ofLength: 8)  // "u7MMZYvG", for example
    /// String.random(ofLength: 0)  // ""
    /// ```
    ///
    /// - Parameter length: The number of characters in the string.
    /// - Returns: A string of `length` random letters and digits.
    /// - Complexity: O(*n*), where *n* is `length`.
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let alphabet = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".utf8)
        let bytes = (0..<length).map { _ in alphabet[Int.random(in: alphabet.indices)] }
        return String(decoding: bytes, as: UTF8.self)
    }
}
