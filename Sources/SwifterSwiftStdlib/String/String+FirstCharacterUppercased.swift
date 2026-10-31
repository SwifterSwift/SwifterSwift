// String+FirstCharacterUppercased.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the string with its first letter capitalized and everything else unchanged.
    ///
    /// Unlike Foundation's `capitalized`, which capitalizes every word and lowercases the rest, only the first
    /// character changes. It's converted to its Unicode title case form, which is the right form for the start of a
    /// sentence: usually the same as uppercase, but `"ß"` becomes `"Ss"` and the digraph `"ǆ"` becomes `"ǅ"`. A string
    /// that starts with a character without case, such as a digit or an emoji, is returned unchanged.
    ///
    /// ```swift
    /// "hello world".firstCharacterUppercased()  // "Hello world"
    /// "élan".firstCharacterUppercased()  // "Élan"
    /// "iPhone".firstCharacterUppercased()  // "IPhone"
    /// "".firstCharacterUppercased()  // ""
    /// ```
    ///
    /// - Returns: The string with its first character in title case.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func firstCharacterUppercased() -> String {
        guard let first = unicodeScalars.first else { return self }
        var result = first.properties.titlecaseMapping
        result.unicodeScalars.append(contentsOf: unicodeScalars.dropFirst())
        return result
    }
}
