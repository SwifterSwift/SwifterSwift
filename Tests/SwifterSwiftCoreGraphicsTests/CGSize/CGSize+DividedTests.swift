// CGSize+DividedTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGSizeDividedTests {
    @Test(arguments: [
        (CGSize(width: 1179, height: 2556), CGFloat(3), CGSize(width: 393, height: 852)),
        (CGSize(width: 320, height: 180), CGFloat(2), CGSize(width: 160, height: 90)),
        (CGSize(width: 5, height: 10), CGFloat(1), CGSize(width: 5, height: 10)),
        (CGSize(width: 5, height: 10), CGFloat(-2), CGSize(width: -2.5, height: -5)),
        (CGSize(width: 5, height: 0), CGFloat(4), CGSize(width: 1.25, height: 0)),
        (CGSize(width: 5, height: 10), CGFloat(0.25), CGSize(width: 20, height: 40)),
        (CGSize.zero, CGFloat(7), CGSize.zero)
    ])
    func dividesBothDimensions(_ size: CGSize, by scalar: CGFloat, expected: CGSize) {
        #expect(size.divided(by: scalar) == expected)
    }

    @Test(arguments: [CGFloat(3), -2, 0.25])
    func undoesMultiplyingByTheSameScalar(_ scalar: CGFloat) {
        let size = CGSize(width: 12, height: 7.5)
        #expect(CGSize(width: size.width * scalar, height: size.height * scalar).divided(by: scalar) == size)
    }

    @Test
    func dividesDirectlyInsteadOfMultiplyingByTheReciprocal() {
        let five: CGFloat = 5
        let three: CGFloat = 3
        let thirds = CGSize(width: five, height: 2 * five).divided(by: three)
        #expect(thirds.width == five / three)
        #expect(thirds.height == 2 * five / three)
        #expect(thirds.width != five * (1 / three))

        // The reciprocal of the smallest subnormal overflows to infinity, but the quotient is exact.
        let tiny = CGSize(width: CGFloat.leastNonzeroMagnitude, height: 0).divided(by: .leastNonzeroMagnitude)
        #expect(tiny == CGSize(width: 1, height: 0))
    }

    @Test
    func dividingByZeroGivesInfinityOrNaN() {
        let result = CGSize(width: 10, height: -2).divided(by: 0)
        #expect(result.width == .infinity)
        #expect(result.height == -.infinity)

        let zero = CGSize(width: 10, height: 0).divided(by: 0)
        #expect(zero.width == .infinity)
        #expect(zero.height.isNaN)
    }

    @Test
    func dividingByNegativeZeroFlipsTheSignOfTheInfinity() {
        let result = CGSize(width: 10, height: -2).divided(by: -0.0)
        #expect(result.width == -.infinity)
        #expect(result.height == .infinity)
    }

    @Test
    func dividingByInfinityGivesSignedZero() {
        let result = CGSize(width: 5, height: -5).divided(by: .infinity)
        #expect(result == .zero)
        #expect(result.width.sign == .plus)
        #expect(result.height.sign == .minus)
    }

    @Test
    func overflowsToInfinityAndUnderflowsToZero() {
        let overflow = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 1).divided(by: 0.5)
        #expect(overflow.width == .infinity)
        #expect(overflow.height == 2)

        let underflow = CGSize(width: CGFloat.leastNonzeroMagnitude, height: 1).divided(by: 2)
        #expect(underflow.width == 0)
        #expect(underflow.height == 0.5)
    }

    @Test
    func handlesInfinityAndNaN() {
        let infinite = CGSize(width: CGFloat.infinity, height: 4).divided(by: 2)
        #expect(infinite.width == .infinity)
        #expect(infinite.height == 2)

        let nan = CGSize(width: 1, height: 2).divided(by: .nan)
        #expect(nan.width.isNaN)
        #expect(nan.height.isNaN)
    }
}
#endif
