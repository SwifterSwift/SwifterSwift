// MutableCollection+SortBy.swift - Copyright 2026 SwifterSwift

public extension MutableCollection where Self: RandomAccessCollection {
    /// SwifterSwift: Sorts the collection in place, in increasing order of the key the given closure returns.
    ///
    /// This is the mutating form of `sorted(by:)` with a key, and it saves writing the same key twice in
    /// `sort { $0.age < $1.age }`. You can pass a key path, such as `\.age`. The closure takes a single element, so it
    /// can't be confused with the standard library's `sort(by:)`, which takes a comparison of two elements:
    /// `sort(by: >)` still calls the standard library. The sort is stable, so elements with equal keys keep their
    /// relative order. `key` is called on both elements of every comparison, so keep it cheap.
    ///
    /// ```swift
    /// var fruits = ["banana", "fig", "apple"]
    /// fruits.sort(by: \.count)
    /// fruits  // ["fig", "apple", "banana"]
    ///
    /// people.sort(by: \.age)
    /// ```
    ///
    /// If `key` throws, the error is rethrown. The elements may then be in a different order, but none are lost.
    ///
    /// - Parameter key: A closure that returns the value to sort an element by.
    /// - Throws: Rethrows any error thrown by `key`.
    /// - Complexity: O(*n* log *n*), where *n* is the length of the collection.
    mutating func sort(by key: (Element) throws -> some Comparable) rethrows {
        try sort { try key($0) < key($1) }
    }
}
