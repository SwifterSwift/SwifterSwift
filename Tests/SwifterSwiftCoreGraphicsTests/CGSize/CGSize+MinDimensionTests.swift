// CGSize+MinDimensionTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGSizeMinDimensionTests {
    @Test(arguments: [
        (CGSize(width: 1920, height: 1080), CGFloat(1080)),
        (CGSize(width: 50, height: 80), CGFloat(50)),
        (CGSize(width: 10, height: 0), CGFloat(0)),
        (CGSize(width: 25, height: 25), CGFloat(25)),
        (CGSize.zero, CGFloat(0)),
        (CGSize(width: -30, height: 10), CGFloat(-30)),
        (CGSize(width: -30, height: -10), CGFloat(-30)),
        (CGSize(width: CGFloat.infinity, height: 1), CGFloat(1)),
        (CGSize(width: -CGFloat.infinity, height: 1), -CGFloat.infinity)
    ])
    func returnsTheSmallerDimension(_ size: CGSize, expected: CGFloat) {
        #expect(size.minDimension == expected)
    }

    @Test(arguments: [
        CGSize(width: CGFloat.nan, height: 5),
        CGSize(width: 5, height: CGFloat.nan),
        CGSize(width: CGFloat.nan, height: CGFloat.nan)
    ])
    func returnsNaNWhenEitherDimensionIsNaN(_ size: CGSize) {
        #expect(size.minDimension.isNaN)
    }
}
#endif
