// Character+IsEmojiTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct CharacterIsEmojiTests {
    @Test(
        arguments: [
            "😀",
            "😂",
            "⌚",
            "🫠",
            "❤️",
            "☺️",
            "©️",
            "🇸🇾",
            "🇦",
            "👍🏽",
            "☝🏽",
            "🏽",
            "🧑‍💻",
            "👨‍👩‍👧‍👦",
            "👁‍🗨",
            "#️⃣",
            "7️⃣",
            "1⃣",
            "🏴󠁧󠁢󠁥󠁮󠁧󠁿"
        ] as [Character])
    func returnsTrueForEmoji(_ character: Character) {
        #expect(character.isEmoji)
    }

    @Test(
        arguments: [
            "a",
            "j",
            "Z",
            "7",
            "#",
            "*",
            "©",
            "™",
            "❤",
            "☺",
            "↔",
            "⎌",
            "\u{20D0}",
            " ",
            "\n",
            "é",
            "e\u{301}",
            "1\u{301}",
            "日",
            "\u{FE0F}"
        ] as [Character])
    func returnsFalseForNonEmoji(_ character: Character) {
        #expect(!character.isEmoji)
    }
}
