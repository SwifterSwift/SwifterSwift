// UIBezierPath+InitPointsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIBezierPathInitPointsTests {
    @Test
    func connectsPointsInOrder() {
        let points = [CGPoint(x: -1, y: 2), CGPoint(x: 2, y: 4), CGPoint(x: 3, y: -3)]
        let expected = UIBezierPath()
        expected.move(to: points[0])
        expected.addLine(to: points[1])
        expected.addLine(to: points[2])

        let path = UIBezierPath(points: points)
        #expect(path.cgPath == expected.cgPath)
        #expect(path.currentPoint == points[2])
    }

    @Test
    func isEmptyForNoPoints() {
        let path = UIBezierPath(points: [])
        #expect(path.isEmpty)
        #expect(path.cgPath == UIBezierPath().cgPath)
    }

    @Test
    func onlyMovesForASinglePoint() {
        let point = CGPoint(x: 3, y: 4)
        let expected = UIBezierPath()
        expected.move(to: point)

        let path = UIBezierPath(points: [point])
        #expect(path.cgPath == expected.cgPath)
        #expect(path.currentPoint == point)
    }

    @Test
    func keepsRepeatedPointsAndStaysOpen() {
        let points = [CGPoint.zero, CGPoint(x: 10, y: 0), CGPoint(x: 10, y: 0), CGPoint.zero]
        let expected = UIBezierPath()
        expected.move(to: points[0])
        for point in points.dropFirst() {
            expected.addLine(to: point)
        }

        let path = UIBezierPath(points: points)
        #expect(path.cgPath == expected.cgPath)

        let closed = UIBezierPath(points: points)
        closed.close()
        #expect(path.cgPath != closed.cgPath)
    }
}
#endif
