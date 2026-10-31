// String+IsPalindromeTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringIsPalindromeTests {
    @Test(arguments: [
        "racecar",
        "abba",
        "a",
        "Mom",
        "A man, a plan, a canal: Panama!",
        "Was it a car or a cat I saw?",
        "12321",
        "1a2 2A1",
        "ÉtÉ",
        "e\u{301}te\u{301}",
        "😀 abba 🎉"
    ])
    func returnsTrueForPalindromes(_ string: String) {
        #expect(string.isPalindrome)
    }

    @Test(arguments: ["Swift", "Mama", "ab", "123", "été!x", "abca"])
    func returnsFalseForNonPalindromes(_ string: String) {
        #expect(!string.isPalindrome)
    }

    @Test(arguments: ["", " ", "!?", "😀🎉😀", "\n\t"])
    func returnsFalseWithoutLettersOrNumbers(_ string: String) {
        #expect(!string.isPalindrome)
    }

    @Test
    func treatsPrecomposedAndDecomposedLettersAsEqual() {
        #expect("\u{E9}xe\u{301}".isPalindrome)
    }
}
