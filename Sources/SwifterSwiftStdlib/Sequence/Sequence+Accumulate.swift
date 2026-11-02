// Sequence+Accumulate.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the running results of combining the elements, such as running totals.
    ///
    /// This works like `reduce(_:_:)`, but returns every intermediate result instead of only the final one. The
    /// initial value isn't included, so the result has one entry per element, and its last entry is what `reduce`
    /// returns.
    ///
    /// ```swift
    /// [1, 2, 3, 4].accumulate(initial: 0, next: +)  // [1, 3, 6, 10]
    /// ["a", "b", "c"].accumulate(initial: "", next: +)  // ["a", "ab", "abc"]
    /// [Int]().accumulate(initial: 0, next: +)  // []
    /// ```
    ///
    /// - Parameters:
    ///   - initial: The value to combine with the first element.
    ///   - next: A closure that combines the running result with the next element.
    /// - Returns: The running results, one for each element.
    /// - Throws: Rethrows any error thrown by `next`.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func accumulate<Result>(initial: Result, next: (Result, Element) throws -> Result) rethrows -> [Result] {
        var results: [Result] = []
        results.reserveCapacity(underestimatedCount)
        var running = initial
        for element in self {
            running = try next(running, element)
            results.append(running)
        }
        return results
    }
}
