// Character+RandomAlphanumericTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct CharacterRandomAlphanumericTests {
    @Test
    func returnsASCIILetterOrDigit() {
        for _ in 0..<1000 {
            let character = Character.randomAlphanumeric()
            #expect(character.isASCII && (character.isLetter || character.isNumber))
        }
    }

    @Test
    func coversTheWholeAlphabet() {
        // With 20,000 draws from 62 characters, the chance of missing any character is below 1e-130.
        let characters = Set((0..<20000).map { _ in Character.randomAlphanumeric() })
        #expect(characters.count == 62)
    }
}
