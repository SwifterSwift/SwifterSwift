// CGPoint+MultipliedTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGPointMultipliedTests {
    @Test(arguments: [
        (CGPoint(x: 10, y: -4), CGFloat(2.5), CGPoint(x: 25, y: -10)),
        (CGPoint(x: 10, y: 10), CGFloat(5), CGPoint(x: 50, y: 50)),
        (CGPoint(x: 10, y: -4), CGFloat(-1), CGPoint(x: -10, y: 4)),
        (CGPoint(x: 10, y: -4), CGFloat(1), CGPoint(x: 10, y: -4)),
        (CGPoint(x: 8, y: 6), CGFloat(0.5), CGPoint(x: 4, y: 3)),
        (CGPoint.zero, CGFloat(100), CGPoint.zero)
    ])
    func multipliesBothCoordinates(_ point: CGPoint, by scalar: CGFloat, expected: CGPoint) {
        #expect(point.multiplied(by: scalar) == expected)
    }

    @Test
    func multiplyingByZeroGivesZeroForFinitePoints() {
        #expect(CGPoint(x: -123.5, y: 99).multiplied(by: 0) == .zero)
    }

    @Test(arguments: [CGFloat(3), -2, 0.25])
    func matchesUniformScaleTransform(_ scalar: CGFloat) {
        let point = CGPoint(x: 12, y: -7.5)
        #expect(point.multiplied(by: scalar) == point.applying(CGAffineTransform(scaleX: scalar, y: scalar)))
    }

    @Test
    func handlesInfinityAndNaN() {
        let scaled = CGPoint(x: 1, y: -1).multiplied(by: .infinity)
        #expect(scaled.x == .infinity)
        #expect(scaled.y == -.infinity)

        let infinityTimesZero = CGPoint(x: CGFloat.infinity, y: 1).multiplied(by: 0)
        #expect(infinityTimesZero.x.isNaN)
        #expect(infinityTimesZero.y == 0)

        let nan = CGPoint(x: 1, y: 2).multiplied(by: .nan)
        #expect(nan.x.isNaN)
        #expect(nan.y.isNaN)
    }
}
#endif
