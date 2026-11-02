// String+WordCount.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the number of words in the string.
    ///
    /// Words are found with the Unicode default word boundaries (UAX #29), the same rules text editors use to select a
    /// word. Contractions (`"don't"`, `"it’s"`), decimal numbers (`"3.14"`) and words joined by underscores count as
    /// one word, while hyphens, spaces and punctuation separate words and aren't counted. Emoji and symbols aren't
    /// words.
    ///
    /// The boundaries come from the standard library's regular expression engine, so no dictionary is used. Every
    /// Chinese or Japanese ideograph counts as a word of its own; use `NLTokenizer` from the Natural Language framework
    /// for language-aware segmentation.
    ///
    /// ```swift
    /// "Swift is amazing".wordCount()  // 3
    /// "Don't panic, it's 3.14!".wordCount()  // 4
    /// "  ".wordCount()  // 0
    /// ```
    ///
    /// - Returns: The number of words in the string.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func wordCount() -> Int {
        matches(of: #/\b\w.*?\b/#).count
    }
}
