// CGRect+CenterTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics
import SwifterSwiftCoreGraphics
import Testing

struct CGRectCenterTests {
    @Test(arguments: [
        (CGRect(x: 0, y: 0, width: 100, height: 50), CGPoint(x: 50, y: 25)),
        (CGRect(x: 10, y: 20, width: 100, height: 50), CGPoint(x: 60, y: 45)),
        (CGRect(x: -10, y: -20, width: 20, height: 40), CGPoint(x: 0, y: 0)),
        (CGRect(x: 0.5, y: 0.5, width: 1, height: 1), CGPoint(x: 1, y: 1)),
        (CGRect.zero, CGPoint.zero)
    ])
    func returnsMidpoint(of rect: CGRect, expected: CGPoint) {
        #expect(rect.center == expected)
    }

    @Test
    func handlesNegativeSize() {
        let rect = CGRect(x: 10, y: 10, width: -20, height: -40)
        #expect(rect.center == CGPoint(x: 0, y: -10))
        #expect(rect.center == rect.standardized.center)
    }
}
#endif
