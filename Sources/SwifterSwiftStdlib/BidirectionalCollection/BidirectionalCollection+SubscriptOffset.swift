// BidirectionalCollection+SubscriptOffset.swift - Copyright 2026 SwifterSwift

public extension BidirectionalCollection {
    /// SwifterSwift: Accesses the element at the given offset from the start, or from the end for a negative offset.
    ///
    /// A non-negative offset counts from the start, so `0` is the first element. A negative offset counts back from
    /// the end, as in Python, so `-1` is the last element. Unlike the standard subscript, this one never traps: it
    /// returns `nil` when the offset falls outside the collection, including `Int.min` and `Int.max`.
    ///
    /// Offsets are counted from the collection's own start, so they also work on slices, whose indices don't start at
    /// zero, and on collections whose indices aren't integers, such as `String`.
    ///
    /// ```swift
    /// let numbers = [10, 20, 30, 40]
    /// numbers[offset: 0]  // 10
    /// numbers[offset: -1]  // 40
    /// numbers[offset: 4]  // nil
    /// numbers[offset: -5]  // nil
    ///
    /// numbers[2...][offset: 0]  // 30
    /// "héllo"[offset: 1]  // "é"
    /// ```
    ///
    /// - Parameter offset: The distance from the start when non-negative, or from the end when negative.
    /// - Returns: The element at `offset`, or `nil` if the offset is outside the collection.
    /// - Complexity: O(1) for random-access collections such as `Array`; otherwise O(*k*), where *k* is the smaller of
    ///   the absolute value of `offset` and the length of the collection.
    subscript(offset offset: Int) -> Element? {
        if offset >= 0 {
            guard let position = index(startIndex, offsetBy: offset, limitedBy: endIndex), position != endIndex else {
                return nil
            }
            return self[position]
        }
        guard let position = index(endIndex, offsetBy: offset, limitedBy: startIndex) else { return nil }
        return self[position]
    }
}
