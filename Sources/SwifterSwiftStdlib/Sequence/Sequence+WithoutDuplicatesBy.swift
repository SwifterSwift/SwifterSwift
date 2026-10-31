// Sequence+WithoutDuplicatesBy.swift - Copyright 2026 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Returns the elements without those whose key repeats an earlier element's key.
    ///
    /// The first element for each key is kept, the elements keep their original order, and `key` is called once per
    /// element. You can pass a key path, such as `\.id`. This overload compares each key with the keys kept so far;
    /// when the keys are `Hashable`, a linear-time overload is used instead.
    ///
    /// ```swift
    /// let tags = [Tag(name: "swift", color: .orange), Tag(name: "ios", color: .blue), Tag(name: "go", color: .blue)]
    /// tags.withoutDuplicates(by: \.color).map(\.name)  // ["swift", "ios"]
    /// ```
    ///
    /// - Parameter key: A closure that returns the value to compare for an element.
    /// - Returns: An array with the first element for every distinct key, in the order they appear.
    /// - Throws: Rethrows any error thrown by `key`.
    /// - Complexity: O(*n*²), where *n* is the length of the sequence.
    func withoutDuplicates<Key: Equatable>(by key: (Element) throws -> Key) rethrows -> [Element] {
        var keptKeys: [Key] = []
        var unique: [Element] = []
        for element in self {
            let elementKey = try key(element)
            if !keptKeys.contains(elementKey) {
                keptKeys.append(elementKey)
                unique.append(element)
            }
        }
        return unique
    }
}

public extension Sequence {
    /// SwifterSwift: Returns the elements without those whose key repeats an earlier element's key.
    ///
    /// The first element for each key is kept, the elements keep their original order, and `key` is called once per
    /// element. You can pass a key path, such as `\.id`. The keys seen so far are tracked in a `Set`, so this overload
    /// runs in linear time.
    ///
    /// ```swift
    /// ["apple", "avocado", "banana", "blueberry", "cherry"].withoutDuplicates(by: \.first)
    /// // ["apple", "banana", "cherry"]
    /// ```
    ///
    /// - Parameter key: A closure that returns the value to compare for an element.
    /// - Returns: An array with the first element for every distinct key, in the order they appear.
    /// - Throws: Rethrows any error thrown by `key`.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func withoutDuplicates<Key: Hashable>(by key: (Element) throws -> Key) rethrows -> [Element] {
        var seenKeys = Set<Key>()
        var unique: [Element] = []
        for element in self where try seenKeys.insert(key(element)).inserted {
            unique.append(element)
        }
        return unique
    }
}
