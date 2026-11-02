// String+RandomTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringRandomTests {
    @Test(arguments: [1, 10, 64, 1000])
    func returnsStringOfRequestedLength(_ length: Int) {
        #expect(String.random(ofLength: length).count == length)
    }

    @Test(arguments: [0, -1, Int.min])
    func returnsEmptyStringForNonPositiveLength(_ length: Int) {
        #expect(String.random(ofLength: length).isEmpty)
    }

    @Test
    func usesOnlyASCIILettersAndDigits() {
        let string = String.random(ofLength: 5000)
        #expect(string.utf8.count == 5000)
        #expect(string.allSatisfy { $0.isASCII && ($0.isLetter || $0.isNumber) })
    }

    @Test
    func coversTheWholeAlphabet() {
        // With 20,000 draws from 62 characters, the chance of missing any character is below 1e-130.
        let string = String.random(ofLength: 20000)
        #expect(Set(string).count == 62)
    }

    @Test
    func returnsDifferentStrings() {
        // Two random 32-character strings collide with a probability of 62^-32.
        #expect(String.random(ofLength: 32) != String.random(ofLength: 32))
    }
}
