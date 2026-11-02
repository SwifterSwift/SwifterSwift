// CGPoint+Divided.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGPoint {
    /// SwifterSwift: Returns the point with both coordinates divided by a scalar.
    ///
    /// This scales the point's position relative to the origin, for example to convert a position in pixels to points
    /// with a display scale. A negative scalar also mirrors the point through the origin. Each coordinate is divided
    /// directly instead of being multiplied by `1 / scalar`, so it's rounded only once.
    ///
    /// Dividing never traps, not even by zero, because it follows IEEE 754 floating-point rules. A non-zero coordinate
    /// divided by zero becomes an infinity, negative when exactly one of the coordinate and the zero is negative, and
    /// a zero coordinate divided by zero becomes NaN. Dividing a finite point by an infinite scalar gives zero
    /// coordinates. Check that `scalar` isn't zero first if you need a finite result.
    ///
    /// ```swift
    /// let pixels = CGPoint(x: 300, y: -90)
    /// pixels.divided(by: 3)  // (100.0, -30.0)
    /// CGPoint(x: 1, y: 0).divided(by: 0)  // (inf, nan)
    /// ```
    ///
    /// - Parameter scalar: The value to divide both coordinates by.
    /// - Returns: A point with `x` equal to `self.x / scalar` and `y` equal to `self.y / scalar`.
    func divided(by scalar: CGFloat) -> CGPoint {
        CGPoint(x: x / scalar, y: y / scalar)
    }
}
#endif
