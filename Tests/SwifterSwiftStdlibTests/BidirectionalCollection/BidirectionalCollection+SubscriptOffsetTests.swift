// BidirectionalCollection+SubscriptOffsetTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BidirectionalCollectionSubscriptOffsetTests {
    @Test(arguments: [(0, 10), (1, 20), (3, 40), (-1, 40), (-2, 30), (-4, 10)])
    func returnsElementForValidOffset(_ offset: Int, expected: Int) {
        let numbers = [10, 20, 30, 40]
        #expect(numbers[offset: offset] == expected)
    }

    @Test(arguments: [4, 5, -5, 100, -100, Int.max, Int.min])
    func returnsNilForOutOfBoundsOffset(_ offset: Int) {
        let numbers = [10, 20, 30, 40]
        #expect(numbers[offset: offset] == nil)
    }

    @Test(arguments: [0, 1, -1, Int.max, Int.min])
    func returnsNilForEmptyCollection(_ offset: Int) {
        let empty: [Int] = []
        #expect(empty[offset: offset] == nil)
    }

    @Test
    func countsFromTheBoundsOfASlice() {
        let slice = [10, 20, 30, 40, 50][1..<4]
        #expect(slice[offset: 0] == 20)
        #expect(slice[offset: 2] == 40)
        #expect(slice[offset: -1] == 40)
        #expect(slice[offset: -3] == 20)
        #expect(slice[offset: 3] == nil)
        #expect(slice[offset: -4] == nil)
    }

    @Test
    func countsCharactersInStrings() {
        // A flag, a letter with a combining accent and an emoji with a skin tone are each a single `Character`.
        let text = "🇸🇾e\u{301}👍🏽x"
        #expect(text[offset: 0] == "🇸🇾")
        #expect(text[offset: 1] == "é")
        #expect(text[offset: 2] == "👍🏽")
        #expect(text[offset: 3] == "x")
        #expect(text[offset: -1] == "x")
        #expect(text[offset: -4] == "🇸🇾")
        #expect(text[offset: 4] == nil)
        #expect(text[offset: -5] == nil)
        #expect(text[offset: Int.max] == nil)
        #expect(text[offset: Int.min] == nil)
    }

    @Test
    func worksWithNonRandomAccessCollections() {
        let reversed = "abc".reversed()
        #expect(reversed[offset: 0] == "c")
        #expect(reversed[offset: -1] == "a")
        #expect(reversed[offset: 3] == nil)
        #expect(reversed[offset: -4] == nil)
    }
}
