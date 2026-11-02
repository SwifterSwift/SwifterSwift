// Dictionary+KeysForValue.swift - Copyright 2026 SwifterSwift

public extension Dictionary where Value: Equatable {
    /// SwifterSwift: Returns every key whose value is equal to the given value.
    ///
    /// A dictionary has no defined order, so the keys come back in an unspecified order. Sort them when you need the
    /// same order on every run.
    ///
    /// ```swift
    /// let colors = ["sky": "blue", "sea": "blue", "grass": "green"]
    /// colors.keys(forValue: "blue").sorted()  // ["sea", "sky"]
    /// colors.keys(forValue: "red")  // []
    /// ```
    ///
    /// - Parameter value: The value to look for.
    /// - Returns: The keys whose value is equal to `value`, or an empty array if there are none.
    /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the dictionary.
    func keys(forValue value: Value) -> [Key] {
        compactMap { $0.value == value ? $0.key : nil }
    }
}
