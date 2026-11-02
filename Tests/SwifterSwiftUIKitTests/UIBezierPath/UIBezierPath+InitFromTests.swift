// UIBezierPath+InitFromTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIBezierPathInitFromTests {
    @Test(arguments: [
        (CGPoint(x: -1, y: 2), CGPoint(x: 2, y: 4)),
        (CGPoint(x: 0, y: 10), CGPoint(x: 100, y: 10)),
        (CGPoint(x: 5, y: 5), CGPoint(x: 5, y: 5))
    ])
    func drawsASingleLine(from start: CGPoint, to end: CGPoint) {
        let expected = UIBezierPath()
        expected.move(to: start)
        expected.addLine(to: end)

        let path = UIBezierPath(from: start, to: end)
        #expect(path.cgPath == expected.cgPath)
        #expect(path.currentPoint == end)
    }

    @Test
    func coversTheLineInItsBounds() {
        let path = UIBezierPath(from: CGPoint(x: 100, y: 50), to: CGPoint(x: -20, y: 10))
        #expect(path.bounds == CGRect(x: -20, y: 10, width: 120, height: 40))
    }

    @Test
    func isNotClosed() {
        let path = UIBezierPath(from: .zero, to: CGPoint(x: 10, y: 0))
        let closed = UIBezierPath(from: .zero, to: CGPoint(x: 10, y: 0))
        closed.close()
        #expect(path.cgPath != closed.cgPath)
    }
}
#endif
