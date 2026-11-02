// CGVector+MagnitudeTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGVectorMagnitudeTests {
    @Test(arguments: [
        (CGVector(dx: 3, dy: 4), CGFloat(5)),
        (CGVector(dx: -5, dy: 12), CGFloat(13)),
        (CGVector(dx: 8, dy: -15), CGFloat(17)),
        (CGVector(dx: 20, dy: 0), CGFloat(20)),
        (CGVector(dx: 0, dy: -20), CGFloat(20)),
        (CGVector(dx: 1, dy: 1), CGFloat(2).squareRoot()),
        (CGVector.zero, CGFloat(0))
    ])
    func returnsTheLength(_ vector: CGVector, expected: CGFloat) {
        #expect(vector.magnitude == expected)
    }

    @Test
    func doesNotOverflowWhenTheSquaresAreTooLarge() {
        let large = CGFloat.greatestFiniteMagnitude / 2
        let magnitude = CGVector(dx: large, dy: -large).magnitude
        #expect(magnitude.isFinite)
        #expect(abs(magnitude - large * 2.squareRoot()) <= large * 1e-12)
    }

    @Test
    func doesNotUnderflowWhenTheSquaresAreTooSmall() {
        let tiny = CGFloat.leastNormalMagnitude
        #expect(CGVector(dx: 3 * tiny, dy: 4 * tiny).magnitude == 5 * tiny)
    }

    @Test
    func handlesInfinityAndNaN() {
        #expect(CGVector(dx: -CGFloat.infinity, dy: 1).magnitude == .infinity)
        #expect(CGVector(dx: CGFloat.nan, dy: 1).magnitude.isNaN)
    }
}
#endif
