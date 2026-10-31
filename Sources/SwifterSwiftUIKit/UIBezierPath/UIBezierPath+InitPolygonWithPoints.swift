// UIBezierPath+InitPolygonWithPoints.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import UIKit

public extension UIBezierPath {
    /// SwifterSwift: Creates a closed polygon through the given points, or `nil` if there are fewer than three.
    ///
    /// The path moves to the first point, adds a line to each of the following points, and then closes the subpath,
    /// which adds the final edge back to the first point. The points aren't checked any further, so collinear or repeated
    /// points still give a path.
    ///
    /// ```swift
    /// let triangle = UIBezierPath(polygonWithPoints: [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 0), CGPoint(x: 5, y: 8)])
    /// triangle?.bounds  // (0.0, 0.0, 10.0, 8.0)
    /// UIBezierPath(polygonWithPoints: [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 0)])  // nil
    /// ```
    ///
    /// - Parameter points: The corners of the polygon, in drawing order.
    /// - Complexity: O(*n*), where *n* is the number of points.
    convenience init?(polygonWithPoints points: [CGPoint]) {
        guard points.count > 2, let first = points.first else { return nil }
        self.init()
        move(to: first)
        for point in points.dropFirst() {
            addLine(to: point)
        }
        close()
    }
}
#endif
