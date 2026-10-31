// CATransform3D+InvertedTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DInvertedTests {
    @Test(arguments: [
        CATransform3DIdentity,
        CATransform3DMakeTranslation(5, 10, 20),
        CATransform3DMakeScale(5, 10, 20),
        CATransform3DMakeRotation(.pi / 3, 5, 10, 20)
    ])
    func matchesCoreAnimation(_ transform: CATransform3D) {
        #expect(CATransform3DEqualToTransform(transform.inverted(), CATransform3DInvert(transform)))
    }

    @Test
    func invertsTranslationsAndScales() {
        let translation = CATransform3DMakeTranslation(5, -10, 20).inverted()
        #expect(CATransform3DEqualToTransform(translation, CATransform3DMakeTranslation(-5, 10, -20)))

        let scale = CATransform3DMakeScale(2, 4, 1).inverted()
        #expect(CATransform3DEqualToTransform(scale, CATransform3DMakeScale(0.5, 0.25, 1)))
    }

    @Test
    func undoesTheTransform() {
        let transform = CATransform3DTranslate(CATransform3DMakeScale(2, 4, 8), 1, 2, 3)
        #expect(CATransform3DIsIdentity(CATransform3DConcat(transform, transform.inverted())))
    }

    @Test
    func theIdentityIsItsOwnInverse() {
        #expect(CATransform3DIsIdentity(CATransform3DIdentity.inverted()))
    }

    @Test(arguments: [
        CATransform3DMakeScale(0, 1, 1),
        CATransform3DMakeScale(1, 1, 0),
        CATransform3DMakeScale(0, 0, 0)
    ])
    func returnsTheTransformUnchangedWhenItHasNoInverse(_ transform: CATransform3D) {
        #expect(CATransform3DEqualToTransform(transform.inverted(), transform))
    }
}
#endif
