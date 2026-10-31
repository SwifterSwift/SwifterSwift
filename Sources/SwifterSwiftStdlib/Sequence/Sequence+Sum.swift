// Sequence+Sum.swift - Copyright 2026 SwifterSwift

public extension Sequence where Element: AdditiveArithmetic {
    /// SwifterSwift: Returns the sum of the elements.
    ///
    /// The sum of an empty sequence is zero. The elements are added with `+`, so the same rules apply: integer
    /// overflow traps, as it does for `reduce(0, +)`, and floating-point sums can round or become infinite or NaN.
    ///
    /// ```swift
    /// [1, 2, 3, 4].sum()  // 10
    /// [0.5, 1.5].sum()  // 2.0
    /// [Int]().sum()  // 0
    /// ```
    ///
    /// - Returns: The sum of all the elements, or zero if the sequence is empty.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func sum() -> Element {
        reduce(.zero, +)
    }
}
