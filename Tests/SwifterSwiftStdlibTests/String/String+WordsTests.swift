// String+WordsTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringWordsTests {
    @Test(arguments: [
        ("Swift is amazing", ["Swift", "is", "amazing"]),
        ("Don't panic, it's 3.14!", ["Don't", "panic", "it's", "3.14"]),
        ("it’s fine", ["it’s", "fine"]),
        ("state-of-the-art", ["state", "of", "the", "art"]),
        ("hello,world", ["hello", "world"]),
        ("foo_bar baz", ["foo_bar", "baz"]),
        ("  leading\n\ttrailing  ", ["leading", "trailing"]),
        ("naïve café", ["naïve", "café"]),
        ("e\u{301}clair", ["e\u{301}clair"]),
        ("Привет, мир!", ["Привет", "мир"]),
        ("🙂 smile 👍🏽 ok", ["smile", "ok"]),
        ("1,000 people", ["1,000", "people"]),
        ("日本語", ["日", "本", "語"])
    ])
    func splitsIntoWords(_ string: String, _ expected: [String]) {
        #expect(string.words() == expected)
    }

    @Test(arguments: ["", " ", "\n\t", "!?.,", "😀 🎉", "--"])
    func returnsNoWordsWithoutLettersOrNumbers(_ string: String) {
        #expect(string.words().isEmpty)
    }
}
