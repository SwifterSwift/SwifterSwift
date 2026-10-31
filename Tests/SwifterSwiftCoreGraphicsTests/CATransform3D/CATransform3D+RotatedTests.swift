// CATransform3D+RotatedTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DRotatedTests {
    @Test
    func rotatingTheIdentityGivesARotation() {
        let transform = CATransform3DIdentity.rotated(by: .pi / 3, x: 5, y: 10, z: 20)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeRotation(.pi / 3, 5, 10, 20)))
    }

    @Test
    func matchesCoreAnimation() {
        let base = CATransform3DScale(CATransform3DMakeTranslation(2, 3, 4), 2, 2, 2)
        let transform = base.rotated(by: -1.25, x: 0, y: 1, z: 1)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DRotate(base, -1.25, 0, 1, 1)))
    }

    @Test
    func appliesTheRotationBeforeTheTransform() {
        let transform = CATransform3DMakeTranslation(10, 0, 0).rotated(by: .pi / 2, x: 0, y: 0, z: 1)
        #expect(transform.m41 == 10)
        #expect(transform.m42 == 0)
        #expect(abs(transform.m11) <= 1e-15)
        #expect(transform.m12 == 1)
    }

    @Test(arguments: [CGFloat.pi / 2, -1, 100])
    func returnsTheTransformUnchangedForAZeroLengthAxis(_ angle: CGFloat) {
        let base = CATransform3DScale(CATransform3DMakeTranslation(2, 3, 4), 2, 2, 2)
        #expect(CATransform3DEqualToTransform(base.rotated(by: angle, x: 0, y: 0, z: 0), base))
    }

    @Test
    func aZeroAngleLeavesTheTransformUnchanged() {
        let base = CATransform3DMakeTranslation(2, 3, 4)
        #expect(CATransform3DEqualToTransform(base.rotated(by: 0, x: 1, y: 0, z: 0), base))
    }
}
#endif
