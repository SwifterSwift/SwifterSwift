// RangeReplaceableCollection+RemoveDuplicates.swift - Copyright 2026 SwifterSwift

public extension RangeReplaceableCollection where Element: Equatable {
    /// SwifterSwift: Removes repeated elements, keeping the first occurrence of each.
    ///
    /// The remaining elements keep their original order. This overload compares each element with the ones kept so
    /// far; when the elements are `Hashable`, a linear-time overload is used instead.
    ///
    /// ```swift
    /// var numbers = [3, 1, 3, 2, 1]
    /// numbers.removeDuplicates()
    /// numbers  // [3, 1, 2]
    /// ```
    ///
    /// - Complexity: O(*n*²), where *n* is the length of the collection.
    mutating func removeDuplicates() {
        var unique = Self()
        for element in self where !unique.contains(element) {
            unique.append(element)
        }
        self = unique
    }
}

public extension RangeReplaceableCollection where Element: Hashable {
    /// SwifterSwift: Removes repeated elements, keeping the first occurrence of each.
    ///
    /// The remaining elements keep their original order. The elements seen so far are tracked in a `Set`, so this
    /// overload runs in linear time.
    ///
    /// ```swift
    /// var numbers = [3, 1, 3, 2, 1]
    /// numbers.removeDuplicates()
    /// numbers  // [3, 1, 2]
    ///
    /// var word = "bookkeeper"
    /// word.removeDuplicates()
    /// word  // "bokepr"
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating func removeDuplicates() {
        var seen = Set<Element>()
        var unique = Self()
        for element in self where seen.insert(element).inserted {
            unique.append(element)
        }
        self = unique
    }
}
