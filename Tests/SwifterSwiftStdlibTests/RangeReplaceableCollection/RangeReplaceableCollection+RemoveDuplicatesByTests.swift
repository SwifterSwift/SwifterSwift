// RangeReplaceableCollection+RemoveDuplicatesByTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct RangeReplaceableCollectionRemoveDuplicatesByTests {
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
        var words = ["apple", "avocado", "banana", "blueberry", "cherry"]
        words.removeDuplicates(by: \.first)
        #expect(words == ["apple", "banana", "cherry"])
    }

    @Test
    func keepsTheFirstElementForEachEquatableKey() {
        let orange = Color(red: 255, green: 128, blue: 0)
        let blue = Color(red: 0, green: 0, blue: 255)
        var tags = [Tag(name: "swift", color: orange), Tag(name: "ios", color: blue), Tag(name: "go", color: blue)]
        tags.removeDuplicates(by: \.color)
        #expect(tags.map(\.name) == ["swift", "ios"])
    }

    @Test
    func acceptsClosures() {
        var numbers = [-2, 1, 2, -1, 3]
        numbers.removeDuplicates(by: { abs($0) })
        #expect(numbers == [-2, 1, 3])
    }

    @Test
    func callsTheKeyClosureOncePerElement() {
        var numbers = [1, 2, 1, 3]
        var calls = 0
        numbers.removeDuplicates { number in
            calls += 1
            return number
        }
        #expect(numbers == [1, 2, 3])
        #expect(calls == 4)

        var tags = [Tag(name: "a", color: Color(red: 0, green: 0, blue: 0))]
        var equatableCalls = 0
        tags.removeDuplicates { tag in
            equatableCalls += 1
            return tag.color
        }
        #expect(equatableCalls == 1)
    }

    @Test
    func doesNothingForEmptyCollection() {
        var empty: [String] = []
        empty.removeDuplicates(by: \.count)
        #expect(empty.isEmpty)

        var noTags: [Tag] = []
        noTags.removeDuplicates(by: \.color)
        #expect(noTags.isEmpty)
    }

    @Test
    func removesCharactersOfStringsByKey() {
        var text = "aAbBcÇ"
        text.removeDuplicates(by: { $0.lowercased() })
        #expect(text == "abcÇ")
    }

    @Test
    func rethrowsAndLeavesTheCollectionUnchanged() {
        var numbers = [1, 2, 1]
        #expect(throws: CancellationError.self) {
            try numbers.removeDuplicates(by: { (_: Int) throws -> Int in throw CancellationError() })
        }
        #expect(numbers == [1, 2, 1])

        let color = Color(red: 0, green: 0, blue: 0)
        var tags = [Tag(name: "a", color: color), Tag(name: "b", color: color)]
        #expect(throws: CancellationError.self) {
            try tags.removeDuplicates(by: { (_: Tag) throws -> Color in throw CancellationError() })
        }
        #expect(tags.count == 2)
    }
}
