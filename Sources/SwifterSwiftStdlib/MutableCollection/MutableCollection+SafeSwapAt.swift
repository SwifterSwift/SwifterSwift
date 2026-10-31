// MutableCollection+SafeSwapAt.swift - Copyright 2026 SwifterSwift

public extension MutableCollection {
    /// SwifterSwift: Swaps the elements at the given positions if both indices are valid, and returns whether it did.
    ///
    /// The standard `swapAt(_:_:)` traps when either index is invalid. This method checks both indices against the
    /// collection's `indices` first and leaves the collection unchanged if either isn't valid, so it's safe to call
    /// with any value. The result tells you which happened, so a bad index doesn't go unnoticed; it's discardable for
    /// when you don't care. Swapping an element with itself is a valid swap that changes nothing, and returns `true`.
    ///
    /// ```swift
    /// var letters = ["a", "b", "c"]
    /// letters.safeSwapAt(0, 2)  // true
    /// letters  // ["c", "b", "a"]
    /// letters.safeSwapAt(1, 3)  // false
    /// letters  // ["c", "b", "a"]
    /// ```
    ///
    /// Slices keep the indices of the collection they came from, so `letters[1...].safeSwapAt(0, 1)` returns `false`.
    ///
    /// - Parameters:
    ///   - i: The position of the first element to swap.
    ///   - j: The position of the second element to swap.
    /// - Returns: `true` if both indices are valid and the elements were swapped; otherwise, `false`.
    /// - Complexity: O(1) for collections whose `Indices` is a `Range`, such as `Array`; otherwise O(*n*), where *n*
    ///   is the length of the collection.
    @discardableResult
    mutating func safeSwapAt(_ i: Index, _ j: Index) -> Bool {
        guard indices.contains(i), indices.contains(j) else { return false }
        swapAt(i, j)
        return true
    }
}
