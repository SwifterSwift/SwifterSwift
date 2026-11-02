// Sequence+SortedByWith.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the elements sorted by the key the given closure returns, using the given comparison.
    ///
    /// The key doesn't need to be `Comparable`, and `areInIncreasingOrder` decides the order, for example `>` for
    /// decreasing order. You can pass a key path, such as `\.name`. `key` is called on both elements of every
    /// comparison, so keep it cheap.
    ///
    /// ```swift
    /// ["banana", "fig", "apple"].sorted(by: \.count, with: >)  // ["banana", "apple", "fig"]
    /// ```
    ///
    /// - Parameters:
    ///   - key: A closure that returns the value to sort an element by.
    ///   - areInIncreasingOrder: A closure that returns `true` if its first key should come before its second key.
    /// - Returns: An array of the elements, sorted by their keys.
    /// - Throws: Rethrows any error thrown by `key` or `areInIncreasingOrder`.
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    func sorted<Key>(
        by key: (Element) throws -> Key,
        with areInIncreasingOrder: (Key, Key) throws -> Bool
    ) rethrows -> [Element] {
        try sorted { try areInIncreasingOrder(key($0), key($1)) }
    }
}
