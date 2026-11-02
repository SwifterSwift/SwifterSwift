// Sequence+Divided.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Splits the elements into those that satisfy the given predicate and those that don't.
    ///
    /// Both arrays keep the original order of their elements. The standard library's `partition(by:)` works in place,
    /// doesn't keep the order, and only works on mutable collections.
    ///
    /// ```swift
    /// let (even, odd) = [1, 2, 3, 4, 5].divided(by: { $0.isMultiple(of: 2) })
    /// even  // [2, 4]
    /// odd  // [1, 3, 5]
    /// ```
    ///
    /// - Parameter predicate: A closure that takes an element and returns whether it belongs in `matching`.
    /// - Returns: The elements that satisfy `predicate` and the elements that don't, each in their original order.
    /// - Throws: Rethrows any error thrown by `predicate`.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func divided(
        by predicate: (Element) throws -> Bool
    ) rethrows -> (matching: [Element], nonMatching: [Element]) {
        var matching: [Element] = []
        var nonMatching: [Element] = []
        for element in self {
            if try predicate(element) {
                matching.append(element)
            } else {
                nonMatching.append(element)
            }
        }
        return (matching, nonMatching)
    }
}
