// BinaryInteger+GCD.swift - Copyright 2026 SwifterSwift

public extension BinaryInteger {
    /// SwifterSwift: Returns the greatest common divisor of the integer and the given integer.
    ///
    /// The result is never negative, whatever the signs of the inputs, and it's `0` only when both are `0`. It's
    /// returned as `Magnitude` (for example `UInt` for `Int`) because the divisor of `Int.min` and `0` is 2⁶³, which
    /// doesn't fit in `Int`.
    ///
    /// ```swift
    /// 8.gcd(of: 20)  // 4
    /// 4.gcd(of: -6)  // 2
    /// 7.gcd(of: 0)  // 7
    /// Int.min.gcd(of: 0)  // 9223372036854775808 (UInt)
    /// ```
    ///
    /// - Parameter other: The integer to find the greatest common divisor with.
    /// - Returns: The largest integer that divides both the integer and `other`, or `0` if both are `0`.
    /// - Complexity: O(log *n*), where *n* is the smaller of the two magnitudes.
    func gcd(of other: Self) -> Magnitude {
        var divisor = magnitude
        var remainder = other.magnitude
        while remainder != 0 {
            (divisor, remainder) = (remainder, divisor % remainder)
        }
        return divisor
    }
}
