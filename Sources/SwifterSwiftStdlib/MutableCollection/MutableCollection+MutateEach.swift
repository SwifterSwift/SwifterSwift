// MutableCollection+MutateEach.swift - Copyright 2026 SwifterSwift

public extension MutableCollection {
    /// SwifterSwift: Calls the given closure on each element in place, so the closure can change it.
    ///
    /// `for var element in collection` only changes a copy of each element, and `map(_:)` builds a new collection.
    /// This method writes every change back into the collection itself, in order from the first element to the last.
    ///
    /// If `body` throws, iteration stops. The elements visited before keep their changes, and so does any change
    /// `body` made to the current element before throwing.
    ///
    /// ```swift
    /// var prices = [10, 20, 30]
    /// prices.mutateEach { $0 *= 2 }
    /// prices  // [20, 40, 60]
    ///
    /// var users = [User(name: "Ana", isActive: true), User(name: "Ben", isActive: true)]
    /// users.mutateEach { $0.isActive = false }
    /// users.map(\.isActive)  // [false, false]
    /// ```
    ///
    /// - Parameter body: A closure that takes an element as an `inout` parameter and can change it.
    /// - Throws: Rethrows any error thrown by `body`.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating func mutateEach(_ body: (inout Element) throws -> Void) rethrows {
        var position = startIndex
        while position != endIndex {
            try body(&self[position])
            formIndex(after: &position)
        }
    }
}
