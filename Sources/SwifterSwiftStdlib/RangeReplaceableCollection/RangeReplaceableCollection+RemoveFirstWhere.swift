// RangeReplaceableCollection+RemoveFirstWhere.swift - Copyright 2026 SwifterSwift

public extension RangeReplaceableCollection {
    /// SwifterSwift: Removes and returns the first element that satisfies the given predicate.
    ///
    /// Only the first match is removed, and later matches stay where they are. The standard library's
    /// `removeAll(where:)` removes every match, and `removeFirst()` removes the first element whatever it is, trapping
    /// when the collection is empty. This method returns `nil` instead when nothing matches.
    ///
    /// ```swift
    /// var numbers = [1, 2, 3, 4]
    /// numbers.removeFirst(where: { $0.isMultiple(of: 2) })  // 2
    /// numbers  // [1, 3, 4]
    /// numbers.removeFirst(where: { $0 > 10 })  // nil
    /// ```
    ///
    /// - Parameter predicate: A closure that takes an element and returns whether it's the one to remove.
    /// - Returns: The removed element, or `nil` if no element satisfies `predicate`.
    /// - Throws: Rethrows any error thrown by `predicate`. The collection is left unchanged when it throws.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    @discardableResult
    mutating func removeFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        guard let position = try firstIndex(where: predicate) else { return nil }
        return remove(at: position)
    }
}
