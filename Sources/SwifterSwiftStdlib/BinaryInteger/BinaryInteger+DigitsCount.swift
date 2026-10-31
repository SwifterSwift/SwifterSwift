// BinaryInteger+DigitsCount.swift - Copyright 2026 SwifterSwift

public extension BinaryInteger {
    /// SwifterSwift: The number of decimal digits in the integer.
    ///
    /// The minus sign isn't counted, and zero has one digit. The count uses integer division, so it's exact for every
    /// value, including 18- and 19-digit numbers where a `log10`-based count is off by one, and `.min` of a signed
    /// type.
    ///
    /// ```swift
    /// 2026.digitsCount  // 4
    /// (-45).digitsCount  // 2
    /// 0.digitsCount  // 1
    /// Int.max.digitsCount  // 19
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of digits.
    var digitsCount: Int {
        var remaining = magnitude / 10
        var count = 1
        while remaining != 0 {
            remaining /= 10
            count += 1
        }
        return count
    }
}
