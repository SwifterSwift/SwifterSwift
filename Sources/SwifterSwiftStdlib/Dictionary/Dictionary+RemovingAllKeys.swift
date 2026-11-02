// Dictionary+RemovingAllKeys.swift - Copyright 2026 SwifterSwift

public extension Dictionary {
    /// SwifterSwift: Returns a new dictionary without the entries for the given keys.
    ///
    /// This is the non-mutating form of `removeAll(keys:)`, and the opposite of `pick(keys:)`. Keys that aren't in the
    /// dictionary are ignored, and a key that appears more than once in `keys` is simply removed once. The keys can
    /// come from any sequence, such as an array, a set or another dictionary's `keys`.
    ///
    /// ```swift
    /// let scores = ["Ana": 3, "Ben": 5, "Cy": 8]
    /// scores.removingAll(keys: ["Ana", "Dee"])  // ["Ben": 5, "Cy": 8]
    /// scores.removingAll(keys: [])  // ["Ana": 3, "Ben": 5, "Cy": 8]
    /// ```
    ///
    /// - Parameter keys: The keys of the entries to leave out.
    /// - Returns: A dictionary with the entries of this dictionary whose keys aren't in `keys`.
    /// - Complexity: O(*n* + *m*) on average, where *n* is the length of the dictionary and *m* is the length of
    ///   `keys`.
    func removingAll(keys: some Sequence<Key>) -> [Key: Value] {
        var remaining = self
        for key in keys {
            remaining.removeValue(forKey: key)
        }
        return remaining
    }
}
