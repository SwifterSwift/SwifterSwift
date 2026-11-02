// Sequence+SortedLikeBy.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the elements sorted so that their keys follow the order of the given keys.
    ///
    /// An element whose key comes earlier in `order` comes earlier in the result. Elements whose key isn't in `order`
    /// go last, and elements that share a position keep their original relative order. When a key appears more than
    /// once in `order`, its first position counts. `key` is called once per element. You can pass a key path, such as
    /// `\.status`.
    ///
    /// ```swift
    /// let todos = [
    ///     Todo(title: "Email", priority: "low"),
    ///     Todo(title: "Lunch", priority: "none"),
    ///     Todo(title: "Fix bug", priority: "high"),
    ///     Todo(title: "Review", priority: "medium")
    /// ]
    /// todos.sorted(like: ["high", "medium", "low"], by: \.priority).map(\.title)
    /// // ["Fix bug", "Review", "Email", "Lunch"]
    /// ```
    ///
    /// - Parameters:
    ///   - order: The keys in the order the elements should follow.
    ///   - key: A closure that returns the key of an element.
    /// - Returns: An array of the elements, sorted by the position of their key in `order`.
    /// - Throws: Rethrows any error thrown by `key`.
    /// - Complexity: O(*n* log *n* + *m*), where *n* is the length of the sequence and *m* is the length of `order`.
    func sorted<Key: Hashable>(
        like order: some Sequence<Key>,
        by key: (Element) throws -> Key
    ) rethrows -> [Element] {
        let positions = [Key: Int](
            order.enumerated().map { ($0.element, $0.offset) },
            uniquingKeysWith: { first, _ in first }
        )
        let ranked = try enumerated().map { offset, element in
            (rank: positions[try key(element)] ?? Int.max, offset: offset, element: element)
        }
        return ranked.sorted { ($0.rank, $0.offset) < ($1.rank, $1.offset) }.map(\.element)
    }
}
