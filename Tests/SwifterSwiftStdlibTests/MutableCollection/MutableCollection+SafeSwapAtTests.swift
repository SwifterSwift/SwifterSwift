// MutableCollection+SafeSwapAtTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct MutableCollectionSafeSwapAtTests {
    @Test(arguments: [(0, 2), (2, 0), (0, 1), (1, 2)])
    func swapsTheElementsAtValidIndices(_ i: Int, _ j: Int) {
        var letters = ["a", "b", "c"]
        var expected = letters
        expected.swapAt(i, j)
        let swapped = letters.safeSwapAt(i, j)
        #expect(swapped)
        #expect(letters == expected)
    }

    @Test(arguments: [(0, 3), (3, 0), (-1, 0), (1, -1), (3, 3), (Int.max, 0), (0, Int.min), (Int.min, Int.max)])
    func leavesTheCollectionUnchangedForInvalidIndices(_ i: Int, _ j: Int) {
        var letters = ["a", "b", "c"]
        let swapped = letters.safeSwapAt(i, j)
        #expect(!swapped)
        #expect(letters == ["a", "b", "c"])
    }

    @Test(arguments: [0, 1, 2])
    func returnsTrueForSwappingAnElementWithItself(_ index: Int) {
        var letters = ["a", "b", "c"]
        let swapped = letters.safeSwapAt(index, index)
        #expect(swapped)
        #expect(letters == ["a", "b", "c"])
    }

    @Test
    func returnsFalseForEmptyCollection() {
        var empty: [Int] = []
        let swapped = empty.safeSwapAt(0, 0)
        #expect(!swapped)
        #expect(empty.isEmpty)
    }

    @Test
    func canBeCalledWithoutUsingTheResult() {
        var numbers = [1, 2]
        numbers.safeSwapAt(0, 1)
        numbers.safeSwapAt(0, 5)
        #expect(numbers == [2, 1])
    }

    @Test
    func usesTheIndicesOfTheBaseCollectionForSlices() {
        var numbers = [10, 20, 30, 40]
        let swappedOutside = numbers[1...].safeSwapAt(0, 1)
        let swappedInside = numbers[1...].safeSwapAt(1, 3)
        #expect(!swappedOutside)
        #expect(swappedInside)
        #expect(numbers == [10, 40, 30, 20])
    }

    @Test
    func worksWithNonIntegerIndices() throws {
        var ages = ["Ana": 30, "Ben": 12]
        let ana = try #require(ages.index(forKey: "Ana"))
        let ben = try #require(ages.index(forKey: "Ben"))
        let swapped = ages.values.safeSwapAt(ana, ben)
        #expect(swapped)
        #expect(ages == ["Ana": 12, "Ben": 30])
        let swappedWithEnd = ages.values.safeSwapAt(ana, ages.endIndex)
        #expect(!swappedWithEnd)
        #expect(ages == ["Ana": 12, "Ben": 30])
    }
}
