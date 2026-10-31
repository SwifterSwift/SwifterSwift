// Sequence+SumFor.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the sum of the values the given closure returns for the elements.
    ///
    /// You can pass a key path, such as `\.price`. The sum of an empty sequence is zero. The values are added with
    /// `+`, so the same rules apply: integer overflow traps, as it does for `reduce(0, +)`, and floating-point sums can
    /// round or become infinite or NaN.
    ///
    /// ```swift
    /// ["Ana", "Ben", "Cyril"].sum(for: \.count)  // 11
    /// cart.sum(for: { $0.price * Double($0.quantity) })
    /// ```
    ///
    /// - Parameter value: A closure that returns the value to add for an element.
    /// - Returns: The sum of the values for all the elements, or zero if the sequence is empty.
    /// - Throws: Rethrows any error thrown by `value`.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func sum<Value: AdditiveArithmetic>(for value: (Element) throws -> Value) rethrows -> Value {
        try reduce(.zero) { try $0 + value($1) }
    }
}
