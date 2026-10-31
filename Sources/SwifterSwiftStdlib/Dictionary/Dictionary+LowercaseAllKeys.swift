// Dictionary+LowercaseAllKeys.swift - Copyright 2026 SwifterSwift

public extension Dictionary where Key == String {
    /// SwifterSwift: Lowercases every key, combining the values of keys that become equal.
    ///
    /// Keys are lowercased with `String.lowercased()`, which uses Unicode's default case mapping and doesn't depend on
    /// a locale. Keys such as `"ID"` and `"id"` collide once lowercased, so `combine` decides which value to keep.
    ///
    /// A dictionary has no defined order, so `combine` receives colliding values in an unspecified order. Use an
    /// order-independent rule, such as `max` or `+`, when the result must be the same on every run.
    ///
    /// ```swift
    /// var headers = ["Content-Type": "json", "ACCEPT": "html"]
    /// headers.lowercaseAllKeys(uniquingKeysWith: { current, _ in current })
    /// headers  // ["content-type": "json", "accept": "html"]
    ///
    /// var counts = ["Swift": 2, "SWIFT": 3, "Kotlin": 1]
    /// counts.lowercaseAllKeys(uniquingKeysWith: +)
    /// counts  // ["swift": 5, "kotlin": 1]
    /// ```
    ///
    /// - Parameter combine: A closure that takes the value already stored for a duplicate key and the new value, and
    ///   returns the value to keep.
    /// - Throws: Rethrows any error thrown by `combine`. The dictionary is left unchanged when it throws.
    /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the dictionary.
    mutating func lowercaseAllKeys(uniquingKeysWith combine: (Value, Value) throws -> Value) rethrows {
        self = try [String: Value](map { ($0.key.lowercased(), $0.value) }, uniquingKeysWith: combine)
    }
}
