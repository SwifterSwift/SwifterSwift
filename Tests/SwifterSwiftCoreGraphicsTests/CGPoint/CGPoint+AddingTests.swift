// CGPoint+AddingTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGPointAddingTests {
    @Test(arguments: [
        (CGPoint(x: 10, y: 20), CGPoint(x: 5, y: -5), CGPoint(x: 15, y: 15)),
        (CGPoint(x: 10, y: 10), CGPoint(x: 30, y: 30), CGPoint(x: 40, y: 40)),
        (CGPoint(x: -1.5, y: 2.5), CGPoint(x: 1.5, y: -2.5), CGPoint.zero),
        (CGPoint(x: 3, y: 4), CGPoint.zero, CGPoint(x: 3, y: 4)),
        (CGPoint(x: -10, y: -20), CGPoint(x: -30, y: -40), CGPoint(x: -40, y: -60))
    ])
    func addsCoordinates(_ point: CGPoint, _ other: CGPoint, expected: CGPoint) {
        #expect(point.adding(other) == expected)
    }

    @Test
    func isCommutative() {
        let first = CGPoint(x: 7.25, y: -3)
        let second = CGPoint(x: -1, y: 12.5)
        #expect(first.adding(second) == second.adding(first))
    }

    @Test
    func doesNotMutateTheReceiver() {
        let point = CGPoint(x: 1, y: 2)
        _ = point.adding(CGPoint(x: 10, y: 10))
        #expect(point == CGPoint(x: 1, y: 2))
    }

    @Test
    func overflowsToInfinity() {
        let extreme = CGPoint(x: CGFloat.greatestFiniteMagnitude, y: -CGFloat.greatestFiniteMagnitude)
        let result = extreme.adding(extreme)
        #expect(result.x == .infinity)
        #expect(result.y == -.infinity)
    }

    @Test
    func propagatesNaN() {
        let result = CGPoint(x: CGFloat.nan, y: 1).adding(CGPoint(x: 1, y: 1))
        #expect(result.x.isNaN)
        #expect(result.y == 2)
    }
}
#endif
