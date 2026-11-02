// CGVector+Negated.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGVector {
    /// SwifterSwift: Returns the vector that points the opposite way, with the same magnitude.
    ///
    /// Both components are negated, so negating twice gives back the original vector. A zero component becomes
    /// negative zero, which compares equal to zero.
    ///
    /// ```swift
    /// let gravity = CGVector(dx: 0, dy: -9.8)
    /// gravity.negated()  // (-0.0, 9.8)
    /// CGVector(dx: 3, dy: -4).negated()  // (-3.0, 4.0)
    /// ```
    ///
    /// - Returns: A vector with `dx` equal to `-self.dx` and `dy` equal to `-self.dy`.
    func negated() -> CGVector {
        CGVector(dx: -dx, dy: -dy)
    }
}
#endif
