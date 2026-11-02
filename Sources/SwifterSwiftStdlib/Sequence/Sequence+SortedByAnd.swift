// Sequence+SortedByAnd.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the elements sorted by one key, then by a second key when the first keys are equal.
    ///
    /// Both keys sort in increasing order. You can pass key paths, such as `\.lastName` and `\.firstName`. The second
    /// key is only computed for elements whose first keys are equal, and each key is called on both elements of a
    /// comparison, so keep them cheap.
    ///
    /// ```swift
    /// ["bb", "c", "aa", "b"].sorted(by: \.count, and: \.self)  // ["b", "c", "aa", "bb"]
    /// people.sorted(by: \.lastName, and: \.firstName)
    /// ```
    ///
    /// - Parameters:
    ///   - firstKey: A closure that returns the main value to sort an element by.
    ///   - secondKey: A closure that returns the value to sort by when the first keys are equal.
    /// - Returns: An array of the elements, sorted by their keys in increasing order.
    /// - Throws: Rethrows any error thrown by `firstKey` or `secondKey`.
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    func sorted(
        by firstKey: (Element) throws -> some Comparable,
        and secondKey: (Element) throws -> some Comparable
    ) rethrows -> [Element] {
        try sorted { lhs, rhs in
            let lhsFirst = try firstKey(lhs)
            let rhsFirst = try firstKey(rhs)
            if lhsFirst < rhsFirst {
                return true
            }
            if rhsFirst < lhsFirst {
                return false
            }
            return try secondKey(lhs) < secondKey(rhs)
        }
    }
}
