// Sequence+SortedByAndAnd.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the elements sorted by up to three keys, each used when the keys before it are equal.
    ///
    /// All keys sort in increasing order. You can pass key paths, such as `\.year`, `\.month` and `\.day`. A key is
    /// only computed for elements whose earlier keys are equal, and each key is called on both elements of a
    /// comparison, so keep them cheap.
    ///
    /// ```swift
    /// let words = ["bat", "Cat", "Bat", "be", "ant"]
    /// words.sorted(by: \.count, and: { $0.lowercased() }, and: \.self)  // ["be", "ant", "Bat", "bat", "Cat"]
    /// ```
    ///
    /// - Parameters:
    ///   - firstKey: A closure that returns the main value to sort an element by.
    ///   - secondKey: A closure that returns the value to sort by when the first keys are equal.
    ///   - thirdKey: A closure that returns the value to sort by when the first and second keys are equal.
    /// - Returns: An array of the elements, sorted by their keys in increasing order.
    /// - Throws: Rethrows any error thrown by `firstKey`, `secondKey` or `thirdKey`.
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    func sorted(
        by firstKey: (Element) throws -> some Comparable,
        and secondKey: (Element) throws -> some Comparable,
        and thirdKey: (Element) throws -> some Comparable
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
            let lhsSecond = try secondKey(lhs)
            let rhsSecond = try secondKey(rhs)
            if lhsSecond < rhsSecond {
                return true
            }
            if rhsSecond < lhsSecond {
                return false
            }
            return try thirdKey(lhs) < thirdKey(rhs)
        }
    }
}
