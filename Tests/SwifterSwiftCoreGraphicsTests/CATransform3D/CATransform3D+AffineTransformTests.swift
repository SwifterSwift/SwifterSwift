// CATransform3D+AffineTransformTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DAffineTransformTests {
    @Test
    func convertsTheIdentity() {
        #expect(CATransform3DIdentity.affineTransform() == .identity)
    }

    @Test
    func convertsATranslationInThePlane() {
        let transform = CATransform3DMakeTranslation(10, 20, 0)
        #expect(transform.affineTransform() == CGAffineTransform(translationX: 10, y: 20))
    }

    @Test(arguments: [
        CGAffineTransform(a: 1, b: 2, c: 3, d: 4, tx: 5, ty: 6),
        CGAffineTransform(scaleX: -2, y: 0.5),
        CGAffineTransform(rotationAngle: .pi / 6).translatedBy(x: 3, y: -4)
    ])
    func roundTripsAnAffineTransform(_ affine: CGAffineTransform) {
        #expect(CATransform3DMakeAffineTransform(affine).affineTransform() == affine)
    }

    @Test
    func matchesCoreAnimationForAffineTransforms() throws {
        let transform = CATransform3DMakeRotation(.pi / 4, 0, 0, 1)
        let affine = try #require(transform.affineTransform())
        #expect(affine == CATransform3DGetAffineTransform(transform))
    }

    @Test(arguments: [
        CATransform3DMakeTranslation(10, 20, 5),
        CATransform3DMakeScale(1, 1, 2),
        CATransform3DMakeRotation(.pi / 4, 1, 0, 0)
    ])
    func returnsNilForTransformsThatUseTheZAxis(_ transform: CATransform3D) {
        #expect(transform.affineTransform() == nil)
    }

    @Test
    func returnsNilForPerspective() {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500
        #expect(perspective.affineTransform() == nil)
    }
}
#endif
