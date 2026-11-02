// CGVector+AngleTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGVectorAngleTests {
    @Test(
        arguments: [
            (CGVector(dx: 1, dy: 0), 0),
            (CGVector(dx: 1, dy: 1), .pi / 4),
            (CGVector(dx: 0, dy: 1), .pi / 2),
            (CGVector(dx: -1, dy: 1), 3 * .pi / 4),
            (CGVector(dx: -1, dy: 0), .pi),
            (CGVector(dx: -1, dy: -1), -3 * .pi / 4),
            (CGVector(dx: 0, dy: -1), -.pi / 2),
            (CGVector(dx: 1, dy: -1), -.pi / 4)
        ] as [(CGVector, CGFloat)]
    )
    func returnsTheDirectionInEachOctant(_ vector: CGVector, expected: CGFloat) {
        #expect(vector.angle == expected)
    }

    // 1e30 rather than anything larger, because `CGFloat` is 32 bits on Apple Watch hardware.
    @Test(arguments: [CGFloat(0.001), 2, 1000, 1e30])
    func doesNotDependOnTheMagnitude(_ scale: CGFloat) {
        #expect(CGVector(dx: scale, dy: scale).angle == .pi / 4)
        #expect(CGVector(dx: -scale, dy: 0).angle == .pi)
    }

    @Test
    func matchesAtan2ForArbitraryVectors() {
        let vector = CGVector(dx: 3, dy: -4)
        #expect(vector.angle == atan2(-4, 3))
        #expect(abs(CGVector(dx: 1, dy: 3.squareRoot()).angle - .pi / 3) <= 1e-15)
    }

    @Test
    func returnsZeroForTheZeroVector() {
        #expect(CGVector.zero.angle == 0)
    }

    @Test
    func returnsMinusPiForANegativeZeroDy() {
        #expect(CGVector(dx: -1, dy: -0.0).angle == -.pi)
        #expect(CGVector(dx: -1, dy: 0).angle == .pi)
    }

    @Test(arguments: [
        CGVector(dx: 5, dy: -12),
        CGVector(dx: -0.25, dy: 0.5),
        CGVector(dx: -1000, dy: -1e-9),
        CGVector(dx: CGFloat.leastNonzeroMagnitude, dy: CGFloat.greatestFiniteMagnitude)
    ])
    func staysWithinMinusPiToPi(_ vector: CGVector) {
        #expect((-CGFloat.pi...CGFloat.pi).contains(vector.angle))
    }

    @Test
    func handlesInfinityAndNaN() {
        #expect(CGVector(dx: CGFloat.infinity, dy: CGFloat.infinity).angle == .pi / 4)
        #expect(CGVector(dx: 1, dy: CGFloat.infinity).angle == .pi / 2)
        #expect(CGVector(dx: -CGFloat.infinity, dy: 1).angle == .pi)
        #expect(CGVector(dx: CGFloat.nan, dy: 1).angle.isNaN)
        #expect(CGVector(dx: 1, dy: CGFloat.nan).angle.isNaN)
    }
}
#endif
