// CGSize+MultipliedTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGSizeMultipliedTests {
    @Test(arguments: [
        (CGSize(width: 320, height: 180), CGFloat(3), CGSize(width: 960, height: 540)),
        (CGSize(width: 320, height: 180), CGFloat(0.5), CGSize(width: 160, height: 90)),
        (CGSize(width: 5, height: 10), CGFloat(1), CGSize(width: 5, height: 10)),
        (CGSize(width: 5, height: 10), CGFloat(-2), CGSize(width: -10, height: -20)),
        (CGSize(width: 5, height: 0), CGFloat(4), CGSize(width: 20, height: 0)),
        (CGSize(width: 5, height: 10), CGFloat(0), CGSize.zero)
    ])
    func multipliesBothDimensions(_ size: CGSize, by scalar: CGFloat, expected: CGSize) {
        #expect(size.multiplied(by: scalar) == expected)
    }

    @Test(arguments: [CGFloat(3), -2, 0.25])
    func matchesUniformScaleTransform(_ scalar: CGFloat) {
        let size = CGSize(width: 12, height: 7.5)
        #expect(size.multiplied(by: scalar) == size.applying(CGAffineTransform(scaleX: scalar, y: scalar)))
    }

    @Test
    func handlesInfinityAndNaN() {
        let infinite = CGSize(width: 1, height: 0).multiplied(by: .infinity)
        #expect(infinite.width == .infinity)
        #expect(infinite.height.isNaN)

        let nan = CGSize(width: 1, height: 2).multiplied(by: .nan)
        #expect(nan.width.isNaN)
        #expect(nan.height.isNaN)
    }
}
#endif
