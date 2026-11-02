// FixedWidthInteger+RaisedTo.swift - Copyright 2026 SwifterSwift

public extension FixedWidthInteger {
    /// SwifterSwift: Returns the integer raised to the given power, or `nil` if the result doesn't fit in the type.
    ///
    /// The standard library has no integer power, and `Int(pow(Double(x), Double(n)))` silently loses precision once
    /// the result is above 2⁵³. This method stays in integer arithmetic, so the result is exact, and it reports
    /// overflow as `nil` instead of trapping or wrapping around.
    ///
    /// Any integer raised to the power of 0 is 1, including 0. A negative exponent returns `nil`, because the result
    /// is a fraction, or undefined for 0, except for the two bases whose powers are always integers: 1 gives 1, and -1
    /// gives 1 or -1.
    ///
    /// ```swift
    /// 2.raised(to: 10)  // 1024
    /// (-3).raised(to: 3)  // -27
    /// Int64(3).raised(to: 39)  // 4052555153018976267
    /// Int8(2).raised(to: 7)  // nil, since 128 doesn't fit in an Int8
    /// Int8(-2).raised(to: 7)  // -128
    /// 2.raised(to: -1)  // nil
    /// (-1).raised(to: -3)  // -1
    /// ```
    ///
    /// - Parameter exponent: The power to raise the integer to.
    /// - Returns: The integer raised to `exponent`, or `nil` if the result overflows the type or isn't an integer.
    /// - Complexity: O(log *n*), where *n* is the magnitude of `exponent`.
    func raised(to exponent: Int) -> Self? {
        guard exponent >= 0 else {
            // Only 1 and -1 have integer powers with a negative exponent.
            guard magnitude == 1 else { return nil }
            return exponent.isMultiple(of: 2) ? 1 : self
        }
        // Exponentiation by squaring. No intermediate value is larger in magnitude than the result, so an overflow
        // anywhere means that the result overflows too.
        var result: Self = 1
        var base = self
        var remaining = exponent
        while remaining > 0 {
            if !remaining.isMultiple(of: 2) {
                let (product, overflow) = result.multipliedReportingOverflow(by: base)
                guard !overflow else { return nil }
                result = product
            }
            remaining /= 2
            if remaining > 0 {
                let (square, overflow) = base.multipliedReportingOverflow(by: base)
                guard !overflow else { return nil }
                base = square
            }
        }
        return result
    }
}
