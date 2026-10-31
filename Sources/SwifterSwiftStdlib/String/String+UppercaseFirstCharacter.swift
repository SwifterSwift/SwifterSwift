// String+UppercaseFirstCharacter.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Capitalizes the first letter of the string in place, leaving everything else unchanged.
    ///
    /// This is the mutating form of `firstCharacterUppercased()`. Unlike Foundation's `capitalized`, which capitalizes
    /// every word and lowercases the rest, only the first character changes. It's converted to its Unicode title case
    /// form, which is the right form for the start of a sentence: usually the same as uppercase, but `"ß"` becomes
    /// `"Ss"` and the digraph `"ǆ"` becomes `"ǅ"`. A string that starts with a character without case, such as a digit
    /// or an emoji, is left unchanged.
    ///
    /// ```swift
    /// var greeting = "hello world"
    /// greeting.uppercaseFirstCharacter()
    /// greeting  // "Hello world"
    ///
    /// var street = "ßtraße"
    /// street.uppercaseFirstCharacter()
    /// street  // "Sstraße"
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    mutating func uppercaseFirstCharacter() {
        guard let first = unicodeScalars.first else { return }
        let firstEnd = unicodeScalars.index(after: unicodeScalars.startIndex)
        unicodeScalars.replaceSubrange(
            unicodeScalars.startIndex..<firstEnd,
            with: first.properties.titlecaseMapping.unicodeScalars
        )
    }
}
