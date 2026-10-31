// CATransform3D+IdentityTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DIdentityTests {
    @Test
    func equalsTheCoreAnimationConstant() {
        #expect(CATransform3DEqualToTransform(CATransform3D.identity, CATransform3DIdentity))
        #expect(CATransform3DIsIdentity(CATransform3D.identity))
    }

    @Test
    func worksWithTypeInference() {
        let transform: CATransform3D = .identity
        #expect(transform.m11 == 1)
        #expect(transform.m22 == 1)
        #expect(transform.m33 == 1)
        #expect(transform.m44 == 1)
        #expect(transform.m34 == 0)
        #expect(transform.m41 == 0)
    }

    @Test
    func isNotEqualToOtherTransforms() {
        #expect(!CATransform3DEqualToTransform(.identity, CATransform3DMakeTranslation(1, 0, 0)))
        #expect(!CATransform3DEqualToTransform(.identity, CATransform3DMakeScale(2, 2, 2)))
        #expect(!CATransform3DEqualToTransform(.identity, CATransform3DMakeRotation(.pi / 3, 0, 0, 1)))
    }
}
#endif
