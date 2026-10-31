// CATransform3D+InitTranslationXTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DInitTranslationXTests {
    @Test(arguments: [
        (CGFloat(5), CGFloat(10), CGFloat(20)),
        (CGFloat(-5), CGFloat(0.5), CGFloat(-20)),
        (CGFloat(0), CGFloat(0), CGFloat(1))
    ])
    func matchesCoreAnimation(x: CGFloat, y: CGFloat, z: CGFloat) {
        let transform = CATransform3D(translationX: x, y: y, z: z)
        #expect(CATransform3DEqualToTransform(transform, CATransform3DMakeTranslation(x, y, z)))
        #expect(transform.m41 == x)
        #expect(transform.m42 == y)
        #expect(transform.m43 == z)
    }

    @Test
    func leavesTheRestOfTheMatrixAsTheIdentity() {
        var transform = CATransform3D(translationX: 5, y: 10, z: 20)
        transform.m41 = 0
        transform.m42 = 0
        transform.m43 = 0
        #expect(CATransform3DIsIdentity(transform))
    }

    @Test
    func aZeroTranslationIsTheIdentity() {
        #expect(CATransform3DIsIdentity(CATransform3D(translationX: 0, y: 0, z: 0)))
    }
}
#endif
