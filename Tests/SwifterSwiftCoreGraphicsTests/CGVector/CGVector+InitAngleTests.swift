// CGVector+InitAngleTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGVectorInitAngleTests {
    let tolerance: CGFloat = 1e-15

    @Test(arguments: [
        (CGFloat(0), CGFloat(1), CGVector(dx: 1, dy: 0)),
        (CGFloat.pi / 4, CGFloat(2).squareRoot(), CGVector(dx: 1, dy: 1)),
        (CGFloat.pi / 2, CGFloat(3), CGVector(dx: 0, dy: 3)),
        (CGFloat.pi, CGFloat(1), CGVector(dx: -1, dy: 0)),
        (CGFloat.pi / 6, CGFloat(2), CGVector(dx: CGFloat(3).squareRoot(), dy: 1)),
        (CGFloat.pi / 3, CGFloat(2), CGVector(dx: 1, dy: CGFloat(3).squareRoot())),
        (-CGFloat.pi / 2, CGFloat(5), CGVector(dx: 0, dy: -5))
    ])
    func createsTheComponentsFromPolarCoordinates(angle: CGFloat, magnitude: CGFloat, expected: CGVector) {
        let vector = CGVector(angle: angle, magnitude: magnitude)
        #expect(abs(vector.dx - expected.dx) <= tolerance * 4)
        #expect(abs(vector.dy - expected.dy) <= tolerance * 4)
    }

    @Test(arguments: [CGFloat(0.3), 1.2, -2.5, 3])
    func roundTripsThroughAtan2AndHypot(_ angle: CGFloat) {
        let vector = CGVector(angle: angle, magnitude: 7)
        #expect(abs(atan2(vector.dy, vector.dx) - angle) <= tolerance * 4)
        #expect(abs(hypot(vector.dx, vector.dy) - 7) <= tolerance * 16)
    }

    @Test
    func aNegativeMagnitudePointsTheOppositeWay() {
        let forward = CGVector(angle: .pi / 3, magnitude: 2)
        let backward = CGVector(angle: .pi / 3, magnitude: -2)
        #expect(backward.dx == -forward.dx)
        #expect(backward.dy == -forward.dy)
    }

    @Test
    func aZeroMagnitudeGivesTheZeroVector() {
        #expect(CGVector(angle: 1.234, magnitude: 0) == .zero)
    }

    @Test
    func fullTurnsGiveTheSameDirection() {
        let start = CGVector(angle: 0.5, magnitude: 1)
        let turned = CGVector(angle: 0.5 + 2 * .pi, magnitude: 1)
        #expect(abs(start.dx - turned.dx) <= tolerance * 4)
        #expect(abs(start.dy - turned.dy) <= tolerance * 4)
    }

    @Test
    func handlesInfinityAndNaN() {
        let infiniteAngle = CGVector(angle: .infinity, magnitude: 1)
        #expect(infiniteAngle.dx.isNaN)
        #expect(infiniteAngle.dy.isNaN)

        let nanMagnitude = CGVector(angle: 0, magnitude: .nan)
        #expect(nanMagnitude.dx.isNaN)
        #expect(nanMagnitude.dy.isNaN)
    }
}
#endif
