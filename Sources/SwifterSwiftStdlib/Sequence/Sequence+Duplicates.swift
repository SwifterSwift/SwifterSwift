// Sequence+Duplicates.swift - Copyright 2026 SwifterSwift

public extension Sequence where Element: Hashable {
    /// SwifterSwift: Returns the elements that appear more than once, each listed once.
    ///
    /// The result is in the order in which the repeated elements first appear in the sequence, so it's the same on
    /// every run.
    ///
    /// ```swift
    /// [3, 1, 2, 1, 3, 3].duplicates()  // [3, 1]
    /// "bookkeeper".duplicates()  // ["o", "k", "e"]
    /// [1, 2, 3].duplicates()  // []
    /// ```
    ///
    /// - Returns: The elements that appear at least twice, in the order of their first occurrence.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func duplicates() -> [Element] {
        var seen = Set<Element>()
        var repeated = Set<Element>()
        var firstOccurrences: [Element] = []
        for element in self {
            if seen.insert(element).inserted {
                firstOccurrences.append(element)
            } else {
                repeated.insert(element)
            }
        }
        return firstOccurrences.filter { repeated.contains($0) }
    }
}
