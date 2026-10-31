// MutableCollection+SortByWith.swift - Copyright 2026 SwifterSwift

public extension MutableCollection where Self: RandomAccessCollection {
    /// SwifterSwift: Sorts the collection in place by the key the given closure returns, using the given comparison.
    ///
    /// This is the mutating form of `sorted(by:with:)`. The key doesn't need to be `Comparable`, and
    /// `areInIncreasingOrder` decides the order, for example `>` for decreasing order. You can pass a key path, such
    /// as `\.name`. The sort is stable, so elements whose keys are in no order relative to each other keep their
    /// relative order. `key` is called on both elements of every comparison, so keep it cheap.
    ///
    /// ```swift
    /// var fruits = ["banana", "fig", "apple"]
    /// fruits.sort(by: \.count, with: >)
    /// fruits  // ["banana", "apple", "fig"]
    /// ```
    ///
    /// If a closure throws, the error is rethrown. The elements may then be in a different order, but none are lost.
    ///
    /// - Parameters:
    ///   - key: A closure that returns the value to sort an element by.
    ///   - areInIncreasingOrder: A closure that returns `true` if its first key should come before its second key.
    /// - Throws: Rethrows any error thrown by `key` or `areInIncreasingOrder`.
    /// - Complexity: O(*n* log *n*), where *n* is the length of the collection.
    mutating func sort<Key>(
        by key: (Element) throws -> Key,
        with areInIncreasingOrder: (Key, Key) throws -> Bool
    ) rethrows {
        try sort { try areInIncreasingOrder(key($0), key($1)) }
    }
}
