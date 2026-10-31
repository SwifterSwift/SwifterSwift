// CGRect+InitCenterTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGRectInitCenterTests {
    @Test(arguments: [
        (CGPoint(x: 50, y: 50), CGSize(width: 20, height: 10), CGRect(x: 40, y: 45, width: 20, height: 10)),
        (CGPoint(x: 10, y: 20), CGSize(width: 30, height: 40), CGRect(x: -5, y: 0, width: 30, height: 40)),
        (CGPoint.zero, CGSize(width: 3, height: 5), CGRect(x: -1.5, y: -2.5, width: 3, height: 5)),
        (CGPoint(x: -10, y: -10), CGSize(width: 4, height: 4), CGRect(x: -12, y: -12, width: 4, height: 4)),
        (CGPoint(x: 7, y: 8), CGSize.zero, CGRect(x: 7, y: 8, width: 0, height: 0))
    ])
    func centersTheRectangleOnThePoint(_ center: CGPoint, _ size: CGSize, expected: CGRect) {
        let rect = CGRect(center: center, size: size)
        #expect(rect == expected)
        #expect(rect.midX == center.x)
        #expect(rect.midY == center.y)
        #expect(rect.size == size)
    }

    @Test
    func keepsANegativeSizeAndStaysCentered() {
        let center = CGPoint(x: 10, y: 20)
        let size = CGSize(width: -30, height: -40)
        let rect = CGRect(center: center, size: size)
        #expect(rect.size == size)
        #expect(rect.midX == center.x)
        #expect(rect.midY == center.y)
        #expect(rect.standardized == CGRect(center: center, size: CGSize(width: 30, height: 40)))
    }
}
#endif
