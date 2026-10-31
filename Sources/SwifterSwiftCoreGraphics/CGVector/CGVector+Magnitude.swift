// CGVector+Magnitude.swift - Copyright 2026 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

public extension CGVector {
    /// SwifterSwift: The length of the vector.
    ///
    /// The magnitude is computed with `hypot(_:_:)`, so it doesn't overflow when the squares of `dx` and `dy` are too
    /// large to represent. It's never negative, and it's 0 only for the zero vector.
    ///
    /// ```swift
    /// CGVector(dx: 3, dy: 4).magnitude  // 5.0
    /// CGVector(dx: -5, dy: 12).magnitude  // 13.0
    /// ```
    var magnitude: CGFloat {
        hypot(dx, dy)
    }
}
#endif
