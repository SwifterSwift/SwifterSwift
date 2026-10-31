// String+MostCommonCharacterTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringMostCommonCharacterTests {
    @Test
    func returnsMostCommonCharacter() {
        let sentence = "This is a test, since e is appearing every where e should be the common character"
        #expect(sentence.mostCommonCharacter() == "e")
        #expect("This is a test".mostCommonCharacter() == "s")
        #expect("x".mostCommonCharacter() == "x")
    }

    @Test
    func ignoresWhitespaceAndNewlines() {
        #expect("a   b\n\n\nb\t\t\t\t".mostCommonCharacter() == "b")
    }

    @Test(arguments: [("abba", "a"), ("abab", "a"), ("baab", "b"), ("xyz", "x"), ("zyx", "z")] as [(String, Character)])
    func breaksTiesByFirstAppearance(_ string: String, _ expected: Character) {
        #expect(string.mostCommonCharacter() == expected)
    }

    @Test
    func countsCharactersCaseSensitively() {
        #expect("AaaB".mostCommonCharacter() == "a")
    }

    @Test
    func countsEquivalentCharactersTogether() {
        #expect("\u{E9}xe\u{301}y".mostCommonCharacter() == "\u{E9}")
        #expect("👍🏽👍👍🏽".mostCommonCharacter() == "👍🏽")
    }

    @Test(arguments: ["", " ", "\n\t \r\n"])
    func returnsNilWithoutNonWhitespaceCharacters(_ string: String) {
        #expect(string.mostCommonCharacter() == nil)
    }
}
