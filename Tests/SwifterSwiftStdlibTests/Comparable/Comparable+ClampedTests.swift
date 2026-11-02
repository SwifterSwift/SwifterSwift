// Comparable+ClampedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct ComparableClampedTests {
    @Test(arguments: [(-5, 0), (0, 0), (5, 5), (10, 10), (15, 10), (Int.min, 0), (Int.max, 10)])
    func clampsIntegers(_ value: Int, expected: Int) {
        #expect(value.clamped(to: 0...10) == expected)
    }

    @Test
    func clampsToRangesOfNegativeNumbers() {
        #expect((-20).clamped(to: (-10)...(-5)) == -10)
        #expect((-7).clamped(to: (-10)...(-5)) == -7)
        #expect(0.clamped(to: (-10)...(-5)) == -5)
    }

    @Test(arguments: [Int.min, 6, 7, 8, Int.max])
    func returnsTheOnlyValueOfASingleValueRange(_ value: Int) {
        #expect(value.clamped(to: 7...7) == 7)
    }

    @Test
    func clampsFloatingPointValues() {
        #expect(0.32.clamped(to: 0.1...0.29) == 0.29)
        #expect(0.05.clamped(to: 0.1...0.29) == 0.1)
        #expect(0.2.clamped(to: 0.1...0.29) == 0.2)
        #expect(Double.infinity.clamped(to: 0...1) == 1)
        #expect((-Double.infinity).clamped(to: 0...1) == 0)
        #expect(5.0.clamped(to: -Double.infinity...Double.infinity) == 5)
    }

    @Test
    func keepsNaNInsteadOfReturningABound() {
        #expect(Double.nan.clamped(to: 0...1).isNaN)
        #expect(Float.nan.clamped(to: -1...1).isNaN)
    }

    @Test
    func clampsStringsAndCharacters() {
        #expect("m".clamped(to: "a"..."f") == "f")
        #expect("A".clamped(to: "a"..."f") == "a")
        #expect("c".clamped(to: "a"..."f") == "c")
        #expect(Character("é").clamped(to: "a"..."z") == "z")
    }
}
