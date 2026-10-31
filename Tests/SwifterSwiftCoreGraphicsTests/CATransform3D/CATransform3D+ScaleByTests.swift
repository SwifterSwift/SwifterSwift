// CATransform3D+ScaleByTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DScaleByTests {
    @Test
    func scalingTheIdentityGivesAScale() {
        var transform = CATransform3DIdentity
        transform.scaleBy(x: 5, y: 10, z: 20)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeScale(5, 10, 20)))
    }

    @Test
    func matchesCoreAnimation() {
        let base = CATransform3DRotate(CATransform3DMakeTranslation(2, 3, 4), .pi / 3, 1, 1, 0)
        var transform = base
        transform.scaleBy(x: -5, y: 0.5, z: 7)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DScale(base, -5, 0.5, 7)))
    }

    @Test
    func appliesTheScaleBeforeTheTransform() {
        var transform = CATransform3DMakeTranslation(10, 0, 0)
        transform.scaleBy(x: 2, y: 2, z: 1)
        #expect(transform.m11 == 2)
        #expect(transform.m41 == 10)
    }

    @Test
    func multipliesScales() {
        var transform = CATransform3DMakeScale(2, 2, 2)
        transform.scaleBy(x: 3, y: 0.5, z: 1)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeScale(6, 1, 2)))
    }

    @Test
    func aUnitScaleLeavesTheTransformUnchanged() {
        let base = CATransform3DMakeRotation(.pi / 5, 0, 0, 1)
        var transform = base
        transform.scaleBy(x: 1, y: 1, z: 1)
        #expect(CATransform3DEqualToTransform(transform, base))
    }

    @Test
    func aZeroFactorMakesTheTransformNonInvertible() {
        var transform = CATransform3DMakeTranslation(5, 10, 20)
        transform.scaleBy(x: 1, y: 0, z: 1)
        #expect(transform.m22 == 0)
        #expect(CATransform3DEqualToTransform(CATransform3DInvert(transform), transform))
    }
}
#endif
