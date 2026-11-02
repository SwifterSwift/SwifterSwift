// Character+RandomAlphanumericUsingTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct CharacterRandomAlphanumericUsingTests {
    /// A deterministic SplitMix64 generator, so the tests don't depend on chance.
    struct SeededGenerator: RandomNumberGenerator {
        var state: UInt64

        mutating func next() -> UInt64 {
            state &+= 0x9E37_79B9_7F4A_7C15
            var value = state
            value = (value ^ (value >> 30)) &* 0xBF58_476D_1CE4_E5B9
            value = (value ^ (value >> 27)) &* 0x94D0_49BB_1331_11EB
            return value ^ (value >> 31)
        }
    }

    @Test
    func returnsTheSameCharactersForTheSameSeed() {
        var first = SeededGenerator(state: 42)
        var second = SeededGenerator(state: 42)
        let firstRun = (0..<20).map { _ in Character.randomAlphanumeric(using: &first) }
        let secondRun = (0..<20).map { _ in Character.randomAlphanumeric(using: &second) }
        #expect(firstRun == secondRun)
    }

    @Test
    func returnsOnlyASCIILettersAndDigitsAndCoversTheAlphabet() {
        var generator = SeededGenerator(state: 7)
        let characters = (0..<20000).map { _ in Character.randomAlphanumeric(using: &generator) }
        #expect(characters.allSatisfy { $0.isASCII && ($0.isLetter || $0.isNumber) })
        #expect(Set(characters).count == 62)
    }

    @Test
    func acceptsTheSystemGenerator() {
        var generator = SystemRandomNumberGenerator()
        let character = Character.randomAlphanumeric(using: &generator)
        #expect(character.isASCII && (character.isLetter || character.isNumber))
    }
}
