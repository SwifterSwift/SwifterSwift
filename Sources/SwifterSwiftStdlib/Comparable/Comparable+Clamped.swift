// Comparable+Clamped.swift - Copyright 2026 SwifterSwift

public extension Comparable {
    /// SwifterSwift: Returns the value limited to the given closed range.
    ///
    /// A value below the range becomes `range.lowerBound`, a value above it becomes `range.upperBound`, and a value
    /// inside it is returned unchanged. The standard library's `clamped(to:)` only clamps one range to another, and
    /// `clamped(lowerBound:upperBound:)` only exists for SIMD vectors.
    ///
    /// NaN is neither below nor above any bound, so `Double.nan` comes back as NaN instead of silently turning into
    /// one of the bounds.
    ///
    /// ```swift
    /// 15.clamped(to: 0...10)  // 10
    /// (-3).clamped(to: 0...10)  // 0
    /// 7.clamped(to: 0...10)  // 7
    /// "m".clamped(to: "a"..."f")  // "f"
    /// Double.nan.clamped(to: 0...1)  // nan
    /// ```
    ///
    /// - Parameter range: The closed range to limit the value to.
    /// - Returns: `range.lowerBound` if the value is less than it, `range.upperBound` if the value is greater than it,
    ///   and the value itself otherwise.
    func clamped(to range: ClosedRange<Self>) -> Self {
        if self < range.lowerBound {
            return range.lowerBound
        }
        if self > range.upperBound {
            return range.upperBound
        }
        return self
    }
}
