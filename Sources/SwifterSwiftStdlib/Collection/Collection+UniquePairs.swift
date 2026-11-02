// Collection+UniquePairs.swift - Copyright 2026 SwifterSwift

public extension Collection {
    /// SwifterSwift: Returns every pair of two different elements of the collection, in order.
    ///
    /// The result has one pair for each 2-combination of positions: the first element paired with each later one,
    /// then the second element paired with each later one, and so on. Within a pair, the earlier element comes first,
    /// and no element is paired with itself. Pairs are made by position, not by value, so equal elements are still
    /// paired, and repeated values give repeated pairs. A collection with *n* elements gives *n* × (*n* - 1) / 2
    /// pairs, so a collection with fewer than two elements gives none.
    ///
    /// This isn't swift-algorithms' `adjacentPairs()`, which pairs each element only with the next one; for that,
    /// use `zip(collection, collection.dropFirst())`. It gives the same pairs as swift-algorithms'
    /// `combinations(ofCount: 2)`, but as tuples in an array.
    ///
    /// ```swift
    /// [1, 2, 3].uniquePairs()  // [(1, 2), (1, 3), (2, 3)]
    /// ["a", "a"].uniquePairs()  // [("a", "a")]
    /// [1].uniquePairs()  // []
    /// ```
    ///
    /// - Returns: An array of every pair of elements at two different positions, ordered by the position of the first
    ///   element, then of the second.
    /// - Complexity: O(*n*²), where *n* is the length of the collection.
    func uniquePairs() -> [(Element, Element)] {
        var pairs: [(Element, Element)] = []
        var remaining = self[...]
        while let first = remaining.popFirst() {
            for second in remaining {
                pairs.append((first, second))
            }
        }
        return pairs
    }
}
