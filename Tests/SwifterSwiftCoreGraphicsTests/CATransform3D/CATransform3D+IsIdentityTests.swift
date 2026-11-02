// CATransform3D+IsIdentityTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DIsIdentityTests {
    @Test
    func isTrueForTheIdentity() {
        #expect(CATransform3DIdentity.isIdentity)
        #expect(CATransform3DMakeTranslation(0, 0, 0).isIdentity)
        #expect(CATransform3DMakeScale(1, 1, 1).isIdentity)
    }

    @Test(arguments: [
        CATransform3DMakeTranslation(5, 10, 20),
        CATransform3DMakeScale(2, 2, 1),
        CATransform3DMakeRotation(.pi / 3, 0, 0, 1),
        CATransform3DMakeTranslation(0, 0, 1)
    ])
    func isFalseForOtherTransforms(_ transform: CATransform3D) {
        #expect(!transform.isIdentity)
    }

    @Test
    func comparesEveryElementExactly() {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500
        #expect(!perspective.isIdentity)

        var almost = CATransform3DIdentity
        almost.m11 = 1 + .ulpOfOne
        #expect(!almost.isIdentity)
    }

    @Test
    func isFalseForNaN() {
        var transform = CATransform3DIdentity
        transform.m41 = .nan
        #expect(!transform.isIdentity)
    }
}
#endif
