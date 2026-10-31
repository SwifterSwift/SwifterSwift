// CGVector+Subtracting.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGVector {
    /// SwifterSwift: Returns the component-wise difference between this vector and another vector.
    ///
    /// The result is the change from `vector` to this vector, for example how much a velocity changed between two
    /// frames. Subtracting a vector from itself gives `.zero` for any finite vector, and swapping the operands negates
    /// the result. Core Graphics has no arithmetic for vectors.
    ///
    /// ```swift
    /// let now = CGVector(dx: 5, dy: -2)
    /// let before = CGVector(dx: 2, dy: 2)
    /// now.subtracting(before)  // (3.0, -4.0)
    /// ```
    ///
    /// - Parameter vector: The vector whose components to subtract.
    /// - Returns: A vector with `dx` equal to `self.dx - vector.dx` and `dy` equal to `self.dy - vector.dy`.
    func subtracting(_ vector: CGVector) -> CGVector {
        CGVector(dx: dx - vector.dx, dy: dy - vector.dy)
    }
}
#endif
