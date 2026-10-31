// String+SubscriptSafeTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringSubscriptSafeTests {
    let text = "Hello world!"

    @Test
    func returnsCharacterAtValidOffset() {
        #expect(text[safe: 0] == "H")
        #expect(text[safe: 1] == "e")
        #expect(text[safe: 11] == "!")
    }

    @Test(arguments: [-1, 12, 100, Int.max, Int.min])
    func returnsNilForInvalidOffset(_ offset: Int) {
        #expect(text[safe: offset] == nil)
    }

    @Test
    func countsCharactersNotScalars() {
        let greeting = "Hi 👋🏽 e\u{301}🇸🇾!"
        #expect(greeting[safe: 3] == "👋🏽")
        #expect(greeting[safe: 5] == "e\u{301}")
        #expect(greeting[safe: 6] == "🇸🇾")
        #expect(greeting[safe: 7] == "!")
        #expect(greeting[safe: 8] == nil)
    }

    @Test
    func returnsNilForEveryOffsetOfEmptyString() {
        #expect(""[safe: 0] == nil)
        #expect(""[safe: 0..<1] == nil)
        #expect(""[safe: 0...0] == nil)
        #expect(""[safe: ...0] == nil)
        #expect(""[safe: 1...] == nil)
    }

    @Test
    func returnsEmptySubstringForEmptyRangesOfEmptyString() {
        #expect(""[safe: 0..<0] == "")
        #expect(""[safe: ..<0] == "")
        #expect(""[safe: 0...] == "")
    }

    @Test
    func returnsSubstringForValidHalfOpenRange() {
        #expect(text[safe: 0..<0] == "")
        #expect(text[safe: 0..<4] == "Hell")
        #expect(text[safe: 1..<5] == "ello")
        #expect(text[safe: 7..<7] == "")
        #expect(text[safe: 11..<12] == "!")
        #expect(text[safe: 0..<12] == "Hello world!")
        #expect(text[safe: 12..<12] == "")
    }

    @Test(arguments: [-5..<5, -1..<0, 10..<18, 12..<13, 13..<13, 0..<Int.max, Int.max..<Int.max, Int.min..<0])
    func returnsNilForHalfOpenRangeOutOfBounds(_ range: Range<Int>) {
        #expect(text[safe: range] == nil)
    }

    @Test
    func returnsSubstringForValidClosedRange() {
        #expect(text[safe: 0...0] == "H")
        #expect(text[safe: 0...4] == "Hello")
        #expect(text[safe: 1...5] == "ello ")
        #expect(text[safe: 7...7] == "o")
        #expect(text[safe: 11...11] == "!")
        #expect(text[safe: 0...11] == "Hello world!")
    }

    @Test(arguments: [-5...5, -1...0, 10...18, 11...12, 12...12, 0...Int.max, Int.max...Int.max, Int.min...Int.max])
    func returnsNilForClosedRangeOutOfBounds(_ range: ClosedRange<Int>) {
        #expect(text[safe: range] == nil)
    }

    @Test
    func returnsPrefixForPartialRangeUpTo() {
        #expect(text[safe: ..<0] == "")
        #expect(text[safe: ..<5] == "Hello")
        #expect(text[safe: ..<12] == "Hello world!")
        #expect(text[safe: ..<(-1)] == nil)
        #expect(text[safe: ..<13] == nil)
        #expect(text[safe: ..<Int.max] == nil)
        #expect(text[safe: ..<Int.min] == nil)
    }

    @Test
    func returnsPrefixForPartialRangeThrough() {
        #expect(text[safe: ...0] == "H")
        #expect(text[safe: ...4] == "Hello")
        #expect(text[safe: ...11] == "Hello world!")
        #expect(text[safe: ...(-1)] == nil)
        #expect(text[safe: ...12] == nil)
        #expect(text[safe: ...Int.max] == nil)
        #expect(text[safe: ...Int.min] == nil)
    }

    @Test
    func returnsSuffixForPartialRangeFrom() {
        #expect(text[safe: 0...] == "Hello world!")
        #expect(text[safe: 6...] == "world!")
        #expect(text[safe: 11...] == "!")
        #expect(text[safe: 12...] == "")
        #expect(text[safe: (-1)...] == nil)
        #expect(text[safe: 13...] == nil)
        #expect(text[safe: Int.max...] == nil)
        #expect(text[safe: Int.min...] == nil)
    }

    @Test
    func rangesCountCharactersNotScalars() {
        let flags = "🇸🇾🇫🇷🇯🇵"
        #expect(flags[safe: 1..<2] == "🇫🇷")
        #expect(flags[safe: 1...2] == "🇫🇷🇯🇵")
        #expect(flags[safe: ..<1] == "🇸🇾")
        #expect(flags[safe: ...0] == "🇸🇾")
        #expect(flags[safe: 2...] == "🇯🇵")
        #expect(flags[safe: 0..<4] == nil)
    }
}
