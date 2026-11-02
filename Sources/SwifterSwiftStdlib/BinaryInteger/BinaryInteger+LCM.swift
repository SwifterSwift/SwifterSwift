// BinaryInteger+LCM.swift - Copyright 2026 SwifterSwift

public extension BinaryInteger where Self: FixedWidthInteger {
    /// SwifterSwift: Returns the least common multiple of the integer and the given integer.
    ///
    /// The result is never negative, whatever the signs of the inputs. If either integer is `0`, the result is `0`.
    /// It's returned as `Magnitude` (for example `UInt` for `Int`), the type of the magnitudes it's built from, and
    /// it's `nil` when it doesn't fit even there. The multiplication happens after dividing by the greatest common
    /// divisor, so results that fit never overflow along the way.
    ///
    /// ```swift
    /// 4.lcm(of: 6)  // 12
    /// (-4).lcm(of: 6)  // 12
    /// 0.lcm(of: 0)  // 0
    /// Int.max.lcm(of: 2)  // 18446744073709551614 (UInt)
    /// Int.max.lcm(of: 3)  // nil
    /// ```
    ///
    /// - Parameter other: The integer to find the least common multiple with.
    /// - Returns: The smallest non-negative integer that both the integer and `other` divide, or `nil` if it doesn't
    ///   fit in `Magnitude`.
    /// - Complexity: O(log *n*), where *n* is the smaller of the two magnitudes.
    func lcm(of other: Self) -> Magnitude? {
        guard self != 0, other != 0 else { return 0 }
        var divisor = magnitude
        var remainder = other.magnitude
        while remainder != 0 {
            (divisor, remainder) = (remainder, divisor % remainder)
        }
        let (result, overflow) = (magnitude / divisor).multipliedReportingOverflow(by: other.magnitude)
        return overflow ? nil : result
    }
}
