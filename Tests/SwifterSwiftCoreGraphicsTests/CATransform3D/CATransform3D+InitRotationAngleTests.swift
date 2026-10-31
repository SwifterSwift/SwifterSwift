// CATransform3D+InitRotationAngleTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DInitRotationAngleTests {
    @Test(arguments: [
        (CGFloat.pi / 3, CGFloat(5), CGFloat(10), CGFloat(20)),
        (CGFloat.pi / 4, CGFloat(0), CGFloat(1), CGFloat(0)),
        (-CGFloat.pi / 2, CGFloat(1), CGFloat(0), CGFloat(0)),
        (CGFloat(2), CGFloat(0), CGFloat(0), CGFloat(-1))
    ])
    func matchesCoreAnimation(angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) {
        let transform = CATransform3D(rotationAngle: angle, x: x, y: y, z: z)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeRotation(angle, x, y, z)))
    }

    @Test
    func rotatesAroundTheYAxis() {
        let transform = CATransform3D(rotationAngle: .pi / 4, x: 0, y: 1, z: 0)
        let tolerance: CGFloat = 1e-15
        #expect(abs(transform.m11 - CGFloat(0.5).squareRoot()) <= tolerance)
        #expect(abs(transform.m13 + CGFloat(0.5).squareRoot()) <= tolerance)
        #expect(transform.m22 == 1)
        #expect(!CATransform3DIsAffine(transform))
    }

    @Test
    func rotatingAroundTheZAxisMatchesTheAffineRotation() {
        let transform = CATransform3D(rotationAngle: .pi / 4, x: 0, y: 0, z: 1)
        #expect(CATransform3DIsAffine(transform))
        let affine = CATransform3DGetAffineTransform(transform)
        let expected = CGAffineTransform(rotationAngle: .pi / 4)
        let tolerance: CGFloat = 1e-15
        #expect(abs(affine.a - expected.a) <= tolerance)
        #expect(abs(affine.b - expected.b) <= tolerance)
        #expect(abs(affine.c - expected.c) <= tolerance)
        #expect(abs(affine.d - expected.d) <= tolerance)
    }

    @Test
    func onlyTheDirectionOfTheAxisMatters() {
        let unit = CATransform3D(rotationAngle: .pi / 2, x: 0, y: 0, z: 1)
        let long = CATransform3D(rotationAngle: .pi / 2, x: 0, y: 0, z: 5)
        #expect(CATransform3DEqualToTransform(unit, long))
    }

    @Test(arguments: [CGFloat.pi / 2, -1, 0, 100])
    func returnsTheIdentityForAZeroLengthAxis(_ angle: CGFloat) {
        #expect(CATransform3DIsIdentity(CATransform3D(rotationAngle: angle, x: 0, y: 0, z: 0)))
    }

    @Test
    func aZeroAngleIsTheIdentity() {
        #expect(CATransform3DIsIdentity(CATransform3D(rotationAngle: 0, x: 1, y: 2, z: 3)))
    }
}
#endif
