// String+Words.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the words in the string.
    ///
    /// Words are found with the Unicode default word boundaries (UAX #29), the same rules text editors use to select a
    /// word. Contractions (`"don't"`, `"it’s"`), decimal numbers (`"3.14"`) and words joined by underscores stay whole,
    /// while hyphens, spaces and punctuation separate words and aren't returned. Emoji and symbols aren't words.
    ///
    /// The boundaries come from the standard library's regular expression engine, so no dictionary is used. Every
    /// Chinese or Japanese ideograph is a word of its own; use `NLTokenizer` from the Natural Language framework for
    /// language-aware segmentation.
    ///
    /// ```swift
    /// "Swift is amazing".words()  // ["Swift", "is", "amazing"]
    /// "Don't panic, it's 3.14!".words()  // ["Don't", "panic", "it's", "3.14"]
    /// "state-of-the-art".words()  // ["state", "of", "the", "art"]
    /// "".words()  // []
    /// ```
    ///
    /// - Returns: The words in the string, in order.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func words() -> [String] {
        matches(of: #/\b\w.*?\b/#).map { String($0.output) }
    }
}
