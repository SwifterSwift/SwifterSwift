// BinaryInteger+RoundedToMultipleOf.swift - Copyright 2026 SwifterSwift

public extension BinaryInteger where Self: FixedWidthInteger {
    /// SwifterSwift: Returns the multiple of the given number that is closest to the integer.
    ///
    /// A value exactly halfway between two multiples rounds away from zero, like `rounded()` on floating-point
    /// numbers. The sign of `multiple` doesn't matter: the multiples of `-5` are the multiples of `5`. The arithmetic
    /// is all integer, so it's exact for every value.
    ///
    /// ```swift
    /// 12.rounded(toMultipleOf: 5)  // 10
    /// 13.rounded(toMultipleOf: 5)  // 15
    /// 15.rounded(toMultipleOf: 10)  // 20
    /// (-15).rounded(toMultipleOf: 10)  // -20
    /// 12.rounded(toMultipleOf: 0)  // nil
    /// Int.max.rounded(toMultipleOf: 10)  // nil
    /// ```
    ///
    /// - Parameter multiple: The number whose multiples to round to.
    /// - Returns: The multiple of `multiple` closest to the integer, or `nil` if `multiple` is zero or the closest
    ///   multiple doesn't fit in the type.
    func rounded(toMultipleOf multiple: Self) -> Self? {
        guard multiple != 0 else { return nil }
        // Every integer is a multiple of 1 and -1; handling them here also avoids the overflow of `.min % -1`.
        guard multiple.magnitude != 1 else { return self }
        let remainder = self % multiple
        let towardZero = self - remainder
        guard remainder.magnitude >= multiple.magnitude - remainder.magnitude else { return towardZero }

        // Move one more step away from zero.
        let (result, overflow) =
            (self < 0) == (multiple < 0)
            ? towardZero.addingReportingOverflow(multiple)
            : towardZero.subtractingReportingOverflow(multiple)
        return overflow ? nil : result
    }
}
