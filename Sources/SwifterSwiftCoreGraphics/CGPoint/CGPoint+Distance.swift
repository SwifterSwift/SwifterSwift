// CGPoint+Distance.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGPoint {
    /// SwifterSwift: Returns the straight-line distance between this point and another point.
    ///
    /// The distance is computed with `hypot(_:_:)`, so it doesn't overflow when the squared differences between the
    /// coordinates are too large to represent, and it's the same in both directions.
    ///
    /// ```swift
    /// let start = CGPoint(x: 10, y: 10)
    /// let end = CGPoint(x: 40, y: 50)
    /// start.distance(from: end)  // 50.0
    /// end.distance(from: start)  // 50.0
    /// ```
    ///
    /// - Parameter point: The point to measure the distance from.
    /// - Returns: The Euclidean distance between the two points, which is never negative.
    func distance(from point: CGPoint) -> CGFloat {
        hypot(x - point.x, y - point.y)
    }
}
#endif
