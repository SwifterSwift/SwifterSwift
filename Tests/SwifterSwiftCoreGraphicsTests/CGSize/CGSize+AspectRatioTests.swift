// CGSize+AspectRatioTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGSizeAspectRatioTests {
    @Test(arguments: [
        (CGSize(width: 1920, height: 1080), CGFloat(1920) / 1080),
        (CGSize(width: 20, height: 10), CGFloat(2)),
        (CGSize(width: 100, height: 200), CGFloat(0.5)),
        (CGSize(width: 50, height: 50), CGFloat(1)),
        (CGSize(width: 0, height: 100), CGFloat(0)),
        (CGSize(width: -20, height: 10), CGFloat(-2)),
        (CGSize(width: -20, height: -10), CGFloat(2))
    ])
    func dividesWidthByHeight(_ size: CGSize, expected: CGFloat) {
        #expect(size.aspectRatio == expected)
    }

    @Test(arguments: [
        CGSize(width: 10, height: 0),
        CGSize(width: -10, height: 0),
        CGSize(width: 10, height: -0.0),
        CGSize.zero,
        CGSize(width: CGFloat.infinity, height: 0)
    ])
    func returnsZeroForZeroHeight(_ size: CGSize) {
        #expect(size.aspectRatio == 0)
    }

    @Test
    func handlesInfinityAndNaN() {
        #expect(CGSize(width: CGFloat.infinity, height: 10).aspectRatio == .infinity)
        #expect(CGSize(width: 10, height: CGFloat.infinity).aspectRatio == 0)
        #expect(CGSize(width: CGFloat.nan, height: 10).aspectRatio.isNaN)
        #expect(CGSize(width: 10, height: CGFloat.nan).aspectRatio.isNaN)
    }
}
#endif
