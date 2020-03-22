//
//  UIBezierPathExtensions.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 06.04.19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit)
import UIKit

final class UIBezierPathExtensionsTests: XCTestCase {

    func testInitPathFromTo() {
        let fromPoint = CGPoint(x: -1, y: 2)
        let toPoint = CGPoint(x: 2, y: 4)
        let path = UIBezierPath(from: fromPoint, to: toPoint)
        XCTAssertEqual(path.points, [fromPoint, toPoint])
    }

    func testInitWithPoints() {
        let emptyPath = UIBezierPath(points: [])
        XCTAssert(emptyPath.points.isEmpty)

        let points = [
            CGPoint(x: -1, y: 2),
            CGPoint(x: 2, y: 4),
            CGPoint(x: 3, y: -3)
        ]
        let path = UIBezierPath(points: points)
        XCTAssertEqual(path.points, points)
    }

    func testInitPolygonWithPoints() {
        let insufficientPoints = [
            CGPoint(x: 0, y: 0),
            CGPoint(x: -1, y: 2)
        ]
        XCTAssertNil(UIBezierPath(polygonWithPoints: insufficientPoints))

        let firstPoint = CGPoint.zero
        let points = [
            firstPoint,
            CGPoint(x: -1, y: 2),
            CGPoint(x: 2, y: 4),
            CGPoint(x: 3, y: -3)
        ]
        let path = UIBezierPath(polygonWithPoints: points)
        XCTAssertNotNil(path)
        XCTAssertEqual(path!.points, points + [firstPoint])
    }

    func testInitOvalOfSize() {
        let width: CGFloat = 100
        let height: CGFloat = 50
        let size = CGSize(width: width, height: height)

        let centeredPath = UIBezierPath(ovalOf: size, centered: true)
        XCTAssertEqual(centeredPath, UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: -width / 2, y: -height / 2), size: size)))

        let uncenteredPath = UIBezierPath(ovalOf: size, centered: false)
        XCTAssertEqual(uncenteredPath, UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)))
    }

    func testInitRectOfSize() {
        let width: CGFloat = 100
        let height: CGFloat = 50
        let size = CGSize(width: width, height: height)

        let centeredPath = UIBezierPath(rectOf: size, centered: true)
        XCTAssertEqual(centeredPath, UIBezierPath(rect: CGRect(origin: CGPoint(x: -width / 2, y: -height / 2), size: size)))

        let uncenteredPath = UIBezierPath(rectOf: size, centered: false)
        XCTAssertEqual(uncenteredPath, UIBezierPath(rect: CGRect(origin: .zero, size: size)))
    }

}

fileprivate extension UIBezierPath {

    // Only works for straight lines
    var points: [CGPoint] {
        var points = [CGPoint]()
        if #available(iOS 11.0, *) {
            cgPath.applyWithBlock { pointer in
                let element = pointer.pointee
                var point = CGPoint.zero
                switch element.type {
                case .moveToPoint: point = element.points[0]
                case .addLineToPoint: point = element.points[0]
                default: break
                }
                points.append(point)
            }
        }
        return points
    }

}

#endif
