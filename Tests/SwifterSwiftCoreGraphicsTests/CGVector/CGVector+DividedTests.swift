// CGVector+DividedTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGVectorDividedTests {
    @Test(arguments: [
        (CGVector(dx: 120, dy: -60), CGFloat(60), CGVector(dx: 2, dy: -1)),
        (CGVector(dx: 3, dy: -4), CGFloat(-0.5), CGVector(dx: -6, dy: 8)),
        (CGVector(dx: 3, dy: 4), CGFloat(1), CGVector(dx: 3, dy: 4)),
        (CGVector(dx: 3, dy: 4), CGFloat(-1), CGVector(dx: -3, dy: -4)),
        (CGVector(dx: 3, dy: 4), CGFloat(2), CGVector(dx: 1.5, dy: 2)),
        (CGVector.zero, CGFloat(42), CGVector.zero)
    ])
    func dividesBothComponents(_ vector: CGVector, by scalar: CGFloat, expected: CGVector) {
        #expect(vector.divided(by: scalar) == expected)
    }

    @Test(arguments: [CGFloat(5), -4, 0.25])
    func dividesTheMagnitudeByTheAbsoluteValueOfTheScalar(_ scalar: CGFloat) {
        let divided = CGVector(dx: 30, dy: 40).divided(by: scalar)
        #expect(hypot(divided.dx, divided.dy) == 50 / abs(scalar))
    }

    @Test
    func keepsTheDirectionForAPositiveScalarAndReversesItForANegativeOne() {
        let vector = CGVector(dx: 3, dy: -4)
        let positive = vector.divided(by: 7)
        #expect(atan2(positive.dy, positive.dx) == atan2(vector.dy, vector.dx))

        let negative = vector.divided(by: -2)
        #expect(negative == CGVector(dx: -1.5, dy: 2))
    }

    @Test
    func dividesDirectlyInsteadOfMultiplyingByTheReciprocal() {
        let five: CGFloat = 5
        let three: CGFloat = 3
        let thirds = CGVector(dx: five, dy: -five).divided(by: three)
        #expect(thirds.dx == five / three)
        #expect(thirds.dy == -five / three)
        #expect(thirds.dx != five * (1 / three))

        // The reciprocal of the smallest subnormal overflows to infinity, but the quotient is exact.
        let tiny = CGVector(dx: CGFloat.leastNonzeroMagnitude, dy: 0).divided(by: .leastNonzeroMagnitude)
        #expect(tiny == CGVector(dx: 1, dy: 0))
    }

    @Test
    func dividingByZeroGivesInfinityOrNaN() {
        let result = CGVector(dx: 0, dy: -5).divided(by: 0)
        #expect(result.dx.isNaN)
        #expect(result.dy == -.infinity)

        let negativeZero = CGVector(dx: 1, dy: -5).divided(by: -0.0)
        #expect(negativeZero.dx == -.infinity)
        #expect(negativeZero.dy == .infinity)
    }

    @Test
    func dividingByInfinityGivesSignedZero() {
        let result = CGVector(dx: 5, dy: -5).divided(by: .infinity)
        #expect(result == .zero)
        #expect(result.dx.sign == .plus)
        #expect(result.dy.sign == .minus)
    }

    @Test
    func overflowsToInfinityAndUnderflowsToZero() {
        let overflow = CGVector(dx: CGFloat.greatestFiniteMagnitude, dy: -CGFloat.greatestFiniteMagnitude)
            .divided(by: 0.5)
        #expect(overflow.dx == .infinity)
        #expect(overflow.dy == -.infinity)

        let underflow = CGVector(dx: CGFloat.leastNonzeroMagnitude, dy: -CGFloat.leastNonzeroMagnitude).divided(by: 2)
        #expect(underflow == .zero)
        #expect(underflow.dy.sign == .minus)
    }

    @Test
    func handlesInfinityAndNaN() {
        let infinite = CGVector(dx: CGFloat.infinity, dy: 4).divided(by: 2)
        #expect(infinite.dx == .infinity)
        #expect(infinite.dy == 2)

        let nan = CGVector(dx: 1, dy: 2).divided(by: .nan)
        #expect(nan.dx.isNaN)
        #expect(nan.dy.isNaN)
    }
}
#endif
