// Dictionary+MapKeysAndValues.swift - Copyright 2026 SwifterSwift

public extension Dictionary {
    /// SwifterSwift: Returns a dictionary with the keys and values that the given closure makes from each entry.
    ///
    /// The standard library's `mapValues(_:)` can only change the values. This method can change the keys too, so two
    /// entries can end up with the same new key: `combine` then decides which value to keep, where
    /// `Dictionary(uniqueKeysWithValues:)` would trap.
    ///
    /// A dictionary has no defined order, so `combine` receives colliding values in an unspecified order. Use an
    /// order-independent rule, such as `max` or `+`, when the result must be the same on every run.
    ///
    /// ```swift
    /// let stock = ["Apple": 3, "apple": 2, "Pear": 5]
    /// stock.mapKeysAndValues({ ($0.key.lowercased(), $0.value) }, uniquingKeysWith: +)
    /// // ["apple": 5, "pear": 5]
    /// ```
    ///
    /// - Parameters:
    ///   - transform: A closure that takes a key-value pair and returns the new key and value.
    ///   - combine: A closure that takes the value already stored for a duplicate key and the new value, and returns
    ///     the value to keep.
    /// - Returns: A dictionary with the new keys and values.
    /// - Throws: Rethrows any error thrown by `transform` or `combine`.
    /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the dictionary.
    func mapKeysAndValues<NewKey: Hashable, NewValue>(
        _ transform: (Element) throws -> (NewKey, NewValue),
        uniquingKeysWith combine: (NewValue, NewValue) throws -> NewValue
    ) rethrows -> [NewKey: NewValue] {
        try [NewKey: NewValue](map(transform), uniquingKeysWith: combine)
    }
}
