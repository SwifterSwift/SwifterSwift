// CATransform3D+InitScaleXTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DInitScaleXTests {
    @Test(arguments: [
        (CGFloat(5), CGFloat(10), CGFloat(20)),
        (CGFloat(2), CGFloat(0.5), CGFloat(1)),
        (CGFloat(-1), CGFloat(1), CGFloat(1))
    ])
    func matchesCoreAnimation(x: CGFloat, y: CGFloat, z: CGFloat) {
        let transform = CATransform3D(scaleX: x, y: y, z: z)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeScale(x, y, z)))
        #expect(transform.m11 == x)
        #expect(transform.m22 == y)
        #expect(transform.m33 == z)
        #expect(transform.m44 == 1)
        #expect(transform.m41 == 0)
    }

    @Test
    func aUnitScaleIsTheIdentity() {
        #expect(CATransform3DIsIdentity(CATransform3D(scaleX: 1, y: 1, z: 1)))
    }

    @Test
    func aZeroFactorMakesTheTransformNonInvertible() {
        let flat = CATransform3D(scaleX: 0, y: 1, z: 1)
        #expect(CATransform3DEqualToTransform(CATransform3DInvert(flat), flat))
    }
}
#endif
