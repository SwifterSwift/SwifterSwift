// Sequence+ContainsAllOf.swift - Copyright 2026 SwifterSwift

public extension Sequence where Element: Equatable {
    /// SwifterSwift: Returns a Boolean value indicating whether the sequence contains every given element.
    ///
    /// The elements can appear anywhere and in any order, and an element repeated in `elements` needs to appear only
    /// once. That's different from the standard library's `contains(_:)` for collections, which looks for the
    /// elements as one contiguous run, in the same order. An empty `elements` is contained in every sequence.
    ///
    /// The sequence is iterated once and the search stops as soon as every element has been found, so this also works
    /// on single-pass sequences. When the elements are `Hashable`, a faster overload looks them up in a `Set`.
    ///
    /// ```swift
    /// [1, 2, 3, 4].contains(allOf: [3, 1])  // true
    /// [1, 2, 3, 4].contains(allOf: [1, 5])  // false
    /// [1, 2, 3, 4].contains([3, 1])  // false, because 3, 1 isn't a contiguous run
    /// ```
    ///
    /// - Parameter elements: The elements to look for.
    /// - Returns: `true` if the sequence contains every element of `elements`; otherwise, `false`.
    /// - Complexity: O(*n* × *m*), where *n* is the length of the sequence and *m* is the length of `elements`.
    func contains(allOf elements: some Sequence<Element>) -> Bool {
        var missing = Array(elements)
        guard !missing.isEmpty else { return true }
        for element in self {
            missing.removeAll { $0 == element }
            if missing.isEmpty {
                return true
            }
        }
        return false
    }
}

public extension Sequence where Element: Hashable {
    /// SwifterSwift: Returns a Boolean value indicating whether the sequence contains every given element.
    ///
    /// The elements can appear anywhere and in any order, and an element repeated in `elements` needs to appear only
    /// once. That's different from the standard library's `contains(_:)` for collections, which looks for the
    /// elements as one contiguous run, in the same order. An empty `elements` is contained in every sequence.
    ///
    /// The sequence is iterated once and the search stops as soon as every element has been found, so this also works
    /// on single-pass sequences. The missing elements are tracked in a `Set`, so this overload runs in linear time.
    ///
    /// ```swift
    /// [1, 2, 3, 4].contains(allOf: [3, 1])  // true
    /// [1, 2, 3, 4].contains(allOf: [1, 5])  // false
    /// [1, 2, 3, 4].contains([3, 1])  // false, because 3, 1 isn't a contiguous run
    /// "swift".contains(allOf: "fist")  // true
    /// ```
    ///
    /// - Parameter elements: The elements to look for.
    /// - Returns: `true` if the sequence contains every element of `elements`; otherwise, `false`.
    /// - Complexity: O(*n* + *m*), where *n* is the length of the sequence and *m* is the length of `elements`.
    func contains(allOf elements: some Sequence<Element>) -> Bool {
        var missing = Set(elements)
        guard !missing.isEmpty else { return true }
        for element in self {
            missing.remove(element)
            if missing.isEmpty {
                return true
            }
        }
        return false
    }
}
