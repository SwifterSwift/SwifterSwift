// CGAffineTransform+Transform3DTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CGAffineTransformTransform3DTests {
    @Test(arguments: [
        CGAffineTransform.identity,
        CGAffineTransform(translationX: 10, y: -20),
        CGAffineTransform(scaleX: 2, y: -0.5),
        CGAffineTransform(rotationAngle: .pi / 3),
        CGAffineTransform(a: 1, b: 2, c: 3, d: 4, tx: 5, ty: 6)
    ])
    func matchesCoreAnimation(_ transform: CGAffineTransform) {
        let result = transform.transform3D()
        #expect(CATransform3DEqualToTransform(result, CATransform3DMakeAffineTransform(transform)))
        #expect(CATransform3DIsAffine(result))
        #expect(CATransform3DGetAffineTransform(result) == transform)
    }

    @Test
    func placesTheAffineValuesInTheMatrix() {
        let result = CGAffineTransform(a: 1, b: 2, c: 3, d: 4, tx: 5, ty: 6).transform3D()
        #expect(result.m11 == 1)
        #expect(result.m12 == 2)
        #expect(result.m21 == 3)
        #expect(result.m22 == 4)
        #expect(result.m41 == 5)
        #expect(result.m42 == 6)
    }

    @Test
    func leavesTheZAxisUnchanged() {
        let result = CGAffineTransform(a: 1, b: 2, c: 3, d: 4, tx: 5, ty: 6).transform3D()
        #expect(result.m13 == 0)
        #expect(result.m23 == 0)
        #expect(result.m31 == 0)
        #expect(result.m32 == 0)
        #expect(result.m33 == 1)
        #expect(result.m34 == 0)
        #expect(result.m43 == 0)
        #expect(result.m44 == 1)
    }

    @Test
    func convertsTheIdentityToTheIdentity() {
        #expect(CATransform3DIsIdentity(CGAffineTransform.identity.transform3D()))
    }
}
#endif
