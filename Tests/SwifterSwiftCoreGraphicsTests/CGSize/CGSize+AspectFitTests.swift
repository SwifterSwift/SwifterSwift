// CGSize+AspectFitTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGSizeAspectFitTests {
    @Test(arguments: [
        (CGSize(width: 120, height: 80), CGSize(width: 100, height: 50), CGSize(width: 75, height: 50)),
        (CGSize(width: 120, height: 80), CGSize(width: 240, height: 240), CGSize(width: 240, height: 160)),
        (CGSize(width: 20, height: 120), CGSize(width: 100, height: 60), CGSize(width: 10, height: 60)),
        (CGSize(width: 50, height: 50), CGSize(width: 100, height: 30), CGSize(width: 30, height: 30)),
        (CGSize(width: 100, height: 50), CGSize(width: 100, height: 50), CGSize(width: 100, height: 50)),
        (CGSize(width: 1, height: 2), CGSize(width: 1000, height: 1000), CGSize(width: 500, height: 1000))
    ])
    func fitsInsideTheBoundingSize(_ size: CGSize, _ boundingSize: CGSize, expected: CGSize) {
        #expect(size.aspectFit(to: boundingSize) == expected)
    }

    @Test(arguments: [
        (CGSize(width: 120, height: 80), CGSize(width: 100, height: 70)),
        (CGSize(width: 3, height: 7), CGSize(width: 10, height: 10)),
        (CGSize(width: 1920, height: 1080), CGSize(width: 375, height: 812)),
        (CGSize(width: 0.5, height: 0.25), CGSize(width: 33, height: 1))
    ])
    func keepsTheAspectRatioAndMatchesOneSideExactly(_ size: CGSize, _ boundingSize: CGSize) {
        let result = size.aspectFit(to: boundingSize)
        #expect(result.width <= boundingSize.width)
        #expect(result.height <= boundingSize.height)
        #expect(result.width == boundingSize.width || result.height == boundingSize.height)
        #expect(abs(result.width / result.height - size.width / size.height) <= 1e-12 * (size.width / size.height))
    }

    @Test(arguments: [
        CGSize.zero,
        CGSize(width: 0, height: 10),
        CGSize(width: 10, height: 0),
        CGSize(width: -10, height: 10),
        CGSize(width: 10, height: -10),
        CGSize(width: CGFloat.nan, height: 10),
        CGSize(width: 10, height: CGFloat.nan),
        CGSize(width: CGFloat.infinity, height: 10),
        CGSize(width: 10, height: CGFloat.infinity)
    ])
    func returnsZeroForASizeWithoutAnAspectRatio(_ size: CGSize) {
        #expect(size.aspectFit(to: CGSize(width: 100, height: 50)) == .zero)
    }

    @Test(arguments: [
        CGSize(width: -1, height: 50),
        CGSize(width: 100, height: -1),
        CGSize(width: CGFloat.nan, height: 50),
        CGSize(width: 100, height: CGFloat.nan)
    ])
    func returnsZeroForAnInvalidBoundingSize(_ boundingSize: CGSize) {
        #expect(CGSize(width: 120, height: 80).aspectFit(to: boundingSize) == .zero)
    }

    @Test
    func returnsZeroForAnEmptyBoundingSize() {
        let size = CGSize(width: 120, height: 80)
        #expect(size.aspectFit(to: .zero) == .zero)
        #expect(size.aspectFit(to: CGSize(width: 0, height: 50)) == .zero)
    }

    @Test
    func anInfiniteBoundingDimensionDoesNotLimitThatSide() {
        let size = CGSize(width: 120, height: 80)
        #expect(size.aspectFit(to: CGSize(width: CGFloat.infinity, height: 50)) == CGSize(width: 75, height: 50))
        #expect(size.aspectFit(to: CGSize(width: 60, height: CGFloat.infinity)) == CGSize(width: 60, height: 40))
        let unbounded = size.aspectFit(to: CGSize(width: CGFloat.infinity, height: CGFloat.infinity))
        #expect(unbounded == CGSize(width: CGFloat.infinity, height: CGFloat.infinity))
    }
}
#endif
