// Dictionary+CompactMapKeysAndValues.swift - Copyright 2026 SwifterSwift

public extension Dictionary {
    /// SwifterSwift: Returns a dictionary of the non-`nil` keys and values that a closure makes from each entry.
    ///
    /// Entries for which `transform` returns `nil` are left out. The standard library's `compactMapValues(_:)` can only
    /// change the values. This method can change the keys too, so two entries can end up with the same new key:
    /// `combine` then decides which value to keep, where `Dictionary(uniqueKeysWithValues:)` would trap.
    ///
    /// A dictionary has no defined order, so `combine` receives colliding values in an unspecified order. Use an
    /// order-independent rule, such as `max` or `+`, when the result must be the same on every run.
    ///
    /// ```swift
    /// let fields = ["Age": "42", "age": "7", "Name": "Ana"]
    /// fields.compactMapKeysAndValues(
    ///     { entry in Int(entry.value).map { (entry.key.lowercased(), $0) } },
    ///     uniquingKeysWith: max
    /// )
    /// // ["age": 42]
    /// ```
    ///
    /// - Parameters:
    ///   - transform: A closure that takes a key-value pair and returns the new key and value, or `nil` to leave the
    ///     entry out.
    ///   - combine: A closure that takes the value already stored for a duplicate key and the new value, and returns
    ///     the value to keep.
    /// - Returns: A dictionary with the new keys and values of every entry for which `transform` didn't return `nil`.
    /// - Throws: Rethrows any error thrown by `transform` or `combine`.
    /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the dictionary.
    func compactMapKeysAndValues<NewKey: Hashable, NewValue>(
        _ transform: (Element) throws -> (NewKey, NewValue)?,
        uniquingKeysWith combine: (NewValue, NewValue) throws -> NewValue
    ) rethrows -> [NewKey: NewValue] {
        try [NewKey: NewValue](compactMap(transform), uniquingKeysWith: combine)
    }
}
