// Dictionary+Pick.swift - Copyright 2026 SwifterSwift

public extension Dictionary {
    /// SwifterSwift: Returns a new dictionary with only the entries for the given keys.
    ///
    /// Keys that aren't in the dictionary are skipped, so the result can have fewer entries than `keys`. In a
    /// dictionary with optional values, an entry whose value is `nil` is still an entry, so it's kept.
    ///
    /// ```swift
    /// let scores = ["Ana": 3, "Ben": 5, "Cy": 8]
    /// scores.pick(keys: ["Ana", "Cy", "Dee"])  // ["Ana": 3, "Cy": 8]
    /// scores.pick(keys: [])  // [:]
    /// ```
    ///
    /// - Parameter keys: The keys of the entries to keep.
    /// - Returns: A dictionary with the entries of this dictionary whose keys are in `keys`.
    /// - Complexity: O(*m*) on average, where *m* is the length of `keys`.
    func pick(keys: some Sequence<Key>) -> [Key: Value] {
        var picked: [Key: Value] = [:]
        for key in keys {
            if let value = self[key] {
                picked[key] = value
            }
        }
        return picked
    }
}
