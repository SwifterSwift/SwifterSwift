// CATransform3D+TranslateByTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DTranslateByTests {
    @Test
    func translatingTheIdentityGivesATranslation() {
        var transform = CATransform3DIdentity
        transform.translateBy(x: 5, y: 10, z: 20)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeTranslation(5, 10, 20)))
    }

    @Test
    func matchesCoreAnimation() {
        let base = CATransform3DRotate(CATransform3DMakeScale(2, 3, 4), .pi / 3, 1, 1, 0)
        var transform = base
        transform.translateBy(x: -5, y: 0.5, z: 7)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DTranslate(base, -5, 0.5, 7)))
    }

    @Test
    func appliesTheTranslationBeforeTheTransform() {
        var transform = CATransform3DMakeScale(2, 2, 1)
        transform.translateBy(x: 10, y: 0, z: 0)
        #expect(transform.m11 == 2)
        #expect(transform.m41 == 20)
    }

    @Test
    func accumulatesTranslations() {
        var transform = CATransform3DIdentity
        transform.translateBy(x: 1, y: 2, z: 3)
        transform.translateBy(x: 4, y: 5, z: 6)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeTranslation(5, 7, 9)))
    }

    @Test
    func aZeroTranslationLeavesTheTransformUnchanged() {
        let base = CATransform3DMakeRotation(.pi / 5, 0, 0, 1)
        var transform = base
        transform.translateBy(x: 0, y: 0, z: 0)
        #expect(CATransform3DEqualToTransform(transform, base))
    }

    @Test
    func propagatesNaNToTheTranslationRow() {
        var transform = CATransform3DIdentity
        transform.translateBy(x: .nan, y: 1, z: 0)
        #expect(transform.m41.isNaN)
        #expect(transform.m42.isNaN)
        #expect(transform.m11 == 1)
        #expect(transform.m22 == 1)
        #expect(transform.m33 == 1)
    }
}
#endif
