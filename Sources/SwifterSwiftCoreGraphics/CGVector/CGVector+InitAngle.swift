// CGVector+InitAngle.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGVector {
    /// SwifterSwift: Creates a vector with the given direction and length.
    ///
    /// `angle` is in radians, measured from the positive x-axis toward the positive y-axis. A negative `magnitude`
    /// gives a vector that points the opposite way. The components are computed with `cos` and `sin`, so they're
    /// subject to floating-point rounding: a vector at an angle of `.pi / 2` has a tiny non-zero `dx` instead of
    /// exactly 0.
    ///
    /// ```swift
    /// let vector = CGVector(angle: .pi / 3, magnitude: 2)
    /// vector.dx  // 1.0000000000000002
    /// vector.dy  // 1.7320508075688772
    /// ```
    ///
    /// - Parameters:
    ///   - angle: The direction of the vector, in radians, measured from the positive x-axis.
    ///   - magnitude: The length of the vector.
    init(angle: CGFloat, magnitude: CGFloat) {
        self.init(dx: magnitude * cos(angle), dy: magnitude * sin(angle))
    }
}
#endif
