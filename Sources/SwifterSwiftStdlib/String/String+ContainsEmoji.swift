// String+ContainsEmoji.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Whether the string contains at least one character that's displayed as an emoji.
    ///
    /// A character counts as an emoji when it's displayed as one by default (such as 😀, ⌚ or a flag), or when it's an
    /// emoji that's turned into its emoji form by a variation selector, a skin tone modifier, a keycap or a zero-width
    /// joiner sequence (such as ❤️, 1️⃣ or 🧑‍💻). Symbols that are displayed as text by default, such as `©`, `™` or a
    /// plain digit, don't count. The check uses the Unicode emoji properties built into the standard library.
    ///
    /// ```swift
    /// "Hello 😀".containsEmoji  // true
    /// "I ❤️ Swift".containsEmoji  // true
    /// "Copyright © 2026".containsEmoji  // false
    /// "".containsEmoji  // false
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var containsEmoji: Bool {
        contains { character in
            let scalars = character.unicodeScalars
            guard let first = scalars.first else { return false }
            if first.properties.isEmojiPresentation {
                return true
            }
            return first.properties.isEmoji
                && scalars.dropFirst().contains { scalar in
                    scalar == "\u{FE0F}" || scalar == "\u{20E3}" || scalar == "\u{200D}"
                        || scalar.properties.isEmojiModifier
                }
        }
    }
}
