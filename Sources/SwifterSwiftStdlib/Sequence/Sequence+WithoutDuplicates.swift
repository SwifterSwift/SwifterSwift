// Sequence+WithoutDuplicates.swift - Copyright 2026 SwifterSwift

public extension Sequence where Element: Equatable {
    /// SwifterSwift: Returns the elements without repeats, keeping the first occurrence of each.
    ///
    /// The elements keep their original order. This overload compares each element with the ones kept so far; when
    /// the elements are `Hashable`, a linear-time overload is used instead.
    ///
    /// ```swift
    /// [3, 1, 3, 2, 1].withoutDuplicates()  // [3, 1, 2]
    /// ```
    ///
    /// - Returns: An array with the first occurrence of every distinct element, in the order they appear.
    /// - Complexity: O(*n*²), where *n* is the length of the sequence.
    func withoutDuplicates() -> [Element] {
        var unique: [Element] = []
        for element in self where !unique.contains(element) {
            unique.append(element)
        }
        return unique
    }
}

public extension Sequence where Element: Hashable {
    /// SwifterSwift: Returns the elements without repeats, keeping the first occurrence of each.
    ///
    /// The elements keep their original order. The elements seen so far are tracked in a `Set`, so this overload runs
    /// in linear time.
    ///
    /// ```swift
    /// [3, 1, 3, 2, 1].withoutDuplicates()  // [3, 1, 2]
    /// "bookkeeper".withoutDuplicates()  // ["b", "o", "k", "e", "p", "r"]
    /// ```
    ///
    /// - Returns: An array with the first occurrence of every distinct element, in the order they appear.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func withoutDuplicates() -> [Element] {
        var seen = Set<Element>()
        var unique: [Element] = []
        for element in self where seen.insert(element).inserted {
            unique.append(element)
        }
        return unique
    }
}
