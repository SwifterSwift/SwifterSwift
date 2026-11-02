// RangeReplaceableCollection+RotatedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct RangeReplaceableCollectionRotatedTests {
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
    func returnsCopyRotatedByTheGivenPlaces(_ places: Int, expected: [Int]) {
        let numbers = [1, 2, 3, 4, 5]
        #expect(numbers.rotated(by: places) == expected)
        #expect(numbers == [1, 2, 3, 4, 5])
    }

    @Test(arguments: [0, 1, -1, Int.max, Int.min])
    func returnsEmptyCollectionForEmptyCollection(_ places: Int) {
        #expect([Int]().rotated(by: places).isEmpty)
        #expect("".rotated(by: places).isEmpty)
    }

    @Test(arguments: [0, 1, -1, Int.max, Int.min])
    func returnsSingleElementUnchanged(_ places: Int) {
        #expect([42].rotated(by: places) == [42])
    }

    @Test
    func handlesExtremePlaces() {
        // Int.max leaves a remainder of 2 and Int.min a remainder of -3 when divided by 5, which both give this order.
        #expect([1, 2, 3, 4, 5].rotated(by: Int.max) == [4, 5, 1, 2, 3])
        #expect([1, 2, 3, 4, 5].rotated(by: Int.min) == [4, 5, 1, 2, 3])
    }

    @Test
    func rotatesStringsByCharacter() {
        #expect("swift".rotated(by: 1) == "tswif")
        #expect("swift".rotated(by: -1) == "wifts")
        #expect("ab🇸🇾e\u{301}👍🏽".rotated(by: 3) == "🇸🇾é👍🏽ab")
    }

    @Test
    func rotatesSlices() {
        let slice = [0, 1, 2, 3, 4][1...]
        #expect(Array(slice.rotated(by: -1)) == [2, 3, 4, 1])
    }
}
