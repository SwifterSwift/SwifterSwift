// CATransform3D+ConcatenatingTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DConcatenatingTests {
    @Test(arguments: [
        CATransform3DMakeTranslation(5, 10, 20),
        CATransform3DMakeScale(5, 10, 20),
        CATransform3DMakeRotation(.pi / 3, 5, 10, 20)
    ])
    func concatenatingWithTheIdentityLeavesTheTransformUnchanged(_ transform: CATransform3D) {
        #expect(CATransform3DEqualToTransform(CATransform3DIdentity.concatenating(transform), transform))
        #expect(CATransform3DEqualToTransform(transform.concatenating(CATransform3DIdentity), transform))
    }

    @Test
    func matchesCoreAnimation() {
        let first = CATransform3DMakeRotation(.pi / 3, 1, 0, 0)
        let second = CATransform3DMakeTranslation(5, 10, 20)
        #expect(CATransform3DEqualToTransform(first.concatenating(second), CATransform3DConcat(first, second)))
    }

    @Test
    func appliesTheReceiverFirst() {
        let move = CATransform3DMakeTranslation(10, 0, 0)
        let grow = CATransform3DMakeScale(2, 2, 1)
        #expect(move.concatenating(grow).m41 == 20)
        #expect(grow.concatenating(move).m41 == 10)
    }

    @Test
    func concatenatingTheInverseGivesTheIdentity() {
        let transform = CATransform3DMakeTranslation(5, -10, 20)
        #expect(CATransform3DIsIdentity(transform.concatenating(CATransform3DInvert(transform))))
    }
}
#endif
