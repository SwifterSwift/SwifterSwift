// Character+RandomAlphanumeric.swift - Copyright 2026 SwifterSwift

public extension Character {
    /// SwifterSwift: Returns a random ASCII letter or digit.
    ///
    /// The character is picked uniformly from the 62 characters `a`–`z`, `A`–`Z` and `0`–`9`, using the system's random
    /// number generator.
    ///
    /// ```swift
    /// Character.randomAlphanumeric()  // "k", for example
    /// ```
    ///
    /// - Returns: A random letter or digit.
    static func randomAlphanumeric() -> Character {
        let alphabet = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        return alphabet[Int.random(in: alphabet.indices)]
    }
}
