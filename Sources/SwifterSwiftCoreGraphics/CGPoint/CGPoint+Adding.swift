// CGPoint+Adding.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGPoint {
    /// SwifterSwift: Returns the component-wise sum of this point and another point.
    ///
    /// Core Graphics has no arithmetic for points. The closest SDK spelling is
    /// `point.applying(CGAffineTransform(translationX: other.x, y: other.y))`, which goes through a matrix.
    ///
    /// ```swift
    /// let origin = CGPoint(x: 10, y: 20)
    /// origin.adding(CGPoint(x: 5, y: -5))  // (15.0, 15.0)
    /// ```
    ///
    /// - Parameter point: The point whose coordinates to add.
    /// - Returns: A point with `x` equal to `self.x + point.x` and `y` equal to `self.y + point.y`.
    func adding(_ point: CGPoint) -> CGPoint {
        CGPoint(x: x + point.x, y: y + point.y)
    }
}
#endif
