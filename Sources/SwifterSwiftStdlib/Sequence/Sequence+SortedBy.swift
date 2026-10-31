// Sequence+SortedBy.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the elements sorted in increasing order of the key the given closure returns.
    ///
    /// This saves writing the same key twice in `sorted { $0.age < $1.age }`. You can pass a key path, such as
    /// `\.age`. The closure takes a single element, so it can't be confused with the standard library's
    /// `sorted(by:)`, which takes a comparison of two elements. `key` is called on both elements of every comparison,
    /// so keep it cheap.
    ///
    /// ```swift
    /// ["banana", "fig", "apple"].sorted(by: \.count)  // ["fig", "apple", "banana"]
    /// people.sorted(by: \.age)
    /// ```
    ///
    /// - Parameter key: A closure that returns the value to sort an element by.
    /// - Returns: An array of the elements, sorted by their keys in increasing order.
    /// - Throws: Rethrows any error thrown by `key`.
    /// - Complexity: O(*n* log *n*), where *n* is the length of the sequence.
    func sorted(by key: (Element) throws -> some Comparable) rethrows -> [Element] {
        try sorted { try key($0) < key($1) }
    }
}
