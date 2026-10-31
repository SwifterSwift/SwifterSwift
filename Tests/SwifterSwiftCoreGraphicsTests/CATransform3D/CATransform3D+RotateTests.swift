// CATransform3D+RotateTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DRotateTests {
    @Test
    func rotatingTheIdentityGivesARotation() {
        var transform = CATransform3DIdentity
        transform.rotate(by: .pi / 3, x: 5, y: 10, z: 20)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeRotation(.pi / 3, 5, 10, 20)))
    }

    @Test
    func matchesCoreAnimation() {
        let base = CATransform3DScale(CATransform3DMakeTranslation(2, 3, 4), 2, 2, 2)
        var transform = base
        transform.rotate(by: -1.25, x: 0, y: 1, z: 1)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DRotate(base, -1.25, 0, 1, 1)))
    }

    @Test
    func appliesTheRotationBeforeTheTransform() {
        var transform = CATransform3DMakeTranslation(10, 0, 0)
        transform.rotate(by: .pi / 2, x: 0, y: 0, z: 1)
        #expect(transform.m41 == 10)
        #expect(transform.m42 == 0)
        #expect(abs(transform.m11) <= 1e-15)
        #expect(transform.m12 == 1)
    }

    @Test
    func onlyTheDirectionOfTheAxisMatters() {
        var unit = CATransform3DIdentity
        unit.rotate(by: .pi / 3, x: 0, y: 0, z: 1)
        var long = CATransform3DIdentity
        long.rotate(by: .pi / 3, x: 0, y: 0, z: 5)
        #expect(CATransform3DEqualToTransform(unit, long))
    }

    @Test
    func rotatingBackGivesTheOriginalTransform() {
        let base = CATransform3DMakeTranslation(2, 3, 4)
        var transform = base
        transform.rotate(by: .pi / 3, x: 1, y: 2, z: 3)
        transform.rotate(by: -.pi / 3, x: 1, y: 2, z: 3)
        #expect(abs(transform.m11 - 1) <= 1e-15)
        #expect(abs(transform.m12) <= 1e-15)
        #expect(abs(transform.m21) <= 1e-15)
        #expect(transform.m41 == base.m41)
        #expect(transform.m42 == base.m42)
        #expect(transform.m43 == base.m43)
    }

    @Test(arguments: [CGFloat.pi / 2, -1, 100, .infinity, .nan])
    func leavesTheTransformUnchangedForAZeroLengthAxis(_ angle: CGFloat) {
        let base = CATransform3DScale(CATransform3DMakeTranslation(2, 3, 4), 2, 2, 2)
        var transform = base
        transform.rotate(by: angle, x: 0, y: 0, z: 0)
        #expect(CATransform3DEqualToTransform(transform, base))
    }

    @Test
    func treatsANegativeZeroAxisAsZeroLength() {
        let base = CATransform3DMakeTranslation(2, 3, 4)
        var transform = base
        transform.rotate(by: .pi / 2, x: -0.0, y: 0, z: -0.0)
        #expect(CATransform3DEqualToTransform(transform, base))
    }

    @Test
    func aZeroAngleLeavesTheTransformUnchanged() {
        let base = CATransform3DMakeTranslation(2, 3, 4)
        var transform = base
        transform.rotate(by: 0, x: 1, y: 0, z: 0)
        #expect(CATransform3DEqualToTransform(transform, base))
    }
}
#endif
