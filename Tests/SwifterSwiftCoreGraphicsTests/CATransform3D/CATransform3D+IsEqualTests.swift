// CATransform3D+IsEqualTests.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftCoreGraphics
import Testing

struct CATransform3DIsEqualTests {
    @Test(arguments: [
        CATransform3DIdentity,
        CATransform3DMakeTranslation(5, 10, 20),
        CATransform3DMakeScale(5, 10, 20),
        CATransform3DMakeRotation(.pi / 3, 5, 10, 20)
    ])
    func isTrueForTheSameTransform(_ transform: CATransform3D) {
        #expect(transform.isEqual(to: transform))
    }

    @Test
    func isTrueForEqualTransformsBuiltDifferently() {
        let translation = CATransform3DMakeTranslation(10, 20, 0)
        #expect(translation.isEqual(to: CATransform3DTranslate(CATransform3DIdentity, 10, 20, 0)))

        let scale = CATransform3DMakeScale(2, 3, 4)
        #expect(scale.isEqual(to: CATransform3DScale(CATransform3DIdentity, 2, 3, 4)))
    }

    @Test
    func comparesEveryElement() {
        let elements: [WritableKeyPath<CATransform3D, CGFloat>] = [
            \.m11, \.m12, \.m13, \.m14,
            \.m21, \.m22, \.m23, \.m24,
            \.m31, \.m32, \.m33, \.m34,
            \.m41, \.m42, \.m43, \.m44
        ]
        for element in elements {
            var changed = CATransform3DIdentity
            changed[keyPath: element] += 0.5
            #expect(!changed.isEqual(to: CATransform3DIdentity))
            #expect(!CATransform3DIdentity.isEqual(to: changed))
        }
    }

    @Test
    func comparesExactly() {
        let rounded = CATransform3DTranslate(CATransform3DMakeTranslation(0.1, 0, 0), 0.2, 0, 0)
        #expect(!rounded.isEqual(to: CATransform3DMakeTranslation(0.3, 0, 0)))

        var almost = CATransform3DIdentity
        almost.m11 = 1 + .ulpOfOne
        #expect(!almost.isEqual(to: CATransform3DIdentity))
    }

    @Test
    func isSymmetric() {
        let first = CATransform3DMakeRotation(.pi / 3, 1, 0, 0)
        let second = CATransform3DMakeRotation(.pi / 3, 0, 1, 0)
        #expect(first.isEqual(to: second) == second.isEqual(to: first))
        #expect(!first.isEqual(to: second))
    }

    @Test
    func dependsOnTheOrderOfOperations() {
        let move = CATransform3DMakeTranslation(10, 0, 0)
        let grow = CATransform3DMakeScale(2, 2, 1)
        #expect(!CATransform3DConcat(move, grow).isEqual(to: CATransform3DConcat(grow, move)))
    }

    @Test
    func treatsNegativeZeroAsZero() {
        var transform = CATransform3DIdentity
        transform.m41 = -0.0
        #expect(transform.isEqual(to: CATransform3DIdentity))
    }

    @Test
    func isFalseForNaNEvenAgainstItself() {
        var transform = CATransform3DIdentity
        transform.m34 = .nan
        #expect(!transform.isEqual(to: transform))
        #expect(!transform.isEqual(to: CATransform3DIdentity))
    }
}
#endif
