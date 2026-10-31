// SIMD+Normalized.swift - Copyright 2026 SwifterSwift

public extension SIMD where Scalar: FloatingPoint {
    /// SwifterSwift: Returns the unit vector in the same direction, or `nil` for a vector without a direction.
    ///
    /// The result is the vector divided by its length, so its length is 1, give or take rounding. Apple's
    /// `simd_normalize(_:)` returns a vector of NaNs for the zero vector, which then spreads silently through later
    /// math; this method returns `nil` instead, for the zero vector and for a vector with an infinite or NaN scalar.
    /// It works for any floating-point `SIMD` type, such as `SIMD3<Float>` in RealityKit, and on every platform Swift
    /// runs on, including Linux and Windows, where `simd` doesn't exist.
    ///
    /// The vector is scaled first when squaring its scalars would overflow to infinity or underflow to zero, so a
    /// vector of huge or tiny scalars still normalizes correctly.
    ///
    /// ```swift
    /// SIMD2<Double>(3, 4).normalized()  // SIMD2<Double>(0.6, 0.8)
    /// SIMD3<Float>(0, 0, -5).normalized()  // SIMD3<Float>(0, 0, -1)
    /// SIMD2<Float>(3e30, 4e30).normalized()  // SIMD2<Float>(0.6, 0.8)
    /// SIMD3<Float>.zero.normalized()  // nil
    /// ```
    ///
    /// - Returns: A vector with the same direction and a length of 1, or `nil` if the vector is zero or has an infinite
    ///   or NaN scalar.
    /// - Complexity: O(*n*), where *n* is the number of scalars in the vector.
    func normalized() -> Self? {
        let lengthSquared = (self * self).sum()
        if lengthSquared.isNormal {
            return self / lengthSquared.squareRoot()
        }
        // The vector is zero, isn't finite, or squaring overflowed or underflowed: scale it by its largest scalar so
        // that the largest square is 1.
        var largest: Scalar = 0
        for index in indices {
            let magnitude = self[index].magnitude
            guard magnitude.isFinite else { return nil }
            largest = Swift.max(largest, magnitude)
        }
        guard largest > 0 else { return nil }
        let scaled = self / largest
        return scaled / (scaled * scaled).sum().squareRoot()
    }
}
