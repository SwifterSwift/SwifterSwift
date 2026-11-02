// MutableCollection+SortByAnd.swift - Copyright 2026 SwifterSwift

public extension MutableCollection where Self: RandomAccessCollection {
    /// SwifterSwift: Sorts the collection in place by one key, then by a second key when the first keys are equal.
    ///
    /// This is the mutating form of `sorted(by:and:)`. Both keys sort in increasing order. You can pass key paths,
    /// such as `\.lastName` and `\.firstName`. The sort is stable, so elements whose keys are all equal keep their
    /// relative order. The second key is only computed for elements whose first keys are equal, and each key is called
    /// on both elements of a comparison, so keep them cheap.
    ///
    /// ```swift
    /// var words = ["bb", "c", "aa", "b"]
    /// words.sort(by: \.count, and: \.self)
    /// words  // ["b", "c", "aa", "bb"]
    ///
    /// people.sort(by: \.lastName, and: \.firstName)
    /// ```
    ///
    /// If a key throws, the error is rethrown. The elements may then be in a different order, but none are lost.
    ///
    /// - Parameters:
    ///   - firstKey: A closure that returns the main value to sort an element by.
    ///   - secondKey: A closure that returns the value to sort by when the first keys are equal.
    /// - Throws: Rethrows any error thrown by `firstKey` or `secondKey`.
    /// - Complexity: O(*n* log *n*), where *n* is the length of the collection.
    mutating func sort(
        by firstKey: (Element) throws -> some Comparable,
        and secondKey: (Element) throws -> some Comparable
    ) rethrows {
        try sort { lhs, rhs in
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
