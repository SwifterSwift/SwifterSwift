// Sequence+WithoutDuplicatesByTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct SequenceWithoutDuplicatesByTests {
    private struct Color: Equatable {
        var red: Int
        var green: Int
        var blue: Int
    }

    private struct Tag: Equatable {
        var name: String
        var color: Color
    }

    @Test
    func keepsTheFirstElementForEachHashableKey() {
        let words = ["apple", "avocado", "banana", "blueberry", "cherry"]
        #expect(words.withoutDuplicates(by: \.first) == ["apple", "banana", "cherry"])
        #expect(words.withoutDuplicates(by: \.count) == ["apple", "avocado", "banana", "blueberry"])
    }

    @Test
    func keepsTheFirstElementForEachEquatableKey() {
        let orange = Color(red: 255, green: 128, blue: 0)
        let blue = Color(red: 0, green: 0, blue: 255)
        let tags = [Tag(name: "swift", color: orange), Tag(name: "ios", color: blue), Tag(name: "go", color: blue)]
        #expect(tags.withoutDuplicates(by: \.color).map(\.name) == ["swift", "ios"])
    }

    @Test
    func acceptsClosures() {
        #expect([-2, 1, 2, -1, 3].withoutDuplicates(by: { abs($0) }) == [-2, 1, 3])
        #expect("aAbBcÇ".withoutDuplicates(by: { $0.lowercased() }) == ["a", "b", "c", "Ç"])
    }

    @Test
    func callsTheKeyClosureOncePerElement() {
        var calls = 0
        let unique = [1, 2, 1, 3].withoutDuplicates { number in
            calls += 1
            return number
        }
        #expect(unique == [1, 2, 3])
        #expect(calls == 4)
    }

    @Test
    func returnsEmptyArrayForEmptySequence() {
        #expect([String]().withoutDuplicates(by: \.count).isEmpty)
        #expect([Tag]().withoutDuplicates(by: \.color).isEmpty)
    }

    @Test
    func worksWithSinglePassSequences() {
        var iterator = ["a", "bb", "c"].makeIterator()
        #expect(AnyIterator { iterator.next() }.withoutDuplicates(by: \.count) == ["a", "bb"])
    }

    @Test
    func rethrowsErrorsFromTheKeyClosure() {
        #expect(throws: CancellationError.self) {
            try [1, 2].withoutDuplicates(by: { (_: Int) throws -> Int in throw CancellationError() })
        }
        let tags = [Tag(name: "a", color: Color(red: 0, green: 0, blue: 0))]
        #expect(throws: CancellationError.self) {
            try tags.withoutDuplicates(by: { (_: Tag) throws -> Color in throw CancellationError() })
        }
    }
}
