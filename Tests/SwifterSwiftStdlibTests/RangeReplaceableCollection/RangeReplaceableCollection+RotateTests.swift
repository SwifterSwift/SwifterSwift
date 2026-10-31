// RangeReplaceableCollection+RotateTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct RangeReplaceableCollectionRotateTests {
    @Test(arguments: [
        (0, [1, 2, 3, 4, 5]),
        (1, [5, 1, 2, 3, 4]),
        (2, [4, 5, 1, 2, 3]),
        (5, [1, 2, 3, 4, 5]),
        (7, [4, 5, 1, 2, 3]),
        (-1, [2, 3, 4, 5, 1]),
        (-2, [3, 4, 5, 1, 2]),
        (-5, [1, 2, 3, 4, 5]),
        (-7, [3, 4, 5, 1, 2])
    ])
    func rotatesByTheGivenPlaces(_ places: Int, expected: [Int]) {
        var numbers = [1, 2, 3, 4, 5]
        numbers.rotate(by: places)
        #expect(numbers == expected)
    }

    @Test(arguments: [0, 1, -1, Int.max, Int.min])
    func leavesEmptyCollectionUnchanged(_ places: Int) {
        var empty: [Int] = []
        empty.rotate(by: places)
        #expect(empty.isEmpty)
    }

    @Test(arguments: [0, 1, -1, Int.max, Int.min])
    func leavesSingleElementUnchanged(_ places: Int) {
        var single = [42]
        single.rotate(by: places)
        #expect(single == [42])
    }

    @Test
    func handlesExtremePlaces() {
        // Int.max leaves a remainder of 2 and Int.min a remainder of -3 when divided by 5, which both give this order.
        var maxRotated = [1, 2, 3, 4, 5]
        maxRotated.rotate(by: Int.max)
        #expect(maxRotated == [4, 5, 1, 2, 3])

        var minRotated = [1, 2, 3, 4, 5]
        minRotated.rotate(by: Int.min)
        #expect(minRotated == [4, 5, 1, 2, 3])
    }

    @Test
    func rotatesStringsByCharacter() {
        var word = "swift"
        word.rotate(by: 1)
        #expect(word == "tswif")

        var symbols = "ab🇸🇾e\u{301}👍🏽"
        symbols.rotate(by: 3)
        #expect(symbols == "🇸🇾é👍🏽ab")
        symbols.rotate(by: -3)
        #expect(symbols == "ab🇸🇾é👍🏽")
    }

    @Test
    func rotatesSlices() {
        var slice = [0, 1, 2, 3, 4][1...]
        slice.rotate(by: 1)
        #expect(Array(slice) == [4, 1, 2, 3])
    }
}
