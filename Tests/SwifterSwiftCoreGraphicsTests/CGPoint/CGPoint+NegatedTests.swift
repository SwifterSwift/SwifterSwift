// CGPoint+NegatedTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGPointNegatedTests {
    @Test(arguments: [
        (CGPoint(x: 12, y: -5), CGPoint(x: -12, y: 5)),
        (CGPoint(x: -1.5, y: -2.5), CGPoint(x: 1.5, y: 2.5)),
        (CGPoint(x: 0, y: 3), CGPoint(x: 0, y: -3)),
        (CGPoint.zero, CGPoint.zero)
    ])
    func negatesBothCoordinates(_ point: CGPoint, expected: CGPoint) {
        #expect(point.negated() == expected)
    }

    @Test
    func negatingTwiceGivesTheOriginalPoint() {
        let point = CGPoint(x: 12.75, y: -0.5)
        #expect(point.negated().negated() == point)
    }

    @Test
    func mirrorsThePointThroughTheOrigin() {
        let point = CGPoint(x: 3, y: 4)
        let negated = point.negated()
        #expect(hypot(negated.x, negated.y) == hypot(point.x, point.y))
        #expect(CGPoint(x: point.x + negated.x, y: point.y + negated.y) == .zero)
    }

    @Test
    func turnsZeroIntoNegativeZero() {
        let negated = CGPoint.zero.negated()
        #expect(negated == .zero)
        #expect(negated.x.sign == .minus)
        #expect(negated.y.sign == .minus)
    }

    @Test
    func staysFiniteAtTheExtremes() {
        let negated = CGPoint(x: CGFloat.greatestFiniteMagnitude, y: -CGFloat.leastNonzeroMagnitude).negated()
        #expect(negated.x == -.greatestFiniteMagnitude)
        #expect(negated.y == .leastNonzeroMagnitude)
    }

    @Test
    func handlesInfinityAndNaN() {
        let negated = CGPoint(x: CGFloat.infinity, y: CGFloat.nan).negated()
        #expect(negated.x == -.infinity)
        #expect(negated.y.isNaN)
    }
}
#endif
