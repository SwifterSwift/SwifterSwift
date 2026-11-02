// UIBezierPath+InitPoints.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIBezierPath {
    /// SwifterSwift: Creates an open path that connects the given points with straight lines, in order.
    ///
    /// The path moves to the first point and adds a line to each of the following points. It isn't closed; use
    /// `init(polygonWithPoints:)` for a closed shape. An empty array gives an empty path, and a single point gives a path
    /// that only moves to that point.
    ///
    /// ```swift
    /// let zigzag = UIBezierPath(points: [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 10), CGPoint(x: 20, y: 0)])
    /// zigzag.currentPoint  // (20.0, 0.0)
    /// UIBezierPath(points: []).isEmpty  // true
    /// ```
    ///
    /// - Parameter points: The points to connect, in drawing order.
    /// - Complexity: O(*n*), where *n* is the number of points.
    convenience init(points: [CGPoint]) {
        self.init()
        guard let first = points.first else { return }
        move(to: first)
        for point in points.dropFirst() {
            addLine(to: point)
        }
    }
}
#endif
