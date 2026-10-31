// Sequence+Single.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the only element that satisfies the given predicate, or `nil` if there isn't exactly one.
    ///
    /// Unlike `first(where:)`, this also returns `nil` when two or more elements match, which makes it useful for
    /// lookups that must be unambiguous. It stops at the second match, so it also works on infinite sequences that
    /// match at least twice.
    ///
    /// ```swift
    /// [1, 4, 7].single(where: { $0.isMultiple(of: 2) })  // 4
    /// [2, 4, 7].single(where: { $0.isMultiple(of: 2) })  // nil
    /// [1, 3, 7].single(where: { $0.isMultiple(of: 2) })  // nil
    /// ```
    ///
    /// - Parameter predicate: A closure that takes an element and returns whether it matches.
    /// - Returns: The only element that satisfies `predicate`, or `nil` if none or several do.
    /// - Throws: Rethrows any error thrown by `predicate`.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func single(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        var match: Element?
        for element in self where try predicate(element) {
            guard match == nil else { return nil }
            match = element
        }
        return match
    }
}
