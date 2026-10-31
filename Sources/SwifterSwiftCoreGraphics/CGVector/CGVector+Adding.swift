// CGVector+Adding.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGVector {
    /// SwifterSwift: Returns the component-wise sum of this vector and another vector.
    ///
    /// Adding vectors combines them, for example a velocity and the wind acting on it. The result is the same in
    /// either order, and adding `.zero` gives back the original vector. Core Graphics has no arithmetic for vectors.
    ///
    /// ```swift
    /// let velocity = CGVector(dx: 3, dy: 0)
    /// let wind = CGVector(dx: -1, dy: 2)
    /// velocity.adding(wind)  // (2.0, 2.0)
    /// ```
    ///
    /// - Parameter vector: The vector whose components to add.
    /// - Returns: A vector with `dx` equal to `self.dx + vector.dx` and `dy` equal to `self.dy + vector.dy`.
    func adding(_ vector: CGVector) -> CGVector {
        CGVector(dx: dx + vector.dx, dy: dy + vector.dy)
    }
}
#endif
