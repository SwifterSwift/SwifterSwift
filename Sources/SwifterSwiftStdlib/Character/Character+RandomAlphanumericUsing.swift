// Character+RandomAlphanumericUsing.swift - Copyright 2026 SwifterSwift

public extension Character {
    /// SwifterSwift: Returns a random ASCII letter or digit, using the given random number generator.
    ///
    /// The character is picked uniformly from the 62 characters `a`–`z`, `A`–`Z` and `0`–`9`. Pass a seeded generator
    /// to get the same character every time, for example in tests.
    ///
    /// ```swift
    /// var generator = SystemRandomNumberGenerator()
    /// Character.randomAlphanumeric(using: &generator)  // "Q", for example
    /// ```
    ///
    /// - Parameter generator: The random number generator to use when picking the character.
    /// - Returns: A random letter or digit.
    static func randomAlphanumeric(using generator: inout some RandomNumberGenerator) -> Character {
        let alphabet = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        return alphabet[Int.random(in: alphabet.indices, using: &generator)]
    }
}
