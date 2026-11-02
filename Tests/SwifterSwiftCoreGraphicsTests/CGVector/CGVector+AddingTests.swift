// CGVector+AddingTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGVectorAddingTests {
    @Test(arguments: [
        (CGVector(dx: 3, dy: 0), CGVector(dx: -1, dy: 2), CGVector(dx: 2, dy: 2)),
        (CGVector(dx: 10, dy: 10), CGVector(dx: 30, dy: 30), CGVector(dx: 40, dy: 40)),
        (CGVector(dx: -1.5, dy: 2.5), CGVector(dx: 1.5, dy: -2.5), CGVector.zero),
        (CGVector(dx: 3, dy: 4), CGVector.zero, CGVector(dx: 3, dy: 4)),
        (CGVector(dx: -10, dy: -20), CGVector(dx: -30, dy: -40), CGVector(dx: -40, dy: -60))
    ])
    func addsComponents(_ vector: CGVector, _ other: CGVector, expected: CGVector) {
        #expect(vector.adding(other) == expected)
    }

    @Test
    func isCommutative() {
        let first = CGVector(dx: 7.25, dy: -3)
        let second = CGVector(dx: -1, dy: 12.5)
        #expect(first.adding(second) == second.adding(first))
    }

    @Test
    func addingTheOppositeVectorGivesZero() {
        let vector = CGVector(dx: 12.75, dy: -0.5)
        #expect(vector.adding(CGVector(dx: -vector.dx, dy: -vector.dy)) == .zero)
    }

    @Test
    func doesNotMutateTheReceiver() {
        let vector = CGVector(dx: 1, dy: 2)
        _ = vector.adding(CGVector(dx: 10, dy: 10))
        #expect(vector == CGVector(dx: 1, dy: 2))
    }

    @Test
    func overflowsToInfinity() {
        let extreme = CGVector(dx: CGFloat.greatestFiniteMagnitude, dy: -CGFloat.greatestFiniteMagnitude)
        let result = extreme.adding(extreme)
        #expect(result.dx == .infinity)
        #expect(result.dy == -.infinity)
    }

    @Test
    func handlesInfinityAndNaN() {
        let opposite = CGVector(dx: CGFloat.infinity, dy: 1).adding(CGVector(dx: -CGFloat.infinity, dy: 1))
        #expect(opposite.dx.isNaN)
        #expect(opposite.dy == 2)

        let nan = CGVector(dx: CGFloat.nan, dy: 1).adding(CGVector(dx: 1, dy: CGFloat.infinity))
        #expect(nan.dx.isNaN)
        #expect(nan.dy == .infinity)
    }
}
#endif
