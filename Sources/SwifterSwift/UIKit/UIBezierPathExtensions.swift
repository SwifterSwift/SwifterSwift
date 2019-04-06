//
//  UIBezierPathExtensions.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 04.04.19.
//  Copyright © 2019 SwifterSwift
//

#if canImport(UIKit)
import UIKit

// MARK: - Initializers
public extension UIBezierPath {

    /// SwifterSwift: Initializes a UIBezierPath with a line from a CGPoint to another CGPoint.
    ///
    /// - Parameters:
    ///   - from: The point from which to path should start.
    ///   - to: The point where the path should end.
    convenience init(from: CGPoint, to otherPoint: CGPoint) {
        self.init()
        move(to: from)
        addLine(to: otherPoint)
    }

    /// SwifterSwift: Initializes a UIBezierPath connecting the given CGPoints with straight lines.
    ///
    /// - Parameter points: The points of which the path should consist.
    convenience init(points: [CGPoint]) {
        self.init()
        if !points.isEmpty {
            move(to: points[0])
            for point in points[1...] {
                addLine(to: point)
            }
        }
    }

    /// SwifterSwift: Initializes a polygonal UIBezierPath with the given CGPoints. At least 3 points must be given.
    ///
    /// - Parameter points: The points of the polygon which the path should form.
    convenience init?(polygonWithPoints points: [CGPoint]) {
        guard points.count > 2 else {return nil}
        self.init()
        move(to: points[0])
        for point in points[1...] {
            addLine(to: point)
        }
        close()
    }

    /// SwifterSwift: Initializes a UIBezierPath with an oval path of given size.
    ///
    /// - Parameters:
    ///   - size: The width and height of the oval.
    ///   - centered: Whether the oval should be centered in its coordinate space.
    convenience init(ovalOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(ovalIn: CGRect(origin: origin, size: size))
    }

    /// SwifterSwift: Initializes a UIBezierPath with a  rectangular path of given size.
    ///
    /// - Parameters:
    ///   - size: The width and height of the rect.
    ///   - centered: Whether the oval should be centered in its coordinate space.
    convenience init(rectOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(rect: CGRect(origin: origin, size: size))
    }

}

#endif
