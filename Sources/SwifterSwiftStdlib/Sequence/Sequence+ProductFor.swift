// Sequence+ProductFor.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the product of the values the given closure returns for the elements.
    ///
    /// You can pass a key path, such as `\.factor`. The product of an empty sequence is one. The values are multiplied
    /// with `*`, so the same rules apply: integer overflow traps, as it does for `reduce(1, *)`, and floating-point
    /// products can round or become infinite or NaN.
    ///
    /// ```swift
    /// ["Ana", "Ben", "Cyril"].product(for: \.count)  // 45
    /// ```
    ///
    /// - Parameter value: A closure that returns the value to multiply by for an element.
    /// - Returns: The product of the values for all the elements, or one if the sequence is empty.
    /// - Throws: Rethrows any error thrown by `value`.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func product<Value: Numeric>(for value: (Element) throws -> Value) rethrows -> Value {
        try reduce(1) { try $0 * value($1) }
    }
}
