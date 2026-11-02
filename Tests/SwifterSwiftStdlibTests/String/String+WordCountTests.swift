// String+WordCountTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringWordCountTests {
    @Test(arguments: [
        ("Swift is amazing", 3),
        ("Don't panic, it's 3.14!", 4),
        ("state-of-the-art", 4),
        ("one\ntwo\r\nthree", 3),
        ("naïve café", 2),
        ("🙂 smile 👍🏽 ok", 2),
        ("日本語", 3),
        ("word", 1)
    ])
    func countsWords(_ string: String, _ expected: Int) {
        #expect(string.wordCount() == expected)
    }

    @Test(arguments: ["", "  ", "!?", "😀"])
    func returnsZeroWithoutLettersOrNumbers(_ string: String) {
        #expect(string.wordCount() == 0)
    }
}
