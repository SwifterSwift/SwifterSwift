// CGPoint+DistanceTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGPointDistanceTests {
    @Test(arguments: [
        (CGPoint(x: 10, y: 10), CGPoint(x: 40, y: 50), CGFloat(50)),
        (CGPoint.zero, CGPoint(x: 3, y: 4), CGFloat(5)),
        (CGPoint(x: -3, y: -4), CGPoint.zero, CGFloat(5)),
        (CGPoint(x: -5, y: 0), CGPoint(x: 5, y: 0), CGFloat(10)),
        (CGPoint(x: 0, y: -7), CGPoint(x: 0, y: 7), CGFloat(14)),
        (CGPoint(x: -8, y: 3), CGPoint(x: 7, y: -5), CGFloat(17))
    ])
    func returnsEuclideanDistance(between first: CGPoint, and second: CGPoint, expected: CGFloat) {
        #expect(first.distance(from: second) == expected)
        #expect(second.distance(from: first) == expected)
    }

    @Test
    func returnsZeroForTheSamePoint() {
        let point = CGPoint(x: -12.5, y: 42)
        #expect(point.distance(from: point) == 0)
        #expect(CGPoint.zero.distance(from: .zero) == 0)
    }

    @Test
    func handlesFractionalCoordinates() {
        let distance = CGPoint(x: 0.1, y: 0.2).distance(from: CGPoint(x: 0.4, y: 0.6))
        #expect(abs(distance - 0.5) <= 1e-12)
    }

    @Test
    func doesNotOverflowWhenTheSquaresAreTooLarge() {
        let large = CGFloat.greatestFiniteMagnitude / 2
        let distance = CGPoint.zero.distance(from: CGPoint(x: large, y: large))
        #expect(distance.isFinite)
        #expect(abs(distance - large * 2.squareRoot()) <= large * 1e-12)
    }

    @Test
    func returnsInfinityForAnInfiniteCoordinate() {
        #expect(CGPoint.zero.distance(from: CGPoint(x: CGFloat.infinity, y: 0)) == .infinity)
        #expect(CGPoint.zero.distance(from: CGPoint(x: 0, y: -CGFloat.infinity)) == .infinity)
    }

    @Test
    func returnsNaNForANaNCoordinate() {
        #expect(CGPoint.zero.distance(from: CGPoint(x: CGFloat.nan, y: 1)).isNaN)
        #expect(CGPoint(x: 1, y: CGFloat.nan).distance(from: .zero).isNaN)
    }
}
#endif
