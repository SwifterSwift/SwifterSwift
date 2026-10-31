// RangeReplaceableCollection+Rotate.swift - Copyright 2026 SwifterSwift

public extension RangeReplaceableCollection {
    /// SwifterSwift: Rotates the elements by the given number of places.
    ///
    /// A positive `places` moves every element toward the end, and the elements that fall off the end wrap around to
    /// the start. A negative `places` moves them toward the start instead. Only the remainder of `places` divided by
    /// the length matters, so any value, including `Int.min` and `Int.max`, is valid. Empty and single-element
    /// collections are left unchanged.
    ///
    /// ```swift
    /// var numbers = [1, 2, 3, 4, 5]
    /// numbers.rotate(by: 2)
    /// numbers  // [4, 5, 1, 2, 3]
    /// numbers.rotate(by: -2)
    /// numbers  // [1, 2, 3, 4, 5]
    ///
    /// var word = "swift"
    /// word.rotate(by: 1)
    /// word  // "tswif"
    /// ```
    ///
    /// - Parameter places: The number of places to move each element: toward the end when positive, toward the start
    ///   when negative.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating func rotate(by places: Int) {
        let count = self.count
        guard count > 1 else { return }
        let shift = places % count
        guard shift != 0 else { return }
        let pivot = index(startIndex, offsetBy: shift > 0 ? count - shift : -shift)
        var rotated = Self()
        rotated.reserveCapacity(count)
        rotated.append(contentsOf: self[pivot...])
        rotated.append(contentsOf: self[..<pivot])
        self = rotated
    }
}
