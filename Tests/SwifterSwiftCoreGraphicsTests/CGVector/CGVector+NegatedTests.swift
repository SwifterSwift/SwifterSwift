// CGVector+NegatedTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGVectorNegatedTests {
    @Test(arguments: [
        (CGVector(dx: 3, dy: -4), CGVector(dx: -3, dy: 4)),
        (CGVector(dx: -1.5, dy: -2.5), CGVector(dx: 1.5, dy: 2.5)),
        (CGVector(dx: 0, dy: -9.8), CGVector(dx: 0, dy: 9.8)),
        (CGVector.zero, CGVector.zero)
    ])
    func negatesBothComponents(_ vector: CGVector, expected: CGVector) {
        #expect(vector.negated() == expected)
    }

    @Test
    func negatingTwiceGivesTheOriginalVector() {
        let vector = CGVector(dx: 12.75, dy: -0.5)
        #expect(vector.negated().negated() == vector)
    }

    @Test
    func keepsTheMagnitudeAndReversesTheDirection() {
        let vector = CGVector(dx: 3, dy: 4)
        let negated = vector.negated()
        #expect(hypot(negated.dx, negated.dy) == 5)
        #expect(abs(atan2(negated.dy, negated.dx) - (atan2(vector.dy, vector.dx) - .pi)) <= 1e-15)
    }

    @Test
    func turnsZeroIntoNegativeZero() {
        let negated = CGVector.zero.negated()
        #expect(negated.dx == 0)
        #expect(negated.dx.sign == .minus)
        #expect(negated.dy.sign == .minus)
    }

    @Test
    func handlesInfinityAndNaN() {
        let negated = CGVector(dx: CGFloat.infinity, dy: CGFloat.nan).negated()
        #expect(negated.dx == -.infinity)
        #expect(negated.dy.isNaN)
    }
}
#endif
