// CGVector+Multiplied.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGVector {
    /// SwifterSwift: Returns the vector with both components multiplied by a scalar.
    ///
    /// This scales the vector's magnitude by the absolute value of `scalar` and keeps its direction. A negative scalar
    /// also reverses the direction, and a scalar of zero gives `.zero` for any finite vector. Core Graphics has no
    /// arithmetic for vectors.
    ///
    /// ```swift
    /// let velocity = CGVector(dx: 3, dy: -4)
    /// velocity.multiplied(by: 2)  // (6.0, -8.0)
    /// velocity.multiplied(by: -0.5)  // (-1.5, 2.0)
    /// ```
    ///
    /// - Parameter scalar: The value to multiply both components by.
    /// - Returns: A vector with `dx` equal to `self.dx * scalar` and `dy` equal to `self.dy * scalar`.
    func multiplied(by scalar: CGFloat) -> CGVector {
        CGVector(dx: dx * scalar, dy: dy * scalar)
    }
}
#endif
