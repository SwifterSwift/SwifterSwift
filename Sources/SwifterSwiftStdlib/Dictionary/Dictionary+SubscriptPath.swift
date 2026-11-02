// Dictionary+SubscriptPath.swift - Copyright 2026 SwifterSwift

public extension Dictionary where Value == Any {
    /// SwifterSwift: Accesses the value at the given path of keys in nested dictionaries, or `nil` if there's none.
    ///
    /// Each key but the last must lead to another dictionary with the same key type, such as the `[String: Any]` that
    /// `JSONSerialization` produces. A nested dictionary with typed values, such as `[String: Int]`, works too.
    /// Only dictionaries are searched: an array along the path isn't indexed, so the lookup gives `nil`. An empty path
    /// also gives `nil`.
    ///
    /// The value comes back as found: a JSON `null` from `JSONSerialization` is an `NSNull`, not `nil`. Cast the
    /// result to the type you expect. The subscript is get-only; to change a nested value, change the inner
    /// dictionary and store it back. Unlike `NSDictionary`'s `value(forKeyPath:)`, keys are matched exactly and
    /// aren't split at dots.
    ///
    /// ```swift
    /// let json: [String: Any] = ["user": ["name": "Ana", "address": ["city": "Damascus"]]]
    /// json[path: ["user", "address", "city"]] as? String  // "Damascus"
    /// json[path: ["user", "age"]]  // nil
    /// json[path: ["user", "name", "first"]]  // nil
    /// json[path: []]  // nil
    /// ```
    ///
    /// - Parameter path: The keys to follow, from the outermost dictionary inward.
    /// - Returns: The value at the end of `path`, or `nil` if `path` is empty or a key along it is missing or doesn't
    ///   lead to a dictionary.
    /// - Complexity: O(*m*) on average, where *m* is the length of `path`, plus the cost of casting each nested
    ///   dictionary to `[Key: Any]`.
    subscript(path path: [Key]) -> Any? {
        guard let lastKey = path.last else { return nil }
        var dictionary: [Key: Any] = self
        for key in path.dropLast() {
            guard let nested = dictionary[key] as? [Key: Any] else { return nil }
            dictionary = nested
        }
        return dictionary[lastKey]
    }
}
