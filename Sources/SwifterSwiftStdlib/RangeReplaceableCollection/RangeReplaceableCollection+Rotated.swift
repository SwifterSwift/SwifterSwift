// RangeReplaceableCollection+Rotated.swift - Copyright 2026 SwifterSwift

public extension RangeReplaceableCollection {
    /// SwifterSwift: Returns a copy of the collection with its elements rotated by the given number of places.
    ///
    /// A positive `places` moves every element toward the end, and the elements that fall off the end wrap around to
    /// the start. A negative `places` moves them toward the start instead. Only the remainder of `places` divided by
    /// the length matters, so any value, including `Int.min` and `Int.max`, is valid. Empty and single-element
    /// collections come back unchanged.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].rotated(by: 2)  // [4, 5, 1, 2, 3]
    /// [1, 2, 3, 4, 5].rotated(by: -1)  // [2, 3, 4, 5, 1]
    /// [1, 2, 3].rotated(by: 7)  // [3, 1, 2]
    /// "swift".rotated(by: 1)  // "tswif"
    /// [Int]().rotated(by: 3)  // []
    /// ```
    ///
    /// - Parameter places: The number of places to move each element: toward the end when positive, toward the start
    ///   when negative.
    /// - Returns: A collection with the same elements, rotated by `places`.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    func rotated(by places: Int) -> Self {
        let count = self.count
        guard count > 1 else { return self }
        let shift = places % count
        guard shift != 0 else { return self }
        let pivot = index(startIndex, offsetBy: shift > 0 ? count - shift : -shift)
        var result = Self()
        result.reserveCapacity(count)
        result.append(contentsOf: self[pivot...])
        result.append(contentsOf: self[..<pivot])
        return result
    }
}
