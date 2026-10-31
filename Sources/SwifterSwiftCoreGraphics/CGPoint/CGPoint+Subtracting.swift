// CGPoint+Subtracting.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGPoint {
    /// SwifterSwift: Returns the component-wise difference between this point and another point.
    ///
    /// The result is the offset from `point` to this point, for example the distance a finger moved since a gesture
    /// began. Core Graphics has no arithmetic for points.
    ///
    /// ```swift
    /// let touch = CGPoint(x: 120, y: 80)
    /// let start = CGPoint(x: 100, y: 100)
    /// touch.subtracting(start)  // (20.0, -20.0)
    /// ```
    ///
    /// - Parameter point: The point whose coordinates to subtract.
    /// - Returns: A point with `x` equal to `self.x - point.x` and `y` equal to `self.y - point.y`.
    func subtracting(_ point: CGPoint) -> CGPoint {
        CGPoint(x: x - point.x, y: y - point.y)
    }
}
#endif
