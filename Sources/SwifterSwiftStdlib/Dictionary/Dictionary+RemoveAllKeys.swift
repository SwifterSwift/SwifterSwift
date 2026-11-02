// Dictionary+RemoveAllKeys.swift - Copyright 2026 SwifterSwift

public extension Dictionary {
    /// SwifterSwift: Removes the given keys and their values from the dictionary.
    ///
    /// Keys that aren't in the dictionary are ignored, and a key that appears more than once in `keys` is simply
    /// removed once. The keys can come from any sequence, such as an array, a set or another dictionary's `keys`.
    ///
    /// ```swift
    /// var scores = ["Ana": 3, "Ben": 5, "Cy": 8]
    /// scores.removeAll(keys: ["Ana", "Dee"])
    /// scores  // ["Ben": 5, "Cy": 8]
    /// ```
    ///
    /// - Parameter keys: The keys to remove.
    /// - Complexity: O(*m*) on average, where *m* is the length of `keys`.
    mutating func removeAll(keys: some Sequence<Key>) {
        for key in keys {
            removeValue(forKey: key)
        }
    }
}
