// CGVector+MultipliedTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGVectorMultipliedTests {
    @Test(arguments: [
        (CGVector(dx: 3, dy: -4), CGFloat(2), CGVector(dx: 6, dy: -8)),
        (CGVector(dx: 3, dy: -4), CGFloat(-0.5), CGVector(dx: -1.5, dy: 2)),
        (CGVector(dx: 3, dy: 4), CGFloat(1), CGVector(dx: 3, dy: 4)),
        (CGVector(dx: 3, dy: 4), CGFloat(-1), CGVector(dx: -3, dy: -4)),
        (CGVector(dx: 3, dy: 4), CGFloat(0), CGVector.zero),
        (CGVector.zero, CGFloat(42), CGVector.zero)
    ])
    func multipliesBothComponents(_ vector: CGVector, by scalar: CGFloat, expected: CGVector) {
        #expect(vector.multiplied(by: scalar) == expected)
    }

    @Test(arguments: [CGFloat(5), -3, 0.25])
    func scalesTheMagnitudeByTheAbsoluteValueOfTheScalar(_ scalar: CGFloat) {
        let vector = CGVector(dx: 3, dy: 4)
        #expect(hypot(vector.multiplied(by: scalar).dx, vector.multiplied(by: scalar).dy) == 5 * abs(scalar))
    }

    @Test
    func keepsTheDirectionForAPositiveScalar() {
        let vector = CGVector(dx: 3, dy: -4)
        let scaled = vector.multiplied(by: 7)
        #expect(atan2(scaled.dy, scaled.dx) == atan2(vector.dy, vector.dx))
    }

    @Test
    func handlesInfinityAndNaN() {
        let infinite = CGVector(dx: 1, dy: 0).multiplied(by: .infinity)
        #expect(infinite.dx == .infinity)
        #expect(infinite.dy.isNaN)

        let nan = CGVector(dx: 1, dy: 2).multiplied(by: .nan)
        #expect(nan.dx.isNaN)
        #expect(nan.dy.isNaN)
    }
}
#endif
