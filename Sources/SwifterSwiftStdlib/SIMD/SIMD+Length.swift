// SIMD+Length.swift - Copyright 2026 SwifterSwift

public extension SIMD where Scalar: FloatingPoint {
    /// SwifterSwift: The length of the vector: the square root of the sum of the squares of its scalars.
    ///
    /// This is the Euclidean length, or magnitude, of the vector, which Apple's `simd` module computes with
    /// `simd_length(_:)` for vectors of 2, 3 or 4 scalars. This property works for any floating-point `SIMD` type, such
    /// as `SIMD3<Float>` in RealityKit or `SIMD8<Double>`, and on every platform Swift runs on, including Linux and
    /// Windows, where `simd` doesn't exist.
    ///
    /// The vector is scaled first when squaring its scalars would overflow to infinity or underflow to zero, so a
    /// vector of huge or tiny scalars still has the right length. The length is 0 for the zero vector, infinity if a
    /// scalar is infinite, and NaN if a scalar is NaN.
    ///
    /// ```swift
    /// SIMD2<Double>(3, 4).length  // 5
    /// SIMD3<Float>(1, 2, 2).length  // 3
    /// SIMD2<Float>(3e30, 4e30).length  // 5e30
    /// SIMD3<Double>.zero.length  // 0
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of scalars in the vector.
    var length: Scalar {
        let lengthSquared = (self * self).sum()
        if lengthSquared.isNormal || lengthSquared.isNaN {
            return lengthSquared.squareRoot()
        }
        // The vector is zero, has an infinite scalar, or squaring overflowed or underflowed: scale it by its largest
        // scalar so that the largest square is 1.
        var largest: Scalar = 0
        for index in indices {
            largest = Swift.max(largest, self[index].magnitude)
        }
        guard largest.isFinite, largest > 0 else { return largest }
        let scaled = self / largest
        return largest * (scaled * scaled).sum().squareRoot()
    }
}
