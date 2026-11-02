// CGSize+AspectFillTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGSizeAspectFillTests {
    @Test(arguments: [
        (CGSize(width: 20, height: 120), CGSize(width: 100, height: 60), CGSize(width: 100, height: 600)),
        (CGSize(width: 120, height: 80), CGSize(width: 240, height: 240), CGSize(width: 360, height: 240)),
        (CGSize(width: 50, height: 50), CGSize(width: 100, height: 30), CGSize(width: 100, height: 100)),
        (CGSize(width: 100, height: 50), CGSize(width: 100, height: 50), CGSize(width: 100, height: 50)),
        (CGSize(width: 400, height: 100), CGSize(width: 100, height: 100), CGSize(width: 400, height: 100))
    ])
    func coversTheBoundingSize(_ size: CGSize, _ boundingSize: CGSize, expected: CGSize) {
        #expect(size.aspectFill(to: boundingSize) == expected)
    }

    @Test
    func keepsTheAspectRatioInsteadOfReturningTheBoundingSize() {
        let boundingSize = CGSize(width: 100, height: 60)
        let result = CGSize(width: 20, height: 120).aspectFill(to: boundingSize)
        #expect(result != boundingSize)
        #expect(result.height / result.width == 6)
    }

    @Test(arguments: [
        (CGSize(width: 120, height: 80), CGSize(width: 100, height: 50)),
        (CGSize(width: 3, height: 7), CGSize(width: 10, height: 10)),
        (CGSize(width: 1920, height: 1080), CGSize(width: 375, height: 812)),
        (CGSize(width: 0.5, height: 0.25), CGSize(width: 33, height: 1))
    ])
    func keepsTheAspectRatioAndMatchesOneSideExactly(_ size: CGSize, _ boundingSize: CGSize) {
        let result = size.aspectFill(to: boundingSize)
        #expect(result.width >= boundingSize.width)
        #expect(result.height >= boundingSize.height)
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
        #expect(size.aspectFill(to: CGSize(width: 100, height: 50)) == .zero)
    }

    @Test(arguments: [
        CGSize(width: -1, height: 50),
        CGSize(width: 100, height: -1),
        CGSize(width: CGFloat.nan, height: 50),
        CGSize(width: 100, height: CGFloat.nan)
    ])
    func returnsZeroForAnInvalidBoundingSize(_ boundingSize: CGSize) {
        #expect(CGSize(width: 120, height: 80).aspectFill(to: boundingSize) == .zero)
    }

    @Test
    func handlesAnEmptyBoundingSize() {
        let size = CGSize(width: 120, height: 80)
        #expect(size.aspectFill(to: .zero) == .zero)
        #expect(size.aspectFill(to: CGSize(width: 0, height: 50)) == CGSize(width: 75, height: 50))
    }

    @Test
    func anInfiniteBoundingDimensionGivesAnInfiniteSize() {
        let result = CGSize(width: 120, height: 80).aspectFill(to: CGSize(width: CGFloat.infinity, height: 50))
        #expect(result == CGSize(width: CGFloat.infinity, height: CGFloat.infinity))
    }
}
#endif
