// CGSize+SubtractingTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGSizeSubtractingTests {
    @Test(arguments: [
        (CGSize(width: 300, height: 200), CGSize(width: 32, height: 16), CGSize(width: 268, height: 184)),
        (CGSize(width: 5, height: 10), CGSize(width: 3, height: 4), CGSize(width: 2, height: 6)),
        (CGSize(width: 5, height: 10), CGSize.zero, CGSize(width: 5, height: 10)),
        (CGSize(width: 5, height: 10), CGSize(width: 5, height: 10), CGSize.zero),
        (CGSize(width: 5, height: 10), CGSize(width: -1.5, height: -2), CGSize(width: 6.5, height: 12))
    ])
    func subtractsDimensions(_ size: CGSize, _ other: CGSize, expected: CGSize) {
        #expect(size.subtracting(other) == expected)
    }

    @Test
    func doesNotClampAtZero() {
        let result = CGSize(width: 300, height: 200).subtracting(CGSize(width: 400, height: 0))
        #expect(result == CGSize(width: -100, height: 200))
    }

    @Test
    func returnsNaNForInfinityMinusInfinity() {
        let infinite = CGSize(width: CGFloat.infinity, height: 1)
        let result = infinite.subtracting(infinite)
        #expect(result.width.isNaN)
        #expect(result.height == 0)
    }
}
#endif
