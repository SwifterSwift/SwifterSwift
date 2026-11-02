// Collection+SubscriptSafeTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct CollectionSubscriptSafeTests {
    @Test(arguments: [0, 1, 2])
    func returnsElementForValidIndex(_ index: Int) {
        let numbers = [10, 20, 30]
        #expect(numbers[safe: index] == numbers[index])
    }

    @Test(arguments: [-1, 3, 100, Int.max, Int.min])
    func returnsNilForInvalidIndex(_ index: Int) {
        let numbers = [10, 20, 30]
        #expect(numbers[safe: index] == nil)
    }

    @Test
    func returnsNilForEmptyCollection() {
        let empty: [Int] = []
        #expect(empty[safe: 0] == nil)
    }

    @Test
    func usesTheIndicesOfTheBaseCollectionForSlices() {
        let slice = [10, 20, 30, 40][1..<3]
        #expect(slice[safe: 0] == nil)
        #expect(slice[safe: 1] == 20)
        #expect(slice[safe: 2] == 30)
        #expect(slice[safe: 3] == nil)
    }

    @Test
    func returnsCharacterForValidStringIndex() {
        let word = "héllo"
        #expect(word[safe: word.startIndex] == "h")
        #expect(word[safe: word.index(after: word.startIndex)] == "é")
        #expect(word[safe: word.endIndex] == nil)
    }

    @Test
    func returnsNilForStringIndexInsideACharacter() {
        // "e" followed by a combining acute accent is a single `Character` made of two Unicode scalars.
        let word = "e\u{301}x"
        let insideFirstCharacter = word.unicodeScalars.index(after: word.startIndex)
        #expect(word[safe: insideFirstCharacter] == nil)
    }

    @Test
    func worksWithNonIntegerIndices() throws {
        let scores = ["a": 1]
        let index = try #require(scores.index(forKey: "a"))
        #expect(scores[safe: index]?.value == 1)
        #expect(scores[safe: scores.endIndex] == nil)
    }
}
