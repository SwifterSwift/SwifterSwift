// MutableCollection+SortByAndAnd.swift - Copyright 2026 SwifterSwift

public extension MutableCollection where Self: RandomAccessCollection {
    /// SwifterSwift: Sorts the collection in place by up to three keys, each used when the keys before it are equal.
    ///
    /// This is the mutating form of `sorted(by:and:and:)`. All keys sort in increasing order. You can pass key paths,
    /// such as `\.year`, `\.month` and `\.day`. The sort is stable, so elements whose keys are all equal keep their
    /// relative order. A key is only computed for elements whose earlier keys are equal, and each key is called on
    /// both elements of a comparison, so keep them cheap.
    ///
    /// ```swift
    /// var words = ["bat", "Cat", "Bat", "be", "ant"]
    /// words.sort(by: \.count, and: { $0.lowercased() }, and: \.self)
    /// words  // ["be", "ant", "Bat", "bat", "Cat"]
    /// ```
    ///
    /// If a key throws, the error is rethrown. The elements may then be in a different order, but none are lost.
    ///
    /// - Parameters:
    ///   - firstKey: A closure that returns the main value to sort an element by.
    ///   - secondKey: A closure that returns the value to sort by when the first keys are equal.
    ///   - thirdKey: A closure that returns the value to sort by when the first and second keys are equal.
    /// - Throws: Rethrows any error thrown by `firstKey`, `secondKey` or `thirdKey`.
    /// - Complexity: O(*n* log *n*), where *n* is the length of the collection.
    mutating func sort(
        by firstKey: (Element) throws -> some Comparable,
        and secondKey: (Element) throws -> some Comparable,
        and thirdKey: (Element) throws -> some Comparable
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
