// CGPoint+SubtractingTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGPointSubtractingTests {
    @Test(arguments: [
        (CGPoint(x: 120, y: 80), CGPoint(x: 100, y: 100), CGPoint(x: 20, y: -20)),
        (CGPoint(x: 10, y: 10), CGPoint(x: 30, y: 30), CGPoint(x: -20, y: -20)),
        (CGPoint(x: 3, y: 4), CGPoint.zero, CGPoint(x: 3, y: 4)),
        (CGPoint.zero, CGPoint(x: 3, y: 4), CGPoint(x: -3, y: -4)),
        (CGPoint(x: -1.5, y: -2.5), CGPoint(x: -1.5, y: -2.5), CGPoint.zero)
    ])
    func subtractsCoordinates(_ point: CGPoint, _ other: CGPoint, expected: CGPoint) {
        #expect(point.subtracting(other) == expected)
    }

    @Test
    func reversingTheOperandsNegatesTheResult() {
        let first = CGPoint(x: 7.25, y: -3)
        let second = CGPoint(x: -1, y: 12.5)
        let forward = first.subtracting(second)
        let backward = second.subtracting(first)
        #expect(forward.x == -backward.x)
        #expect(forward.y == -backward.y)
    }

    @Test
    func overflowsToInfinity() {
        let result = CGPoint(x: CGFloat.greatestFiniteMagnitude, y: 0)
            .subtracting(CGPoint(x: -CGFloat.greatestFiniteMagnitude, y: 0))
        #expect(result.x == .infinity)
        #expect(result.y == 0)
    }

    @Test
    func returnsNaNForInfinityMinusInfinity() {
        let infinite = CGPoint(x: CGFloat.infinity, y: CGFloat.infinity)
        let result = infinite.subtracting(infinite)
        #expect(result.x.isNaN)
        #expect(result.y.isNaN)
    }
}
#endif
