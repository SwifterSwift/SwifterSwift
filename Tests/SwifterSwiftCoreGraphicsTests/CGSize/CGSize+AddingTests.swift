// CGSize+AddingTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGSizeAddingTests {
    @Test(arguments: [
        (CGSize(width: 300, height: 200), CGSize(width: 32, height: 16), CGSize(width: 332, height: 216)),
        (CGSize(width: 5, height: 10), CGSize(width: 3, height: 4), CGSize(width: 8, height: 14)),
        (CGSize(width: 5, height: 10), CGSize.zero, CGSize(width: 5, height: 10)),
        (CGSize(width: 5, height: 10), CGSize(width: -8, height: -2.5), CGSize(width: -3, height: 7.5)),
        (CGSize(width: -1, height: -2), CGSize(width: 1, height: 2), CGSize.zero)
    ])
    func addsDimensions(_ size: CGSize, _ other: CGSize, expected: CGSize) {
        #expect(size.adding(other) == expected)
    }

    @Test
    func isCommutative() {
        let first = CGSize(width: 7.25, height: 3)
        let second = CGSize(width: 1, height: 12.5)
        #expect(first.adding(second) == second.adding(first))
    }

    @Test
    func overflowsToInfinity() {
        let extreme = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 1)
        let result = extreme.adding(extreme)
        #expect(result.width == .infinity)
        #expect(result.height == 2)
    }

    @Test
    func propagatesNaN() {
        let result = CGSize(width: 1, height: CGFloat.nan).adding(CGSize(width: 1, height: 1))
        #expect(result.width == 2)
        #expect(result.height.isNaN)
    }
}
#endif
