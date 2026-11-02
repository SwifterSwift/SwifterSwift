// String+LoremIpsumTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringLoremIpsumTests {
    @Test
    func returnsFullTextByDefault() {
        let text = String.loremIpsum()
        #expect(text.count == 445)
        #expect(text.hasPrefix("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor"))
        #expect(text.hasSuffix("sunt in culpa qui officia deserunt mollit anim id est laborum."))
        #expect(!text.contains("\n"))
        #expect(!text.contains("  "))
        #expect(text.contains("eu fugiat nulla pariatur."))
    }

    @Test(arguments: [1, 5, 11, 100, 444, 445])
    func returnsPrefixOfRequestedLength(_ length: Int) {
        let text = String.loremIpsum(ofLength: length)
        #expect(text.count == length)
        #expect(String.loremIpsum().hasPrefix(text))
    }

    @Test
    func cutsInTheMiddleOfAWord() {
        #expect(String.loremIpsum(ofLength: 11) == "Lorem ipsum")
        #expect(String.loremIpsum(ofLength: 3) == "Lor")
    }

    @Test(arguments: [446, 1000, Int.max])
    func returnsFullTextForLongerLengths(_ length: Int) {
        #expect(String.loremIpsum(ofLength: length) == String.loremIpsum())
    }

    @Test(arguments: [0, -1, Int.min])
    func returnsEmptyStringForNonPositiveLengths(_ length: Int) {
        #expect(String.loremIpsum(ofLength: length).isEmpty)
    }
}
