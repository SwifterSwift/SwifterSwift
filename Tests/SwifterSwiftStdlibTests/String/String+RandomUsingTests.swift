// String+RandomUsingTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringRandomUsingTests {
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
    func returnsTheSameStringForTheSameSeed() {
        var first = SeededGenerator(state: 42)
        var second = SeededGenerator(state: 42)
        let string = String.random(ofLength: 50, using: &first)
        #expect(string == String.random(ofLength: 50, using: &second))
        #expect(string.count == 50)
    }

    @Test
    func returnsDifferentStringsForDifferentSeeds() {
        var first = SeededGenerator(state: 1)
        var second = SeededGenerator(state: 2)
        #expect(String.random(ofLength: 32, using: &first) != String.random(ofLength: 32, using: &second))
    }

    @Test
    func usesOnlyASCIILettersAndDigitsAndCoversTheAlphabet() {
        var generator = SeededGenerator(state: 7)
        let string = String.random(ofLength: 20000, using: &generator)
        #expect(string.allSatisfy { $0.isASCII && ($0.isLetter || $0.isNumber) })
        #expect(Set(string).count == 62)
    }

    @Test(arguments: [0, -1, Int.min])
    func returnsEmptyStringWithoutUsingTheGenerator(_ length: Int) {
        var generator = SeededGenerator(state: 3)
        #expect(String.random(ofLength: length, using: &generator).isEmpty)
        #expect(generator.state == 3)
    }

    @Test
    func acceptsTheSystemGenerator() {
        var generator = SystemRandomNumberGenerator()
        #expect(String.random(ofLength: 12, using: &generator).count == 12)
    }
}
