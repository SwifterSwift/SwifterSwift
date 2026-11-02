// CGPoint+DividedTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGPointDividedTests {
    @Test(arguments: [
        (CGPoint(x: 300, y: -90), CGFloat(3), CGPoint(x: 100, y: -30)),
        (CGPoint(x: 10, y: -4), CGFloat(-2), CGPoint(x: -5, y: 2)),
        (CGPoint(x: 10, y: -4), CGFloat(1), CGPoint(x: 10, y: -4)),
        (CGPoint(x: 10, y: -4), CGFloat(-1), CGPoint(x: -10, y: 4)),
        (CGPoint(x: 3, y: 1), CGFloat(0.5), CGPoint(x: 6, y: 2)),
        (CGPoint.zero, CGFloat(7), CGPoint.zero)
    ])
    func dividesBothCoordinates(_ point: CGPoint, by scalar: CGFloat, expected: CGPoint) {
        #expect(point.divided(by: scalar) == expected)
    }

    @Test(arguments: [CGFloat(3), -2, 0.25])
    func undoesMultiplyingByTheSameScalar(_ scalar: CGFloat) {
        let point = CGPoint(x: 12, y: -7.5)
        #expect(CGPoint(x: point.x * scalar, y: point.y * scalar).divided(by: scalar) == point)
    }

    @Test
    func dividesDirectlyInsteadOfMultiplyingByTheReciprocal() {
        let five: CGFloat = 5
        let three: CGFloat = 3
        let thirds = CGPoint(x: five, y: -five).divided(by: three)
        #expect(thirds.x == five / three)
        #expect(thirds.y == -five / three)
        #expect(thirds.x != five * (1 / three))

        // The reciprocal of the smallest subnormal overflows to infinity, but the quotient is exact.
        let tiny = CGPoint(x: CGFloat.leastNonzeroMagnitude, y: 0).divided(by: .leastNonzeroMagnitude)
        #expect(tiny == CGPoint(x: 1, y: 0))
    }

    @Test
    func dividingByZeroGivesInfinityOrNaN() {
        let result = CGPoint(x: 1, y: -2).divided(by: 0)
        #expect(result.x == .infinity)
        #expect(result.y == -.infinity)

        let zero = CGPoint.zero.divided(by: 0)
        #expect(zero.x.isNaN)
        #expect(zero.y.isNaN)
    }

    @Test
    func dividingByNegativeZeroFlipsTheSignOfTheInfinity() {
        let result = CGPoint(x: 1, y: -2).divided(by: -0.0)
        #expect(result.x == -.infinity)
        #expect(result.y == .infinity)
    }

    @Test
    func dividingByInfinityGivesSignedZero() {
        let result = CGPoint(x: 5, y: -5).divided(by: .infinity)
        #expect(result == .zero)
        #expect(result.x.sign == .plus)
        #expect(result.y.sign == .minus)
    }

    @Test
    func overflowsToInfinityAndUnderflowsToZero() {
        let overflow = CGPoint(x: CGFloat.greatestFiniteMagnitude, y: -CGFloat.greatestFiniteMagnitude)
            .divided(by: 0.5)
        #expect(overflow.x == .infinity)
        #expect(overflow.y == -.infinity)

        let underflow = CGPoint(x: CGFloat.leastNonzeroMagnitude, y: -CGFloat.leastNonzeroMagnitude).divided(by: 2)
        #expect(underflow == .zero)
        #expect(underflow.y.sign == .minus)
    }

    @Test
    func handlesInfinityAndNaN() {
        let infinite = CGPoint(x: CGFloat.infinity, y: 4).divided(by: -2)
        #expect(infinite.x == -.infinity)
        #expect(infinite.y == -2)

        let infinityOverInfinity = CGPoint(x: CGFloat.infinity, y: 1).divided(by: .infinity)
        #expect(infinityOverInfinity.x.isNaN)
        #expect(infinityOverInfinity.y == 0)

        let nan = CGPoint(x: 1, y: 2).divided(by: .nan)
        #expect(nan.x.isNaN)
        #expect(nan.y.isNaN)
    }
}
#endif
