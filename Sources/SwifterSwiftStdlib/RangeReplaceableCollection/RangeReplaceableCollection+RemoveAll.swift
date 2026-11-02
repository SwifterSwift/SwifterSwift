// RangeReplaceableCollection+RemoveAll.swift - Copyright 2026 SwifterSwift

public extension RangeReplaceableCollection where Element: Equatable {
    /// SwifterSwift: Removes every occurrence of each of the given elements.
    ///
    /// The remaining elements keep their order. Elements of `elements` that aren't in the collection are ignored, and
    /// `elements` can be any sequence, including a single-pass one. This overload compares elements one by one; when
    /// the elements are `Hashable`, a faster overload looks them up in a `Set`.
    ///
    /// ```swift
    /// var numbers = [1, 2, 2, 3, 4, 5]
    /// numbers.removeAll([2, 5, 9])
    /// numbers  // [1, 3, 4]
    /// ```
    ///
    /// - Parameter elements: The elements to remove.
    /// - Complexity: O(*n* × *m*), where *n* is the length of the collection and *m* is the length of `elements`.
    mutating func removeAll(_ elements: some Sequence<Element>) {
        let unwanted = Array(elements)
        guard !unwanted.isEmpty else { return }
        removeAll { unwanted.contains($0) }
    }
}

public extension RangeReplaceableCollection where Element: Hashable {
    /// SwifterSwift: Removes every occurrence of each of the given elements.
    ///
    /// The remaining elements keep their order. Elements of `elements` that aren't in the collection are ignored, and
    /// `elements` can be any sequence, including a single-pass one. The elements are looked up in a `Set`, so this
    /// overload runs in linear time.
    ///
    /// ```swift
    /// var numbers = [1, 2, 2, 3, 4, 5]
    /// numbers.removeAll([2, 5, 9])
    /// numbers  // [1, 3, 4]
    ///
    /// var word = "hello, world"
    /// word.removeAll("lo")
    /// word  // "he, wrd"
    /// ```
    ///
    /// - Parameter elements: The elements to remove.
    /// - Complexity: O(*n* + *m*), where *n* is the length of the collection and *m* is the length of `elements`.
    mutating func removeAll(_ elements: some Sequence<Element>) {
        let unwanted = Set(elements)
        guard !unwanted.isEmpty else { return }
        removeAll { unwanted.contains($0) }
    }
}
