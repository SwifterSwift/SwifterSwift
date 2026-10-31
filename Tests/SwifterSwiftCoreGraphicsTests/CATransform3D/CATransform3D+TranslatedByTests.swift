// CATransform3D+TranslatedByTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DTranslatedByTests {
    @Test
    func translatingTheIdentityGivesATranslation() {
        let transform = CATransform3DIdentity.translatedBy(x: 5, y: 10, z: 20)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeTranslation(5, 10, 20)))
    }

    @Test
    func matchesCoreAnimation() {
        let base = CATransform3DRotate(CATransform3DMakeScale(2, 3, 4), .pi / 3, 1, 1, 0)
        let transform = base.translatedBy(x: -5, y: 0.5, z: 7)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DTranslate(base, -5, 0.5, 7)))
    }

    @Test
    func appliesTheTranslationBeforeTheTransform() {
        let transform = CATransform3DMakeScale(2, 2, 1).translatedBy(x: 10, y: 0, z: 0)
        #expect(transform.m11 == 2)
        #expect(transform.m41 == 20)
    }

    @Test
    func accumulatesTranslations() {
        let transform = CATransform3DIdentity.translatedBy(x: 1, y: 2, z: 3).translatedBy(x: 4, y: 5, z: 6)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeTranslation(5, 7, 9)))
    }

    @Test
    func aZeroTranslationLeavesTheTransformUnchanged() {
        let base = CATransform3DMakeRotation(.pi / 5, 0, 0, 1)
        #expect(CATransform3DEqualToTransform(base.translatedBy(x: 0, y: 0, z: 0), base))
    }
}
#endif
