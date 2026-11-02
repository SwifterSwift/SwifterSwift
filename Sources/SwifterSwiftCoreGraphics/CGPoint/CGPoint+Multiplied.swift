// CGPoint+Multiplied.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGPoint {
    /// SwifterSwift: Returns the point with both coordinates multiplied by a scalar.
    ///
    /// This scales the point's position relative to the origin. A negative scalar also mirrors the point through the
    /// origin, and a scalar of zero gives `.zero` for any finite point. It's equivalent to
    /// `point.applying(CGAffineTransform(scaleX: scalar, y: scalar))`, without going through a matrix.
    ///
    /// ```swift
    /// let point = CGPoint(x: 10, y: -4)
    /// point.multiplied(by: 2.5)  // (25.0, -10.0)
    /// point.multiplied(by: -1)  // (-10.0, 4.0)
    /// ```
    ///
    /// - Parameter scalar: The value to multiply both coordinates by.
    /// - Returns: A point with `x` equal to `self.x * scalar` and `y` equal to `self.y * scalar`.
    func multiplied(by scalar: CGFloat) -> CGPoint {
        CGPoint(x: x * scalar, y: y * scalar)
    }
}
#endif
