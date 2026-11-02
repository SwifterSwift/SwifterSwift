// CATransform3D+ConcatenateTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DConcatenateTests {
    @Test(arguments: [
        CATransform3DMakeTranslation(5, 10, 20),
        CATransform3DMakeScale(5, 10, 20),
        CATransform3DMakeRotation(.pi / 3, 5, 10, 20)
    ])
    func concatenatingWithTheIdentityLeavesTheTransformUnchanged(_ original: CATransform3D) {
        var transform = original
        transform.concatenate(CATransform3DIdentity)
        #expect(CATransform3DEqualToTransform(transform, original))

        var identity = CATransform3DIdentity
        identity.concatenate(original)
        #expect(CATransform3DEqualToTransform(identity, original))
    }

    @Test
    func matchesCoreAnimation() {
        let first = CATransform3DMakeRotation(.pi / 3, 1, 0, 0)
        let second = CATransform3DMakeTranslation(5, 10, 20)
        var transform = first
        transform.concatenate(second)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DConcat(first, second)))
    }

    @Test
    func appliesTheExistingTransformFirst() {
        var moveThenGrow = CATransform3DMakeTranslation(10, 0, 0)
        moveThenGrow.concatenate(CATransform3DMakeScale(2, 2, 1))
        #expect(moveThenGrow.m11 == 2)
        #expect(moveThenGrow.m41 == 20)

        var growThenMove = CATransform3DMakeScale(2, 2, 1)
        growThenMove.concatenate(CATransform3DMakeTranslation(10, 0, 0))
        #expect(growThenMove.m41 == 10)
    }

    @Test
    func concatenatingTheInverseGivesTheIdentity() {
        let original = CATransform3DMakeTranslation(5, -10, 20)
        var transform = original
        transform.concatenate(CATransform3DInvert(original))
        #expect(CATransform3DIsIdentity(transform))
    }

    @Test
    func concatenatingATransformWithItselfAppliesItTwice() {
        let original = CATransform3DMakeTranslation(5, -10, 20)
        var transform = original
        transform.concatenate(transform)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeTranslation(10, -20, 40)))
    }
}
#endif
