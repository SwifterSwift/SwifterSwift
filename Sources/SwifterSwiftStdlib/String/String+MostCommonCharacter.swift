// String+MostCommonCharacter.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the character that appears most often in the string, ignoring whitespace and newlines.
    ///
    /// Characters are compared as the user sees them and case-sensitively, so `"e"` and `"E"` are counted separately,
    /// and a precomposed `é` and `e` followed by a combining accent are counted together. When several characters are
    /// equally common, the one that appears first wins. A string that's empty or made only of whitespace has no most
    /// common character.
    ///
    /// ```swift
    /// "This is a test".mostCommonCharacter()  // "s"
    /// "abba".mostCommonCharacter()  // "a"
    /// " \n ".mostCommonCharacter()  // nil
    /// ```
    ///
    /// - Returns: The most common character that isn't whitespace, or `nil` if there's none.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func mostCommonCharacter() -> Character? {
        var counts: [Character: Int] = [:]
        for character in self where !character.isWhitespace {
            counts[character, default: 0] += 1
        }
        guard let highestCount = counts.values.max() else { return nil }
        return first { counts[$0] == highestCount }
    }
}
