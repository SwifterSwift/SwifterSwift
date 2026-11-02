// CGVector+Divided.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGVector {
    /// SwifterSwift: Returns the vector with both components divided by a scalar.
    ///
    /// This divides the vector's magnitude by the absolute value of `scalar` and keeps its direction, for example to
    /// turn a velocity per second into a displacement per frame. A negative scalar also reverses the direction. Each
    /// component is divided directly instead of being multiplied by `1 / scalar`, so it's rounded only once.
    ///
    /// Dividing never traps, not even by zero, because it follows IEEE 754 floating-point rules. A non-zero component
    /// divided by zero becomes an infinity, negative when exactly one of the component and the zero is negative, and a
    /// zero component divided by zero becomes NaN. Dividing a finite vector by an infinite scalar gives zero
    /// components. Check that `scalar` isn't zero first if you need a finite result.
    ///
    /// ```swift
    /// let velocity = CGVector(dx: 120, dy: -60)
    /// velocity.divided(by: 60)  // (2.0, -1.0)
    /// CGVector(dx: 0, dy: -5).divided(by: 0)  // (nan, -inf)
    /// ```
    ///
    /// - Parameter scalar: The value to divide both components by.
    /// - Returns: A vector with `dx` equal to `self.dx / scalar` and `dy` equal to `self.dy / scalar`.
    func divided(by scalar: CGFloat) -> CGVector {
        CGVector(dx: dx / scalar, dy: dy / scalar)
    }
}
#endif
