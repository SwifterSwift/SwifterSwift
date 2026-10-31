// Sequence+ContainsDuplicates.swift - Copyright 2026 SwifterSwift

public extension Sequence where Element: Hashable {
    /// SwifterSwift: Returns a Boolean value that indicates whether any element appears more than once.
    ///
    /// The search stops at the first repeated element, so this also works on infinite sequences that repeat an
    /// element. Comparing `Set(self).count` with `count` would always go through every element, and doesn't work on
    /// single-pass sequences.
    ///
    /// ```swift
    /// [1, 2, 3, 2].containsDuplicates()  // true
    /// [1, 2, 3].containsDuplicates()  // false
    /// "swift".containsDuplicates()  // false
    /// ```
    ///
    /// - Returns: `true` if at least one element appears more than once; otherwise, `false`.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func containsDuplicates() -> Bool {
        var seen = Set<Element>()
        for element in self where !seen.insert(element).inserted {
            return true
        }
        return false
    }
}
