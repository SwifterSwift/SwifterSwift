// BinaryInteger+IsPrime.swift - Copyright 2026 SwifterSwift

public extension BinaryInteger {
    /// SwifterSwift: A Boolean value indicating whether the integer is a prime number.
    ///
    /// A prime is a whole number greater than 1 whose only divisors are 1 and itself, so negative numbers, `0` and
    /// `1` aren't prime. The check is trial division in integer arithmetic, so it's exact for every value of every
    /// integer type and never overflows. It's fast for numbers up to about 10¹², but a prime close to `Int64.max`
    /// takes about a billion divisions.
    ///
    /// ```swift
    /// 7.isPrime  // true
    /// 21.isPrime  // false
    /// 1.isPrime  // false
    /// (-7).isPrime  // false
    /// UInt8(251).isPrime  // true
    /// ```
    ///
    /// - Complexity: O(√*n*), where *n* is the value of the integer.
    var isPrime: Bool {
        guard self > 3 else { return self > 1 }
        guard !isMultiple(of: 2), !isMultiple(of: 3) else { return false }
        // Every prime above 3 is 6k - 1 or 6k + 1. Comparing with `self / divisor` avoids overflowing `divisor²`.
        var divisor: Self = 5
        while divisor <= self / divisor {
            if isMultiple(of: divisor) || isMultiple(of: divisor + 2) {
                return false
            }
            divisor += 6
        }
        return true
    }
}
