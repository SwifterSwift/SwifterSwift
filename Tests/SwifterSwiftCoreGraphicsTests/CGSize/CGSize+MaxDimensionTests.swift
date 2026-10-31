// CGSize+MaxDimensionTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGSizeMaxDimensionTests {
    @Test(arguments: [
        (CGSize(width: 1920, height: 1080), CGFloat(1920)),
        (CGSize(width: 50, height: 80), CGFloat(80)),
        (CGSize(width: 10, height: 0), CGFloat(10)),
        (CGSize(width: 25, height: 25), CGFloat(25)),
        (CGSize.zero, CGFloat(0)),
        (CGSize(width: -30, height: 10), CGFloat(10)),
        (CGSize(width: -30, height: -10), CGFloat(-10)),
        (CGSize(width: CGFloat.infinity, height: 1), CGFloat.infinity),
        (CGSize(width: -CGFloat.infinity, height: 1), CGFloat(1))
    ])
    func returnsTheLargerDimension(_ size: CGSize, expected: CGFloat) {
        #expect(size.maxDimension == expected)
    }

    @Test(arguments: [
        CGSize(width: CGFloat.nan, height: 5),
        CGSize(width: 5, height: CGFloat.nan),
        CGSize(width: CGFloat.nan, height: CGFloat.nan)
    ])
    func returnsNaNWhenEitherDimensionIsNaN(_ size: CGSize) {
        #expect(size.maxDimension.isNaN)
    }
}
#endif
