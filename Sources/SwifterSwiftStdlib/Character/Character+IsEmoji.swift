// Character+IsEmoji.swift - Copyright 2026 SwifterSwift

public extension Character {
    /// SwifterSwift: Whether the character is displayed as an emoji.
    ///
    /// A character is an emoji when it's displayed as one by default (such as 😀, ⌚, 🫠 or a flag), or when it's an emoji
    /// that's turned into its emoji form by a variation selector, a skin tone modifier, a keycap or a zero-width joiner
    /// sequence (such as ❤️, 👍🏽, 1️⃣ or 🧑‍💻). Symbols that are displayed as text by default, such as `©`, `™`, `↔` or
    /// a plain digit, aren't emoji on their own, even though Unicode lists them as emoji characters.
    ///
    /// The standard library has no `Character`-level check, and `Unicode.Scalar.Properties.isEmoji` alone is true for
    /// the digits `0` to `9`, `#` and `*`. This property combines the Unicode emoji properties of the character's
    /// scalars, so it follows the Unicode version of the standard library it runs on.
    ///
    /// ```swift
    /// Character("😀").isEmoji  // true
    /// Character("❤️").isEmoji  // true
    /// Character("❤").isEmoji  // false
    /// Character("7").isEmoji  // false
    /// Character("7️⃣").isEmoji  // true
    /// ```
    var isEmoji: Bool {
        guard let first = unicodeScalars.first else { return false }
        if first.properties.isEmojiPresentation {
            return true
        }
        return first.properties.isEmoji
            && unicodeScalars.dropFirst().contains { scalar in
                scalar == "\u{FE0F}" || scalar == "\u{20E3}" || scalar == "\u{200D}"
                    || scalar.properties.isEmojiModifier
            }
    }
}
