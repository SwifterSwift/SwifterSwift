// CGVector+SubtractingTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGVectorSubtractingTests {
    @Test(arguments: [
        (CGVector(dx: 5, dy: -2), CGVector(dx: 2, dy: 2), CGVector(dx: 3, dy: -4)),
        (CGVector(dx: 10, dy: 10), CGVector(dx: 30, dy: 30), CGVector(dx: -20, dy: -20)),
        (CGVector(dx: 3, dy: 4), CGVector.zero, CGVector(dx: 3, dy: 4)),
        (CGVector.zero, CGVector(dx: 3, dy: 4), CGVector(dx: -3, dy: -4)),
        (CGVector(dx: -1.5, dy: -2.5), CGVector(dx: -1.5, dy: -2.5), CGVector.zero)
    ])
    func subtractsComponents(_ vector: CGVector, _ other: CGVector, expected: CGVector) {
        #expect(vector.subtracting(other) == expected)
    }

    @Test
    func subtractingAVectorFromItselfGivesZero() {
        let vector = CGVector(dx: 12.75, dy: -0.5)
        #expect(vector.subtracting(vector) == .zero)
    }

    @Test
    func reversingTheOperandsNegatesTheResult() {
        let first = CGVector(dx: 7.25, dy: -3)
        let second = CGVector(dx: -1, dy: 12.5)
        let forward = first.subtracting(second)
        let backward = second.subtracting(first)
        #expect(forward.dx == -backward.dx)
        #expect(forward.dy == -backward.dy)
    }

    @Test
    func addingTheOperandBackGivesTheOriginalVector() {
        let vector = CGVector(dx: 9, dy: -4.5)
        let other = CGVector(dx: 2.25, dy: 1)
        let difference = vector.subtracting(other)
        #expect(CGVector(dx: difference.dx + other.dx, dy: difference.dy + other.dy) == vector)
    }

    @Test
    func overflowsToInfinity() {
        let result = CGVector(dx: CGFloat.greatestFiniteMagnitude, dy: 0)
            .subtracting(CGVector(dx: -CGFloat.greatestFiniteMagnitude, dy: 0))
        #expect(result.dx == .infinity)
        #expect(result.dy == 0)
    }

    @Test
    func returnsNaNForInfinityMinusInfinity() {
        let infinite = CGVector(dx: CGFloat.infinity, dy: -CGFloat.infinity)
        let result = infinite.subtracting(infinite)
        #expect(result.dx.isNaN)
        #expect(result.dy.isNaN)
    }

    @Test
    func propagatesNaN() {
        let result = CGVector(dx: 1, dy: 1).subtracting(CGVector(dx: CGFloat.nan, dy: 1))
        #expect(result.dx.isNaN)
        #expect(result.dy == 0)
    }
}
#endif
