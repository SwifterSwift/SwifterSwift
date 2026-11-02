// BinaryInteger+Digits.swift - Copyright 2026 SwifterSwift

public extension BinaryInteger {
    /// SwifterSwift: The decimal digits of the integer, most significant first.
    ///
    /// The sign is ignored, so a negative number has the same digits as its magnitude. Zero has the single digit
    /// `0`. The digits come from `magnitude`, so `.min` of a signed type works too.
    ///
    /// ```swift
    /// 2026.digits  // [2, 0, 2, 6]
    /// (-45).digits  // [4, 5]
    /// 0.digits  // [0]
    /// Int8.min.digits  // [1, 2, 8]
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of digits.
    var digits: [Int] {
        var remaining = magnitude
        var digits: [Int] = []
        repeat {
            let (quotient, remainder) = remaining.quotientAndRemainder(dividingBy: 10)
            digits.append(Int(remainder))
            remaining = quotient
        } while remaining != 0
        return digits.reversed()
    }
}
