// String+ContainsEmojiTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringContainsEmojiTests {
    @Test(arguments: [
        "Hello 😀",
        "😂",
        "Time ⌚",
        "Melting 🫠",
        "I ❤️ Swift",
        "Flag 🇸🇾",
        "Thumbs 👍🏽 up",
        "Coder 🧑‍💻",
        "Key 1️⃣",
        "England 🏴󠁧󠁢󠁥󠁮󠁧󠁿",
        "abc😀def"
    ])
    func returnsTrueWhenStringContainsEmoji(_ string: String) {
        #expect(string.containsEmoji)
    }

    @Test(arguments: [
        "",
        "Hello ;)",
        "Copyright © 2026",
        "Trademark™",
        "123 #*",
        "Arrows ↔ ⎌",
        "Plain heart ❤",
        "e\u{301}",
        "1\u{301}",
        "日本語"
    ])
    func returnsFalseWhenStringHasNoEmoji(_ string: String) {
        #expect(!string.containsEmoji)
    }
}
