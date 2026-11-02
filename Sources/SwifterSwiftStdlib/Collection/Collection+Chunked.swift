// Collection+Chunked.swift - Copyright 2026 SwifterSwift

public extension Collection {
    /// SwifterSwift: Splits the collection into consecutive chunks of the given size.
    ///
    /// Every chunk has `size` elements except the last one, which holds whatever is left over. The chunks are slices
    /// that share indices with the collection; wrap one in `Array(_:)` or `String(_:)` to store it on its own.
    ///
    /// An empty collection has no chunks. A `size` of zero or less is invalid, so it also returns an empty array
    /// instead of trapping or looping forever.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].chunked(into: 2)  // [[1, 2], [3, 4], [5]]
    /// "abcdef".chunked(into: 4)  // ["abcd", "ef"]
    /// [1, 2, 3].chunked(into: 5)  // [[1, 2, 3]]
    /// [1, 2, 3].chunked(into: 0)  // []
    /// ```
    ///
    /// - Parameter size: The maximum number of elements in each chunk.
    /// - Returns: The chunks in order, or an empty array if the collection is empty or `size` is less than 1.
    /// - Complexity: O(*n* / `size`) for random-access collections such as `Array`; otherwise O(*n*), where *n* is
    ///   the length of the collection.
    func chunked(into size: Int) -> [SubSequence] {
        guard size > 0 else { return [] }
        var chunks: [SubSequence] = []
        var start = startIndex
        while start != endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            chunks.append(self[start..<end])
            start = end
        }
        return chunks
    }
}
