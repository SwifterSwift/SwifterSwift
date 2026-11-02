// CGRect+ResizingTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGRectResizingTests {
    let rect = CGRect(x: 10, y: 20, width: 30, height: 40)
    let newSize = CGSize(width: 50, height: 60)

    @Test
    func resizesAroundTheCenterByDefault() {
        let resized = rect.resizing(to: newSize)
        #expect(resized == CGRect(x: 0, y: 10, width: 50, height: 60))
        #expect(resized == rect.resizing(to: newSize, anchor: CGPoint(x: 0.5, y: 0.5)))
        #expect(resized.midX == rect.midX)
        #expect(resized.midY == rect.midY)
    }

    @Test
    func keepsTheMinimumCornerForAnchorZero() {
        let resized = rect.resizing(to: newSize, anchor: .zero)
        #expect(resized.origin == rect.origin)
        #expect(resized.size == newSize)
    }

    @Test
    func keepsTheMaxXMinYCornerForAnchorOneZero() {
        let resized = rect.resizing(to: newSize, anchor: CGPoint(x: 1, y: 0))
        #expect(resized.maxX == rect.maxX)
        #expect(resized.minY == rect.minY)
        #expect(resized.size == newSize)
    }

    @Test
    func keepsTheMinXMaxYCornerForAnchorZeroOne() {
        let resized = rect.resizing(to: newSize, anchor: CGPoint(x: 0, y: 1))
        #expect(resized.minX == rect.minX)
        #expect(resized.maxY == rect.maxY)
        #expect(resized.size == newSize)
    }

    @Test
    func keepsTheMaximumCornerForAnchorOne() {
        let resized = rect.resizing(to: newSize, anchor: CGPoint(x: 1, y: 1))
        #expect(resized == CGRect(x: -10, y: 0, width: 50, height: 60))
        #expect(resized.maxX == rect.maxX)
        #expect(resized.maxY == rect.maxY)
    }

    @Test(arguments: [
        CGPoint(x: 0.25, y: 0.75),
        CGPoint(x: 2, y: -1),
        CGPoint(x: -0.5, y: 1.5)
    ])
    func keepsTheAnchorPointInPlace(_ anchor: CGPoint) {
        let resized = rect.resizing(to: newSize, anchor: anchor)
        #expect(resized.minX + anchor.x * resized.width == rect.minX + anchor.x * rect.width)
        #expect(resized.minY + anchor.y * resized.height == rect.minY + anchor.y * rect.height)
        #expect(resized.size == newSize)
    }

    @Test
    func shrinksAroundTheAnchor() {
        let resized = rect.resizing(to: CGSize(width: 10, height: 20))
        #expect(resized == CGRect(x: 20, y: 30, width: 10, height: 20))
    }

    @Test
    func returnsTheSameRectangleForTheSameSize() {
        #expect(rect.resizing(to: rect.size, anchor: CGPoint(x: 0.3, y: 0.9)) == rect)
    }

    @Test
    func resizesToAPointAtTheAnchor() {
        let resized = rect.resizing(to: .zero)
        #expect(resized == CGRect(x: 25, y: 40, width: 0, height: 0))
    }

    @Test
    func resizesARectangleWithANegativeSizeLikeItsStandardizedForm() {
        let flipped = CGRect(x: 40, y: 60, width: -30, height: -40)
        let standardized = flipped.standardized
        #expect(flipped.resizing(to: newSize, anchor: .zero) == standardized.resizing(to: newSize, anchor: .zero))
        #expect(flipped.resizing(to: newSize) == rect.resizing(to: newSize))
    }
}
#endif
