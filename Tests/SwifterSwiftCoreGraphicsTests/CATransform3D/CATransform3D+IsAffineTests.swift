// CATransform3D+IsAffineTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DIsAffineTests {
    @Test(arguments: [
        CATransform3DIdentity,
        CATransform3DMakeTranslation(5, 10, 0),
        CATransform3DMakeScale(2, -3, 1),
        CATransform3DMakeRotation(.pi / 4, 0, 0, 1),
        CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 2, c: 3, d: 4, tx: 5, ty: 6))
    ])
    func isTrueForTwoDimensionalTransforms(_ transform: CATransform3D) {
        #expect(transform.isAffine)
    }

    @Test(arguments: [
        CATransform3DMakeTranslation(0, 0, 1),
        CATransform3DMakeScale(1, 1, 2),
        CATransform3DMakeRotation(.pi / 4, 1, 0, 0),
        CATransform3DMakeRotation(.pi / 4, 0, 1, 0)
    ])
    func isFalseForTransformsThatUseTheZAxis(_ transform: CATransform3D) {
        #expect(!transform.isAffine)
    }

    @Test
    func isFalseForPerspective() {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500
        #expect(!perspective.isAffine)
    }
}
#endif
