// String+RandomUsing.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns a random string of ASCII letters and digits, using the given random number generator.
    ///
    /// Each character is picked independently and uniformly from the 62 characters `a`–`z`, `A`–`Z` and `0`–`9`. A
    /// length of zero or less gives an empty string and doesn't use the generator.
    ///
    /// Pass a seeded generator to get the same string every time, for example in tests or procedural content.
    ///
    /// ```swift
    /// var generator = SystemRandomNumberGenerator()
    /// String.random(ofLength: 8, using: &generator)  // "Xq3Lr9Bz", for example
    /// ```
    ///
    /// - Parameters:
    ///   - length: The number of characters in the string.
    ///   - generator: The random number generator to use when picking the characters.
    /// - Returns: A string of `length` random letters and digits.
    /// - Complexity: O(*n*), where *n* is `length`.
    static func random(ofLength length: Int, using generator: inout some RandomNumberGenerator) -> String {
        guard length > 0 else { return "" }
        let alphabet = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".utf8)
        let bytes = (0..<length).map { _ in alphabet[Int.random(in: alphabet.indices, using: &generator)] }
        return String(decoding: bytes, as: UTF8.self)
    }
}
