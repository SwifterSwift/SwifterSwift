// Sequence+Product.swift - Copyright 2026 SwifterSwift

public extension Sequence where Element: Numeric {
    /// SwifterSwift: Returns the product of the elements.
    ///
    /// The product of an empty sequence is one. The elements are multiplied with `*`, so the same rules apply: integer
    /// overflow traps, as it does for `reduce(1, *)`, and floating-point products can round or become infinite or
    /// NaN.
    ///
    /// ```swift
    /// [1, 2, 3, 4].product()  // 24
    /// [0.5, 4].product()  // 2.0
    /// [Int]().product()  // 1
    /// ```
    ///
    /// - Returns: The product of all the elements, or one if the sequence is empty.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func product() -> Element {
        reduce(1, *)
    }
}
