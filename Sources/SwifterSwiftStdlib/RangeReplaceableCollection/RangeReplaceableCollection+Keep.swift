// RangeReplaceableCollection+Keep.swift - Copyright 2026 SwifterSwift

public extension RangeReplaceableCollection {
    /// SwifterSwift: Keeps the leading elements that satisfy the given predicate and removes all the others.
    ///
    /// This is the in-place version of `prefix(while:)`. Everything from the first element that fails `predicate`
    /// onward is removed, even elements after it that would pass. `predicate` isn't called again after the first
    /// failure.
    ///
    /// ```swift
    /// var numbers = [2, 4, 5, 6, 8]
    /// numbers.keep(while: { $0.isMultiple(of: 2) })
    /// numbers  // [2, 4]
    /// ```
    ///
    /// - Parameter predicate: A closure that takes an element and returns whether to keep it.
    /// - Throws: Rethrows any error thrown by `predicate`. The collection is left unchanged when it throws.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating func keep(while predicate: (Element) throws -> Bool) rethrows {
        guard let end = try firstIndex(where: { try !predicate($0) }) else { return }
        removeSubrange(end...)
    }
}
