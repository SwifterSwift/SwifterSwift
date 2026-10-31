// CATransform3D+InvertTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DInvertTests {
    @Test(arguments: [
        CATransform3DIdentity,
        CATransform3DMakeTranslation(5, 10, 20),
        CATransform3DMakeScale(5, 10, 20),
        CATransform3DMakeRotation(.pi / 3, 5, 10, 20)
    ])
    func matchesCoreAnimation(_ original: CATransform3D) {
        var transform = original
        transform.invert()
        #expect(CATransform3DEqualToTransform(transform, CATransform3DInvert(original)))
    }

    @Test
    func invertsTranslationsAndScales() {
        var translation = CATransform3DMakeTranslation(5, -10, 20)
        translation.invert()
        #expect(CATransform3DEqualToTransform(translation, CATransform3DMakeTranslation(-5, 10, -20)))

        var scale = CATransform3DMakeScale(2, 4, 1)
        scale.invert()
        #expect(CATransform3DEqualToTransform(scale, CATransform3DMakeScale(0.5, 0.25, 1)))
    }

    @Test
    func undoesTheTransform() {
        let original = CATransform3DTranslate(CATransform3DMakeScale(2, 4, 8), 1, 2, 3)
        var transform = original
        transform.invert()
        #expect(CATransform3DIsIdentity(CATransform3DConcat(original, transform)))
    }

    @Test
    func invertingTwiceGivesTheOriginalTransform() {
        let original = CATransform3DTranslate(CATransform3DMakeScale(2, 4, 8), 1, 2, 3)
        var transform = original
        transform.invert()
        transform.invert()
        #expect(CATransform3DEqualToTransform(transform, original))
    }

    @Test
    func leavesTheIdentityUnchanged() {
        var transform = CATransform3DIdentity
        transform.invert()
        #expect(CATransform3DIsIdentity(transform))
    }

    @Test(arguments: [
        CATransform3DMakeScale(0, 1, 1),
        CATransform3DMakeScale(1, 1, 0),
        CATransform3DMakeScale(0, 0, 0)
    ])
    func leavesTheTransformUnchangedWhenItHasNoInverse(_ original: CATransform3D) {
        var transform = original
        transform.invert()
        #expect(CATransform3DEqualToTransform(transform, original))
    }
}
#endif
