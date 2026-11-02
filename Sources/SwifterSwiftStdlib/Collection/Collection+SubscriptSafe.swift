// Collection+SubscriptSafe.swift - Copyright 2026 SwifterSwift

public extension Collection {
    /// SwifterSwift: Accesses the element at the given position, or returns `nil` if the position isn't a valid index.
    ///
    /// The standard subscript traps when you pass an invalid index. This subscript checks the index against the
    /// collection's `indices` first, so it's safe to call with any value, including indices that are out of bounds or,
    /// for strings, that don't fall on a `Character` boundary.
    ///
    /// ```swift
    /// let numbers = [10, 20, 30]
    /// numbers[safe: 1]  // 20
    /// numbers[safe: 3]  // nil
    /// numbers[safe: -1]  // nil
    /// ```
    ///
    /// Slices keep the indices of the collection they came from:
    ///
    /// ```swift
    /// let slice = numbers[1...]
    /// slice[safe: 0]  // nil
    /// slice[safe: 1]  // 20
    /// ```
    ///
    /// - Parameter index: The position of the element to access.
    /// - Returns: The element at `index`, or `nil` if `index` is not one of the collection's valid indices.
    /// - Complexity: O(1) for collections whose `Indices` is a `Range`, such as `Array`; otherwise O(*n*), where *n*
    ///   is the length of the collection.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
