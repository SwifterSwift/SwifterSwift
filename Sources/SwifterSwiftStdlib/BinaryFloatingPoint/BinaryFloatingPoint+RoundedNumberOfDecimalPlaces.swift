// BinaryFloatingPoint+RoundedNumberOfDecimalPlaces.swift - Copyright 2026 SwifterSwift

public extension BinaryFloatingPoint {
    /// SwifterSwift: Returns the value rounded to the given number of decimal places, using the given rounding rule.
    ///
    /// Rounding happens on the decimal number the value stands for, not on its binary approximation. `1.005` is
    /// stored as `1.00499999999999989…`, so the common `(x * 100).rounded() / 100` gives `1.0`, and `1.1 * 10` is
    /// `11.000000000000002`, so rounding `1.1` up to one place that way gives `1.2`. This method gives `1.01` and
    /// `1.1`. The result is the representable value closest to the rounded decimal.
    ///
    /// ```swift
    /// let pi = 3.1415927
    /// pi.rounded(numberOfDecimalPlaces: 2)  // 3.14
    /// pi.rounded(numberOfDecimalPlaces: 3, rule: .up)  // 3.142
    /// pi.rounded(numberOfDecimalPlaces: 3, rule: .down)  // 3.141
    /// 1.005.rounded(numberOfDecimalPlaces: 2)  // 1.01
    /// 1.005.rounded(numberOfDecimalPlaces: 2, rule: .toNearestOrEven)  // 1.0
    /// ```
    ///
    /// A negative or zero `numberOfDecimalPlaces` rounds to a whole number, like `rounded(_:)`. NaN, infinity and
    /// zero are returned unchanged. When the requested digits go beyond the precision of the type (more than about
    /// 15 significant digits for `Double`, or 6 for `Float`), or 10 to the power of `numberOfDecimalPlaces` overflows
    /// it, the value is also returned unchanged.
    ///
    /// For text, prefer `formatted(.number.precision(.fractionLength(_:)))` from Foundation, and for money use
    /// `Decimal`.
    ///
    /// - Parameters:
    ///   - numberOfDecimalPlaces: The number of digits to keep after the decimal point.
    ///   - rule: The rounding rule to use. The default, `.toNearestOrAwayFromZero`, is schoolbook rounding.
    /// - Returns: The value rounded to `numberOfDecimalPlaces` decimal places.
    /// - Complexity: O(*n*), where *n* is the smaller of `numberOfDecimalPlaces` and the number of decimal digits
    ///   the type can represent.
    func rounded(numberOfDecimalPlaces: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
        guard numberOfDecimalPlaces > 0 else { return rounded(rule) }
        guard isFinite, !isZero else { return self }

        // Scaled values stay below this bound, so they keep two spare fractional bits for the rounding step below.
        let limit = Self(sign: .plus, exponent: Self.Exponent(Self.significandBitCount - 2), significand: 1)
        var factor: Self = 1
        for _ in 0..<numberOfDecimalPlaces {
            let nextFactor = factor * 10
            guard nextFactor.isFinite, magnitude * nextFactor < limit else { return self }
            factor = nextFactor
        }

        // Find the decimal step `lower` such that `lower / factor <= self < (lower + 1) / factor`.
        var lower = (self * factor).rounded(.down)
        if lower / factor > self {
            lower -= 1
        } else if (lower + 1) / factor <= self {
            lower += 1
        }
        guard lower / factor != self else { return self }

        // Place `self` below, on or above the decimal midpoint, then let the standard library apply `rule`.
        let midpoint = (lower * 2 + 1) / (factor * 2)
        let offset: Self = self < midpoint ? 0.25 : (self > midpoint ? 0.75 : 0.5)
        return Self(signOf: self, magnitudeOf: (lower + offset).rounded(rule) / factor)
    }
}
