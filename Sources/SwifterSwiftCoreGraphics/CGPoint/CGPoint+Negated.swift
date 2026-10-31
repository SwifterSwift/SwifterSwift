// CGPoint+Negated.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGPoint {
    /// SwifterSwift: Returns the point mirrored through the origin.
    ///
    /// Both coordinates are negated, so negating twice gives back the original point. Use it to reverse an offset, for
    /// example to undo a translation. A zero coordinate becomes negative zero, which compares equal to zero. Core
    /// Graphics has no arithmetic for points.
    ///
    /// ```swift
    /// let offset = CGPoint(x: 12, y: -5)
    /// offset.negated()  // (-12.0, 5.0)
    /// CGPoint(x: 0, y: 3).negated()  // (-0.0, -3.0)
    /// ```
    ///
    /// - Returns: A point with `x` equal to `-self.x` and `y` equal to `-self.y`.
    func negated() -> CGPoint {
        CGPoint(x: -x, y: -y)
    }
}
#endif
