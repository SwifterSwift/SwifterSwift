// UIBezierPath+InitPolygonWithPointsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIBezierPathInitPolygonWithPointsTests {
    @Test
    func drawsAClosedPolygon() throws {
        let points = [CGPoint.zero, CGPoint(x: -1, y: 2), CGPoint(x: 2, y: 4), CGPoint(x: 3, y: -3)]
        let expected = UIBezierPath()
        expected.move(to: points[0])
        for point in points.dropFirst() {
            expected.addLine(to: point)
        }
        expected.close()

        let path = try #require(UIBezierPath(polygonWithPoints: points))
        #expect(path.cgPath == expected.cgPath)
        #expect(path.bounds == CGRect(x: -1, y: -3, width: 4, height: 7))
    }

    @Test
    func acceptsExactlyThreePoints() throws {
        let points = [CGPoint.zero, CGPoint(x: 10, y: 0), CGPoint(x: 5, y: 8)]
        let path = try #require(UIBezierPath(polygonWithPoints: points))
        #expect(path.contains(CGPoint(x: 5, y: 3)))
        #expect(!path.contains(CGPoint(x: 0, y: 8)))
    }

    @Test(arguments: [
        [CGPoint](),
        [CGPoint(x: 1, y: 1)],
        [CGPoint.zero, CGPoint(x: -1, y: 2)]
    ])
    func returnsNilForFewerThanThreePoints(_ points: [CGPoint]) {
        #expect(UIBezierPath(polygonWithPoints: points) == nil)
    }

    @Test
    func acceptsCollinearPoints() throws {
        let points = [CGPoint.zero, CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 2)]
        let path = try #require(UIBezierPath(polygonWithPoints: points))
        #expect(path.bounds == CGRect(x: 0, y: 0, width: 2, height: 2))
    }
}
#endif
